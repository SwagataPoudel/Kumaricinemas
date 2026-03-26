using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Showtimes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { LoadShowtimes(); LoadDropdowns(); }
        }

        void LoadShowtimes()
        {
            string query = @"SELECT s.ShowID, m.MovieTitle, t.TheatreName, t.TheatreCity,
                                    h.HallName, s.ShowDate, s.ShowTime, s.BasePrice,
                                    s.IsReleaseWeek, d.IsHoliday
                             FROM Show s
                             JOIN Movie m ON s.MovieID = m.MovieID
                             JOIN Hall h ON s.HallID = h.HallID
                             JOIN Theatre t ON h.TheatreId = t.TheatreID
                             JOIN DateSchedule d ON s.ShowDate = d.ShowDate
                             ORDER BY s.ShowDate";
            gvShowtimes.DataSource = DBHelper.GetData(query);
            gvShowtimes.DataBind();
        }

        void LoadDropdowns()
        {
            ddlMovie.DataSource = DBHelper.GetData("SELECT MovieID, MovieTitle FROM Movie");
            ddlMovie.DataBind();
            ddlTheatre.DataSource = DBHelper.GetData(
                "SELECT TheatreID, TheatreName || ' - ' || TheatreCity AS TheatreInfo FROM Theatre");
            ddlTheatre.DataBind();
            LoadHallsByTheatre();
        }

        void LoadHallsByTheatre()
        {
            ddlHall.DataSource = DBHelper.GetData(
                $"SELECT HallID, HallName FROM Hall WHERE TheatreId = {ddlTheatre.SelectedValue}");
            ddlHall.DataBind();
        }

        decimal CalculatePrice(decimal basePrice, string showTime, string isReleaseWeek, string isHoliday)
        {
            decimal price = basePrice;
            if (isReleaseWeek.ToUpper() == "YES") price *= 1.20m;
            if (isHoliday.ToUpper() == "YES") price *= 1.20m;
            if (showTime == "Morning") price *= 0.85m;
            else if (showTime == "Evening") price *= 1.10m;
            return Math.Round(price, 2);
        }

        protected void ddlTheatre_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadHallsByTheatre();
        }

        void ClearFields()
        {
            txtShowID.Text = "";
            txtShowDate.Text = "";
            txtBasePrice.Text = "";
            txtFinalPrice.Text = "";
            lblMessage.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtShowID.Text))
                {
                    lblMessage.Text = "✗ Please enter a Show ID";
                    lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                    return;
                }

                decimal basePrice = decimal.Parse(txtBasePrice.Text);
                decimal finalPrice = CalculatePrice(basePrice, ddlShowTime.SelectedValue,
                                                    ddlIsReleaseWeek.SelectedValue, ddlIsHoliday.SelectedValue);
                txtFinalPrice.Text = finalPrice.ToString();

                DataTable dt = DBHelper.GetData($"SELECT COUNT(*) FROM DateSchedule WHERE ShowDate = DATE '{txtShowDate.Text}'");
                if (dt.Rows[0][0].ToString() == "0")
                    DBHelper.ExecuteQuery($"INSERT INTO DateSchedule VALUES (DATE '{txtShowDate.Text}', '{ddlIsHoliday.SelectedValue}')");
                else
                    DBHelper.ExecuteQuery($"UPDATE DateSchedule SET IsHoliday='{ddlIsHoliday.SelectedValue}' WHERE ShowDate = DATE '{txtShowDate.Text}'");

                string query = $@"INSERT INTO Show (ShowID, ShowTime, BasePrice, IsReleaseWeek, HallID, ShowDate, MovieID)
                                  VALUES ({txtShowID.Text}, '{ddlShowTime.SelectedValue}', '{finalPrice}',
                                  '{ddlIsReleaseWeek.SelectedValue}', {ddlHall.SelectedValue},
                                  DATE '{txtShowDate.Text}', {ddlMovie.SelectedValue})";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Show added — ID: {txtShowID.Text} | Final Price: Rs. {finalPrice}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                decimal basePrice = decimal.Parse(txtBasePrice.Text);
                decimal finalPrice = CalculatePrice(basePrice, ddlShowTime.SelectedValue,
                                                    ddlIsReleaseWeek.SelectedValue, ddlIsHoliday.SelectedValue);
                txtFinalPrice.Text = finalPrice.ToString();

                DBHelper.ExecuteQuery($"UPDATE DateSchedule SET IsHoliday='{ddlIsHoliday.SelectedValue}' WHERE ShowDate = DATE '{txtShowDate.Text}'");

                string query = $@"UPDATE Show SET ShowTime='{ddlShowTime.SelectedValue}',
                                  BasePrice='{finalPrice}',
                                  IsReleaseWeek='{ddlIsReleaseWeek.SelectedValue}',
                                  HallID={ddlHall.SelectedValue},
                                  ShowDate=DATE '{txtShowDate.Text}',
                                  MovieID={ddlMovie.SelectedValue}
                                  WHERE ShowID={txtShowID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Show updated | Final Price: Rs. {finalPrice}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DBHelper.ExecuteQuery($"DELETE FROM Ticket WHERE ShowID={txtShowID.Text}");
                DBHelper.ExecuteQuery($"DELETE FROM Show WHERE ShowID={txtShowID.Text}");
                lblMessage.Text = "✓ Show and its associated tickets deleted";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearFields(); LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearFields(); }

        protected void gvShowtimes_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvShowtimes.SelectedRow;
            txtShowID.Text = row.Cells[1].Text;
            txtShowDate.Text = row.Cells[6].Text;
            txtBasePrice.Text = row.Cells[8].Text;
            txtFinalPrice.Text = row.Cells[8].Text;

            ddlShowTime.ClearSelection();
            foreach (ListItem item in ddlShowTime.Items)
                if (item.Text == row.Cells[7].Text) { item.Selected = true; break; }

            ddlIsReleaseWeek.ClearSelection();
            foreach (ListItem item in ddlIsReleaseWeek.Items)
                if (item.Value == row.Cells[9].Text) { item.Selected = true; break; }

            ddlIsHoliday.ClearSelection();
            foreach (ListItem item in ddlIsHoliday.Items)
                if (item.Value == row.Cells[10].Text) { item.Selected = true; break; }

            ddlTheatre.ClearSelection();
            foreach (ListItem item in ddlTheatre.Items)
                if (item.Text.StartsWith(row.Cells[3].Text)) { item.Selected = true; break; }
            LoadHallsByTheatre();

            ddlHall.ClearSelection();
            foreach (ListItem item in ddlHall.Items)
                if (item.Text == row.Cells[5].Text) { item.Selected = true; break; }

            ddlMovie.ClearSelection();
            foreach (ListItem item in ddlMovie.Items)
                if (item.Text == row.Cells[2].Text) { item.Selected = true; break; }
        }
    }
}