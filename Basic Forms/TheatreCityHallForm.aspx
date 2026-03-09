<%@ Page Title="Theatre & Hall" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreCityHallForm.aspx.cs" Inherits="KumariCinemas.TheatreCityHall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Inter:wght@300;400;500&display=swap');

        .page-header {
            display: flex; align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 32px; padding-bottom: 24px;
            border-bottom: 2px solid #1a1a1a;
        }
        .page-header-left h2 {
            font-family: 'Syne', sans-serif; font-size: 52px;
            font-weight: 800; line-height: 1; letter-spacing: -2px; color: #1a1a1a;
        }
        .page-header-left p { color: #888; font-size: 13px; margin-top: 6px; }
        .page-badge {
            background: #1a1a1a; color: #f5f0e8;
            padding: 8px 18px; border-radius: 100px;
            font-size: 12px; font-weight: 500; letter-spacing: 1px;
        }
        .two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px; }
        .form-card {
            background: #1a1a1a; border-radius: 20px;
            padding: 28px; color: #f5f0e8;
        }
        .form-card h3 {
            font-family: 'Syne', sans-serif; font-size: 16px;
            font-weight: 700; letter-spacing: 1px; text-transform: uppercase;
            color: #c8a96e; margin-bottom: 24px;
        }
        .field { margin-bottom: 16px; }
        .field label {
            display: block; font-size: 10px; letter-spacing: 2px;
            text-transform: uppercase; color: #666; margin-bottom: 6px;
        }
        .field input, .field select {
            width: 100%; background: #111; border: 1px solid #2a2a2a;
            border-radius: 10px; padding: 11px 14px; color: #f5f0e8;
            font-family: 'Inter', sans-serif; font-size: 14px; transition: border-color 0.2s;
        }
        .field input:focus, .field select:focus { outline: none; border-color: #c8a96e; }
        .field input[readonly] { color: #444; cursor: not-allowed; }
        .field select option { background: #1a1a1a; }
        .btn-group { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-top: 22px; }
        .btn {
            padding: 11px; border: none; border-radius: 10px;
            font-family: 'Inter', sans-serif; font-size: 13px;
            font-weight: 500; cursor: pointer; transition: all 0.2s;
        }
        .btn:hover { opacity: 0.85; transform: translateY(-1px); }
        .btn-add { background: #c8a96e; color: #1a1a1a; grid-column: span 2; }
        .btn-update { background: #2a3a5a; color: #7eb3ff; }
        .btn-delete { background: #3a1a1a; color: #ff7e7e; }
        .btn-clear { background: #222; color: #666; grid-column: span 2; border: 1px solid #2a2a2a; }
        .msg-box {
            margin-top: 14px; padding: 10px 14px; border-radius: 8px;
            font-size: 12px; background: #111; border: 1px solid #2a2a2a; min-height: 36px;
        }
        .table-card { background: white; border-radius: 20px; overflow: hidden; border: 1px solid #e8e0d0; }
        .table-card-header {
            padding: 20px 24px; border-bottom: 1px solid #e8e0d0;
            display: flex; align-items: center; justify-content: space-between;
        }
        .table-card-header h3 { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; color: #1a1a1a; }
        .table-card-header span { font-size: 12px; color: #aaa; }
        .grid-scroll { overflow-x: auto; }
        table.datagrid { width: 100%; border-collapse: collapse; }
        table.datagrid th {
            background: #faf7f2; padding: 12px 16px; text-align: left;
            font-size: 10px; font-weight: 600; text-transform: uppercase;
            letter-spacing: 1.5px; color: #888; border-bottom: 1px solid #e8e0d0;
        }
        table.datagrid td {
            padding: 13px 16px; border-bottom: 1px solid #f0ebe0; font-size: 13px; color: #333;
        }
        table.datagrid tr:last-child td { border-bottom: none; }
        table.datagrid tr:hover td { background: #faf7f2; }
        table.datagrid a {
            color: #c8a96e; font-size: 12px; font-weight: 500; text-decoration: none;
            padding: 4px 10px; background: #faf0e0; border-radius: 6px;
        }
        table.datagrid a:hover { background: #c8a96e; color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div class="page-header-left">
            <h2>Theatre & Hall</h2>
            <p>Manage theatres, cities and halls</p>
        </div>
        <span class="page-badge">THEATRE MANAGEMENT</span>
    </div>

    <div class="two-col">
        <!-- Theatre Form -->
        <div class="form-card">
            <h3>Theatre Info</h3>
            <div class="field">
                <label>Theatre ID</label>
                <asp:TextBox ID="txtTheatreID" runat="server" ReadOnly="true" placeholder="Auto-generated"/>
            </div>
            <div class="field">
                <label>Theatre Name</label>
                <asp:TextBox ID="txtTheatreName" runat="server" placeholder="Enter name"/>
            </div>
            <div class="field">
                <label>Theatre City</label>
                <asp:TextBox ID="txtTheatreCity" runat="server" placeholder="Enter city"/>
            </div>
            <div class="btn-group">
                <asp:Button ID="btnAddTheatre" runat="server" Text="+ Add Theatre" CssClass="btn btn-add" OnClick="btnAddTheatre_Click"/>
                <asp:Button ID="btnUpdateTheatre" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdateTheatre_Click"/>
                <asp:Button ID="btnDeleteTheatre" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDeleteTheatre_Click"/>
                <asp:Button ID="btnClearTheatre" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClearTheatre_Click"/>
            </div>
            <div class="msg-box"><asp:Label ID="lblTheatreMsg" runat="server"/></div>
        </div>

        <!-- Hall Form -->
        <div class="form-card">
            <h3>Hall Info</h3>
            <div class="field">
                <label>Hall ID</label>
                <asp:TextBox ID="txtHallID" runat="server" ReadOnly="true" placeholder="Auto-generated"/>
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
    </div>

    <!-- Combined Grid -->
    <div class="table-card">
        <div class="table-card-header">
            <h3>All Theatres & Halls</h3>
            <span>Click a row to select</span>
        </div>
        <div class="grid-scroll">
            <asp:GridView ID="gvTheatreCityHall" runat="server"
                AutoGenerateColumns="False"
                OnSelectedIndexChanged="gvTheatreCityHall_SelectedIndexChanged"
                DataKeyNames="HALLID" CssClass="datagrid" GridLines="None">
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
    </div>
</asp:Content>