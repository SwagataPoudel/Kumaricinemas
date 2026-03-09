using System;
using System.Data;
using System.Web.UI.WebControls;

namespace KumariCinemas
{
    public partial class Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCustomers();
        }

        void LoadCustomers()
        {
            gvCustomers.DataSource = DBHelper.GetData(
                "SELECT CustomerID, CustomerName, Address FROM Customer ORDER BY CustomerID");
            gvCustomers.DataBind();
        }

        void ClearFields()
        {
            txtCustomerID.Text = "";
            txtCustomerName.Text = "";
            txtAddress.Text = "";
            lblMessage.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int newID = DBHelper.GetNextID("seq_customer");
                txtCustomerID.Text = newID.ToString();
                string query = $@"INSERT INTO Customer (CustomerID, CustomerName, Address) 
                                  VALUES ({newID}, '{txtCustomerName.Text}', '{txtAddress.Text}')";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = $"✓ Customer added — ID: {newID}";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(200, 169, 110);
                LoadCustomers();
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
                string query = $@"UPDATE Customer SET 
                                  CustomerName='{txtCustomerName.Text}', 
                                  Address='{txtAddress.Text}'
                                  WHERE CustomerID={txtCustomerID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "✓ Customer updated successfully";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(126, 179, 255);
                LoadCustomers();
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
                string query = $"DELETE FROM Customer WHERE CustomerID={txtCustomerID.Text}";
                DBHelper.ExecuteQuery(query);
                lblMessage.Text = "✓ Customer deleted";
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
                ClearFields();
                LoadCustomers();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "✗ " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.FromArgb(255, 126, 126);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        protected void gvCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvCustomers.SelectedRow;
            txtCustomerID.Text = row.Cells[1].Text;
            txtCustomerName.Text = row.Cells[2].Text;
            txtAddress.Text = row.Cells[3].Text;
        }
    }
}