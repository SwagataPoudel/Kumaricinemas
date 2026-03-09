<%@ Page Title="Theatre & Hall Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreHallForm.aspx.cs" Inherits="KumariCinemas.TheatreHallForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Theatre Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" /><br /><br />

    <asp:Button ID="btnAddTheatre" runat="server" Text="+ Add New Theatre" OnClick="btnAddTheatre_Click" />
    <br /><br />

    <asp:Panel ID="pnlTheatreForm" runat="server" Visible="false">
        <fieldset>
            <legend>Theatre Details</legend>
            <asp:HiddenField ID="hfTheatreID" runat="server" />
            <table>
                <tr>
                    <td>Theatre Name:</td>
                    <td>
                        <asp:TextBox ID="txtTheatreName" runat="server" Width="250px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTheatreName"
                            ErrorMessage=" * Name required" ForeColor="Red" ValidationGroup="TheatreGroup" />
                    </td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td>
                        <asp:TextBox ID="txtTheatreCity" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTheatreCity"
                            ErrorMessage=" * City required" ForeColor="Red" ValidationGroup="TheatreGroup" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSaveTheatre" runat="server" Text="Save Theatre" OnClick="btnSaveTheatre_Click" ValidationGroup="TheatreGroup" />
                        &nbsp;
                        <asp:Button ID="btnCancelTheatre" runat="server" Text="Cancel" OnClick="btnCancelTheatre_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <asp:GridView ID="gvTheatres" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="THEATREID"
        OnRowEditing="gvTheatres_RowEditing"
        OnRowDeleting="gvTheatres_RowDeleting"
        OnRowCancelingEdit="gvTheatres_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="THEATREID"   HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre Name" />
            <asp:BoundField DataField="THEATRECITY" HeaderText="City" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

    <hr />

    <h2>Hall Management</h2>

    <asp:Button ID="btnAddHall" runat="server" Text="+ Add New Hall" OnClick="btnAddHall_Click" />
    <br /><br />

    <asp:Panel ID="pnlHallForm" runat="server" Visible="false">
        <fieldset>
            <legend>Hall Details</legend>
            <asp:HiddenField ID="hfHallID" runat="server" />
            <table>
                <tr>
                    <td>Hall Name:</td>
                    <td>
                        <asp:TextBox ID="txtHallName" runat="server" Width="250px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHallName"
                            ErrorMessage=" * Name required" ForeColor="Red" ValidationGroup="HallGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Capacity:</td>
                    <td>
                        <asp:TextBox ID="txtHallCapacity" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHallCapacity"
                            ErrorMessage=" * Capacity required" ForeColor="Red" ValidationGroup="HallGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Theatre:</td>
                    <td>
                        <asp:DropDownList ID="ddlTheatre" runat="server"
                            DataValueField="THEATREID" DataTextField="THEATRENAME" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSaveHall" runat="server" Text="Save Hall" OnClick="btnSaveHall_Click" ValidationGroup="HallGroup" />
                        &nbsp;
                        <asp:Button ID="btnCancelHall" runat="server" Text="Cancel" OnClick="btnCancelHall_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <asp:GridView ID="gvHalls" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="HALLID"
        OnRowEditing="gvHalls_RowEditing"
        OnRowDeleting="gvHalls_RowDeleting"
        OnRowCancelingEdit="gvHalls_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="HALLID"       HeaderText="Hall ID" ReadOnly="true" />
            <asp:BoundField DataField="HALLNAME"     HeaderText="Hall Name" />
            <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity" />
            <asp:BoundField DataField="THEATRENAME"  HeaderText="Theatre" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
