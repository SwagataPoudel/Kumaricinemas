using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class TicketForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlForm.Visible = false;
                LoadGrid();
            }
        }

        void LoadGrid()
        {
            string sql =
                "SELECT t.TICKETID, c.CUSTOMERNAME, " +
                "       m.MOVIETITLE || ' | ' || TO_CHAR(s.SHOWDATE,'DD-MON-YYYY') || ' ' || s.SHOWTIME AS SHOWLABEL, " +
                "       t.TICKETPRICE, t.SEATNUMBER, t.BOOKINGDATE, t.BOOKINGSTATUS " +
                "FROM Ticket t " +
                "JOIN Customer c ON t.CUSTOMERID = c.CUSTOMERID " +
                "JOIN Show     s ON t.SHOWID     = s.SHOWID " +
                "JOIN Movie    m ON s.MOVIEID    = m.MOVIEID " +
                "ORDER BY t.TICKETID";
            gvTickets.DataSource = DBHelper.GetData(sql);
            gvTickets.DataBind();
        }

        void LoadDropdowns()
        {
            ddlCustomer.DataSource = DBHelper.GetData(
                "SELECT CUSTOMERID, CUSTOMERNAME FROM Customer ORDER BY CUSTOMERID");
            ddlCustomer.DataBind();

            ddlShow.DataSource = DBHelper.GetData(
                "SELECT s.SHOWID, " +
                "       m.MOVIETITLE || ' | ' || TO_CHAR(s.SHOWDATE,'DD-MON-YYYY') || ' ' || s.SHOWTIME AS SHOWLABEL " +
                "FROM Show s JOIN Movie m ON s.MOVIEID = m.MOVIEID ORDER BY s.SHOWID");
            ddlShow.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            hfTicketID.Value    = "";
            txtTicketPrice.Text = "";
            txtSeatNumber.Text  = "";
            txtBookingDate.Text = "";
            LoadDropdowns();
            ddlStatus.SelectedIndex = 0;
            pnlForm.Visible = true;
            btnAdd.Visible  = false;
            lblMsg.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string custId    = ddlCustomer.SelectedValue;
            string showId    = ddlShow.SelectedValue;
            string price     = txtTicketPrice.Text.Trim().Replace("'", "''");
            string seat      = txtSeatNumber.Text.Trim().Replace("'", "''");
            string bookDate  = txtBookingDate.Text.Trim().ToUpper().Replace("'", "''");
            string status    = ddlStatus.SelectedValue;

            if (string.IsNullOrEmpty(hfTicketID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Ticket (TicketID, CustomerID, ShowID, TicketPrice, SeatNumber, BookingDate, BookingStatus) " +
                    $"VALUES (ticket_seq.NEXTVAL, {custId}, {showId}, '{price}', '{seat}', " +
                    $"TO_DATE('{bookDate}','DD-MON-YYYY'), '{status}')");
                lblMsg.Text = "Ticket added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Ticket SET CustomerID={custId}, ShowID={showId}, " +
                    $"TicketPrice='{price}', SeatNumber='{seat}', " +
                    $"BookingDate=TO_DATE('{bookDate}','DD-MON-YYYY'), BookingStatus='{status}' " +
                    $"WHERE TicketID={hfTicketID.Value}");
                lblMsg.Text = "Ticket updated successfully.";
            }

            pnlForm.Visible = false;
            btnAdd.Visible  = true;
            LoadGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            btnAdd.Visible  = true;
            lblMsg.Text = "";
        }

        protected void gvTickets_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvTickets.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Ticket WHERE TicketID={id}");
            if (dt.Rows.Count > 0)
            {
                hfTicketID.Value    = id;
                txtTicketPrice.Text = dt.Rows[0]["TICKETPRICE"].ToString();
                txtSeatNumber.Text  = dt.Rows[0]["SEATNUMBER"].ToString();
                txtBookingDate.Text = Convert.ToDateTime(dt.Rows[0]["BOOKINGDATE"])
                                        .ToString("dd-MMM-yyyy").ToUpper();
                LoadDropdowns();
                ddlCustomer.SelectedValue = dt.Rows[0]["CUSTOMERID"].ToString();
                ddlShow.SelectedValue     = dt.Rows[0]["SHOWID"].ToString();
                ddlStatus.SelectedValue   = dt.Rows[0]["BOOKINGSTATUS"].ToString();
                pnlForm.Visible = true;
                btnAdd.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvTickets_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvTickets.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Ticket WHERE TicketID={id}");
            lblMsg.Text = "Ticket deleted successfully.";
            LoadGrid();
        }

        protected void gvTickets_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTickets.EditIndex = -1;
            LoadGrid();
        }
    }
}
