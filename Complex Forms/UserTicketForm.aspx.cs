using System;
using System.Data;

namespace KumariCinemas
{
    public partial class UserTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomers();
                pnlCustomerInfo.Visible = false;
                pnlStats.Visible = false;
            }
        }

        void LoadCustomers()
        {
            ddlCustomer.DataSource = DBHelper.GetData(
                "SELECT CustomerID, CustomerName || ' - ' || Address AS CustomerInfo FROM Customer ORDER BY CustomerName");
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Customer --", "0"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlCustomer.SelectedValue == "0")
            {
                pnlCustomerInfo.Visible = false;
                pnlStats.Visible = false;
                gvTickets.DataSource = null;
                gvTickets.DataBind();
                lblResultCount.Text = "";
                return;
            }

            int customerID = int.Parse(ddlCustomer.SelectedValue);
            int months = int.Parse(ddlMonths.SelectedValue);

            // Load customer info
            DataTable dtCustomer = DBHelper.GetData(
                $"SELECT CustomerID, CustomerName, Address FROM Customer WHERE CustomerID = {customerID}");

            if (dtCustomer.Rows.Count > 0)
            {
                pnlCustomerInfo.Visible = true;
                lblCustomerName.Text = dtCustomer.Rows[0]["CUSTOMERNAME"].ToString();
                lblCustomerID.Text = dtCustomer.Rows[0]["CUSTOMERID"].ToString();
                lblAddress.Text = dtCustomer.Rows[0]["ADDRESS"].ToString();
                lblPeriod.Text = $"Last {months} month(s)";
            }

            // Load tickets — compare on TRUNC to ignore time component
            string query = $@"SELECT t.TicketID, m.MovieTitle, th.TheatreName, th.TheatreCity,
                                      h.HallName, s.ShowDate, s.ShowTime,
                                      t.SeatNumber, t.TicketPrice, t.BookingDate, t.Bookingstatus
                               FROM Ticket t
                               JOIN Show s  ON t.ShowID  = s.ShowID
                               JOIN Movie m ON s.MovieID = m.MovieID
                               JOIN Hall h  ON s.HallID  = h.HallID
                               JOIN Theatre th ON h.TheatreId = th.TheatreID
                               WHERE t.CustomerID = {customerID}
                               AND TRUNC(t.BookingDate) >= TRUNC(ADD_MONTHS(SYSDATE, -{months}))
                               ORDER BY t.BookingDate DESC";

            DataTable dtTickets = DBHelper.GetData(query);
            gvTickets.DataSource = dtTickets;
            gvTickets.DataBind();

            // Stats
            pnlStats.Visible = true;
            int paid = 0, booked = 0, cancelled = 0;
            decimal totalSpent = 0;

            foreach (DataRow row in dtTickets.Rows)
            {
                string status = row["BOOKINGSTATUS"].ToString().ToLower();
                if (status == "paid") paid++;
                else if (status == "booked") booked++;
                else if (status == "cancelled") cancelled++;

                decimal.TryParse(row["TICKETPRICE"].ToString(), out decimal price);
                totalSpent += price;
            }

            lblTotalTickets.Text = dtTickets.Rows.Count.ToString();
            lblPaidTickets.Text = paid.ToString();
            lblBookedTickets.Text = booked.ToString();
            lblCancelledTickets.Text = cancelled.ToString();
            lblResultCount.Text = $"{dtTickets.Rows.Count} record(s) found";

            // If still 0 results, check if customer has ANY tickets at all
            if (dtTickets.Rows.Count == 0)
            {
                DataTable dtCheck = DBHelper.GetData(
                    $"SELECT COUNT(*) AS CNT FROM Ticket WHERE CustomerID = {customerID}");
                int total = int.Parse(dtCheck.Rows[0]["CNT"].ToString());
                lblResultCount.Text = total == 0
                    ? "This customer has no tickets at all."
                    : $"No tickets in the last {months} month(s). Customer has {total} ticket(s) outside this period — try a longer period.";
            }
        }
    }
}