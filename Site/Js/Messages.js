var MsgPageSize = 20, MsgCurrentPageIndex = 0, MsgMaxPageCount = 0;
$(document).ready(function () {
    $("#" + divSentBox).html('');
    $(window.parent.document).scroll(function () { GetNextMessageList(); });
});
function PostMessage() {
    var strMsgTo = "";
    $(".chzn-choices").find(".search-choice").each(function () {
        strMsgTo += $(this).children(0).html() + ",";
    });
    strMsgTo = strMsgTo.substring(0, strMsgTo.length - 1);
    if ($("#txtMessage").val().replace(/ /g, '') != "") {
        $.ajax({
            type: "POST",
            url: "Messages.aspx/InsertMessage",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'ToUserNames':'" + strMsgTo + "','MessageDesc':'" + $("#txtMessage").val() + "'}",
            success: function () {
                $(".chzn-choices .search-choice").remove();
                $("#txtMessage").val('');
                BindDropDown();
                GetAllMessagesofInbox();
            },
            failure: function () { }
        });
    }
}

function BindDropDown() {
    $.ajax({
        type: "POST",
        url: "Messages.aspx/GetAllMembers",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{}",
        success: onsuccess_GetAllMembers,
        failure: function () { }
    });
}

function onsuccess_GetAllMembers(result, context) {
    if (result.d != null) {
        $("#ctl00_cphBody_ddlMembers").html('');
        for (var index = 0; index < result.d.length; index++) {
            $("#ctl00_cphBody_ddlMembers").append('<option value="' + result.d[index] + '">' + result.d[index] + '</option>');
        }
    }
    $("#ctl00_cphBody_ddlMembers").trigger("liszt:updated");
}

function ResetMessage(obj) {
    $(".btn_silvernnnn").find("a").removeClass("frndsel");
    $(obj).addClass("frndsel");
    $("#divNewMessage").hide();
    $("#ancDelAll").hide();
    $("#chkSelAll").removeAttr("checked");
    $("#" + divSettings).hide();
    $("#" + divMessages).hide();
    $("#" + divNoMessages).hide();
    $("#" + divSentBox).hide();
    $("#" + divNoSentBox).hide();
    MsgCurrentPageIndex = 0;
    MsgMaxPageCount = 0;
}

function GetAllMessagesofInbox(obj) {
    $("#" + hdnMessageType).val('inbox');
    ResetMessage(obj);
    $.ajax({
        type: "POST",
        url: "Messages.aspx/GetAllMessagesofInbox",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'Ticks':'" + new Date() + "','StartIndex':'" + MsgCurrentPageIndex + "','MaxIndex':'" + MsgPageSize + "'}",
        success: onsuccess_GetAllMessagesByToUserId,
        failure: function () { }
    });
}
function onsuccess_GetAllMessagesByToUserId(result, context) {
    if (result.d != null && result.d.MessageList.length > 0) {
        MsgMaxPageCount = parseInt(result.d.PageCount, 10);
        $("#" + divMessages).show();
        $("#" + divSettings).show();
        $("#" + divNoMessages).hide();
        $("#" + divMessages).htmml('');
        result = result.d.MessageList;
        for (var index = 0; index < result.length; index++) {
            var objMessage = result[index];
            var UserName = $("#" + hdnMessageType).val().toString().toLowerCase() == "sent" ? objMessage.ToUserName : objMessage.FromUserName;
            $("#" + divMessages).append('<div class="messagemain"><div class="messagechk"><input type="checkbox" value="' + objMessage.MessageId + '" /></div><div class="messageuser">' + UserName + '</div>' +
                            '<div class="messagetext">' + objMessage.MessageDesc.substring(0, 30) + '</div>' +
                            '<div class="messagedate">' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div>' +
                            '<div class="messagedel"><a onclick="return DeleteMessage(\'' + objMessage.MessageId + '\')">Delete</a></div></div>');
        }
    }
    else {
        $("#" + divMessages).hide();
        $("#" + divSettings).hide();
        $("#" + divNoMessages).show();
    }
}

