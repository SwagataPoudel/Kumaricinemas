using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class MovieForm : System.Web.UI.Page
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
            gvMovies.DataSource = DBHelper.GetData(
                "SELECT MOVIEID, MOVIETITLE, DURATION, LANGUAGE, GENRE, RELEASEDATE " +
                "FROM Movie ORDER BY MOVIEID");
            gvMovies.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            hfMovieID.Value = "";
            txtTitle.Text = "";
            txtDuration.Text = "";
            txtLanguage.Text = "";
            txtGenre.Text = "";
            txtReleaseDate.Text = "";
            pnlForm.Visible = true;
            btnAdd.Visible = false;
            lblMsg.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string title    = txtTitle.Text.Trim().Replace("'", "''");
            string duration = txtDuration.Text.Trim().Replace("'", "''");
            string lang     = txtLanguage.Text.Trim().Replace("'", "''");
            string genre    = txtGenre.Text.Trim().Replace("'", "''");
            string rdate    = txtReleaseDate.Text.Trim().ToUpper().Replace("'", "''");

            if (string.IsNullOrEmpty(hfMovieID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Movie (MovieID, MovieTitle, Duration, Language, Genre, ReleaseDate) " +
                    $"VALUES (movie_seq.NEXTVAL, '{title}', '{duration}', '{lang}', '{genre}', " +
                    $"TO_DATE('{rdate}','DD-MON-YYYY'))");
                lblMsg.Text = "Movie added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Movie SET MovieTitle='{title}', Duration='{duration}', " +
                    $"Language='{lang}', Genre='{genre}', " +
                    $"ReleaseDate=TO_DATE('{rdate}','DD-MON-YYYY') " +
                    $"WHERE MovieID={hfMovieID.Value}");
                lblMsg.Text = "Movie updated successfully.";
            }

            pnlForm.Visible = false;
            btnAdd.Visible = true;
            LoadGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            btnAdd.Visible = true;
            lblMsg.Text = "";
        }

        protected void gvMovies_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvMovies.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Movie WHERE MovieID={id}");
            if (dt.Rows.Count > 0)
            {
                hfMovieID.Value     = id;
                txtTitle.Text       = dt.Rows[0]["MOVIETITLE"].ToString();
                txtDuration.Text    = dt.Rows[0]["DURATION"].ToString();
                txtLanguage.Text    = dt.Rows[0]["LANGUAGE"].ToString();
                txtGenre.Text       = dt.Rows[0]["GENRE"].ToString();
                txtReleaseDate.Text = Convert.ToDateTime(dt.Rows[0]["RELEASEDATE"])
                                        .ToString("dd-MMM-yyyy").ToUpper();
                pnlForm.Visible = true;
                btnAdd.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvMovies_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvMovies.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Movie WHERE MovieID={id}");
            lblMsg.Text = "Movie deleted successfully.";
            LoadGrid();
        }

        protected void gvMovies_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMovies.EditIndex = -1;
            LoadGrid();
        }
    }
}
