<%@ Page Title="Occupancy Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OccupancyReportForm.aspx.cs" Inherits="KumariCinemas.OccupancyReport" %>

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
            grid-template-columns: 1fr auto;
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

        /* Movie Banner */
        .movie-banner {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .movie-banner-icon { font-size: 40px; }
        .movie-banner h3 {
            font-size: 22px;
            font-weight: 600;
            color: #1c1c1c;
            margin-bottom: 8px;
            letter-spacing: -0.3px;
        }
        .movie-meta { display: flex; gap: 10px; flex-wrap: wrap; }
        .movie-tag {
            background: #f2ede6;
            color: #b07d3a;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        /* Podium */
        .podium {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }
        .podium-card {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 22px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .podium-card.rank-1 { border-top: 3px solid #b07d3a; }
        .podium-card.rank-2 { border-top: 3px solid #94a3b8; }
        .podium-card.rank-3 { border-top: 3px solid #c2783a; }
        .rank-badge {
            position: absolute;
            top: 14px;
            right: 16px;
            font-size: 22px;
            font-weight: 700;
        }
        .rank-1 .rank-badge { color: #b07d3a; }
        .rank-2 .rank-badge { color: #94a3b8; }
        .rank-3 .rank-badge { color: #c2783a; }
        .podium-card h4 {
            font-size: 17px;
            font-weight: 600;
            color: #1c1c1c;
            margin-bottom: 4px;
            padding-right: 32px;
        }
        .podium-city {
            font-size: 13px;
            color: #888;
            margin-bottom: 16px;
        }
        .occupancy-bar-wrap {
            background: #f0ebe0;
            border-radius: 100px;
            height: 7px;
            margin-bottom: 12px;
            overflow: hidden;
        }
        .occupancy-bar {
            height: 100%;
            border-radius: 100px;
            background: linear-gradient(90deg, #b07d3a, #d4a05a);
            transition: width 1s ease;
        }
        .occupancy-pct {
            font-size: 32px;
            font-weight: 700;
            color: #1c1c1c;
            line-height: 1;
            letter-spacing: -1px;
        }
        .podium-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px solid #f0ebe0;
        }
        .podium-stat label {
            display: block;
            font-size: 10px;
            letter-spacing: 0.7px;
            text-transform: uppercase;
            color: #aaa;
            margin-bottom: 3px;
        }
        .podium-stat span {
            font-size: 16px;
            font-weight: 600;
            color: #1c1c1c;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div>
            <h2>Occupancy Report</h2>
            <p>Top 3 theatres by seat occupancy % for any movie (paid tickets only)</p>
        </div>
        <span class="page-badge">Complex Report</span>
    </div>

    <!-- Filter -->
    <div class="filter-card">
        <h3>Select Movie</h3>
        <div class="filter-row">
            <div class="field">
                <label>Movie</label>
                <asp:DropDownList ID="ddlMovie" runat="server"
                    DataTextField="MOVIETITLE" DataValueField="MOVIEID"/>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search →" CssClass="btn-search" OnClick="btnSearch_Click"/>
        </div>
    </div>

    <!-- Movie Banner -->
    <asp:Panel ID="pnlMovieBanner" runat="server" Visible="false">
        <div class="movie-banner">
            <div class="movie-banner-icon">🎬</div>
            <div>
                <h3><asp:Label ID="lblMovieTitle" runat="server"/></h3>
                <div class="movie-meta">
                    <span class="movie-tag">🌐 <asp:Label ID="lblLanguage" runat="server"/></span>
                    <span class="movie-tag">🎭 <asp:Label ID="lblGenre" runat="server"/></span>
                    <span class="movie-tag">⏱ <asp:Label ID="lblDuration" runat="server"/></span>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Podium Top 3 -->
    <asp:Panel ID="pnlPodium" runat="server" Visible="false">
        <div class="podium">
            <!-- Rank 1 -->
            <div class="podium-card rank-1">
                <div class="rank-badge">#1</div>
                <h4><asp:Label ID="lblName1" runat="server"/></h4>
                <div class="podium-city">📍 <asp:Label ID="lblCity1" runat="server"/></div>
                <div class="occupancy-bar-wrap">
                    <div class="occupancy-bar" id="bar1" style="width:0%">
                        <asp:HiddenField ID="hfPct1" runat="server"/>
                    </div>
                </div>
                <div class="occupancy-pct"><asp:Label ID="lblPct1" runat="server"/>%</div>
                <div class="podium-stats">
                    <div class="podium-stat">
                        <label>Paid Tickets</label>
                        <span><asp:Label ID="lblTickets1" runat="server"/></span>
                    </div>
                    <div class="podium-stat">
                        <label>Capacity</label>
                        <span><asp:Label ID="lblCapacity1" runat="server"/></span>
                    </div>
                </div>
            </div>
            <!-- Rank 2 -->
            <div class="podium-card rank-2">
                <div class="rank-badge">#2</div>
                <h4><asp:Label ID="lblName2" runat="server"/></h4>
                <div class="podium-city">📍 <asp:Label ID="lblCity2" runat="server"/></div>
                <div class="occupancy-bar-wrap">
                    <div class="occupancy-bar" style="width:0%; background: linear-gradient(90deg,#94a3b8,#cbd5e1)">
                        <asp:HiddenField ID="hfPct2" runat="server"/>
                    </div>
                </div>
                <div class="occupancy-pct"><asp:Label ID="lblPct2" runat="server"/>%</div>
                <div class="podium-stats">
                    <div class="podium-stat">
                        <label>Paid Tickets</label>
                        <span><asp:Label ID="lblTickets2" runat="server"/></span>
                    </div>
                    <div class="podium-stat">
                        <label>Capacity</label>
                        <span><asp:Label ID="lblCapacity2" runat="server"/></span>
                    </div>
                </div>
            </div>
            <!-- Rank 3 -->
            <div class="podium-card rank-3">
                <div class="rank-badge">#3</div>
                <h4><asp:Label ID="lblName3" runat="server"/></h4>
                <div class="podium-city">📍 <asp:Label ID="lblCity3" runat="server"/></div>
                <div class="occupancy-bar-wrap">
                    <div class="occupancy-bar" style="width:0%; background: linear-gradient(90deg,#c2783a,#e8a060)">
                        <asp:HiddenField ID="hfPct3" runat="server"/>
                    </div>
                </div>
                <div class="occupancy-pct"><asp:Label ID="lblPct3" runat="server"/>%</div>
                <div class="podium-stats">
                    <div class="podium-stat">
                        <label>Paid Tickets</label>
                        <span><asp:Label ID="lblTickets3" runat="server"/></span>
                    </div>
                    <div class="podium-stat">
                        <label>Capacity</label>
                        <span><asp:Label ID="lblCapacity3" runat="server"/></span>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Full Table -->
    <div class="table-card">
        <div class="table-card-header">
            <h3>Full Occupancy Breakdown</h3>
            <asp:Label ID="lblResultCount" runat="server" style="font-size:13px;color:#aaa;"/>
        </div>
        <div class="grid-scroll">
            <asp:GridView ID="gvOccupancy" runat="server"
                AutoGenerateColumns="False"
                CssClass="datagrid" GridLines="None"
                EmptyDataText="Please select a movie and search.">
                <Columns>
                    <asp:BoundField DataField="RANK" HeaderText="Rank"/>
                    <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre"/>
                    <asp:BoundField DataField="THEATRECITY" HeaderText="City"/>
                    <asp:BoundField DataField="HALLNAME" HeaderText="Hall"/>
                    <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity"/>
                    <asp:BoundField DataField="PAIDTICKETS" HeaderText="Paid Tickets"/>
                    <asp:BoundField DataField="OCCUPANCYPCT" HeaderText="Occupancy %" DataFormatString="{0:F2}%"/>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <script>
        window.onload = function () {
            document.querySelectorAll('.occupancy-bar').forEach(function (bar) {
                var hf = bar.querySelector('input[type=hidden]');
                if (hf) bar.style.width = hf.value + '%';
            });
        };
    </script>
</asp:Content>