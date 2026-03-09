<%@ Page Title="Occupancy Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OccupancyReportForm.aspx.cs" Inherits="KumariCinemas.OccupancyReport" %>

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
        .filter-row { display: grid; grid-template-columns: 1fr auto; gap: 16px; align-items: end; }
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

        /* Movie Info */
        .movie-banner {
            background: white; border: 1px solid #e8e0d0; border-radius: 16px;
            padding: 24px; margin-bottom: 24px; display: flex;
            align-items: center; gap: 24px;
        }
        .movie-banner-icon { font-size: 48px; }
        .movie-banner h3 {
            font-family: 'Syne', sans-serif; font-size: 24px;
            font-weight: 800; color: #1a1a1a; margin-bottom: 6px;
        }
        .movie-meta { display: flex; gap: 16px; flex-wrap: wrap; }
        .movie-tag {
            background: #faf0e0; color: #c8a96e; padding: 4px 12px;
            border-radius: 100px; font-size: 12px; font-weight: 500;
        }

        /* Top 3 Cards */
        .podium { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 32px; }
        .podium-card {
            background: white; border: 1px solid #e8e0d0;
            border-radius: 20px; padding: 24px; text-align: center;
            position: relative; overflow: hidden;
        }
        .podium-card.rank-1 { border-top: 4px solid #c8a96e; }
        .podium-card.rank-2 { border-top: 4px solid #94a3b8; }
        .podium-card.rank-3 { border-top: 4px solid #cd7c2f; }
        .rank-badge {
            position: absolute; top: 16px; right: 16px;
            font-family: 'Syne', sans-serif; font-size: 28px; font-weight: 800;
        }
        .rank-1 .rank-badge { color: #c8a96e; }
        .rank-2 .rank-badge { color: #94a3b8; }
        .rank-3 .rank-badge { color: #cd7c2f; }
        .podium-card h4 {
            font-family: 'Syne', sans-serif; font-size: 18px;
            font-weight: 800; color: #1a1a1a; margin-bottom: 4px;
        }
        .podium-city { font-size: 12px; color: #888; margin-bottom: 16px; }
        .occupancy-bar-wrap {
            background: #f0ebe0; border-radius: 100px;
            height: 8px; margin-bottom: 12px; overflow: hidden;
        }
        .occupancy-bar {
            height: 100%; border-radius: 100px;
            background: linear-gradient(90deg, #c8a96e, #e8c98e);
            transition: width 1s ease;
        }
        .occupancy-pct {
            font-family: 'Syne', sans-serif; font-size: 36px;
            font-weight: 800; color: #1a1a1a; line-height: 1;
        }
        .podium-stats { display: flex; justify-content: space-around; margin-top: 16px; }
        .podium-stat label { display: block; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; color: #aaa; }
        .podium-stat span { font-size: 16px; font-weight: 600; color: #1a1a1a; }

        /* Full Table */
        .table-card { background: white; border-radius: 20px; overflow: hidden; border: 1px solid #e8e0d0; }
        .table-card-header {
            padding: 20px 24px; border-bottom: 1px solid #e8e0d0;
            display: flex; align-items: center; justify-content: space-between;
        }
        .table-card-header h3 { font-family: 'Syne', sans-serif; font-size: 16px; font-weight: 700; color: #1a1a1a; }
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div class="page-header-left">
            <h2>Occupancy Report</h2>
            <p>Top 3 theatres by seat occupancy % for any movie (paid tickets only)</p>
        </div>
        <span class="page-badge">COMPLEX REPORT</span>
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
                    <div class="occupancy-bar" style="width:0%; background: linear-gradient(90deg,#cd7c2f,#e8a060)">
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
            <asp:Label ID="lblResultCount" runat="server" style="font-size:12px;color:#aaa;"/>
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