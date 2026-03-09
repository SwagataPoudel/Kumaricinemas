using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class TheatreHallForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlTheatreForm.Visible = false;
                pnlHallForm.Visible    = false;
                LoadTheatreGrid();
                LoadHallGrid();
            }
        }

        // ── Data loaders ────────────────────────────────────────────

        void LoadTheatreGrid()
        {
            gvTheatres.DataSource = DBHelper.GetData(
                "SELECT THEATREID, THEATRENAME, THEATRECITY FROM Theatre ORDER BY THEATREID");
            gvTheatres.DataBind();
        }

        void LoadHallGrid()
        {
            gvHalls.DataSource = DBHelper.GetData(
                "SELECT h.HALLID, h.HALLNAME, h.HALLCAPACITY, t.THEATRENAME " +
                "FROM Hall h JOIN Theatre t ON h.THEATREID = t.THEATREID " +
                "ORDER BY h.HALLID");
            gvHalls.DataBind();
        }

        void LoadTheatreDropdown()
        {
            ddlTheatre.DataSource = DBHelper.GetData(
                "SELECT THEATREID, THEATRENAME FROM Theatre ORDER BY THEATREID");
            ddlTheatre.DataBind();
        }

        // ── Theatre CRUD ─────────────────────────────────────────────

        protected void btnAddTheatre_Click(object sender, EventArgs e)
        {
            hfTheatreID.Value   = "";
            txtTheatreName.Text = "";
            txtTheatreCity.Text = "";
            pnlTheatreForm.Visible = true;
            btnAddTheatre.Visible  = false;
            lblMsg.Text = "";
        }

        protected void btnSaveTheatre_Click(object sender, EventArgs e)
        {
            string name = txtTheatreName.Text.Trim().Replace("'", "''");
            string city = txtTheatreCity.Text.Trim().Replace("'", "''");

            if (string.IsNullOrEmpty(hfTheatreID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Theatre (TheatreID, TheatreName, TheatreCity) " +
                    $"VALUES (theatre_seq.NEXTVAL, '{name}', '{city}')");
                lblMsg.Text = "Theatre added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Theatre SET TheatreName='{name}', TheatreCity='{city}' " +
                    $"WHERE TheatreID={hfTheatreID.Value}");
                lblMsg.Text = "Theatre updated successfully.";
            }

            pnlTheatreForm.Visible = false;
            btnAddTheatre.Visible  = true;
            LoadTheatreGrid();
            LoadHallGrid();
        }

        protected void btnCancelTheatre_Click(object sender, EventArgs e)
        {
            pnlTheatreForm.Visible = false;
            btnAddTheatre.Visible  = true;
            lblMsg.Text = "";
        }

        protected void gvTheatres_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvTheatres.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Theatre WHERE TheatreID={id}");
            if (dt.Rows.Count > 0)
            {
                hfTheatreID.Value   = id;
                txtTheatreName.Text = dt.Rows[0]["THEATRENAME"].ToString();
                txtTheatreCity.Text = dt.Rows[0]["THEATRECITY"].ToString();
                pnlTheatreForm.Visible = true;
                btnAddTheatre.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvTheatres_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvTheatres.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Theatre WHERE TheatreID={id}");
            lblMsg.Text = "Theatre deleted successfully.";
            LoadTheatreGrid();
            LoadHallGrid();
        }

        protected void gvTheatres_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTheatres.EditIndex = -1;
            LoadTheatreGrid();
        }

        // ── Hall CRUD ────────────────────────────────────────────────

        protected void btnAddHall_Click(object sender, EventArgs e)
        {
            hfHallID.Value       = "";
            txtHallName.Text     = "";
            txtHallCapacity.Text = "";
            LoadTheatreDropdown();
            pnlHallForm.Visible = true;
            btnAddHall.Visible  = false;
            lblMsg.Text = "";
        }

        protected void btnSaveHall_Click(object sender, EventArgs e)
        {
            string name      = txtHallName.Text.Trim().Replace("'", "''");
            string capacity  = txtHallCapacity.Text.Trim().Replace("'", "''");
            string theatreId = ddlTheatre.SelectedValue;

            if (string.IsNullOrEmpty(hfHallID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Hall (HallID, HallName, HallCapacity, TheatreId) " +
                    $"VALUES (hall_seq.NEXTVAL, '{name}', '{capacity}', {theatreId})");
                lblMsg.Text = "Hall added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Hall SET HallName='{name}', HallCapacity='{capacity}', " +
                    $"TheatreId={theatreId} WHERE HallID={hfHallID.Value}");
                lblMsg.Text = "Hall updated successfully.";
            }

            pnlHallForm.Visible = false;
            btnAddHall.Visible  = true;
            LoadHallGrid();
        }

        protected void btnCancelHall_Click(object sender, EventArgs e)
        {
            pnlHallForm.Visible = false;
            btnAddHall.Visible  = true;
            lblMsg.Text = "";
        }

        protected void gvHalls_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvHalls.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Hall WHERE HallID={id}");
            if (dt.Rows.Count > 0)
            {
                hfHallID.Value       = id;
                txtHallName.Text     = dt.Rows[0]["HALLNAME"].ToString();
                txtHallCapacity.Text = dt.Rows[0]["HALLCAPACITY"].ToString();
                LoadTheatreDropdown();
                ddlTheatre.SelectedValue = dt.Rows[0]["THEATREID"].ToString();
                pnlHallForm.Visible = true;
                btnAddHall.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvHalls_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvHalls.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Hall WHERE HallID={id}");
            lblMsg.Text = "Hall deleted successfully.";
            LoadHallGrid();
        }

        protected void gvHalls_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvHalls.EditIndex = -1;
            LoadHallGrid();
        }
    }
}