function GetAllMessagesofSent(obj) {
    $("#" + hdnMessageType).val('sent');
    ResetMessage(obj);
    $.ajax({
        type: "POST",
        url: "Messages.aspx/GetAllMessagesofSent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'Ticks':'" + new Date() + "','StartIndex':'" + MsgCurrentPageIndex + "','MaxIndex':'" + MsgPageSize + "'}",
        success: onsuccess_GetAllMessagesofSent,
        failure: function () { }
    });
}
function onsuccess_GetAllMessagesofSent(result, context) {
    if (result.d != null && result.d.MessageList.length > 0) {
        MsgMaxPageCount = parseInt(result.d.PageCount, 10);
        $("#" + divSentBox).show();
        $("#" + divSettings).show();
        $("#" + divNoSentBox).hide();
        $("#" + divSentBox).html('');
        result = result.d.MessageList;
        for (var index = 0; index < result.length; index++) {
            var objMessage = result[index];
            var UserName = $("#" + hdnMessageType).val().toString().toLowerCase() == "sent" ? objMessage.ToUserName : objMessage.FromUserName;
            $("#" + divSentBox).append('<div class="messagemain"><div class="messagechk"><input type="checkbox" value="' + objMessage.MessageId + '" /></div><div class="messageuser">' + UserName + '</div>' +
                            '<div class="messagetext">' + objMessage.MessageDesc.substring(0, 30) + '</div>' +
                            '<div class="messagedate">' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div>' +
                            '<div class="messagedel"><a onclick="return DeleteMessage(\'' + objMessage.MessageId + '\')">Delete</a></div></div>');
        }
    }
    else {
        $("#" + divSentBox).hide();
        $("#" + divSettings).hide();
        $("#" + divNoSentBox).show();
    }
}
function GetDateFormat(date) {
    var monthNames = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
    var cDate = date.getDate();
    var cMonth = date.getMonth();
    var cYear = date.getFullYear();
    var cHour = date.getHours();
    var cMin = date.getMinutes();
    var cSec = date.getSeconds();
    return cDate + ' ' + monthNames[cMonth] + ", " + cYear;
}

