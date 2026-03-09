using System;
using System.Data;

namespace KumariCinemas
{
    public partial class TheatreMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTheatreDropdown();
                pnlTheatreBanner.Visible = false;
            }
        }

        void LoadTheatreDropdown()
        {
            ddlTheatre.DataSource = DBHelper.GetData(
                "SELECT theatreID, theatreName || ' - ' || theatreCity AS TheatreInfo FROM Theatre ORDER BY theatreName");
            ddlTheatre.DataBind();
            ddlTheatre.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Theatre --", "0"));

            // Load all halls for default
            ddlHall.Items.Clear();
            ddlHall.Items.Add(new System.Web.UI.WebControls.ListItem("All Halls", "0"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlTheatre.SelectedValue == "0") return;

            int theatreID = int.Parse(ddlTheatre.SelectedValue);
            int hallID = int.Parse(ddlHall.SelectedValue);

            // Theatre info
            DataTable dtTheatre = DBHelper.GetData(
                $"SELECT theatreName, theatreCity FROM Theatre WHERE theatreID = {theatreID}");

            if (dtTheatre.Rows.Count > 0)
            {
                pnlTheatreBanner.Visible = true;
                lblTheatreName.Text = dtTheatre.Rows[0]["theatreNAME"].ToString();
                lblTheatreCity.Text = dtTheatre.Rows[0]["theatreCITY"].ToString();
            }

            // Hall count
            DataTable dtHalls = DBHelper.GetData(
                $"SELECT COUNT(*) FROM Hall WHERE theatreId = {theatreID}");
            lblHallCount.Text = dtHalls.Rows[0][0].ToString();

            // Load halls into dropdown
            ddlHall.Items.Clear();
            ddlHall.Items.Add(new System.Web.UI.WebControls.ListItem("All Halls", "0"));
            DataTable dtHallList = DBHelper.GetData(
                $"SELECT HallID, HallName FROM Hall WHERE theatreId = {theatreID}");
            foreach (DataRow row in dtHallList.Rows)
                ddlHall.Items.Add(new System.Web.UI.WebControls.ListItem(
                    row["HALLNAME"].ToString(), row["HALLID"].ToString()));

            // Shows query
            string hallFilter = hallID > 0 ? $"AND h.HallID = {hallID}" : "";
            string query = $@"SELECT m.MovieTitle, m.Genre, m.Language,
                                     h.HallName, s.ShowDate, s.ShowTime,
                                     s.BasePrice, s.IsReleaseWeek
                              FROM Show s
                              JOIN Movie m ON s.MovieID = m.MovieID
                              JOIN Hall h ON s.HallID = h.HallID
                              JOIN Theatre t ON h.theatreId = t.theatreID
                              WHERE t.theatreID = {theatreID}
                              {hallFilter}
                              ORDER BY s.ShowDate, s.ShowTime";

            DataTable dtShows = DBHelper.GetData(query);
            gvShows.DataSource = dtShows;
            gvShows.DataBind();
            lblResultCount.Text = $"{dtShows.Rows.Count} show(s) found";
        }
    }
}