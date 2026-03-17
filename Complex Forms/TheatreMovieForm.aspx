<%@ Page Title="Theatre Movie Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TheatreMovieForm.aspx.cs" Inherits="KumariCinemas.TheatreMovie" %>

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

        /* Filter */
        .filter-card {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
        }
        .filter-card h3 {
            font-size: 11px;
            font-weight: 500;
            color: #b07d3a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 16px;
        }
        .filter-row {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 16px;
            align-items: end;
        }
        .field label {
            display: block;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.7px;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 6px;
        }
        .field select {
            width: 100%;
            background: #fafaf8;
            border: 1px solid #e8e4de;
            border-radius: 7px;
            padding: 10px 13px;
            color: #1c1c1c;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            transition: border-color 0.15s;
            appearance: auto;
        }
        .field select:focus { outline: none; border-color: #b07d3a; }
        .btn-search {
            background: #b07d3a;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 10px 24px;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.15s;
            white-space: nowrap;
        }
        .btn-search:hover { background: #9a6c30; }

        /* Theatre Banner */
        .theatre-banner {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .theatre-banner h3 {
            font-size: 22px;
            font-weight: 600;
            color: #1c1c1c;
            margin-bottom: 4px;
            letter-spacing: -0.3px;
        }
        .theatre-banner p { color: #888; font-size: 14px; }
        .theatre-banner .hall-count {
            font-size: 40px;
            font-weight: 700;
            color: #b07d3a;
            line-height: 1;
            letter-spacing: -1px;
            text-align: center;
        }
        .theatre-banner .hall-lbl {
            font-size: 10px;
            letter-spacing: 0.8px;
            color: #aaa;
            text-transform: uppercase;
            text-align: center;
            margin-top: 4px;
        }

        /* Table */
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
        .time-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            background: #f2ede6;
            color: #b07d3a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div>
            <h2>Theatre Movie Report</h2>
            <p>View all movies and showtimes for any theatre</p>
        </div>
        <span class="page-badge">Complex Report</span>
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
            <div>
                <div class="hall-count"><asp:Label ID="lblHallCount" runat="server"/></div>
                <div class="hall-lbl">Total Halls</div>
            </div>
        </div>
    </asp:Panel>

    <!-- Showtimes Table -->
    <div class="table-card">
        <div class="table-card-header">
            <h3>Movies & Showtimes</h3>
            <asp:Label ID="lblResultCount" runat="server" style="font-size:13px;color:#aaa;"/>
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