function ShowNewMessage(obj) {
    $(".btn_silvernnnn").find("a").removeClass("frndsel");
    $(obj).addClass("frndsel");
    $("#divNewMessage").slideToggle();
    $("#" + divMessages).hide();
    $("#" + divSettings).hide();
    $("#" + divNoMessages).hide();
    $("#" + divSentBox).hide();
    $("#" + divNoSentBox).hide();
}
function selectAll(obj) {
    if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
        $("#" + divSentBox).find("input").each(function () { $(this).attr("checked", "checked") });
    }
    else {
        $("#" + divMessages).find("input").each(function () { $(this).attr("checked", "checked") });
    }
    $(obj).removeAttr("onclick")
    $(obj).attr("onclick", "DeselectAll(this);")
    $("#ancDelAll").show();
}
function DeselectAll(obj) {
    if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
        $("#" + divSentBox).find("input").each(function () { $(this).removeAttr("checked") });
    }
    else {
        $("#" + divMessages).find("input").each(function () { $(this).removeAttr("checked") });
    }
    $(obj).removeAttr("onclick")
    $(obj).attr("onclick", "selectAll(this);")
    $("#ancDelAll").hide();
}
function DeleteMessage(MessageId) {
    $.ajax({
        type: "POST",
        url: "Messages.aspx/DeleteMessage",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: '{"Ticks":"' + new Date() + '","MessageId":"' + "'" + MessageId + "'" + '"}',
        success: onsuccess_DeleteMessage,
        failure: function () { }
    });
}
function onsuccess_DeleteMessage() {
    if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
        GetAllMessagesofSent();
    }
    else {
        GetAllMessagesofInbox();
    }
}
function DeleteAll() {
    var MessageIds = "";
    if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
        $("#" + divSentBox).find("input").each(function () {
            if ($(this).attr("checked") == "checked") {
                MessageIds += "'" + $(this).val() + "'" + ",";
            }
        });
    }
    else {
        $("#" + divMessages).find("input").each(function () {
            if ($(this).attr("checked") == "checked") {
                MessageIds += "'" + $(this).val() + "'" + ",";
            }
        });
    }
    MessageIds = (MessageIds.substring(0, MessageIds.length - 1));
    $.ajax({
        type: "POST",
        url: "Messages.aspx/DeleteMessage",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: '{"Ticks":"' + new Date() + '","MessageId":"' + MessageIds + '"}',
        success: onsuccess_DeleteMessage,
        failure: function () { }
    });
}
function GetNextMessageList() {
    var scrollTop = parseInt($(window.parent, window.parent.document).scrollTop(), 10);
    if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
        var scrollHeight = parseInt(document.getElementById(divSentBox).scrollHeight, 10);
        if (scrollTop > (scrollHeight - 800)) {
            if (MsgPageSize > MsgCurrentPageIndex) {
                MsgCurrentPageIndex++;
                GetNextMessagesofSent();
            }
        }
    }
    else {
        if ($("#" + hdnMessageType).val().toString().toLowerCase() == "sent") {
            var scrollHeight = parseInt(document.getElementById(divSentBox).scrollHeight, 10);
            if (scrollTop > (scrollHeight - 800)) {
                if (MsgPageSize > MsgCurrentPageIndex) {
                    MsgCurrentPageIndex++;
                    GetNextMessagesofInbox();
                }
            }
        }
    }
}
function GetNextMessagesofSent() {
    $.ajax({
        type: "POST",
        url: "Messages.aspx/GetAllMessagesofSent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'Ticks':'" + new Date() + "','StartIndex':'" + MsgCurrentPageIndex + "','MaxIndex':'" + MsgPageSize + "'}",
        success: onsuccess_GetNextAllMessagesofSent,
        failure: function () { }
    });
}
function onsuccess_GetNextAllMessagesofSent(result,context) {
    if (result.d != null && result.d.MessageList.length > 0) {
        MsgMaxPageCount = parseInt(result.d.PageCount, 10);
        result = result.d.MessageList;
        for (var index = 0; index < result.length; index++) {
            var objMessage = result[index];
            var UserName = $("#" + hdnMessageType).val().toString().toLowerCase() == "sent" ? objMessage.ToUserName : objMessage.FromUserName;
            $("#" + divSentBox).append('<div class="messagemain"><div class="messagechk"><input type="checkbox" value="' + objMessage.MessageId + '" /></div><div class="messageuser">' + UserName + '</div>' +
                            '<div class="messagetext">' + objMessage.MessageDesc.substring(0, 30) + '</div>' +
                            '<div class="messagedate">' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div>' +
                            '<div class="messagedel"><a onclick="return DeleteMessage(\'' + objMessage.MessageId + '\')">Delete</a></div></div>');
        }
    }
}
function GetNextMessagesofInbox() {
    $.ajax({
        type: "POST",
        url: "Messages.aspx/GetAllMessagesofInbox",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'Ticks':'" + new Date() + "','StartIndex':'" + MsgCurrentPageIndex + "','MaxIndex':'" + MsgPageSize + "'}",
        success: onsuccess_GetNextMessagesofInbox,
        failure: function () { }
    });
}
function onsuccess_GetNextMessagesofInbox(result, context) {
    if (result.d != null && result.d.MessageList.length > 0) {
        MsgMaxPageCount = parseInt(result.d.PageCount, 10);
        debugger;
        $("#" + divMessages).html('');
        result = result.d.MessageList;
        for (var index = 0; index < result.length; index++) {
            var objMessage = result[index];
            var UserName = $("#" + hdnMessageType).val().toString().toLowerCase() == "sent" ? objMessage.ToUserName : objMessage.FromUserName;
            $("#" + divMessages).append('<div class="messagemain"><div class="messagechk"><input type="checkbox" value="' + objMessage.MessageId + '" /></div><div class="messageuser">' + UserName + '</div>' +
                            '<div class="messagetext">' + objMessage.MessageDesc.substring(0, 30) + '</div>' +
                            '<div class="messagedate">' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div>' +
                            '<div class="messagedel"><a onclick="return DeleteMessage(\'' + objMessage.MessageId + '\')">Delete</a></div></div>');
        }
    }
}