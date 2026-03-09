<%@ Page Title="Theatre & Hall" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreCityHall.aspx.cs" Inherits="KumariCinemas.TheatreCityHall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #9C27B0; color: white; padding: 10px; }
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
    <h2>🏛️ TheatreCityHall Details</h2>

    <div class="form-section">
        <h3>Theatre Info</h3>
        <table>
            <tr>
                <td>Theatre ID:</td>
                <td><asp:TextBox ID="txtTheatreID" runat="server" ReadOnly="true" CssClass="readonly" placeholder="Auto-generated"/></td>
                <td>Theatre Name:</td>
                <td><asp:TextBox ID="txtTheatreName" runat="server"/></td>
            </tr>
            <tr>
                <td>Theatre City:</td>
                <td><asp:TextBox ID="txtTheatreCity" runat="server"/></td>
                <td></td><td></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnAddTheatre" runat="server" Text="Add Theatre" CssClass="btn btn-add" OnClick="btnAddTheatre_Click"/>
        <asp:Button ID="btnUpdateTheatre" runat="server" Text="Update Theatre" CssClass="btn btn-update" OnClick="btnUpdateTheatre_Click"/>
        <asp:Button ID="btnDeleteTheatre" runat="server" Text="Delete Theatre" CssClass="btn btn-delete" OnClick="btnDeleteTheatre_Click"/>
        <asp:Button ID="btnClearTheatre" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClearTheatre_Click"/>
        <asp:Label ID="lblTheatreMsg" runat="server"/>
    </div>

    <div class="form-section">
        <h3>Hall Info</h3>
        <table>
            <tr>
                <td>Hall ID:</td>
                <td><asp:TextBox ID="txtHallID" runat="server" ReadOnly="true" CssClass="readonly" placeholder="Auto-generated"/></td>
                <td>Hall Name:</td>
                <td><asp:TextBox ID="txtHallName" runat="server"/></td>
            </tr>
            <tr>
                <td>Hall Capacity:</td>
                <td><asp:TextBox ID="txtHallCapacity" runat="server"/></td>
                <td>Theatre:</td>
                <td>
                    <asp:DropDownList ID="ddlTheatre" runat="server"
                        DataTextField="THEATREINFO" DataValueField="THEATREID"/>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnAddHall" runat="server" Text="Add Hall" CssClass="btn btn-add" OnClick="btnAddHall_Click"/>
        <asp:Button ID="btnUpdateHall" runat="server" Text="Update Hall" CssClass="btn btn-update" OnClick="btnUpdateHall_Click"/>
        <asp:Button ID="btnDeleteHall" runat="server" Text="Delete Hall" CssClass="btn btn-delete" OnClick="btnDeleteHall_Click"/>
        <asp:Button ID="btnClearHall" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClearHall_Click"/>
        <asp:Label ID="lblHallMsg" runat="server"/>
    </div>

    <div class="form-section">
        <h3>TheatreCityHall List</h3>
        <asp:GridView ID="gvTheatreCityHall" runat="server" AutoGenerateColumns="False"
            OnSelectedIndexChanged="gvTheatreCityHall_SelectedIndexChanged"
            DataKeyNames="HALLID" Width="100%"
            HeaderStyle-BackColor="#9C27B0" HeaderStyle-ForeColor="White">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                <asp:BoundField DataField="THEATREID" HeaderText="Theatre ID"/>
                <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre Name"/>
                <asp:BoundField DataField="THEATRECITY" HeaderText="City"/>
                <asp:BoundField DataField="HALLID" HeaderText="Hall ID"/>
                <asp:BoundField DataField="HALLNAME" HeaderText="Hall Name"/>
                <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>