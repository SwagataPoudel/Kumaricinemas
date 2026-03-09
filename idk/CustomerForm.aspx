%@ Page Title="Customer Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerForm.aspx.cs" Inherits="KumariCinemas.CustomerForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Customer Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" /><br /><br />

    <asp:Button ID="btnAdd" runat="server" Text="+ Add New Customer" OnClick="btnAdd_Click" />
    <br /><br />

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <fieldset>
            <legend>Customer Details</legend>
            <asp:HiddenField ID="hfCustomerID" runat="server" />
            <table>
                <tr>
                    <td>Customer Name:</td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
                            ErrorMessage=" * Name required" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><asp:TextBox ID="txtAddress" runat="server" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <br />

    <asp:GridView ID="gvCustomers" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="CUSTOMERID"
        OnRowEditing="gvCustomers_RowEditing"
        OnRowDeleting="gvCustomers_RowDeleting"
        OnRowCancelingEdit="gvCustomers_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="CUSTOMERID"   HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Customer Name" />
            <asp:BoundField DataField="ADDRESS"      HeaderText="Address" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
