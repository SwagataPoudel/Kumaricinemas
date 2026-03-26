using System;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class TheatreCityHall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { LoadGrid(); LoadTheatreDropdown(); }
        }

        void LoadGrid()
        {
            string query = @"SELECT h.HallID, h.HallName, h.HallCapacity,
                                    t.TheatreName, t.TheatreCity
                             FROM Hall h
                             JOIN Theatre t ON h.TheatreId = t.TheatreID
                             ORDER BY h.HallID";
            gvTheatreCityHall.DataSource = DBHelper.GetData(query);
            gvTheatreCityHall.DataBind();
        }

        void LoadTheatreDropdown()
        {
            ddlTheatre.DataSource = DBHelper.GetData(
                "SELECT TheatreID, TheatreName || ' - ' || TheatreCity AS TheatreInfo FROM Theatre");
            ddlTheatre.DataBind();
        }

        void ClearHallFields()
        {
            txtHallID.Text = ""; txtHallName.Text = "";
            txtHallCapacity.Text = ""; lblHallMsg.Text = "";
        }

        protected void btnAddHall_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtHallID.Text))
                {
                    lblHallMsg.Text = "✗ Please enter a Hall ID";
                    lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                    return;
                }

                DBHelper.ExecuteQuery($"INSERT INTO Hall VALUES ({txtHallID.Text}, '{txtHallCapacity.Text}', '{txtHallName.Text}', {ddlTheatre.SelectedValue})");
                lblHallMsg.Text = $"✓ Hall added — ID: {txtHallID.Text}";
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "✗ " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnUpdateHall_Click(object sender, EventArgs e)
        {
            try
            {
                DBHelper.ExecuteQuery($"UPDATE Hall SET HallName='{txtHallName.Text}', HallCapacity='{txtHallCapacity.Text}', TheatreId={ddlTheatre.SelectedValue} WHERE HallID={txtHallID.Text}");
                lblHallMsg.Text = "✓ Hall updated";
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "✗ " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnDeleteHall_Click(object sender, EventArgs e)
        {
            try
            {
                DBHelper.ExecuteQuery($"DELETE FROM Ticket WHERE ShowID IN (SELECT ShowID FROM Show WHERE HallID={txtHallID.Text})");
                DBHelper.ExecuteQuery($"DELETE FROM Show WHERE HallID={txtHallID.Text}");
                DBHelper.ExecuteQuery($"DELETE FROM Hall WHERE HallID={txtHallID.Text}");
                lblHallMsg.Text = "✓ Hall deleted";
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearHallFields(); LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "✗ " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClearHall_Click(object sender, EventArgs e) { ClearHallFields(); }

        protected void gvTheatreCityHall_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTheatreCityHall.SelectedRow;
            txtHallID.Text = row.Cells[1].Text;
            txtHallName.Text = row.Cells[2].Text;
            txtHallCapacity.Text = row.Cells[3].Text;
            ddlTheatre.ClearSelection();
            foreach (ListItem item in ddlTheatre.Items)
                if (item.Text.StartsWith(row.Cells[4].Text)) { item.Selected = true; break; }
        }
    }
}