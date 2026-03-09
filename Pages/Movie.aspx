<%@ Page Title="Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="KumariCinemas.Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #4CAF50; color: white; padding: 10px; }
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
    <h2>🎥 Movie Details</h2>

    <div class="form-section">
        <h3>Add / Update Movie</h3>
        <table>
            <tr>
                <td>Movie ID:</td>
                <td><asp:TextBox ID="txtMovieID" runat="server" ReadOnly="true" CssClass="readonly" placeholder="Auto-generated"/></td>
                <td>Movie Title:</td>
                <td><asp:TextBox ID="txtMovieTitle" runat="server"/></td>
            </tr>
            <tr>
                <td>Duration (mins):</td>
                <td><asp:TextBox ID="txtDuration" runat="server"/></td>
                <td>Language:</td>
                <td><asp:TextBox ID="txtLanguage" runat="server"/></td>
            </tr>
            <tr>
                <td>Genre:</td>
                <td><asp:TextBox ID="txtGenre" runat="server"/></td>
                <td>Release Date:</td>
                <td><asp:TextBox ID="txtReleaseDate" runat="server" placeholder="YYYY-MM-DD"/></td>
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
        <h3>Movie List</h3>
        <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="False"
            OnSelectedIndexChanged="gvMovies_SelectedIndexChanged"
            DataKeyNames="MOVIEID" Width="100%"
            HeaderStyle-BackColor="#4CAF50" HeaderStyle-ForeColor="White">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Select"/>
                <asp:BoundField DataField="MOVIEID" HeaderText="ID"/>
                <asp:BoundField DataField="MOVIETITLE" HeaderText="Title"/>
                <asp:BoundField DataField="DURATION" HeaderText="Duration"/>
                <asp:BoundField DataField="LANGUAGE" HeaderText="Language"/>
                <asp:BoundField DataField="GENRE" HeaderText="Genre"/>
                <asp:BoundField DataField="RELEASEDATE" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}"/>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>