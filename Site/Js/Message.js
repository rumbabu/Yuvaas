$(document).ready(function () {
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
            url: "Message.aspx/InsertMessage",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'ToUserNames':'" + strMsgTo + "','MessageDesc':'" + $("#txtMessage").val() + "'}",
            success: function () {
                $(".chzn-choices .search-choice").remove();
                $("#txtMessage").val('');
                BindDropDown();
                BindRecentMessages();
            },
            failure: function () { }
        });
    }
}

function BindDropDown() {
    $.ajax({
        type: "POST",
        url: "Message.aspx/GetAllMembers",
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

function BindRecentMessages() {
    $.ajax({
        type: "POST",
        url: "Message.aspx/GetAllRecentMessages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{}",
        success: onsuccess_BindRecentMessages,
        failure: function () { }
    });
}

function onsuccess_BindRecentMessages(result, context) {
    if (result.d != null) {
        $("#" + divMessages).show();
        $("#" + divNoMessages).hide();
        $("#" + divMessages).html('');
        for (var index = 0; index < result.d.length; index++) {
            var objMessage = result.d[index];
            var UserImage = $("#" + hdnLoggedInUsername).val().toString().toLowerCase() == objMessage.FromUserName.toString().toLowerCase() ? objMessage.ToUserImage : objMessage.FromUserImage;
            var UserName = $("#" + hdnLoggedInUsername).val().toString().toLowerCase() == objMessage.FromUserName.toString().toLowerCase() ? objMessage.ToUserName : objMessage.FromUserName;
            $("#" + divMessages).append('<div class="msglistmain"><a onclick="return GetMessagebyUserId(\'' + objMessage.ToUserId + '\')"><div class="msglistimg"><img src="../getImage.aspx?Image=../Data/ProfileImages/' + UserImage + '&height=40&width=40&Aspect=true&type=0"/></div>' +
                         '<div class="msglistcontent"><h3>' + UserName + '</h3><div>' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div><span>' + objMessage.MessageDesc.substring(0, 15) + '</span></div></a></div>');
        }
    }
    else {
        $("#" + divMessages).hide();
        $("#" + divNoMessages).show();
    }
}

function GetMessagebyUserId(ToUserId) {
    $.ajax({
        type: "POST",
        url: "Message.aspx/GetMessagebyToUserId",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'ToUserId':'" + ToUserId + "'}",
        success: onsuccess_GetMessagebyToUserId,
        failure: function () { }
    });
}

function onsuccess_GetMessagebyToUserId(result, context) {
    if (result.d != null) {
        $("#" + divUserMessages).show();
        $("#" + divNoUserMessages).hide();
        $("#" + divUserMessages).html('');
        for (var index = 0; index < result.d.length; index++) {
            var objMessage = result.d[index];
            $("#" + divUserMessages).append('<div class="fbbtop"><div class="fbbleft"><div class="fimg"><img src="../getImage.aspx?Image=../Data/ProfileImages/' + objMessage.FromUserImage + '&height=60&width=60&Aspect=true&type=0"/></div>' +
                                    '<div class="emailid2">' + objMessage.FromUserName + '</div><div class="message">' + objMessage.MessageDesc + '</div></div>' +
                                    '<div class="time">' + GetDateFormat(new Date(Date.parse(objMessage.Createdon))) + '</div></div>');
        }
    }
    else {
        $("#" + divUserMessages).hide();
        $("#" + divNoUserMessages).show();
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