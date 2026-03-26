<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="KumariCinemas.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <style>

        /* ── Hero ───────────────────────────────────────────────── */
        .hero {
            border: 1px solid #e8e4de;
            border-radius: 14px;
            background: #fff;
            padding: 40px 44px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            overflow: hidden;
            position: relative;
        }
        .hero::after {
            content: '';
            position: absolute;
            right: 0; top: 0; bottom: 0;
            width: 280px;
            background: repeating-linear-gradient(
                135deg,
                rgba(176,125,58,0.035) 0px, rgba(176,125,58,0.035) 1px,
                transparent 1px, transparent 10px
            );
            pointer-events: none;
        }
        .hero-left { position: relative; z-index: 1; }
        .hero-eyebrow {
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #b07d3a;
            margin-bottom: 10px;
        }
        .hero-title {
            font-size: 42px;
            font-weight: 600;
            letter-spacing: -1px;
            color: #1c1c1c;
            line-height: 1.1;
            margin-bottom: 10px;
        }
        .hero-title span { color: #b07d3a; }
        .hero-sub { font-size: 14px; color: #999; }
        .hero-right {
            position: relative;
            z-index: 1;
            display: flex;
            gap: 10px;
        }
        .hero-pill {
            background: #f2ede6;
            color: #b07d3a;
            font-size: 13px;
            font-weight: 500;
            padding: 8px 18px;
            border-radius: 24px;
            text-decoration: none;
            border: 1px solid #e8d9c4;
            transition: background 0.15s;
        }
        .hero-pill:hover { background: #b07d3a; color: #fff; border-color: #b07d3a; }
        .hero-pill.dark { background: #1c1c1c; color: #fff; border-color: #1c1c1c; }
        .hero-pill.dark:hover { background: #333; border-color: #333; }

        /* ── Section heading ──────────────────────────────────── */
        .sec-head {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 14px;
        }
        .sec-head-label {
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            color: #b07d3a;
        }
        .sec-head-line {
            flex: 1;
            height: 1px;
            background: #e8e4de;
        }

        /* ── KPI strip ────────────────────────────────────────── */
        .kpi-strip {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 28px;
        }
        .kpi-card {
            background: #fff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 22px 24px;
            display: flex;
            align-items: center;
            gap: 18px;
        }
        .kpi-icon-wrap {
            width: 44px; height: 44px;
            border-radius: 10px;
            background: #f2ede6;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }
        .kpi-body {}
        .kpi-number {
            font-size: 26px;
            font-weight: 600;
            letter-spacing: -0.5px;
            color: #1c1c1c;
            line-height: 1;
            margin-bottom: 4px;
        }
        .kpi-label {
            font-size: 12px;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.7px;
            font-weight: 500;
        }
        .kpi-trend {
            margin-left: auto;
            font-size: 12px;
            font-weight: 500;
            padding: 3px 9px;
            border-radius: 20px;
        }
        .kpi-trend.up   { background: #eaf4ec; color: #2d7a3e; }
        .kpi-trend.gold { background: #f2ede6; color: #b07d3a; }
        .kpi-trend.blue { background: #eef3fb; color: #3b5fa0; }

        /* ── Two-col grid ─────────────────────────────────────── */
        .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; }
        .grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; margin-bottom: 16px; }
        .grid-1 { margin-bottom: 16px; }

        /* ── Chart card ───────────────────────────────────────── */
        .chart-card {
            background: #fff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            overflow: hidden;
        }
        .card-header {
            padding: 16px 20px 14px;
            border-bottom: 1px solid #f0ebe0;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }
        .card-title { font-size: 15px; font-weight: 500; color: #1c1c1c; }
        .card-desc  { font-size: 12px; color: #aaa; margin-top: 2px; }
        .card-badge {
            background: #f2ede6;
            color: #b07d3a;
            font-size: 11px;
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 20px;
            white-space: nowrap;
            flex-shrink: 0;
        }
        .card-body { padding: 20px; }

        /* ── Donut legend ─────────────────────────────────────── */
        .donut-wrap {
            display: flex;
            align-items: center;
            gap: 24px;
        }
        .donut-canvas-wrap {
            position: relative;
            width: 160px; height: 160px;
            flex-shrink: 0;
        }
        .donut-center {
            position: absolute;
            inset: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            pointer-events: none;
        }
        .donut-center-num {
            font-size: 22px;
            font-weight: 600;
            color: #1c1c1c;
            line-height: 1;
        }
        .donut-center-lbl {
            font-size: 11px;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-top: 3px;
        }
        .legend-list { flex: 1; }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #555;
            margin-bottom: 9px;
        }
        .legend-item:last-child { margin-bottom: 0; }
        .legend-dot {
            width: 10px; height: 10px;
            border-radius: 3px;
            flex-shrink: 0;
        }
        .legend-item-val {
            margin-left: auto;
            font-size: 13px;
            font-weight: 500;
            color: #1c1c1c;
        }

        /* ── Seat occupancy bar ───────────────────────────────── */
        .occ-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 13px;
            font-size: 13px;
        }
        .occ-row:last-child { margin-bottom: 0; }
        .occ-label { width: 130px; color: #555; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex-shrink: 0; }
        .occ-bar-bg { flex: 1; height: 8px; background: #f0ebe0; border-radius: 4px; overflow: hidden; }
        .occ-bar-fill { height: 100%; border-radius: 4px; background: #b07d3a; transition: width 0.6s; }
        .occ-bar-fill.low  { background: #e8a87c; }
        .occ-bar-fill.mid  { background: #b07d3a; }
        .occ-bar-fill.high { background: #7a5426; }
        .occ-pct { width: 38px; text-align: right; font-size: 12px; font-weight: 500; color: #888; flex-shrink: 0; }

        /* ── Recent tickets feed ──────────────────────────────── */
        .feed-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 13px 0;
            border-bottom: 1px solid #f0ebe0;
        }
        .feed-item:last-child { border-bottom: none; }
        .feed-item:first-child { padding-top: 0; }
        .feed-avatar {
            width: 34px; height: 34px;
            border-radius: 8px;
            background: #f2ede6;
            color: #b07d3a;
            font-size: 13px;
            font-weight: 500;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .feed-body { flex: 1; }
        .feed-name { font-size: 14px; font-weight: 500; color: #1c1c1c; }
        .feed-meta { font-size: 12px; color: #aaa; margin-top: 2px; }
        .feed-right { text-align: right; flex-shrink: 0; }
        .feed-price { font-size: 14px; font-weight: 500; color: #1c1c1c; }
        .feed-date  { font-size: 12px; color: #bbb; margin-top: 2px; }
        .s-pill {
            display: inline-block;
            font-size: 11px; font-weight: 500;
            padding: 2px 8px; border-radius: 10px;
            text-transform: capitalize;
        }
        .s-confirmed { background: #eaf4ec; color: #2d7a3e; }
        .s-cancelled { background: #fdf0f0; color: #c0392b; }
        .s-pending   { background: #fef9ec; color: #b07d3a; }

        /* ── Upcoming shows table ─────────────────────────────── */
        .mini-table { width: 100%; border-collapse: collapse; }
        .mini-table th {
            font-size: 10px; font-weight: 500; letter-spacing: 0.8px;
            text-transform: uppercase; color: #bbb;
            padding: 0 0 10px; text-align: left;
            border-bottom: 1px solid #f0ebe0;
        }
        .mini-table td {
            font-size: 13px; color: #444;
            padding: 10px 0;
            border-bottom: 1px solid #f7f3ee;
        }
        .mini-table tr:last-child td { border-bottom: none; }
        .mini-table .movie-cell { font-weight: 500; color: #1c1c1c; }
        .time-badge {
            background: #f2ede6; color: #b07d3a;
            font-size: 11px; font-weight: 500;
            padding: 3px 8px; border-radius: 5px;
        }

        /* ── Booking status summary ───────────────────────────── */
        .status-row {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
        }
        .status-box {
            flex: 1;
            border-radius: 9px;
            padding: 14px 16px;
            text-align: center;
        }
        .status-box .s-num {
            font-size: 22px; font-weight: 600; line-height: 1;
        }
        .status-box .s-lbl {
            font-size: 11px; text-transform: uppercase; letter-spacing: 0.6px; margin-top: 4px;
        }
        .box-confirmed { background: #eaf4ec; }
        .box-confirmed .s-num { color: #2d7a3e; }
        .box-confirmed .s-lbl { color: #60a96e; }
        .box-cancelled { background: #fdf0f0; }
        .box-cancelled .s-num { color: #c0392b; }
        .box-cancelled .s-lbl { color: #d97068; }
        .box-pending { background: #fef9ec; }
        .box-pending .s-num { color: #b07d3a; }
        .box-pending .s-lbl { color: #c8985a; }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ── Hero ─────────────────────────────────────────────────── --%>
    <div class="hero">
        <div class="hero-left">
            <div class="hero-eyebrow">Cinema Management System</div>
            <div class="hero-title">Kumari<span>Cinemas</span></div>
            <div class="hero-sub">Nepal's premier ticketing &amp; scheduling platform</div>
        </div>
        <div class="hero-right">
            <a href="/Basic Forms/MovieForm.aspx"      class="hero-pill">+ Add Movie</a>
            <a href="/Basic Forms/ShowTimesForm.aspx"  class="hero-pill">+ Schedule Show</a>
            <a href="/Basic Forms/TicketForm.aspx"     class="hero-pill dark">+ Book Ticket</a>
        </div>
    </div>

    <%-- ── KPI Strip ──────────────────────────────────────────────── --%>
    <div class="sec-head">
        <span class="sec-head-label">At a Glance</span>
        <div class="sec-head-line"></div>
    </div>

    <div class="kpi-strip">
        <div class="kpi-card">
            <div class="kpi-icon-wrap">🎬</div>
            <div class="kpi-body">
                <div class="kpi-number"><asp:Label ID="lblMovieCount"   runat="server" Text="0"/></div>
                <div class="kpi-label">Movies</div>
            </div>
            <div class="kpi-trend gold">Active</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon-wrap">🎟️</div>
            <div class="kpi-body">
                <div class="kpi-number"><asp:Label ID="lblTicketCount"  runat="server" Text="0"/></div>
                <div class="kpi-label">Tickets Sold</div>
            </div>
            <div class="kpi-trend up">Live</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon-wrap">💰</div>
            <div class="kpi-body">
                <div class="kpi-number">Rs. <asp:Label ID="lblTotalRevenue" runat="server" Text="0"/></div>
                <div class="kpi-label">Total Revenue</div>
            </div>
            <div class="kpi-trend gold">Gross</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon-wrap">🏛️</div>
            <div class="kpi-body">
                <div class="kpi-number"><asp:Label ID="lblTheatreCount" runat="server" Text="0"/></div>
                <div class="kpi-label">Theatres</div>
            </div>
            <div class="kpi-trend blue">Venues</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon-wrap">🎭</div>
            <div class="kpi-body">
                <div class="kpi-number"><asp:Label ID="lblShowCount"    runat="server" Text="0"/></div>
                <div class="kpi-label">Shows Scheduled</div>
            </div>
            <div class="kpi-trend gold">All Time</div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon-wrap">👤</div>
            <div class="kpi-body">
                <div class="kpi-number"><asp:Label ID="lblCustomerCount" runat="server" Text="0"/></div>
                <div class="kpi-label">Customers</div>
            </div>
            <div class="kpi-trend blue">Registered</div>
        </div>
    </div>

    <%-- ── Row 1: Booking Status Summary + Ticket Price Distribution ── --%>
    <div class="sec-head">
        <span class="sec-head-label">Bookings</span>
        <div class="sec-head-line"></div>
    </div>

    <div class="grid-1" style="margin-bottom:16px;">

     

        <%-- Showtime slot popularity --%>
        <div class="chart-card">
            <div class="card-header">
                <div>
                    <div class="card-title">Showtime Slot Popularity</div>
                    <div class="card-desc">Tickets sold by morning, day, evening</div>
                </div>
                <span class="card-badge">Shows</span>
            </div>
            <div class="card-body">
                <div class="donut-wrap">
                    <div class="donut-canvas-wrap">
                        <canvas id="chartSlotPopularity"></canvas>
                        <div class="donut-center">
                            <div class="donut-center-num"><asp:Label ID="lblTotalShows" runat="server" Text="0"/></div>
                            <div class="donut-center-lbl">Shows</div>
                        </div>
                    </div>
                    <div class="legend-list" id="slotLegend"></div>
                </div>
            </div>
        </div>

    </div>

    <%-- ── Row 2: Hall Occupancy Bars ──────────────────────────────── --%>
    <div class="sec-head">
        <span class="sec-head-label">Venue Performance</span>
        <div class="sec-head-line"></div>
    </div>

    <div class="grid-2" style="margin-bottom:16px;">

        <%-- Hall occupancy rates --%>
        <div class="chart-card">
            <div class="card-header">
                <div>
                    <div class="card-title">Hall Occupancy Rate</div>
                    <div class="card-desc">Tickets sold vs hall capacity</div>
                </div>
                <span class="card-badge">Halls</span>
            </div>
            <div class="card-body">
                <div id="occBars"></div>
            </div>
        </div>

        <%-- Revenue by genre --%>
        <div class="chart-card">
            <div class="card-header">
                <div>
                    <div class="card-title">Revenue by Genre</div>
                    <div class="card-desc">Total earnings per movie genre</div>
                </div>
                <span class="card-badge">Revenue</span>
            </div>
            <div class="card-body">
                <div style="position:relative;height:240px;">
                    <canvas id="chartRevenueByGenre"></canvas>
                </div>
            </div>
        </div>

    </div>



    <%-- Hidden fields for chart data --%>
    <asp:HiddenField ID="hdnBookingStatus"   runat="server" />
    <asp:HiddenField ID="hdnSlotPopularity"  runat="server" />
    <asp:HiddenField ID="hdnRevenueByGenre"  runat="server" />
    <asp:HiddenField ID="hdnHallOccupancy"   runat="server" />

<script>
(function () {
    const GOLD   = ['#b07d3a','#c8995a','#d4aa74','#debb93','#e8ccb0'];
    const STATUS = { confirmed:'#2d7a3e', pending:'#b07d3a', cancelled:'#c0392b' };
    const SLOTS  = ['#b07d3a','#4a7ab5','#2d7a3e'];

    function parse(id) {
        try { return JSON.parse(document.getElementById(id).value || '{}'); } catch { return {}; }
    }

    /* ── Booking Status doughnut ── */
    (function(){
        const d = parse('<%= hdnBookingStatus.ClientID %>');
        if (!d.labels) return;
        const colors = d.labels.map(l => STATUS[l.toLowerCase()] || '#aaa');
        new Chart(document.getElementById('chartBookingStatus'), {
            type: 'doughnut',
            data: {
                labels: d.labels,
                datasets: [{ data: d.values, backgroundColor: colors, borderWidth: 2, borderColor: '#fff', hoverOffset: 4 }]
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                cutout: '68%',
                plugins: {
                    legend: { position: 'right', labels: { boxWidth: 10, boxHeight: 10, borderRadius: 3, font: { size: 12 }, color: '#555' } }
                }
            }
        });
    })();

    /* ── Slot Popularity donut + legend ── */
    (function(){
        const d = parse('<%= hdnSlotPopularity.ClientID %>');
        if (!d.labels) return;
        new Chart(document.getElementById('chartSlotPopularity'), {
            type: 'doughnut',
            data: {
                labels: d.labels,
                datasets: [{ data: d.values, backgroundColor: SLOTS.slice(0, d.labels.length), borderWidth: 2, borderColor: '#fff', hoverOffset: 4 }]
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                cutout: '72%',
                plugins: { legend: { display: false } }
            }
        });
        const leg = document.getElementById('slotLegend');
        d.labels.forEach(function(lbl, i) {
            leg.innerHTML += '<div class="legend-item"><span class="legend-dot" style="background:' + SLOTS[i] + '"></span>' + lbl + '<span class="legend-item-val">' + d.values[i] + '</span></div>';
        });
    })();

    /* ── Revenue by Genre horizontal bar ── */
    (function(){
        const d = parse('<%= hdnRevenueByGenre.ClientID %>');
        if (!d.labels) return;
        new Chart(document.getElementById('chartRevenueByGenre'), {
            type: 'bar',
            data: {
                labels: d.labels,
                datasets: [{
                    data: d.values,
                    backgroundColor: GOLD.slice(0, d.labels.length),
                    borderRadius: 5,
                    borderWidth: 0
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true, maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    x: { grid: { color: 'rgba(0,0,0,0.05)' }, ticks: { callback: v => 'Rs ' + v.toLocaleString(), font: { size: 11 }, color: '#aaa' } },
                    y: { grid: { display: false }, ticks: { font: { size: 12 }, color: '#555' } }
                }
            }
        });
    })();

    /* ── Hall Occupancy bars ── */
    (function(){
        const d = parse('<%= hdnHallOccupancy.ClientID %>');
        if (!d.halls) return;
        const container = document.getElementById('occBars');
        d.halls.forEach(function(h) {
            const pct = Math.min(100, Math.round(h.pct));
            const cls = pct < 35 ? 'low' : pct < 70 ? 'mid' : 'high';
            container.innerHTML +=
                '<div class="occ-row">' +
                  '<div class="occ-label" title="' + h.name + '">' + h.name + '</div>' +
                  '<div class="occ-bar-bg"><div class="occ-bar-fill ' + cls + '" style="width:' + pct + '%"></div></div>' +
                  '<div class="occ-pct">' + pct + '%</div>' +
                '</div>';
        });
    })();

})();
</script>

</asp:Content>