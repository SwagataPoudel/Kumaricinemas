using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class TheatreCityHall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrid();
                LoadTheatreDropdown();
            }
        }

        void LoadGrid()
        {
            string query = @"SELECT t.TheatreID, t.TheatreName, t.TheatreCity,
                                    h.HallID, h.HallName, h.HallCapacity
                             FROM Theatre t
                             JOIN Hall h ON t.TheatreID = h.TheatreID
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
            txtTheatreID.Text = "";
            txtTheatreName.Text = "";
            txtTheatreCity.Text = "";
            lblTheatreMsg.Text = "";
        }

        void ClearHallFields()
        {
            txtHallID.Text = "";
            txtHallName.Text = "";
            txtHallCapacity.Text = "";
            lblHallMsg.Text = "";
        }

        // Theatre CRUD
        protected void btnAddTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_theatre");
                txtTheatreID.Text = newID.ToString();
                string query = $"INSERT INTO Theatre VALUES ({newID}, '{txtTheatreName.Text}', '{txtTheatreCity.Text}')";
                DBHelper.ExecuteQuery(query);
                lblTheatreMsg.Text = $"Theatre added with ID: {newID}";
                lblTheatreMsg.ForeColor = System.Drawing.Color.Green;
                LoadGrid();
                LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "Error: " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnUpdateTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $"UPDATE Theatre SET TheatreName='{txtTheatreName.Text}', TheatreCity='{txtTheatreCity.Text}' WHERE TheatreID={txtTheatreID.Text}";
                DBHelper.ExecuteQuery(query);
                lblTheatreMsg.Text = "Theatre updated!";
                lblTheatreMsg.ForeColor = System.Drawing.Color.Blue;
                LoadGrid();
                LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "Error: " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnDeleteTheatre_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $"DELETE FROM Theatre WHERE TheatreID={txtTheatreID.Text}";
                DBHelper.ExecuteQuery(query);
                lblTheatreMsg.Text = "Theatre deleted!";
                lblTheatreMsg.ForeColor = System.Drawing.Color.Red;
                ClearTheatreFields();
                LoadGrid();
                LoadTheatreDropdown();
            }
            catch (Exception ex)
            {
                lblTheatreMsg.Text = "Error: " + ex.Message;
                lblTheatreMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnClearTheatre_Click(object sender, EventArgs e)
        {
            ClearTheatreFields();
        }

        // Hall CRUD
        protected void btnAddHall_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_hall");
                txtHallID.Text = newID.ToString();
                string query = $"INSERT INTO Hall VALUES ({newID}, {txtHallCapacity.Text}, {ddlTheatre.SelectedValue}, '{txtHallName.Text}')";
                DBHelper.ExecuteQuery(query);
                lblHallMsg.Text = $"Hall added with ID: {newID}";
                lblHallMsg.ForeColor = System.Drawing.Color.Green;
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "Error: " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnUpdateHall_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $"UPDATE Hall SET HallName='{txtHallName.Text}', HallCapacity={txtHallCapacity.Text}, TheatreID={ddlTheatre.SelectedValue} WHERE HallID={txtHallID.Text}";
                DBHelper.ExecuteQuery(query);
                lblHallMsg.Text = "Hall updated!";
                lblHallMsg.ForeColor = System.Drawing.Color.Blue;
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "Error: " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnDeleteHall_Click(object sender, EventArgs e)
        {
            try
            {
                string query = $"DELETE FROM Hall WHERE HallID={txtHallID.Text}";
                DBHelper.ExecuteQuery(query);
                lblHallMsg.Text = "Hall deleted!";
                lblHallMsg.ForeColor = System.Drawing.Color.Red;
                ClearHallFields();
                LoadGrid();
            }
            catch (Exception ex)
            {
                lblHallMsg.Text = "Error: " + ex.Message;
                lblHallMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnClearHall_Click(object sender, EventArgs e)
        {
            ClearHallFields();
        }

        protected void gvTheatreCityHall_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTheatreCityHall.SelectedRow;
            txtTheatreID.Text = row.Cells[1].Text;
            txtTheatreName.Text = row.Cells[2].Text;
            txtTheatreCity.Text = row.Cells[3].Text;
            txtHallID.Text = row.Cells[4].Text;
            txtHallName.Text = row.Cells[5].Text;
            txtHallCapacity.Text = row.Cells[6].Text;

            // Match Theatre dropdown
            ddlTheatre.ClearSelection();
            foreach (System.Web.UI.WebControls.ListItem item in ddlTheatre.Items)
            {
                if (item.Text.StartsWith(row.Cells[2].Text))
                {
                    item.Selected = true;
                    break;
                }
            }
        }
    }
}