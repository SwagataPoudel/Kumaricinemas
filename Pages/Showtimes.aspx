<%@ Page Title="Showtimes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Showtimes.aspx.cs" Inherits="KumariCinemas.Showtimes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #FF9800; color: white; padding: 10px; }
        td { padding: 8px; border: 1px solid #ddd; }
        input, select { width: 100%; padding: 5px; }
        .btn { padding: 8px 15px; margin: 3px; cursor: pointer; border-radius: 4px; }
        .btn-add { background: #4CAF50; color: white; border: none; }
        .btn-update { background: #2196F3; color: white; border: none; }
        .btn-delete { background: #f44336; color: white; border: none; }
        .btn-clear { background: #9E9E9E; color: white; border: none; }
        .form-section { background: white; padding: 20px; margin-bottom: 20px; border-radius: 5px; box-shadow: 0 1px 4px rgba(0,0,0,0.1); }
        .readonly { background: #eeeeee; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>🕐 Showtimes Details</h2>

    <div class="form-section">
        <h3>Add / Update Show</h3>
        <table>
            <tr>
                <td>Show ID:</td>
                <td><asp:TextBox ID="txtShowID" runat="server" ReadOnly="true" CssClass="readonly" placeholder="Auto-generated"/></td>
                <td>Show Date:</td>
                <td><asp:TextBox ID="txtShowDate" runat="server" placeholder="YYYY-MM-DD"/></td>
            </tr>
            <tr>
                <td>Show Time:</td>
                <td>
                    <asp:DropDownList ID="ddlShowTime" runat="server">
                        <asp:ListItem>Morning</asp:ListItem>
                        <asp:ListItem>Day</asp:ListItem>
                        <asp:ListItem>Evening</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>Is Release Week:</td>
                <td>
                    <asp:DropDownList ID="ddlIsReleaseWeek" runat="server">
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Movie:</td>
                <td>
                    <asp:DropDownList ID="ddlMovie" runat="server"
                        DataTextField="MOVIETITLE" DataValueField="MOVIEID"/>
                </td>
                <td>Theatre (Name - City):</td>
                <td>
                    <asp:DropDownList ID="ddlTheatre" runat="server"
                        DataTextField="THEATREINFO" DataValueField="THEATREID"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlTheatre_SelectedIndexChanged"/>
                </td>
            </tr>
            <tr>
                <td>Hall:</td>
                <td>
                    <asp:DropDownList ID="ddlHall" runat="server"
                        DataTextField="HALLNAME" DataValueField="HALLID"/>
                </td>
                <td>Base Price:</td>
                <td><asp:TextBox ID="txtBasePrice" runat="server"/></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-add" OnClick="btnAdd_Click"/>
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click"/>
        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDelete_Click"/>
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClear_Click"/>
        <asp:Label ID="lblMessage" runat="server"/>
    </div>

    <div class="form-section">
        <h3>Showtimes List</h3>
        <asp:GridView ID="gvShowtimes" runat="server" AutoGenerateColumns="False"
            OnSelectedIndexChanged="gvShowtimes_SelectedIndexChanged"
            DataKeyNames="SHOWID" Width="100%"
            HeaderStyle-BackColor="#FF9800" HeaderStyle-ForeColor="White">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                <asp:BoundField DataField="SHOWID" HeaderText="Show ID"/>
                <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre"/>
                <asp:BoundField DataField="THEATRECITY" HeaderText="City"/>
                <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date" DataFormatString="{0:yyyy-MM-dd}"/>
                <asp:BoundField DataField="SHOWTIME" HeaderText="Show Time"/>
                <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie"/>
                <asp:BoundField DataField="HALLNAME" HeaderText="Hall"/>
                <asp:BoundField DataField="BASEPRICE" HeaderText="Base Price"/>
                <asp:BoundField DataField="ISRELEASEWEEK" HeaderText="Release Week"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>