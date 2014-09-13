<%@ Page Title="Yuvaas Social - Message" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Message.aspx.cs" Inherits="Pages_Message" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <link href="../Js/Choosen/chosen.css" rel="stylesheet" type="text/css" />
    
    <div class="innerright">
        <div class="wallinner">
            <%--<div class="fbtop">
                <div class="fbtr">
                    <ul>
                        <li><a href="javascript:void(0);">New Message</a> </li>
                    </ul>
                </div>
            </div>--%>
            <div class="fbbottommain" id="divNewMessage">
                <div class="msgbox">
                    <div class="searchbox">
                        <select id="ddlMembers" runat="server" class="chzn-select" multiple="true">
                        </select>
                    </div>
                    <div class="mhht">
                        <textarea rows="2" cols="50" id="txtMessage" placeholder="What's on your mind?"></textarea>
                        <div class="area">
                            <a class="btn_silver" style="width: 35px; float: right; margin: 0px 3px 0px 0px;
                                text-align: center;" onclick="PostMessage();">Post</a></div>
                        <div id="divUploadImage" class="msgbodynn" style="display: none">
                            <img id="imgUploadedImage" src="" width="150" height="150" alt="" />
                            <input type="hidden" id="hdnUploadedImagePath" value="" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="fbbottommain">
                <div class="fbbottommainleft" id="divMessages" runat="server">
                    <asp:Repeater ID="rptMessages" runat="server">
                        <ItemTemplate>
                            <div class="msglistmain">
                                <a onclick='return GetMessagebyUserId("<%#Eval("ToUserId")%>")'>
                                    <div class="msglistimg">
                                        <img src='<%#"../getImage.aspx?Image=../Data/ProfileImages/" + (Session["Name"].ToString().ToLower() == Eval("FromUserName").ToString().ToLower() ? Eval("ToUserImage") : Eval("FromUserImage")) + "&height=40&width=40&Aspect=true&type=0" %>'
                                            alt="" /></div>
                                    <div class="msglistcontent">
                                        <h3>
                                            <%# (Session["Name"].ToString().ToLower() == Eval("FromUserName").ToString().ToLower() ? Eval("ToUserName") : Eval("FromUserName"))%></h3>
                                        <div>
                                            <%#Convert.ToDateTime(Eval("CreatedOn")).ToString("dd MMM, yyyy") %></div>
                                        <span>
                                            <%# Yuvaas.CommonFunctions.GetSubstring(Eval("MessageDesc"), 12) %></span>
                                    </div>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div id="divNoMessages" runat="server">
                    No Message(s).
                </div>
                <div class="fbbottommainright" id="divUserMessages" runat="server">
                    <asp:Repeater ID="rptUserMessages" runat="server">
                        <ItemTemplate>
                            <div class="fbbtop">
                                <div class="fbbleft">
                                    <div class="fimg">
                                        <img src='<%#"../getImage.aspx?Image=../Data/ProfileImages/" + Eval("FromUserImage") + "&height=60&width=60&Aspect=true&type=0" %>'
                                            alt="" /></div>
                                    <div class="emailid2">
                                        <%#Eval("FromUserName") %></div>
                                    <div class="message">
                                        <%#Eval("MessageDesc") %></div>
                                </div>
                                <div class="time">
                                    <%#Convert.ToDateTime(Eval("CreatedOn")).ToString("dd MMM, yyyy") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div id="divNoUserMessages" runat="server">
                    No Message(s).
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnLoggedInUsername" runat="server" />
    <script src="../Js/Message.js" type="text/javascript"></script>
    <script src="../Js/Choosen/chosen.jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(".chzn-select").chosen();
        var hdnLoggedInUsername = '<%=hdnLoggedInUsername.ClientID %>';
        var divNoUserMessages = '<%=divNoUserMessages.ClientID %>';
        var divUserMessages = '<%=divUserMessages.ClientID %>';
        var divNoMessages = '<%=divNoMessages.ClientID %>';
        var divMessages = '<%=divMessages.ClientID %>';
        $("#" + hdnLoggedInUsername).val('<%=Session["Name"]%>');
    </script>
</asp:Content>
