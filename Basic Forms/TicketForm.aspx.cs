using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Ticket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { LoadTickets(); LoadDropdowns(); }
        }

        void LoadTickets()
        {
            string query = @"SELECT t.TicketID, c.CustomerName, m.MovieTitle,
                                    th.theatreName, h.HallName, s.ShowDate, s.ShowTime,
                                    t.TicketPrice, t.SeatNumber, t.BookingDate, t.Bookingstatus
                             FROM Ticket t
                             JOIN Customer c ON t.CustomerID = c.CustomerID
                             JOIN Show s ON t.ShowID = s.ShowID
                             JOIN Movie m ON s.MovieID = m.MovieID
                             JOIN Hall h ON s.HallID = h.HallID
                             JOIN Theatre th ON h.theatreId = th.theatreID
                             ORDER BY t.TicketID";
            gvTickets.DataSource = DBHelper.GetData(query);
            gvTickets.DataBind();
        }

        void LoadDropdowns()
        {
            ddlCustomer.DataSource = DBHelper.GetData(
                "SELECT CustomerID, CustomerName || ' - ' || Address AS CustomerInfo FROM Customer ORDER BY CustomerName");
            ddlCustomer.DataBind();

            ddlShow.DataSource = DBHelper.GetData(@"
                SELECT s.ShowID,
                       m.MovieTitle || ' | ' || th.theatreName || ' - ' || th.theatreCity ||
                       ' | ' || h.HallName || ' | ' || TO_CHAR(s.ShowDate,'DD-Mon-YYYY') ||
                       ' ' || s.ShowTime || ' | Rs.' || s.BasePrice AS ShowInfo
                FROM Show s
                JOIN Movie m ON s.MovieID = m.MovieID
                JOIN Hall h ON s.HallID = h.HallID
                JOIN Theatre th ON h.theatreId = th.theatreID
                ORDER BY s.ShowDate");
            ddlShow.DataBind();

            // Auto-fill price for first show
            if (ddlShow.Items.Count > 0)
                AutoFillPrice(ddlShow.SelectedValue);
        }

        void AutoFillPrice(string showID)
        {
            if (string.IsNullOrEmpty(showID) || showID == "0") return;
            DataTable dt = DBHelper.GetData(
                $"SELECT BasePrice FROM Show WHERE ShowID = {showID}");
            if (dt.Rows.Count > 0)
                txtTicketPrice.Text = dt.Rows[0]["BASEPRICE"].ToString();
        }

        protected void ddlShow_SelectedIndexChanged(object sender, EventArgs e)
        {
            AutoFillPrice(ddlShow.SelectedValue);
        }

        void ClearFields()
        {
            txtTicketID.Text = "";
            txtTicketPrice.Text = "";
            txtSeatNumber.Text = "";
            txtBookingDate.Text = "";
            lblMessage.Text = "";
            if (ddlShow.Items.Count > 0) AutoFillPrice(ddlShow.SelectedValue);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_ticket");
                txtTicketID.Text = newID.ToString();
                string query = $@"INSERT INTO Ticket (TicketID, CustomerID, ShowID, TicketPrice, SeatNumber, BookingDate, Bookingstatus)
                                  VALUES ({newID}, {ddlCustomer.SelectedValue}, {ddlShow.SelectedValue},
                                  '{txtTicketPrice.Text}', '{txtSeatNumber.Text}',
                                  DATE '{txtBookingDate.Text}', '{ddlBookingStatus.SelectedValue}')";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Ticket added — ID: {newID} | Price: Rs. {txtTicketPrice.Text}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadTickets();
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
                // Re-fetch price from show in case show changed
                AutoFillPrice(ddlShow.SelectedValue);
                string query = $@"UPDATE Ticket SET
                                  CustomerID={ddlCustomer.SelectedValue},
                                  ShowID={ddlShow.SelectedValue},
                                  TicketPrice='{txtTicketPrice.Text}',
                                  SeatNumber='{txtSeatNumber.Text}',
                                  BookingDate=DATE '{txtBookingDate.Text}',
                                  Bookingstatus='{ddlBookingStatus.SelectedValue}'
                                  WHERE TicketID={txtTicketID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Ticket updated | Price: Rs. {txtTicketPrice.Text}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadTickets();
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
                DBHelper.ExecuteQuery($"DELETE FROM Ticket WHERE TicketID={txtTicketID.Text}");
                lblMessage.Text = "✓ Ticket deleted";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearFields(); LoadTickets();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearFields(); }

        protected void gvTickets_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTickets.SelectedRow;
            txtTicketID.Text = row.Cells[1].Text;
            txtTicketPrice.Text = row.Cells[8].Text;
            txtSeatNumber.Text = row.Cells[9].Text;
            txtBookingDate.Text = row.Cells[10].Text;

            foreach (System.Web.UI.WebControls.ListItem item in ddlBookingStatus.Items)
                if (item.Text == row.Cells[11].Text) { item.Selected = true; break; }

            foreach (System.Web.UI.WebControls.ListItem item in ddlCustomer.Items)
                if (item.Text.StartsWith(row.Cells[2].Text)) { item.Selected = true; break; }
        }
    }
}