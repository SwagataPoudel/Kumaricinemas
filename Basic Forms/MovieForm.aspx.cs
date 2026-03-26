using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadMovies();
        }

        void LoadMovies()
        {
            gvMovies.DataSource = DBHelper.GetData("SELECT * FROM Movie ORDER BY MovieID");
            gvMovies.DataBind();
        }

        void ClearFields()
        {
            txtMovieID.Text = "";
            txtMovieTitle.Text = "";
            txtDuration.Text = "";
            txtLanguage.Text = "";
            txtGenre.Text = "";
            txtReleaseDate.Text = "";
            lblMessage.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtMovieID.Text))
                {
                    lblMessage.Text = "✗ Please enter a Movie ID";
                    lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                    return;
                }

                string query = $@"INSERT INTO Movie (MovieID, MovieTitle, Duration, Language, Genre, ReleaseDate)
                                  VALUES ({txtMovieID.Text}, '{txtMovieTitle.Text}', '{txtDuration.Text}',
                                  '{txtLanguage.Text}', '{txtGenre.Text}', DATE '{txtReleaseDate.Text}')";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Movie added — ID: {txtMovieID.Text}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadMovies();
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
                string query = $@"UPDATE Movie SET MovieTitle='{txtMovieTitle.Text}',
                                  Duration='{txtDuration.Text}', Language='{txtLanguage.Text}',
                                  Genre='{txtGenre.Text}', ReleaseDate=DATE '{txtReleaseDate.Text}'
                                  WHERE MovieID={txtMovieID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "✓ Movie updated successfully";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadMovies();
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
                DBHelper.ExecuteQuery($"DELETE FROM Ticket WHERE ShowID IN (SELECT ShowID FROM Show WHERE MovieID={txtMovieID.Text})");
                DBHelper.ExecuteQuery($"DELETE FROM Show WHERE MovieID={txtMovieID.Text}");
                DBHelper.ExecuteQuery($"DELETE FROM Movie WHERE MovieID={txtMovieID.Text}");
                lblMessage.Text = "✓ Movie deleted";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearFields();
                LoadMovies();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearFields(); }

        protected void gvMovies_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvMovies.SelectedRow;
            txtMovieID.Text = row.Cells[1].Text;
            txtMovieTitle.Text = row.Cells[2].Text;
            txtDuration.Text = row.Cells[3].Text;
            txtLanguage.Text = row.Cells[4].Text;
            txtGenre.Text = row.Cells[5].Text;
            txtReleaseDate.Text = row.Cells[6].Text;
        }
    }
}