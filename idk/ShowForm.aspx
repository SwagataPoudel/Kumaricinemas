<%@ Page Title="Show Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowForm.aspx.cs" Inherits="KumariCinemas.ShowForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Show Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" /><br /><br />

    <asp:Button ID="btnAdd" runat="server" Text="+ Add New Show" OnClick="btnAdd_Click" />
    <br /><br />

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <fieldset>
            <legend>Show Details</legend>
            <asp:HiddenField ID="hfShowID" runat="server" />
            <table>
                <tr>
                    <td>Movie:</td>
                    <td>
                        <asp:DropDownList ID="ddlMovie" runat="server"
                            DataValueField="MOVIEID" DataTextField="MOVIETITLE" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlMovie"
                            InitialValue="" ErrorMessage=" * Movie required" ForeColor="Red" ValidationGroup="ShowGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Hall:</td>
                    <td>
                        <asp:DropDownList ID="ddlHall" runat="server"
                            DataValueField="HALLID" DataTextField="HALLLABEL" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlHall"
                            InitialValue="" ErrorMessage=" * Hall required" ForeColor="Red" ValidationGroup="ShowGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Show Time:</td>
                    <td>
                        <asp:TextBox ID="txtShowTime" runat="server" placeholder="e.g. Morning / 10:00 AM" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtShowTime"
                            ErrorMessage=" * Time required" ForeColor="Red" ValidationGroup="ShowGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Show Date:</td>
                    <td>
                        <asp:TextBox ID="txtShowDate" runat="server" placeholder="DD-MON-YYYY e.g. 01-JAN-2025" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtShowDate"
                            ErrorMessage=" * Date required" ForeColor="Red" ValidationGroup="ShowGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Base Price:</td>
                    <td>
                        <asp:TextBox ID="txtBasePrice" runat="server" placeholder="e.g. 500" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBasePrice"
                            ErrorMessage=" * Price required" ForeColor="Red" ValidationGroup="ShowGroup" />
                    </td>
                </tr>
                <tr>
                    <td>Is Release Week:</td>
                    <td>
                        <asp:DropDownList ID="ddlIsReleaseWeek" runat="server">
                            <asp:ListItem Text="No"  Value="No"  />
                            <asp:ListItem Text="Yes" Value="Yes" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="ShowGroup" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <br />

    <asp:GridView ID="gvShows" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="SHOWID"
        OnRowEditing="gvShows_RowEditing"
        OnRowDeleting="gvShows_RowDeleting"
        OnRowCancelingEdit="gvShows_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="SHOWID"        HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="MOVIETITLE"    HeaderText="Movie" />
            <asp:BoundField DataField="HALLLABEL"     HeaderText="Hall" />
            <asp:BoundField DataField="SHOWTIME"      HeaderText="Time" />
            <asp:BoundField DataField="SHOWDATE"      HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:BoundField DataField="BASEPRICE"     HeaderText="Base Price" />
            <asp:BoundField DataField="ISRELEASEWEEK" HeaderText="Release Week?" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
