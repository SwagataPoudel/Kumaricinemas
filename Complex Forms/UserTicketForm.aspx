<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserTicketForm.aspx.cs" Inherits="KumariCinemas.UserTicket" %>

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
        .field select, .field input {
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
        .field select:focus, .field input:focus { outline: none; border-color: #b07d3a; }
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

        /* Customer Info */
        .customer-info {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 20px;
            display: none;
        }
        .customer-info.visible { display: block; }
        .customer-info h3 {
            font-size: 18px;
            font-weight: 600;
            color: #1c1c1c;
            margin-bottom: 16px;
            letter-spacing: -0.2px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }
        .info-item label {
            display: block;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.7px;
            text-transform: uppercase;
            color: #aaa;
            margin-bottom: 4px;
        }
        .info-item span {
            font-size: 15px;
            font-weight: 500;
            color: #1c1c1c;
        }

        /* Stats */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }
        .stat-box {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
        }
        .stat-box .num {
            font-size: 34px;
            font-weight: 700;
            color: #1c1c1c;
            line-height: 1;
            letter-spacing: -1px;
        }
        .stat-box .lbl {
            font-size: 11px;
            letter-spacing: 0.7px;
            text-transform: uppercase;
            color: #aaa;
            margin-top: 6px;
        }
        .stat-box .num.gold  { color: #b07d3a; }
        .stat-box .num.green { color: #22c55e; }
        .stat-box .num.red   { color: #ef4444; }

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

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }
        .badge-paid      { background: #dcfce7; color: #16a34a; }
        .badge-booked    { background: #fef9c3; color: #ca8a04; }
        .badge-cancelled { background: #fee2e2; color: #dc2626; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div>
            <h2>User Ticket Report</h2>
            <p>View ticket history for any customer over the last 6 months</p>
        </div>
        <span class="page-badge">Complex Report</span>
    </div>

    <!-- Filter -->
    <div class="filter-card">
        <h3>Select Customer</h3>
        <div class="filter-row">
            <div class="field">
                <label>Customer</label>
                <asp:DropDownList ID="ddlCustomer" runat="server"
                    DataTextField="CUSTOMERINFO" DataValueField="CUSTOMERID"/>
            </div>
            <div class="field">
                <label>Period</label>
                <asp:DropDownList ID="ddlMonths" runat="server">
                    <asp:ListItem Value="1">Last 1 Month</asp:ListItem>
                    <asp:ListItem Value="3">Last 3 Months</asp:ListItem>
                    <asp:ListItem Value="6" Selected="True">Last 6 Months</asp:ListItem>
                    <asp:ListItem Value="12">Last 12 Months</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search →" CssClass="btn-search" OnClick="btnSearch_Click"/>
        </div>
    </div>

    <!-- Customer Info -->
    <asp:Panel ID="pnlCustomerInfo" runat="server" CssClass="customer-info">
        <h3>👤 <asp:Label ID="lblCustomerName" runat="server"/></h3>
        <div class="info-grid">
            <div class="info-item">
                <label>Customer ID</label>
                <span><asp:Label ID="lblCustomerID" runat="server"/></span>
            </div>
            <div class="info-item">
                <label>Address</label>
                <span><asp:Label ID="lblAddress" runat="server"/></span>
            </div>
            <div class="info-item">
                <label>Report Period</label>
                <span><asp:Label ID="lblPeriod" runat="server"/></span>
            </div>
        </div>
    </asp:Panel>

    <!-- Stats -->
    <asp:Panel ID="pnlStats" runat="server">
        <div class="stats-row">
            <div class="stat-box">
                <div class="num gold"><asp:Label ID="lblTotalTickets" runat="server" Text="0"/></div>
                <div class="lbl">Total Tickets</div>
            </div>
            <div class="stat-box">
                <div class="num green"><asp:Label ID="lblPaidTickets" runat="server" Text="0"/></div>
                <div class="lbl">Paid</div>
            </div>
            <div class="stat-box">
                <div class="num"><asp:Label ID="lblBookedTickets" runat="server" Text="0"/></div>
                <div class="lbl">Booked</div>
            </div>
            <div class="stat-box">
                <div class="num red"><asp:Label ID="lblCancelledTickets" runat="server" Text="0"/></div>
                <div class="lbl">Cancelled</div>
            </div>
        </div>
    </asp:Panel>

    <!-- Results Table -->
    <div class="table-card">
        <div class="table-card-header">
            <h3>Ticket Details</h3>
            <asp:Label ID="lblResultCount" runat="server" style="font-size:13px;color:#aaa;"/>
        </div>
        <div class="grid-scroll">
            <asp:GridView ID="gvTickets" runat="server"
                AutoGenerateColumns="False"
                CssClass="datagrid" GridLines="None"
                EmptyDataText="No tickets found for this customer in the selected period.">
                <Columns>
                    <asp:BoundField DataField="TICKETID" HeaderText="Ticket ID"/>
                    <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie"/>
                    <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre"/>
                    <asp:BoundField DataField="THEATRECITY" HeaderText="City"/>
                    <asp:BoundField DataField="HALLNAME" HeaderText="Hall"/>
                    <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date" DataFormatString="{0:dd MMM yyyy}"/>
                    <asp:BoundField DataField="SHOWTIME" HeaderText="Time"/>
                    <asp:BoundField DataField="SEATNUMBER" HeaderText="Seat"/>
                    <asp:BoundField DataField="TICKETPRICE" HeaderText="Price"/>
                    <asp:BoundField DataField="BOOKINGDATE" HeaderText="Booking Date" DataFormatString="{0:dd MMM yyyy}"/>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge badge-<%# Eval("BOOKINGSTATUS").ToString().ToLower() %>'>
                                <%# Eval("BOOKINGSTATUS") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>