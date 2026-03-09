<%@ Page Title="Theatre Movie Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreMovieForm.aspx.cs" Inherits="KumariCinemas.TheatreMovie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Inter:wght@300;400;500&display=swap');

        .page-header {
            display: flex; align-items: flex-end; justify-content: space-between;
            margin-bottom: 32px; padding-bottom: 24px; border-bottom: 2px solid #1a1a1a;
        }
        .page-header-left h2 {
            font-family: 'Syne', sans-serif; font-size: 52px; font-weight: 800;
            line-height: 1; letter-spacing: -2px; color: #1a1a1a;
        }
        .page-header-left p { color: #888; font-size: 13px; margin-top: 6px; }
        .page-badge {
            background: #1a1a1a; color: #f5f0e8; padding: 8px 18px;
            border-radius: 100px; font-size: 12px; font-weight: 500; letter-spacing: 1px;
        }
        .filter-card {
            background: #1a1a1a; border-radius: 20px; padding: 28px;
            color: #f5f0e8; margin-bottom: 24px;
        }
        .filter-card h3 {
            font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700;
            letter-spacing: 1px; text-transform: uppercase; color: #c8a96e; margin-bottom: 20px;
        }
        .filter-row { display: grid; grid-template-columns: 1fr 1fr auto; gap: 16px; align-items: end; }
        .field label {
            display: block; font-size: 10px; letter-spacing: 2px;
            text-transform: uppercase; color: #666; margin-bottom: 6px;
        }
        .field select {
            width: 100%; background: #111; border: 1px solid #2a2a2a;
            border-radius: 10px; padding: 11px 14px; color: #f5f0e8;
            font-family: 'Inter', sans-serif; font-size: 14px;
        }
        .field select:focus { outline: none; border-color: #c8a96e; }
        .field select option { background: #1a1a1a; }
        .btn-search {
            background: #c8a96e; color: #1a1a1a; border: none;
            border-radius: 10px; padding: 11px 28px; font-family: 'Inter', sans-serif;
            font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.2s;
        }
        .btn-search:hover { opacity: 0.85; transform: translateY(-1px); }

        /* Theatre Info */
        .theatre-banner {
            background: #1a1a1a; border-radius: 16px; padding: 24px;
            margin-bottom: 24px; display: flex; align-items: center;
            justify-content: space-between; color: #f5f0e8;
        }
        .theatre-banner h3 {
            font-family: 'Syne', sans-serif; font-size: 28px;
            font-weight: 800; color: white; margin-bottom: 4px;
        }
        .theatre-banner p { color: #888; font-size: 13px; }
        .theatre-banner .hall-count {
            font-family: 'Syne', sans-serif; font-size: 48px;
            font-weight: 800; color: #c8a96e; line-height: 1;
        }
        .theatre-banner .hall-lbl { font-size: 11px; letter-spacing: 2px; color: #666; text-transform: uppercase; }

        /* Movie Cards Grid */
        .movies-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 16px; margin-bottom: 24px;
        }
        .movie-card {
            background: white; border: 1px solid #e8e0d0;
            border-radius: 16px; padding: 20px;
            border-left: 4px solid #c8a96e;
        }
        .movie-card h4 {
            font-family: 'Syne', sans-serif; font-size: 16px;
            font-weight: 800; color: #1a1a1a; margin-bottom: 8px;
        }
        .movie-meta { font-size: 12px; color: #888; margin-bottom: 4px; }
        .movie-meta span { color: #1a1a1a; font-weight: 500; }

        /* Showtimes Table */
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
        table.datagrid td { padding: 13px 16px; border-bottom: 1px solid #f0ebe0; font-size: 13px; color: #333; }
        table.datagrid tr:last-child td { border-bottom: none; }
        table.datagrid tr:hover td { background: #faf7f2; }
        .time-badge {
            display: inline-block; padding: 3px 10px; border-radius: 100px;
            font-size: 11px; font-weight: 600; background: #faf0e0; color: #c8a96e;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div class="page-header-left">
            <h2>Theatre Movie Report</h2>
            <p>View all movies and showtimes for any theatre</p>
        </div>
        <span class="page-badge">COMPLEX REPORT</span>
    </div>

    <!-- Filter -->
    <div class="filter-card">
        <h3>Select Theatre</h3>
        <div class="filter-row">
            <div class="field">
                <label>Theatre</label>
                <asp:DropDownList ID="ddlTheatre" runat="server"
                    DataTextField="THEATREINFO" DataValueField="THEATREID"/>
            </div>
            <div class="field">
                <label>Hall (optional — leave for all halls)</label>
                <asp:DropDownList ID="ddlHall" runat="server">
                    <asp:ListItem Value="0">All Halls</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search →" CssClass="btn-search" OnClick="btnSearch_Click"/>
        </div>
    </div>

    <!-- Theatre Banner -->
    <asp:Panel ID="pnlTheatreBanner" runat="server" Visible="false">
        <div class="theatre-banner">
            <div>
                <h3><asp:Label ID="lblTheatreName" runat="server"/></h3>
                <p>📍 <asp:Label ID="lblTheatreCity" runat="server"/></p>
            </div>
            <div style="text-align:center;">
                <div class="hall-count"><asp:Label ID="lblHallCount" runat="server"/></div>
                <div class="hall-lbl">Total Halls</div>
            </div>
        </div>
    </asp:Panel>

    <!-- Showtimes Table -->
    <div class="table-card">
        <div class="table-card-header">
            <h3>Movies & Showtimes</h3>
            <asp:Label ID="lblResultCount" runat="server" style="font-size:12px;color:#aaa;"/>
        </div>
        <div class="grid-scroll">
            <asp:GridView ID="gvShows" runat="server"
                AutoGenerateColumns="False"
                CssClass="datagrid" GridLines="None"
                EmptyDataText="No shows found. Please select a theatre and search.">
                <Columns>
                    <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie"/>
                    <asp:BoundField DataField="GENRE" HeaderText="Genre"/>
                    <asp:BoundField DataField="LANGUAGE" HeaderText="Language"/>
                    <asp:BoundField DataField="HALLNAME" HeaderText="Hall"/>
                    <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date" DataFormatString="{0:dd MMM yyyy}"/>
                    <asp:TemplateField HeaderText="Show Time">
                        <ItemTemplate>
                            <span class="time-badge"><%# Eval("SHOWTIME") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BASEPRICE" HeaderText="Base Price"/>
                    <asp:BoundField DataField="ISRELEASEWEEK" HeaderText="Release Week"/>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>