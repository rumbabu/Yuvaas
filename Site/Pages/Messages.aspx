<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Messages.aspx.cs" Inherits="Pages_Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <script src="../Js/Messages.js" type="text/javascript"></script>
    <link href="../Js/Choosen/chosen.css" rel="stylesheet" type="text/css" />
    <script src="../Js/Choosen/chosen.jquery.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <div class="innerright">
        <div class="wallinner">
            <div class="btn_silvernnnn">
                <a onclick="return ShowNewMessage(this);" id="ancNewMessage" runat="server" class="">
                    New Message</a> <a onclick="return GetAllMessagesofInbox(this);" class="frndsel"
                        id="ancInbox" runat="server">Inbox</a> <a onclick="return GetAllMessagesofSent(this);"
                            id="ancSent" runat="server" style="border: none;" class="">Sent</a>
            </div>
            <div class="fbbottommain" id="divNewMessage" style="display: none;">
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
            <div id="divSettings" runat="server" class="msgsetting">
                <input type="checkbox" id="chkSelAll" onclick="selectAll(this);" />
                <a id="ancDelAll" style="display: none;" onclick="DeleteAll();">Delete</a>
            </div>
            <div class="fbbottommain" id="divMessages" runat="server">
                <asp:Repeater ID="rptMessages" runat="server">
                    <ItemTemplate>
                        <div class="messagemain">
                            <div class="messagechk">
                                <input type="checkbox" value='<%#Eval("MessageId") %>' />
                            </div>
                            <div class="messageuser">
                                <%#Eval("FromUserName")%>
                            </div>
                            <div class="messagetext">
                                <%#Yuvaas.CommonFunctions.GetSubstring(Eval("MessageDesc"),30)%>
                            </div>
                            <div class="messagedate">
                                <%#Convert.ToDateTime(Eval("CreatedOn")).ToString("dd MMM yyyy")%>
                            </div>
                            <div class="messagedel">
                                <a onclick='<%#"return DeleteMessage(\"" + Eval("MessageId") + "\")" %>'>Delete</a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="nomessage" id="divNoMessages" runat="server">
                No Message(s).
            </div>
            <div class="fbbottommain" id="divSentBox" runat="server" style="display: none">
            </div>
            <div class="nomessage" id="divNoSentBox" runat="server" style="display: none;">
                No Message(s).
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnMessageType" runat="server" Value="inbox" />
    <script type="text/javascript">
        $(".chzn-select").chosen();
        var divNoMessages = '<%=divNoMessages.ClientID %>';
        var divMessages = '<%=divMessages.ClientID %>';
        var divNoSentBox = '<%=divNoSentBox.ClientID %>';
        var divSentBox = '<%=divSentBox.ClientID %>';
        var divSettings = '<%=divSettings.ClientID %>';
        var hdnMessageType = '<%=hdnMessageType.ClientID %>';
    </script>
</asp:Content>
