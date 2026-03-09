using System;
using System.Data;
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
            string query = @"SELECT t.TheatreID, t.TheatreName, t.TheatreCity,
                                    h.HallID, h.HallName, h.HallCapacity
                             FROM Theatre t
                             JOIN Hall h ON t.TheatreID = h.TheatreId
                             ORDER BY t.TheatreID";
            gvTheatreCityHall.DataSource = DBHelper.GetData(query);
            gvTheatreCityHall.DataBind();
        }

        void LoadTheatreDropdown()
        {
            ddlTheatre.DataSource = DBHelper.GetData(
                "SELECT TheatreID, TheatreName || ' - ' || TheatreCity AS TheatreInfo FROM Theatre");
            ddlTheatre.DataBind();
        }

        void ClearTheatreFields()
        {
            txtTheatreID.Text = ""; txtTheatreName.Text = "";
            txtTheatreCity.Text = ""; lblTheatreMsg.Text = "";
        }

        void ClearHallFields()
        {
            txtHallID.Text = ""; txtHallName.Text = "";
            txtHallCapacity.Text = ""; lblHallMsg.Text = "";
        }

        protected void btnAddTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_theatre");
                txtTheatreID.Text = newID.ToString();
                DBHelper.ExecuteQuery($"INSERT INTO Theatre VALUES ({newID}, '{txtTheatreName.Text}', '{txtTheatreCity.Text}')");
                lblTheatreMsg.Text = $"✓ Theatre added — ID: {newID}";
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadGrid(); LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "✗ " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnUpdateTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                DBHelper.ExecuteQuery($"UPDATE Theatre SET TheatreName='{txtTheatreName.Text}', TheatreCity='{txtTheatreCity.Text}' WHERE TheatreID={txtTheatreID.Text}");
                lblTheatreMsg.Text = "✓ Theatre updated";
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadGrid(); LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "✗ " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnDeleteTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                DBHelper.ExecuteQuery($"DELETE FROM Theatre WHERE TheatreID={txtTheatreID.Text}");
                lblTheatreMsg.Text = "✓ Theatre deleted";
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearTheatreFields(); LoadGrid(); LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "✗ " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClearTheatre_Click(object sender, EventArgs e) { ClearTheatreFields(); }

        protected void btnAddHall_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_hall");
                txtHallID.Text = newID.ToString();
                DBHelper.ExecuteQuery($"INSERT INTO Hall VALUES ({newID}, '{txtHallCapacity.Text}', '{txtHallName.Text}', {ddlTheatre.SelectedValue})");
                lblHallMsg.Text = $"✓ Hall added — ID: {newID}";
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
            txtTheatreID.Text = row.Cells[1].Text;
            txtTheatreName.Text = row.Cells[2].Text;
            txtTheatreCity.Text = row.Cells[3].Text;
            txtHallID.Text = row.Cells[4].Text;
            txtHallName.Text = row.Cells[5].Text;
            txtHallCapacity.Text = row.Cells[6].Text;
            ddlTheatre.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlTheatre.Items)
                if (item.Text.StartsWith(row.Cells[2].Text)) { item.Selected = true; break; }
        }
    }
}