<%@ Page Title="Ticket Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TicketForm.aspx.cs" Inherits="KumariCinemas.TicketForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Ticket Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" /><br /><br />

    <asp:Button ID="btnAdd" runat="server" Text="+ Add New Ticket" OnClick="btnAdd_Click" />
    <br /><br />

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <fieldset>
            <legend>Ticket Details</legend>
            <asp:HiddenField ID="hfTicketID" runat="server" />
            <table>
                <tr>
                    <td>Customer:</td>
                    <td>
                        <asp:DropDownList ID="ddlCustomer" runat="server"
                            DataValueField="CUSTOMERID" DataTextField="CUSTOMERNAME" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCustomer"
                            InitialValue="" ErrorMessage=" * Customer required" ForeColor="Red" ValidationGroup="TicketGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Show:</td>
                    <td>
                        <asp:DropDownList ID="ddlShow" runat="server"
                            DataValueField="SHOWID" DataTextField="SHOWLABEL" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlShow"
                            InitialValue="" ErrorMessage=" * Show required" ForeColor="Red" ValidationGroup="TicketGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Ticket Price:</td>
                    <td>
                        <asp:TextBox ID="txtTicketPrice" runat="server" placeholder="e.g. 500" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTicketPrice"
                            ErrorMessage=" * Price required" ForeColor="Red" ValidationGroup="TicketGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Seat Number:</td>
                    <td>
                        <asp:TextBox ID="txtSeatNumber" runat="server" placeholder="e.g. A12" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSeatNumber"
                            ErrorMessage=" * Seat required" ForeColor="Red" ValidationGroup="TicketGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Booking Date:</td>
                    <td>
                        <asp:TextBox ID="txtBookingDate" runat="server" placeholder="DD-MON-YYYY e.g. 01-JAN-2025" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBookingDate"
                            ErrorMessage=" * Date required" ForeColor="Red" ValidationGroup="TicketGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Booking Status:</td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Text="Booked"    Value="Booked"    />
                            <asp:ListItem Text="Paid"      Value="Paid"      />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="TicketGroup" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <br />

    <asp:GridView ID="gvTickets" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="TICKETID"
        OnRowEditing="gvTickets_RowEditing"
        OnRowDeleting="gvTickets_RowDeleting"
        OnRowCancelingEdit="gvTickets_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="TICKETID"      HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="CUSTOMERNAME"  HeaderText="Customer" />
            <asp:BoundField DataField="SHOWLABEL"     HeaderText="Show" />
            <asp:BoundField DataField="TICKETPRICE"   HeaderText="Price" />
            <asp:BoundField DataField="SEATNUMBER"    HeaderText="Seat" />
            <asp:BoundField DataField="BOOKINGDATE"   HeaderText="Booking Date" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:BoundField DataField="BOOKINGSTATUS" HeaderText="Status" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
