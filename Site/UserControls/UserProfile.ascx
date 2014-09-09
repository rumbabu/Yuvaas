<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserProfile.ascx.cs" Inherits="UserControls_UserProfile" %>
<script src="../Js/Notifications.js" type="text/javascript"></script>
<div class="innerleft">
<div class="dn">
    <div class="user_img gallery" style="margin: 5px 0px 10px 7px; text-align: left;
        height: 80px;">
        <a href="~/Pages/NewsFeed.aspx" rel="prettyPhoto" title="" runat="server" id="lnkProfileImg">
            <span style="float: left;">
                <img id="imgProgile" runat="server" width="80" height="80"></span></a>
    </div>
    <div class="usdata">
        <h2>
            <asp:Label ID="lblName" runat="server"></asp:Label>
        </h2>
        <p>
            <asp:Label ID="lblGender" runat="server"></asp:Label></p>
        <p>
            <asp:Label ID="lblCity" runat="server"></asp:Label></p>
        <p>
            <asp:Label ID="lblState" runat="server"></asp:Label></p>
    </div></div>
    <div class="favdata">
      <%--  <h3>
            Favourites
        </h3>
        <p>
            <a href="../Pages/NewsFeed.aspx">News Feed</a></p>
        <p>
            <a href="../Pages/Profile.aspx">Profile</a>
        </p>
        <p>
            <a href="../Pages/Messages.aspx">Messages</a>
        </p>--%>
        
    </div>
</div>
