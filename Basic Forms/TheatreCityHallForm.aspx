<%@ Page Title="Hall" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreCityHallForm.aspx.cs" Inherits="KumariCinemas.TheatreCityHall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .page-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 24px;
            padding-bottom: 18px;
            border-bottom: 1px solid #e5e0d8;
        }
        .page-header h2 {
            font-size: 36px;
            font-weight: 600;
            letter-spacing: -0.5px;
            color: #1c1c1c;
        }
        .page-header p {
            color: #888;
            font-size: 15px;
            margin-top: 5px;
        }
        .page-badge {
            background: #f2ede6;
            color: #b07d3a;
            padding: 7px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            letter-spacing: 0.4px;
        }
        .form-card {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
        }
        .form-card h3 {
            font-size: 11px;
            font-weight: 500;
            color: #b07d3a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }
        .field { margin-bottom: 16px; }
        .field label {
            display: block;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.7px;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 6px;
        }
        .field input, .field select {
            width: 100%;
            background: #fafaf8;
            border: 1px solid #e8e4de;
            border-radius: 7px;
            padding: 10px 13px;
            color: #1c1c1c;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            transition: border-color 0.15s;
        }
        .field input:focus, .field select:focus { outline: none; border-color: #b07d3a; }
        .field input[readonly] { color: #bbb; cursor: not-allowed; background: #f5f5f3; }
        .field select { appearance: auto; }
        .btn-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px;
            border: 1px solid #e8e4de;
            border-radius: 7px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.15s;
            text-align: center;
            background: #fafaf8;
            color: #555;
        }
        .btn:hover { background: #f2ede6; border-color: #d4c9b8; color: #1c1c1c; }
        .btn-add {
            background: #b07d3a;
            color: #fff;
            border-color: #b07d3a;
            grid-column: span 2;
            font-size: 15px;
        }
        .btn-add:hover { background: #9a6c30; border-color: #9a6c30; }
        .btn-delete { color: #c0392b; border-color: #f0d5d3; background: #fdf5f5; }
        .btn-delete:hover { background: #fbeae9; border-color: #e8b4b0; }
        .btn-clear { grid-column: span 2; }
        .msg-box {
            margin-top: 14px;
            padding: 10px 12px;
            border-radius: 7px;
            font-size: 13px;
            background: #fafaf8;
            border: 1px solid #e8e4de;
            min-height: 38px;
            color: #666;
        }
        .table-card {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e8e4de;
        }
        .table-card-header {
            padding: 18px 22px;
            border-bottom: 1px solid #e8e4de;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .table-card-header h3 {
            font-size: 16px;
            font-weight: 500;
            color: #1c1c1c;
        }
        .table-card-header span { font-size: 13px; color: #aaa; }
        .grid-scroll { overflow-x: auto; }
        table.datagrid { width: 100%; border-collapse: collapse; }
        table.datagrid th {
            background: #fafaf8;
            padding: 11px 16px;
            text-align: left;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: #999;
            border-bottom: 1px solid #e8e4de;
        }
        table.datagrid td {
            padding: 13px 16px;
            border-bottom: 1px solid #f0ebe0;
            font-size: 15px;
            color: #333;
        }
        table.datagrid tr:last-child td { border-bottom: none; }
        table.datagrid tr:hover td { background: #fdfaf6; }
        table.datagrid a {
            color: #b07d3a;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            padding: 4px 10px;
            background: #f2ede6;
            border-radius: 5px;
        }
        table.datagrid a:hover { background: #b07d3a; color: #fff; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div>
            <h2>Hall</h2>
            <p>Manage halls</p>
        </div>
        <span class="page-badge">Hall Management</span>
    </div>

    <div class="form-card">
        <h3>Hall Info</h3>
        <div class="field">
            <label>Hall ID</label>
            <asp:TextBox ID="txtHallID" runat="server" placeholder="Enter Hall ID"/>
        </div>
        <div class="field">
            <label>Hall Name</label>
            <asp:TextBox ID="txtHallName" runat="server" placeholder="Enter hall name"/>
        </div>
        <div class="field">
            <label>Hall Capacity</label>
            <asp:TextBox ID="txtHallCapacity" runat="server" placeholder="Enter capacity"/>
        </div>
        <div class="field">
            <label>Theatre</label>
            <asp:DropDownList ID="ddlTheatre" runat="server"
                DataTextField="THEATREINFO" DataValueField="THEATREID"/>
        </div>
        <div class="btn-group">
            <asp:Button ID="btnAddHall" runat="server" Text="+ Add Hall" CssClass="btn btn-add" OnClick="btnAddHall_Click"/>
            <asp:Button ID="btnUpdateHall" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdateHall_Click"/>
            <asp:Button ID="btnDeleteHall" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDeleteHall_Click"/>
            <asp:Button ID="btnClearHall" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClearHall_Click"/>
        </div>
        <div class="msg-box"><asp:Label ID="lblHallMsg" runat="server"/></div>
    </div>

    <div class="table-card">
        <div class="table-card-header">
            <h3>All Halls</h3>
            <span>Click a row to select</span>
        </div>
        <div class="grid-scroll">
            <asp:GridView ID="gvTheatreCityHall" runat="server"
                AutoGenerateColumns="False"
                OnSelectedIndexChanged="gvTheatreCityHall_SelectedIndexChanged"
                DataKeyNames="HALLID" CssClass="datagrid" GridLines="None">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                    <asp:BoundField DataField="HALLID" HeaderText="Hall ID"/>
                    <asp:BoundField DataField="HALLNAME" HeaderText="Hall Name"/>
                    <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity"/>
                    <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre"/>
                    <asp:BoundField DataField="THEATRECITY" HeaderText="City"/>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>