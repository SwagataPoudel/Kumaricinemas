using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Showtimes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadShowtimes();
                LoadDropdowns();
            }
        }

        void LoadShowtimes()
        {
            string query = @"SELECT s.ShowID,
                                    t.TheatreName,
                                    t.TheatreCity,
                                    s.ShowDate,
                                    s.ShowTime,
                                    m.MovieTitle,
                                    h.HallName,
                                    s.BasePrice,
                                    s.IsReleaseWeek
                             FROM Show s
                             JOIN Movie m ON s.MovieID = m.MovieID
                             JOIN Hall h ON s.HallID = h.HallID
                             JOIN Theatre t ON h.TheatreID = t.TheatreID
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
            string query = $"SELECT HallID, HallName FROM Hall WHERE TheatreID={ddlTheatre.SelectedValue}";
            ddlHall.DataSource = DBHelper.GetData(query);
            ddlHall.DataBind();
        }

        protected void ddlTheatre_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadHallsByTheatre();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // Insert ShowDate if it doesn't exist
                string checkDate = $"SELECT COUNT(*) FROM ShowDate WHERE ShowDate = DATE '{txtShowDate.Text}'";
                DataTable dt = DBHelper.GetData(checkDate);
                if (dt.Rows[0][0].ToString() == "0")
                {
                    string insertDate = $"INSERT INTO ShowDate VALUES (DATE '{txtShowDate.Text}', 0)";
                    DBHelper.ExecuteQuery(insertDate);
                }

                string query = $@"INSERT INTO Show VALUES (
                    {txtShowID.Text},
                    DATE '{txtShowDate.Text}',
                    '{ddlShowTime.SelectedValue}',
                    {ddlIsReleaseWeek.SelectedValue},
                    {ddlMovie.SelectedValue},
                    {ddlHall.SelectedValue},
                    {txtBasePrice.Text})";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "Show added successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $@"UPDATE Show SET
                    ShowDate=DATE '{txtShowDate.Text}',
                    ShowTime='{ddlShowTime.SelectedValue}',
                    IsReleaseWeek={ddlIsReleaseWeek.SelectedValue},
                    MovieID={ddlMovie.SelectedValue},
                    HallID={ddlHall.SelectedValue},
                    BasePrice={txtBasePrice.Text}
                    WHERE ShowID={txtShowID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "Show updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Blue;
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $"DELETE FROM Show WHERE ShowID={txtShowID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "Show deleted successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvShowtimes_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvShowtimes.SelectedRow;
            txtShowID.Text = row.Cells[1].Text;   // ShowID
            txtShowDate.Text = row.Cells[4].Text;  // ShowDate
            txtBasePrice.Text = row.Cells[8].Text; // BasePrice

            // Match Theatre dropdown
            ddlTheatre.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlTheatre.Items)
            {
                if (item.Text.StartsWith(row.Cells[2].Text))
                {
                    item.Selected = true;
                    break;
                }
            }
            LoadHallsByTheatre();

            // Match Hall dropdown
            ddlHall.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlHall.Items)
            {
                if (item.Text == row.Cells[7].Text)
                {
                    item.Selected = true;
                    break;
                }
            }

            // Match Movie dropdown
            ddlMovie.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlMovie.Items)
            {
                if (item.Text == row.Cells[6].Text)
                {
                    item.Selected = true;
                    break;
                }
            }

            // Match ShowTime dropdown
            ddlShowTime.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlShowTime.Items)
            {
                if (item.Text == row.Cells[5].Text)
                {
                    item.Selected = true;
                    break;
                }
            }
        }
    }
}