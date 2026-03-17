<%@ Page Title="Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TicketForm.aspx.cs" Inherits="KumariCinemas.Ticket" %>

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

        .layout {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 20px;
            align-items: start;
        }

        .form-card {
            background: #ffffff;
            border: 1px solid #e8e4de;
            border-radius: 12px;
            padding: 24px;
            position: sticky;
            top: 72px;
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
            <h2>Tickets</h2>
            <p>Manage ticket bookings and cancellations</p>
        </div>
        <span class="page-badge">Ticket Management</span>
    </div>

    <div class="layout">
        <div class="form-card">
            <h3>Ticket Info</h3>

            <div class="field">
                <label>Ticket ID</label>
                <asp:TextBox ID="txtTicketID" runat="server" ReadOnly="true" placeholder="Auto-generated"/>
            </div>
            <div class="field">
                <label>Customer</label>
                <asp:DropDownList ID="ddlCustomer" runat="server" DataTextField="CUSTOMERINFO" DataValueField="CUSTOMERID"/>
            </div>
            <div class="field">
                <label>Show</label>
                <asp:DropDownList ID="ddlShow" runat="server" DataTextField="SHOWINFO" DataValueField="SHOWID"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlShow_SelectedIndexChanged"/>
            </div>
            <div class="field">
                <label>Ticket Price (Rs.) — Auto-filled from Show</label>
                <asp:TextBox ID="txtTicketPrice" runat="server" ReadOnly="true" placeholder="Auto-filled from show"/>
            </div>
            <div class="field">
                <label>Seat Number</label>
                <asp:TextBox ID="txtSeatNumber" runat="server" placeholder="e.g. A12"/>
            </div>
            <div class="field">
                <label>Booking Date</label>
                <asp:TextBox ID="txtBookingDate" runat="server" placeholder="YYYY-MM-DD"/>
            </div>
            <div class="field">
                <label>Booking Status</label>
                <asp:DropDownList ID="ddlBookingStatus" runat="server">
                    <asp:ListItem>Paid</asp:ListItem>
                    <asp:ListItem>Booked</asp:ListItem>
                    <asp:ListItem>Cancelled</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="btn-group">
                <asp:Button ID="btnAdd" runat="server" Text="+ Add Ticket" CssClass="btn btn-add" OnClick="btnAdd_Click"/>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click"/>
                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDelete_Click"/>
                <asp:Button ID="btnClear" runat="server" Text="Clear Fields" CssClass="btn btn-clear" OnClick="btnClear_Click"/>
            </div>

            <div class="msg-box">
                <asp:Label ID="lblMessage" runat="server"/>
            </div>
        </div>

        <div class="table-card">
            <div class="table-card-header">
                <h3>All Tickets</h3>
                <span>Click a row to select</span>
            </div>
            <div class="grid-scroll">
                <asp:GridView ID="gvTickets" runat="server"
                    AutoGenerateColumns="False"
                    OnSelectedIndexChanged="gvTickets_SelectedIndexChanged"
                    DataKeyNames="TICKETID" CssClass="datagrid" GridLines="None">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                        <asp:BoundField DataField="TICKETID" HeaderText="ID"/>
                        <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Customer"/>
                        <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie"/>
                        <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre"/>
                        <asp:BoundField DataField="HALLNAME" HeaderText="Hall"/>
                        <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date" DataFormatString="{0:yyyy-MM-dd}"/>
                        <asp:BoundField DataField="SHOWTIME" HeaderText="Time"/>
                        <asp:BoundField DataField="TICKETPRICE" HeaderText="Price (Rs.)"/>
                        <asp:BoundField DataField="SEATNUMBER" HeaderText="Seat"/>
                        <asp:BoundField DataField="BOOKINGDATE" HeaderText="Booking Date" DataFormatString="{0:yyyy-MM-dd}"/>
                        <asp:BoundField DataField="BOOKINGSTATUS" HeaderText="Status"/>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>