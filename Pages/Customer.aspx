<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="KumariCinemas.Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #2196F3; color: white; padding: 10px; }
        td { padding: 8px; border: 1px solid #ddd; }
        input, select { width: 100%; padding: 5px; }
        .btn { padding: 8px 15px; margin: 3px; cursor: pointer; border-radius: 4px; }
        .btn-add { background: #4CAF50; color: white; border: none; }
        .btn-update { background: #2196F3; color: white; border: none; }
        .btn-delete { background: #f44336; color: white; border: none; }
        .btn-clear { background: #9E9E9E; color: white; border: none; }
        .form-section { background: white; padding: 20px; margin-bottom: 20px; border-radius: 5px; box-shadow: 0 1px 4px rgba(0,0,0,0.1); }
        .readonly { background: #eeeeee; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>👤 Customer Details</h2>

    <div class="form-section">
        <h3>Add / Update Customer</h3>
        <table>
            <tr>
                <td>Customer ID:</td>
                <td><asp:TextBox ID="txtCustomerID" runat="server" ReadOnly="true" CssClass="readonly" placeholder="Auto-generated"/></td>
                <td>Customer Name:</td>
                <td><asp:TextBox ID="txtCustomerName" runat="server"/></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><asp:TextBox ID="txtAddress" runat="server"/></td>
                <td>Contact No:</td>
                <td><asp:TextBox ID="txtContactNo" runat="server"/></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-add" OnClick="btnAdd_Click"/>
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click"/>
        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDelete_Click"/>
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClear_Click"/>
        <asp:Label ID="lblMessage" runat="server"/>
    </div>

    <div class="form-section">
        <h3>Customer List</h3>
        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False"
            OnSelectedIndexChanged="gvCustomers_SelectedIndexChanged"
            DataKeyNames="CUSTOMERID" Width="100%"
            HeaderStyle-BackColor="#2196F3" HeaderStyle-ForeColor="White">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                <asp:BoundField DataField="CUSTOMERID" HeaderText="ID"/>
                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Name"/>
                <asp:BoundField DataField="ADDRESS" HeaderText="Address"/>
                <asp:BoundField DataField="CONTACTNO" HeaderText="Contact No"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>