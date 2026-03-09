<%@ Page Title="Movie Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MovieForm.aspx.cs" Inherits="KumariCinemas.MovieForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Movie Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" /><br /><br />

    <asp:Button ID="btnAdd" runat="server" Text="+ Add New Movie" OnClick="btnAdd_Click" />
    <br /><br />

    <asp:Panel ID="pnlForm" runat="server" Visible="false">
        <fieldset>
            <legend>Movie Details</legend>
            <asp:HiddenField ID="hfMovieID" runat="server" />
            <table>
                <tr>
                    <td>Movie Title:</td>
                    <td>
                        <asp:TextBox ID="txtTitle" runat="server" Width="250px" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
                            ErrorMessage=" * Title required" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>Duration:</td>
                    <td><asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 2h 30m" /></td>
                </tr>
                <tr>
                    <td>Language:</td>
                    <td><asp:TextBox ID="txtLanguage" runat="server" /></td>
                </tr>
                <tr>
                    <td>Genre:</td>
                    <td><asp:TextBox ID="txtGenre" runat="server" /></td>
                </tr>
                <tr>
                    <td>Release Date:</td>
                    <td>
                        <asp:TextBox ID="txtReleaseDate" runat="server" placeholder="DD-MON-YYYY e.g. 01-JAN-2025" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReleaseDate"
                            ErrorMessage=" * Date required" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
    </asp:Panel>

    <br />

    <asp:GridView ID="gvMovies" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="MOVIEID"
        OnRowEditing="gvMovies_RowEditing"
        OnRowDeleting="gvMovies_RowDeleting"
        OnRowCancelingEdit="gvMovies_RowCancelingEdit"
        CellPadding="4" BorderWidth="1">
        <HeaderStyle BackColor="#336699" ForeColor="White" />
        <AlternatingRowStyle BackColor="#f2f2f2" />
        <Columns>
            <asp:BoundField DataField="MOVIEID"     HeaderText="ID" ReadOnly="true" />
            <asp:BoundField DataField="MOVIETITLE"  HeaderText="Title" />
            <asp:BoundField DataField="DURATION"    HeaderText="Duration" />
            <asp:BoundField DataField="LANGUAGE"    HeaderText="Language" />
            <asp:BoundField DataField="GENRE"       HeaderText="Genre" />
            <asp:BoundField DataField="RELEASEDATE" HeaderText="Release Date" DataFormatString="{0:dd-MMM-yyyy}" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>

</asp:Content>
