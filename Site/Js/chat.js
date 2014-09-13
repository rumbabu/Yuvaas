
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