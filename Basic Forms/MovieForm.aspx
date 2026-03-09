<%@ Page Title="Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MovieForm.aspx.cs" Inherits="KumariCinemas.Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Inter:wght@300;400;500&display=swap');

        .page-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 2px solid #1a1a1a;
        }
        .page-header-left h2 {
            font-family: 'Syne', sans-serif;
            font-size: 52px;
            font-weight: 800;
            line-height: 1;
            letter-spacing: -2px;
            color: #1a1a1a;
        }
        .page-header-left p { color: #888; font-size: 13px; margin-top: 6px; }
        .page-badge {
            background: #1a1a1a;
            color: #f5f0e8;
            padding: 8px 18px;
            border-radius: 100px;
            font-size: 12px;
            font-weight: 500;
            letter-spacing: 1px;
        }
        .layout { display: grid; grid-template-columns: 360px 1fr; gap: 24px; align-items: start; }
        .form-card {
            background: #1a1a1a;
            border-radius: 20px;
            padding: 28px;
            color: #f5f0e8;
            position: sticky;
            top: 88px;
        }
        .form-card h3 {
            font-family: 'Syne', sans-serif;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #c8a96e;
            margin-bottom: 24px;
        }
        .field { margin-bottom: 16px; }
        .field label {
            display: block;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #666;
            margin-bottom: 6px;
        }
        .field input, .field select {
            width: 100%;
            background: #111;
            border: 1px solid #2a2a2a;
            border-radius: 10px;
            padding: 11px 14px;
            color: #f5f0e8;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        .field input:focus, .field select:focus { outline: none; border-color: #c8a96e; }
        .field input[readonly] { color: #444; cursor: not-allowed; }
        .field select option { background: #1a1a1a; }
        .btn-group { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-top: 22px; }
        .btn {
            padding: 11px;
            border: none;
            border-radius: 10px;
            font-family: 'Inter', sans-serif;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn:hover { opacity: 0.85; transform: translateY(-1px); }
        .btn-add { background: #c8a96e; color: #1a1a1a; grid-column: span 2; }
        .btn-update { background: #2a3a5a; color: #7eb3ff; }
        .btn-delete { background: #3a1a1a; color: #ff7e7e; }
        .btn-clear {  background: #2a3a5a; color: #7eb3ff; grid-column: span 2; border: 1px solid #2a2a2a; }
        .msg-box {
            margin-top: 14px;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 12px;
            background: #111;
            border: 1px solid #2a2a2a;
            min-height: 36px;
        }
        .table-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #e8e0d0;
        }
        .table-card-header {
            padding: 20px 24px;
            border-bottom: 1px solid #e8e0d0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .table-card-header h3 {
            font-family: 'Syne', sans-serif;
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
        }
        .table-card-header span { font-size: 12px; color: #aaa; }
        .grid-scroll { overflow-x: auto; }
        table.datagrid { width: 100%; border-collapse: collapse; }
        table.datagrid th {
            background: #faf7f2;
            padding: 12px 16px;
            text-align: left;
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: #888;
            border-bottom: 1px solid #e8e0d0;
        }
        table.datagrid td {
            padding: 13px 16px;
            border-bottom: 1px solid #f0ebe0;
            font-size: 13px;
            color: #333;
        }
        table.datagrid tr:last-child td { border-bottom: none; }
        table.datagrid tr:hover td { background: #faf7f2; }
        table.datagrid a {
            color: #c8a96e;
            font-size: 12px;
            font-weight: 500;
            text-decoration: none;
            padding: 4px 10px;
            background: #faf0e0;
            border-radius: 6px;
        }
        table.datagrid a:hover { background: #c8a96e; color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div class="page-header-left">
            <h2>Movies</h2>
            <p>Manage movie listings and details</p>
        </div>
        <span class="page-badge">MOVIE MANAGEMENT</span>
    </div>

    <div class="layout">
        <div class="form-card">
            <h3>Movie Info</h3>
            <div class="field">
                <label>Movie ID</label>
                <asp:TextBox ID="txtMovieID" runat="server" ReadOnly="true" placeholder="Auto-generated"/>
            </div>
            <div class="field">
                <label>Movie Title</label>
                <asp:TextBox ID="txtMovieTitle" runat="server" placeholder="Enter title"/>
            </div>
            <div class="field">
                <label>Duration</label>
                <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 2h 30m"/>
            </div>
            <div class="field">
                <label>Language</label>
                <asp:TextBox ID="txtLanguage" runat="server" placeholder="e.g. English"/>
            </div>
            <div class="field">
                <label>Genre</label>
                <asp:TextBox ID="txtGenre" runat="server" placeholder="e.g. Action"/>
            </div>
            <div class="field">
                <label>Release Date</label>
                <asp:TextBox ID="txtReleaseDate" runat="server" placeholder="YYYY-MM-DD"/>
            </div>
            <div class="btn-group">
                <asp:Button ID="btnAdd" runat="server" Text="+ Add Movie" CssClass="btn btn-add" OnClick="btnAdd_Click"/>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click"/>
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDelete_Click"/>
                <asp:Button ID="btnClear" runat="server" Text="Clear Fields" CssClass="btn btn-clear" OnClick="btnClear_Click"/>
            </div>
            <div class="msg-box"><asp:Label ID="lblMessage" runat="server"/></div>
        </div>

        <div class="table-card">
            <div class="table-card-header">
                <h3>All Movies</h3>
                <span>Click a row to select</span>
            </div>
            <div class="grid-scroll">
                <asp:GridView ID="gvMovies" runat="server"
                    AutoGenerateColumns="False"
                    OnSelectedIndexChanged="gvMovies_SelectedIndexChanged"
                    DataKeyNames="MOVIEID" CssClass="datagrid" GridLines="None">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                        <asp:BoundField DataField="MOVIEID" HeaderText="ID"/>
                        <asp:BoundField DataField="MOVIETITLE" HeaderText="Title"/>
                        <asp:BoundField DataField="DURATION" HeaderText="Duration"/>
                        <asp:BoundField DataField="LANGUAGE" HeaderText="Language"/>
                        <asp:BoundField DataField="GENRE" HeaderText="Genre"/>
                        <asp:BoundField DataField="RELEASEDATE" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}"/>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>