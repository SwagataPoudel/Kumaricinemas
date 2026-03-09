using System;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Ticket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTickets();
                LoadDropdowns();
            }
        }

        void LoadTickets()
        {
            string query = @"SELECT t.TicketID, c.CustomerName,
                                    m.MovieTitle, th.TheatreName, th.TheatreCity,
                                    h.HallName, s.ShowDate, s.ShowTime,
                                    t.TicketPrice, t.BookingDate, t.BookingStatus
                             FROM Ticket t
                             JOIN Customer c ON t.CustomerID = c.CustomerID
                             JOIN Show s ON t.ShowID = s.ShowID
                             JOIN Movie m ON s.MovieID = m.MovieID
                             JOIN Hall h ON s.HallID = h.HallID
                             JOIN Theatre th ON h.TheatreID = th.TheatreID
                             ORDER BY t.TicketID";
            gvTickets.DataSource = DBHelper.GetData(query);
            gvTickets.DataBind();
        }

        void LoadDropdowns()
        {
            ddlCustomer.DataSource = DBHelper.GetData(
                "SELECT CustomerID, CustomerName || ' - ' || Address AS CustomerInfo FROM Customer");
            ddlCustomer.DataBind();

            ddlShow.DataSource = DBHelper.GetData(@"
                SELECT s.ShowID, 
                       m.MovieTitle || ' | ' || th.TheatreName || ' - ' || th.TheatreCity || 
                       ' | ' || h.HallName || ' | ' || s.ShowDate AS ShowInfo
                FROM Show s
                JOIN Movie m ON s.MovieID = m.MovieID
                JOIN Hall h ON s.HallID = h.HallID
                JOIN Theatre th ON h.TheatreID = th.TheatreID
                ORDER BY s.ShowDate");
            ddlShow.DataBind();
        }

        void ClearFields()
        {
            txtTicketID.Text = "";
            txtTicketPrice.Text = "";
            txtBookingDate.Text = "";
            lblMessage.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_ticket");
                txtTicketID.Text = newID.ToString();
                string query = $@"INSERT INTO Ticket VALUES (
                    {newID},
                    {txtTicketPrice.Text},
                    {ddlShow.SelectedValue},
                    {ddlCustomer.SelectedValue},
                    DATE '{txtBookingDate.Text}',
                    '{ddlBookingStatus.SelectedValue}')";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"Ticket added with ID: {newID}";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadTickets();
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
                string query = $@"UPDATE Ticket SET
                    TicketPrice={txtTicketPrice.Text},
                    ShowID={ddlShow.SelectedValue},
                    CustomerID={ddlCustomer.SelectedValue},
                    BookingDate=DATE '{txtBookingDate.Text}',
                    BookingStatus='{ddlBookingStatus.SelectedValue}'
                    WHERE TicketID={txtTicketID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "Ticket updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Blue;
                LoadTickets();
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
                string query = $"DELETE FROM Ticket WHERE TicketID={txtTicketID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "Ticket deleted successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ClearFields();
                LoadTickets();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        protected void gvTickets_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTickets.SelectedRow;
            txtTicketID.Text = row.Cells[1].Text;
            txtTicketPrice.Text = row.Cells[9].Text;
            txtBookingDate.Text = row.Cells[10].Text;

            // Match Booking Status dropdown
            ddlBookingStatus.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlBookingStatus.Items)
            {
                if (item.Text == row.Cells[11].Text)
                {
                    item.Selected = true;
                    break;
                }
            }

            // Match Customer dropdown
            ddlCustomer.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlCustomer.Items)
            {
                if (item.Text.StartsWith(row.Cells[2].Text))
                {
                    item.Selected = true;
                    break;
                }
            }
        }
    }
}