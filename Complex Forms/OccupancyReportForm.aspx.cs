using System;
using System.Data;

namespace KumariCinemas
{
    public partial class OccupancyReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
                pnlMovieBanner.Visible = false;
                pnlPodium.Visible = false;
            }
        }

        void LoadMovies()
        {
            ddlMovie.DataSource = DBHelper.GetData("SELECT MovieID, MovieTitle FROM Movie ORDER BY MovieTitle");
            ddlMovie.DataBind();
            ddlMovie.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Movie --", "0"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlMovie.SelectedValue == "0") return;

            int movieID = int.Parse(ddlMovie.SelectedValue);

            // Movie info
            DataTable dtMovie = DBHelper.GetData(
                $"SELECT MovieTitle, Genre, Language, Duration FROM Movie WHERE MovieID = {movieID}");

            if (dtMovie.Rows.Count > 0)
            {
                pnlMovieBanner.Visible = true;
                lblMovieTitle.Text = dtMovie.Rows[0]["MOVIETITLE"].ToString();
                lblGenre.Text = dtMovie.Rows[0]["GENRE"].ToString();
                lblLanguage.Text = dtMovie.Rows[0]["LANGUAGE"].ToString();
                lblDuration.Text = dtMovie.Rows[0]["DURATION"].ToString();
            }

            // Occupancy query — paid tickets only, top 3
            string query = $@"SELECT ROWNUM AS RANK, theatreName, theatreCity, HallName, HallCapacity, PaidTickets, OccupancyPct
                  FROM (
                      SELECT
                          t.theatreName,
                          t.theatreCity,
                          h.HallName,
                          h.HallCapacity,
                          COUNT(tk.TicketID) AS PaidTickets,
                          ROUND(COUNT(tk.TicketID) * 100 / TO_NUMBER(h.HallCapacity), 2) AS OccupancyPct
                      FROM Show s
                      JOIN Hall h ON s.HallID = h.HallID
                      JOIN Theatre t ON h.theatreId = t.theatreID
                      LEFT JOIN Ticket tk ON tk.ShowID = s.ShowID AND UPPER(tk.Bookingstatus) = 'PAID'
                      WHERE s.MovieID = {movieID}
                      GROUP BY t.theatreName, t.theatreCity, h.HallName, h.HallCapacity
                      ORDER BY OccupancyPct DESC
                  )
                  WHERE ROWNUM <= 3";

            DataTable dtOccupancy = DBHelper.GetData(query);
            gvOccupancy.DataSource = dtOccupancy;
            gvOccupancy.DataBind();
            lblResultCount.Text = $"{dtOccupancy.Rows.Count} theatre(s) found";

            // Fill podium cards
            pnlPodium.Visible = dtOccupancy.Rows.Count > 0;

            if (dtOccupancy.Rows.Count >= 1)
            {
                lblName1.Text = dtOccupancy.Rows[0]["THEATRENAME"].ToString();
                lblCity1.Text = dtOccupancy.Rows[0]["THEATRECITY"].ToString();
                lblPct1.Text = dtOccupancy.Rows[0]["OCCUPANCYPCT"].ToString();
                lblTickets1.Text = dtOccupancy.Rows[0]["PAIDTICKETS"].ToString();
                lblCapacity1.Text = dtOccupancy.Rows[0]["HALLCAPACITY"].ToString();
                hfPct1.Value = dtOccupancy.Rows[0]["OCCUPANCYPCT"].ToString();
            }
            if (dtOccupancy.Rows.Count >= 2)
            {
                lblName2.Text = dtOccupancy.Rows[1]["THEATRENAME"].ToString();
                lblCity2.Text = dtOccupancy.Rows[1]["THEATRECITY"].ToString();
                lblPct2.Text = dtOccupancy.Rows[1]["OCCUPANCYPCT"].ToString();
                lblTickets2.Text = dtOccupancy.Rows[1]["PAIDTICKETS"].ToString();
                lblCapacity2.Text = dtOccupancy.Rows[1]["HALLCAPACITY"].ToString();
                hfPct2.Value = dtOccupancy.Rows[1]["OCCUPANCYPCT"].ToString();
            }
            if (dtOccupancy.Rows.Count >= 3)
            {
                lblName3.Text = dtOccupancy.Rows[2]["THEATRENAME"].ToString();
                lblCity3.Text = dtOccupancy.Rows[2]["THEATRECITY"].ToString();
                lblPct3.Text = dtOccupancy.Rows[2]["OCCUPANCYPCT"].ToString();
                lblTickets3.Text = dtOccupancy.Rows[2]["PAIDTICKETS"].ToString();
                lblCapacity3.Text = dtOccupancy.Rows[2]["HALLCAPACITY"].ToString();
                hfPct3.Value = dtOccupancy.Rows[2]["OCCUPANCYPCT"].ToString();
            }
        }
    }
}