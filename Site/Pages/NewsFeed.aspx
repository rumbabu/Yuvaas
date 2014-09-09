<%@ Page Title="Yuvaas - News Feed" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="NewsFeed.aspx.cs" Inherits="SRChat.Pages_NewsFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <style>
        .chatRooms
        {
            max-height: 500px;
            overflow: auto;
        }
        .chatRoom
        {
            width: 100%;
            height: 250px;
            border: 1px solid #ccc;
        }
        .chatMessages
        {
            width: 100%;
            height: 200px;
            overflow: auto;
            margin-left: 0px;
            padding-left: 0px;
        }
        .chatMessages li
        {
            list-style-type: none;
            padding: 1px;
        }
        .chatNewMessage
        {
            border: 1px solid #ccc;
            width: 200px;
            float: left;
            height: 18px;
        }
        .chatMessage
        {
        }
        .chatSend
        {
            float: left;
        }
        .chat-container
        {
            background: none repeat scroll 0 0 #0d630d;
            border: 1px solid rgba(0, 0, 0, 0.07);
            height: 300px;
            overflow-x: hidden;
            overflow-y: scroll;
            position: fixed;
            right: 0;
            bottom: 0;
            width: 16.5%;
            z-index: 100;
        }
    </style>
    <link rel="stylesheet" href="../Css/prettyPhoto.css?v=1.1" />
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Css/jquery-ui.css" />
    <script src="../Js/jquery-1.8.2.js"></script>
    <script src="../Js/jquery-ui.js"></script>
    <script type="text/javascript" src="../Js/jquery.dialogextend.1_0_1.js"></script>
    <script type="text/javascript" src="../Js/jquery.signalR.js"></script>
    <script type="text/javascript" src="../Js/jQuery.tmpl.js"></script>
    <script type="text/javascript" src="../signalr/hubs"></script>
    <script id="new-online-contacts" type="text/x-jquery-tmpl">
        <div>
        <ul>
        {{each messageRecipients}}
        <li id="chatLink${messageRecipientId}">
            <a href="javascript:;" onclick="javascript:SRChat.initiateChat('${messageRecipientId}','${messageRecipientName}');"><span class="spnimg"><img src="../getImage.aspx?image=../Data/ProfileImages/photo635239933260867138.PNG&amp;height=28&amp;width=28&amp;Aspect=true&amp;type=1&amp;bgc=ffffff"></span><span class="spnmsg"><h5>${messageRecipientName}</h5> online</span></li>
            </a>
        </li>
        {{/each}}
        </ul>
        </div>
    </script>
    <script id="new-chatroom-template" type="text/x-jquery-tmpl">
    <div id="chatRoom${chatRoomId}" class="chatRoom">
        <ul id="messages${chatRoomId}" class="chatMessages">
        </ul>
        <form id="sendmessage${chatRoomId}" action="#">
            <input type="text" id="newmessage${chatRoomId}" class="chatNewMessage"/>
            <div class="clear"></div>
            <input type="button" id="chatsend${chatRoomId}" value="Send" class="chatSend" onClick="javascript:SRChat.sendChatMessage('${chatRoomId}')" />
            <input type="button" id="chatend${chatRoomId}" value="End Chat" class="chatSend" onClick="javascript:SRChat.endChat('${chatRoomId}')" />
        </form>
    </div>
    </script>
    <script id="new-chat-header" type="text/x-jquery-tmpl">
    <div id="chatRoomHeader${chatRoomId}">
        {{each messageRecipients}}
            {{if $index == 0}}
                ${messageRecipientName}
            {{else}}
                , ${messageRecipientName}
            {{/if}}
        {{/each}}
    <div>
    </script>
    <script id="new-message-template" type="text/x-jquery-tmpl">
    <li class="message" id="m-${chatMessageId}">
        <strong>${displayPrefix}</strong>
        {{html messageText}}
    </li>
    </script>
    <script id="new-notify-message-template" type="text/x-jquery-tmpl">
    <li class="message" id="m-${chatMessageId}">
        <strong>{{html messageText}}</strong>
    </li>
    </script>
    <div class="innerright">
        <div class="wallinner">
            <div class="updatestatus">
                <ul class="us">
                    <li class=""><a href="javascript:void(0);" class=""><span class="uiIconText"><i class="sx_a35373 sp_8noqk7 img">
                    </i>Update Status<i class=""> </i></span></a></li>
                    <li class=""><a href="javascript:void(0);" class="" onclick="performClick();" id="ancUploadImage">
                        <span class="uiIconText"><i class="sx_48da95 sp_5t1i4q img"></i>Add Photos<i class="">
                        </i></span></a><a href="javascript:void(0);" class="dn" onclick="releaseUploadedFile();"
                            id="ancDelete"><span class="uiIconText"><i class="sx_48da95 sp_5t1i4q img"></i>Delete
                                Image <i class=""></i></span><span>
                                    <img src="" alt="" /></span> </a></li>
                </ul>
                <%-- <ul>
                    <li><a href="javascript:void(0);">Update Status <span>
                        <img src="" alt="" /></span> </a></li>
                    <li><a href="javascript:void(0);" onclick="performClick();" id="ancUploadImage">Upload
                        Image</a> <a href="javascript:void(0);" onclick="releaseUploadedFile();" id="ancDelete">
                            Delete Image <span>
                                <img src="" alt="" /></span> </a></li>
                </ul>--%>
            </div>
            <div class="psbox">
                <div class="mhht">
                    <textarea rows="2" cols="50" id="txtPost" placeholder="What's on your mind?"></textarea>
                    <div class="area">
                        <a class="btn_silver" style="width: 35px; float: right; margin: 0px 3px 0px 0px;
                            text-align: center;" onclick="PostMessage();">Post</a></div>
                    <div id="divUploadImage" class="msgbodynn" style="display: none">
                        <img id="imgUploadedImage" src="" width="150" height="150" alt="" />
                        <input type="hidden" id="hdnUploadedImagePath" value="" />
                    </div>
                </div>
            </div>
            <div class="upimg">
                <asp:FileUpload size="1" Style="visibility: hidden;" ID="updawardimg" name="updawardimg"
                    onchange="return ajaxFileUploader();" runat="server" accept="image/*" />
            </div>
            <div id="divFeedContent" class="feeds">
                <div id="divFeeds">
                </div>
                <%--<div id="divLoader"><img src="../Images/LoadingIndicator-32.png" alt="Loading..." /></div>--%>
            </div>
        </div>
    </div>
    <div class="innerads">
        <ul>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
        </ul>
    </div>
    <div class="innerfeed">
        <div class="chatfld" id="divNotifications">
            <ul id="ulNotifications">
            </ul>
        </div>
        <div class="chat-container">
            <div id="chatRooms">
            </div>
            <div id="chatOnlineContacts">
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnCommentsHTML" runat="server" />
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <asp:HiddenField ID="hdnUserImagePath" runat="server" />
    <asp:HiddenField ID="hdnUserImage" runat="server" />
    <input type="hidden" id="hdnCurrentStatusId" value="" />
    <input type="hidden" id="hdnCurrentCommentId" value="" />
    <input type="hidden" id="hdnCurrentComment" value="" />
    <input type="hidden" id="hdnSelectedUserId" runat="server" value="" />
    <script type="text/javascript">

        var ImagePath = "<%=path %>";
        var updawardimg = '<%=updawardimg.ClientID %>';
        var hdnUserImage = '<%=hdnUserImage.ClientID %>';
        var hdnUserName = '<%=hdnUserName.ClientID %>';
        var hdnUserImagePath = '<%=userimagepath %>';
        var LoggedInUserId = '<%=LoggedInUserId %>';
        var hdnSelectedUserId = '<%=hdnSelectedUserId.ClientID %>';
        var hdnCommentsHTML = '<%=hdnCommentsHTML.ClientID %>';
        var _MaximumRecords = parseInt('<%= MaxRecords %>');
        var _UserId = '<%= Session["UserId"].ToString() %>';

    </script>
    <script src="../Js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="../Js/NewsFeed.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            SRChat.attachEvents();
        });


        SRChat = new function () {
            var chatRooms = 0;
            var userName = '<%= Session["Name"].ToString() %>';
            var senderId = '<%= Session["UserId"].ToString() %>';
            var userImage = '<%= Yuvaas.CommonFunctions.GetStringValue(Session["UserImage"]) %>';
            var senderName = userName;

            var sRChatServer;

            window.onbeforeunload = function () {
                if (chatRooms > 0)
                    return "All chat instances will be ended!";
            };

            this.attachEvents = function () {
                //$("#userNameLabel").html(senderName);
                if ($.connection != null) {
                    jQuery.support.cors = true;
                    $.connection.hub.url = '../signalr/hubs';
                    sRChatServer = $.connection.sRChatServer;

                    $.connection.hub.start({ transport: 'auto' }, function () {
                        sRChatServer.server.connect(senderId, senderName).fail(function (e) {
                            alert(e);
                        });
                    });

                    sRChatServer.client.initiateChatUI = function (chatRoom) {
                        var chatRoomDiv = $('#chatRoom' + chatRoom.chatRoomId);
                        if (($(chatRoomDiv).length > 0)) {
                            var chatRoomText = $('#newmessage' + chatRoom.chatRoomId);
                            var chatRoomSend = $('#chatsend' + chatRoom.chatRoomId);
                            var chatRoomEndChat = $('#chatend' + chatRoom.chatRoomId);

                            chatRoomText.show();
                            chatRoomSend.show();
                            chatRoomEndChat.show();
                        }
                        else {
                            var e = $('#new-chatroom-template').tmpl(chatRoom);
                            var c = $('#new-chat-header').tmpl(chatRoom);

                            chatRooms++;

                            //dialog options
                            var dialogOptions = {
                                "id": '#messages' + chatRoom.chatRoomId,
                                "title": c,
                                "width": 360,
                                "height": 365,
                                "modal": false,
                                "resizable": false,
                                "close": function () { javascript: SRChat.endChat('' + chatRoom.chatRoomId + ''); $(this).remove(); }
                            };

                            // dialog-extend options
                            var dialogExtendOptions = {
                                "close": true,
                                "maximize": false,
                                "minimize": true,
                                "dblclick": 'minimize',
                                "titlebar": 'transparent'
                            };

                            e.dialog(dialogOptions).dialogExtend(dialogExtendOptions);

                            $('#sendmessage' + chatRoom.chatRoomId).keypress(function (e) {
                                if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
                                    $('#chatsend' + chatRoom.chatRoomId).click();
                                    return false;
                                }
                            });
                        }
                    };

                    sRChatServer.client.updateChatUI = function (chatRoom) {
                        var chatRoomHeader = $('#chatRoomHeader' + chatRoom.chatRoomId);
                        var c = $('#new-chat-header').tmpl(chatRoom);
                        chatRoomHeader.html(c);
                    };

                    sRChatServer.client.receiveChatMessage = function (chatMessage, chatRoom) {
                        sRChatServer.client.initiateChatUI(chatRoom);
                        var chatRoom = $('#chatRoom' + chatMessage.conversationId);
                        var chatRoomMessages = $('#messages' + chatMessage.conversationId);
                        var e = $('#new-message-template').tmpl(chatMessage).appendTo(chatRoomMessages);
                        e[0].scrollIntoView();
                        chatRoom.scrollIntoView();
                    };

                    sRChatServer.client.receiveLeftChatMessage = function (chatMessage) {
                        var chatRoom = $('#chatRoom' + chatMessage.conversationId);
                        var chatRoomMessages = $('#messages' + chatMessage.conversationId);
                        var e = $('#new-notify-message-template').tmpl(chatMessage).appendTo(chatRoomMessages);
                        e[0].scrollIntoView();
                        chatRoom.scrollIntoView();
                    };

                    sRChatServer.client.receiveEndChatMessage = function (chatMessage) {
                        var chatRoom = $('#chatRoom' + chatMessage.conversationId);
                        var chatRoomMessages = $('#messages' + chatMessage.conversationId);
                        var chatRoomText = $('#newmessage' + chatMessage.conversationId);
                        var chatRoomSend = $('#chatsend' + chatMessage.conversationId);
                        var chatRoomEndChat = $('#chatend' + chatMessage.conversationId);

                        chatRooms--;

                        var e = $('#new-notify-message-template').tmpl(chatMessage).appendTo(chatRoomMessages);

                        chatRoomText.hide();
                        chatRoomSend.hide();
                        chatRoomEndChat.hide();

                        e[0].scrollIntoView();
                        chatRoom.scrollIntoView();
                    };

                    sRChatServer.client.onGetOnlineContacts = function (chatUsers) {
                        var e = $('#new-online-contacts').tmpl(chatUsers);
                        var chatLink = $('#chatLink' + senderId);
                        e.find("#chatLink" + senderId).remove();
                        $("#chatOnlineContacts").html("");
                        $("#chatOnlineContacts").html(e);
                    };
                }
            };

            this.sendChatMessage = function (chatRoomId) {
                var chatRoomNewMessage = $('#newmessage' + chatRoomId);

                if (chatRoomNewMessage.val() == null || chatRoomNewMessage.val() == "")
                    return;

                var chatMessage = {
                    senderId: senderId,
                    senderName: senderName,
                    conversationId: chatRoomId,
                    messageText: chatRoomNewMessage.val()
                };

                chatRoomNewMessage.val('');
                chatRoomNewMessage.focus();
                sRChatServer.server.sendChatMessage(chatMessage).fail(function (e) {
                    alert(e);
                });

                return false;
            };

            this.endChat = function (chatRoomId) {
                var chatRoomNewMessage = $('#newmessage' + chatRoomId);

                var chatMessage = {
                    senderId: senderId,
                    senderName: senderName,
                    conversationId: chatRoomId,
                    messageText: chatRoomNewMessage.val()
                };
                chatRoomNewMessage.val('');
                chatRoomNewMessage.focus();
                sRChatServer.server.endChat(chatMessage).fail(function (e) {
                    //alert(e);
                });
            };

            this.initiateChat = function (toUserId, toUserName) {
                if (sRChatServer == null) {
                    alert("Problem in connecting to Chat Server. Please Contact Administrator!");
                    return;
                }
                sRChatServer.server.initiateChat(senderId, senderName, toUserId, toUserName).fail(function (e) {
                    alert(e);
                });
            };

        };
    </script>
</asp:Content>
