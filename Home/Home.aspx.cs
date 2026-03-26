using System;
using System.Data;
using System.Text;

namespace KumariCinemas
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadDashboard();
        }

        void LoadDashboard()
        {
            // ── KPI counts ──────────────────────────────────────────
            lblMovieCount.Text = Scalar("SELECT COUNT(*) FROM Movie");
            lblTicketCount.Text = Scalar("SELECT COUNT(*) FROM Ticket");
            lblTheatreCount.Text = Scalar("SELECT COUNT(*) FROM Theatre");
            lblShowCount.Text = Scalar("SELECT COUNT(*) FROM Show");
            lblCustomerCount.Text = Scalar("SELECT COUNT(*) FROM Customer");
            lblTotalShows.Text = Scalar("SELECT COUNT(*) FROM Show");

            // ── Total revenue ────────────────────────────────────────
            string rawRev = Scalar(
                "SELECT NVL(SUM(CAST(TicketPrice AS NUMBER)), 0) FROM Ticket");
            decimal rev;
            decimal.TryParse(rawRev, out rev);
            lblTotalRevenue.Text = rev.ToString("N0");

            hdnBookingStatus.Value = TableToJson(
                DBHelper.GetData(
                    "SELECT INITCAP(BookingStatus) AS LBL, COUNT(*) AS VAL " +
                    "FROM Ticket " +
                    "GROUP BY BookingStatus " +
                    "ORDER BY 1"),
                "LBL", "VAL");

            // ── Showtime slot popularity doughnut ───────────────────
            hdnSlotPopularity.Value = TableToJson(
                DBHelper.GetData(
                    "SELECT s.ShowTime AS LBL, COUNT(t.TicketID) AS VAL " +
                    "FROM Show s " +
                    "LEFT JOIN Ticket t ON t.ShowID = s.ShowID " +
                    "GROUP BY s.ShowTime " +
                    "ORDER BY 1"),
                "LBL", "VAL");

            // ── Revenue by genre ─────────────────────────────────────
            // No Hall/Theatre join needed here — just Ticket > Show > Movie
            hdnRevenueByGenre.Value = TableToJson(
                DBHelper.GetData(
                    "SELECT NVL(m.Genre, 'Unknown') AS LBL, " +
                    "       SUM(CAST(t.TicketPrice AS NUMBER)) AS VAL " +
                    "FROM Ticket t " +
                    "JOIN Show s  ON t.ShowID  = s.ShowID " +
                    "JOIN Movie m ON s.MovieID = m.MovieID " +
                    "GROUP BY m.Genre " +
                    "ORDER BY VAL DESC"),
                "LBL", "VAL");

            // ── Hall occupancy ───────────────────────────────────────
            // No Theatre join needed — Hall + Show + Ticket only
            DataTable dtOcc = DBHelper.GetData(
                "SELECT h.HallName, " +
                "       CAST(h.HallCapacity AS NUMBER) AS Capacity, " +
                "       COUNT(t.TicketID) AS Sold " +
                "FROM Hall h " +
                "LEFT JOIN Show s   ON s.HallID = h.HallID " +
                "LEFT JOIN Ticket t ON t.ShowID = s.ShowID " +
                "GROUP BY h.HallName, h.HallCapacity " +
                "ORDER BY h.HallName");

            var sbOcc = new StringBuilder("{\"halls\":[");
            bool first = true;
            foreach (DataRow row in dtOcc.Rows)
            {
                double cap = 1;
                double sold = 0;
                double.TryParse(row["CAPACITY"].ToString(), out cap);
                double.TryParse(row["SOLD"].ToString(), out sold);
                if (cap <= 0) cap = 1;
                double pct = Math.Round(sold / cap * 100, 1);
                string name = row["HALLNAME"].ToString()
                    .Replace("\\", "").Replace("\"", "'");
                if (!first) sbOcc.Append(",");
                sbOcc.Append("{\"name\":\"" + name + "\",\"pct\":" + pct + "}");
                first = false;
            }
            sbOcc.Append("]}");
            hdnHallOccupancy.Value = sbOcc.ToString();

        }

        // ── Helpers ─────────────────────────────────────────────────
        string Scalar(string sql)
        {
            try
            {
                DataTable dt = DBHelper.GetData(sql);
                if (dt.Rows.Count > 0 && dt.Rows[0][0] != DBNull.Value)
                    return dt.Rows[0][0].ToString();
            }
            catch { }
            return "0";
        }

        string TableToJson(DataTable dt, string labelCol, string valueCol)
        {
            var labels = new System.Collections.Generic.List<string>();
            var values = new System.Collections.Generic.List<double>();
            foreach (DataRow row in dt.Rows)
            {
                labels.Add(row[labelCol].ToString()
                    .Replace("\\", "").Replace("\"", "'"));
                double v;
                double.TryParse(row[valueCol].ToString(), out v);
                values.Add(Math.Round(v, 2));
            }
            var sb = new StringBuilder("{\"labels\":[");
            sb.Append(string.Join(",",
                labels.ConvertAll(l => "\"" + l + "\"")));
            sb.Append("],\"values\":[");
            sb.Append(string.Join(",",
                values.ConvertAll(v => v.ToString())));
            sb.Append("]}");
            return sb.ToString();
        }
    }
}