<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserTicketForm.aspx.cs" Inherits="KumariCinemas.UserTicket" %>

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
        .field { }
        .field label {
            display: block; font-size: 10px; letter-spacing: 2px;
            text-transform: uppercase; color: #666; margin-bottom: 6px;
        }
        .field select, .field input {
            width: 100%; background: #111; border: 1px solid #2a2a2a;
            border-radius: 10px; padding: 11px 14px; color: #f5f0e8;
            font-family: 'Inter', sans-serif; font-size: 14px; transition: border-color 0.2s;
        }
        .field select:focus, .field input:focus { outline: none; border-color: #c8a96e; }
        .field select option { background: #1a1a1a; }
        .btn-search {
            background: #c8a96e; color: #1a1a1a; border: none;
            border-radius: 10px; padding: 11px 28px; font-family: 'Inter', sans-serif;
            font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.2s;
            white-space: nowrap;
        }
        .btn-search:hover { opacity: 0.85; transform: translateY(-1px); }

        /* Customer Info Card */
        .customer-info {
            background: white; border: 1px solid #e8e0d0;
            border-radius: 16px; padding: 24px; margin-bottom: 24px;
            display: none;
        }
        .customer-info.visible { display: block; }
        .customer-info h3 {
            font-family: 'Syne', sans-serif; font-size: 18px;
            font-weight: 800; color: #1a1a1a; margin-bottom: 16px;
        }
        .info-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
        .info-item label {
            display: block; font-size: 10px; letter-spacing: 2px;
            text-transform: uppercase; color: #aaa; margin-bottom: 4px;
        }
        .info-item span { font-size: 15px; font-weight: 500; color: #1a1a1a; }

        /* Summary Stats */
        .stats-row {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 16px; margin-bottom: 24px;
        }
        .stat-box {
            background: white; border: 1px solid #e8e0d0;
            border-radius: 16px; padding: 20px; text-align: center;
        }
        .stat-box .num {
            font-family: 'Syne', sans-serif; font-size: 36px;
            font-weight: 800; color: #1a1a1a; line-height: 1;
        }
        .stat-box .lbl {
            font-size: 11px; letter-spacing: 2px; text-transform: uppercase;
            color: #aaa; margin-top: 6px;
        }
        .stat-box .num.gold { color: #c8a96e; }
        .stat-box .num.green { color: #22c55e; }
        .stat-box .num.red { color: #ef4444; }

        /* Table */
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
        .badge {
            display: inline-block; padding: 3px 10px; border-radius: 100px;
            font-size: 11px; font-weight: 600;
        }
        .badge-paid { background: #dcfce7; color: #16a34a; }
        .badge-booked { background: #fef9c3; color: #ca8a04; }
        .badge-cancelled { background: #fee2e2; color: #dc2626; }

        .no-results {
            text-align: center; padding: 60px; color: #aaa;
            font-size: 14px;
        }
        .no-results span { font-size: 40px; display: block; margin-bottom: 12px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <div class="page-header-left">
            <h2>User Ticket Report</h2>
            <p>View ticket history for any customer over the last 6 months</p>
        </div>
        <span class="page-badge">COMPLEX REPORT</span>
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
            <asp:Label ID="lblResultCount" runat="server" style="font-size:12px;color:#aaa;"/>
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