using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class CustomerForm : System.Web.UI.Page
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
            gvCustomers.DataSource = DBHelper.GetData(
                "SELECT CUSTOMERID, CUSTOMERNAME, ADDRESS FROM Customer ORDER BY CUSTOMERID");
            gvCustomers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            hfCustomerID.Value = "";
            txtName.Text = "";
            txtAddress.Text = "";
            pnlForm.Visible = true;
            btnAdd.Visible = false;
            lblMsg.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name    = txtName.Text.Trim().Replace("'", "''");
            string address = txtAddress.Text.Trim().Replace("'", "''");

            if (string.IsNullOrEmpty(hfCustomerID.Value))
            {
                DBHelper.ExecuteQuery(
                    $"INSERT INTO Customer (CustomerID, CustomerName, Address) " +
                    $"VALUES (customer_seq.NEXTVAL, '{name}', '{address}')");
                lblMsg.Text = "Customer added successfully.";
            }
            else
            {
                DBHelper.ExecuteQuery(
                    $"UPDATE Customer SET CustomerName='{name}', Address='{address}' " +
                    $"WHERE CustomerID={hfCustomerID.Value}");
                lblMsg.Text = "Customer updated successfully.";
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

        protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string id = gvCustomers.DataKeys[e.NewEditIndex].Value.ToString();
            DataTable dt = DBHelper.GetData($"SELECT * FROM Customer WHERE CustomerID={id}");
            if (dt.Rows.Count > 0)
            {
                hfCustomerID.Value = id;
                txtName.Text    = dt.Rows[0]["CUSTOMERNAME"].ToString();
                txtAddress.Text = dt.Rows[0]["ADDRESS"].ToString();
                pnlForm.Visible = true;
                btnAdd.Visible  = false;
                lblMsg.Text = "";
            }
        }

        protected void gvCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvCustomers.DataKeys[e.RowIndex].Value.ToString();
            DBHelper.ExecuteQuery($"DELETE FROM Customer WHERE CustomerID={id}");
            lblMsg.Text = "Customer deleted successfully.";
            LoadGrid();
        }

        protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCustomers.EditIndex = -1;
            LoadGrid();
        }
    }
}
