using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class ShowForm : System.Web.UI.Page
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
                "SELECT s.SHOWID, m.MOVIETITLE, " +
                "       h.HALLNAME || ' (' || t.THEATRENAME || ')' AS HALLLABEL, " +
                "       s.SHOWTIME, s.SHOWDATE, s.BASEPRICE, s.ISRELEASEWEEK " +
                "FROM Show s " +
                "JOIN Movie   m ON s.MOVIEID = m.MOVIEID " +
                "JOIN Hall    h ON s.HALLID  = h.HALLID " +
                "JOIN Theatre t ON h.THEATREID = t.THEATREID " +
                "ORDER BY s.SHOWID";
            gvShows.DataSource = DBHelper.GetData(sql);
            gvShows.DataBind();
        }

        void LoadDropdowns()
        {
            ddlMovie.DataSource = DBHelper.GetData(
                "SELECT MOVIEID, MOVIETITLE FROM Movie ORDER BY MOVIEID");
            ddlMovie.DataBind();

            ddlHall.DataSource = DBHelper.GetData(
                "SELECT h.HALLID, h.HALLNAME || ' (' || t.THEATRENAME || ')' AS HALLLABEL " +
                "FROM Hall h JOIN Theatre t ON h.THEATREID = t.THEATREID ORDER BY h.HALLID");
            ddlHall.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            hfShowID.Value   = "";
            txtShowTime.Text = "";
            txtShowDate.Text = "";
            txtBasePrice.Text = "";
            LoadDropdowns();
            ddlIsReleaseWeek.SelectedIndex = 0;
            pnlForm.Visible = true;
            btnAdd.Visible  = false;
            lblMsg.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string movieId     = ddlMovie.SelectedValue;
            string hallId      = ddlHall.SelectedValue;
            string showTime    = txtShowTime.Text.Trim().Replace("'", "''");
            string showDate    = txtShowDate.Text.Trim().ToUpper().Replace("'", "''");
            string basePrice   = txtBasePrice.Text.Trim().Replace("'", "''");
            string releaseWeek = ddlIsReleaseWeek.SelectedValue;

            // Ensure DateSchedule row exists for this date
            DBHelper.ExecuteQuery(
                $"BEGIN " +
                $"  INSERT INTO DateSchedule (ShowDate) VALUES (TO_DATE('{showDate}','DD-MON-YYYY')); " +
                $"EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; " +
                $"END;");

            if (string.IsNullOrEmpty(hfShowID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Show (ShowID, ShowTime, BasePrice, IsReleaseWeek, HallID, ShowDate, MovieID) " +
                    $"VALUES (show_seq.NEXTVAL, '{showTime}', '{basePrice}', '{releaseWeek}', " +
                    $"{hallId}, TO_DATE('{showDate}','DD-MON-YYYY'), {movieId})");
                lblMsg.Text = "Show added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Show SET ShowTime='{showTime}', BasePrice='{basePrice}', " +
                    $"IsReleaseWeek='{releaseWeek}', HallID={hallId}, " +
                    $"ShowDate=TO_DATE('{showDate}','DD-MON-YYYY'), MovieID={movieId} " +
                    $"WHERE ShowID={hfShowID.Value}");
                lblMsg.Text = "Show updated successfully.";
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

        protected void gvShows_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvShows.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Show WHERE ShowID={id}");
            if (dt.Rows.Count > 0)
            {
                hfShowID.Value    = id;
                txtShowTime.Text  = dt.Rows[0]["SHOWTIME"].ToString();
                txtBasePrice.Text = dt.Rows[0]["BASEPRICE"].ToString();
                txtShowDate.Text  = Convert.ToDateTime(dt.Rows[0]["SHOWDATE"])
                                      .ToString("dd-MMM-yyyy").ToUpper();
                LoadDropdowns();
                ddlMovie.SelectedValue        = dt.Rows[0]["MOVIEID"].ToString();
                ddlHall.SelectedValue         = dt.Rows[0]["HALLID"].ToString();
                ddlIsReleaseWeek.SelectedValue = dt.Rows[0]["ISRELEASEWEEK"].ToString();
                pnlForm.Visible = true;
                btnAdd.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvShows_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvShows.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Show WHERE ShowID={id}");
            lblMsg.Text = "Show deleted successfully.";
            LoadGrid();
        }

        protected void gvShows_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvShows.EditIndex = -1;
            LoadGrid();
        }
    }
}
