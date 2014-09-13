$(document).ready(function () {
    //BindFriends();
    BindNonFriends();
});

function BindFriends() {
    $('#ancNoFriends').attr("class", "");
    $('#ancfrndReq').attr("class", "");
    $('#ancFriends').attr("class", "frndsel");
    var params = "";
    params = params + '{"timestamp":"' + (new Date()) + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/GetFriends",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnFriendsSuccess,
        error: OnFriendsError
    });
    return false;
}

function OnFriendsSuccess(friendslist, context) {
    $("#divSearch").hide();
    if (friendslist.d != null) {
        $('#divFriends').html('');
        $('.norecords').hide('');
        for (var i = 0; i < friendslist.d.length; i++) {
            var firndsblock = '<div class="listfrnds"><div class="uinfoImg"><img src="../getImage.aspx?image=../Data/ProfileImages/' + friendslist.d[i].UserImage + '&height=75&width=75&Aspect=true&type=1&bgc=FFFFFF"></div><div class="fridetail"><a href="UserInfo.aspx?UserId=' + friendslist.d[i].UserId + '">' + friendslist.d[i].FirstName + " " + friendslist.d[i].LastName + '</a><p>' + friendslist.d[i].Designation + '</p></div></div>';
            $('#divFriends').append(firndsblock);
        }
    }

    else {
        $('#divFriends').html('');
        $('.norecords').show('');
        $('#ctl00_cphBody_lblNoRecords').html("No Friend(s).");
    }
}
function OnFriendsError(friendslist, context)
{ }

function BindFriendRequests() {
    $('#ancNoFriends').attr("class", "");
    $('#ancfrndReq').attr("class", "frndsel");
    $('#ancFriends').attr("class", "");
    var params = "";
    params = params + '{"timestamp":"' + (new Date()) + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/GetAllFriendRequests",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnFriendsRequestsSuccess,
        error: OnFriendsRequestsError
    });
    return false;
}

function OnFriendsRequestsSuccess(friendslist, context) {
    $("#divSearch").hide();
    if (friendslist.d != null) {
        $('#divFriends').html('');
        $('.norecords').hide('');
        for (var i = 0; i < friendslist.d.length; i++) {
            var firndsblock = '<div class="listfrnds"><div class="uinfoImg"><img src="../getImage.aspx?image=../Data/ProfileImages/' + friendslist.d[i].UserImage + '&height=75&width=75&Aspect=true&type=1&bgc=FFFFFF"></div><div class="fridetail"><a href="UserInfo.aspx?UserId=' + friendslist.d[i].UserId + '">' + friendslist.d[i].FirstName + " " + friendslist.d[i].LastName + '</a><p>' + friendslist.d[i].Designation + '</p></div><div class="frndbtn"><input type="submit" class="addfrndnn btn_silvernn" value="Accept Friend" onclick="return AcceptFriend(\'' + friendslist.d[i].UserId + '\');"></div></div>';
            $('#divFriends').append(firndsblock);
        }
    }
    else {
        $('#divFriends').html('');
        $('.norecords').show('');
        $('#ctl00_cphBody_lblNoRecords').html("No Friend Request(s).");
    }
}
function OnFriendsRequestsError(friendslist, context)
{ }

function BindNonFriends(Searchstring) {
    $('#ancNoFriends').attr("class", "frndsel");
    $('#ancfrndReq').attr("class", "");
    $('#ancFriends').attr("class", "");
    if (Searchstring == null)
        Searchstring = "1=1";
    var params = "";
    params = params + '{"timestamp":"' + (new Date()) + '","SearchString":"' + Searchstring + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/GetAllNonFriends",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnGetAllNonFriendsSuccess,
        error: OnGetAllNonFriendsError
    });
    return false;
}

function OnGetAllNonFriendsSuccess(userlist, context) {
    $("#divSearch").show();
    if (userlist.d != null) {
        $('#divFriends').html('');
        $('.norecords').hide('');
        for (var i = 0; i < userlist.d.length; i++) {
            var reqbtnvalue, clickevent;
            if (userlist.d[i].friend.IsMailSent == true && userlist.d[i].friend.UserId.toLowerCase() != userid) {
                reqbtnvalue = "Respond to Friend Request";
                clickevent = "return RespondFriendRequest('" + userlist.d[i].UserId + "')";
            }
            else {
                reqbtnvalue = (userlist.d[i].friend.LastRequestedDate != "/Date(-62135596800000)/" && userlist.d[i].friend.IsAccepted == false) ? "Request Sent" : "Add Friend";
                clickevent = (userlist.d[i].friend.LastRequestedDate != "/Date(-62135596800000)/" && userlist.d[i].friend.IsAccepted == false) ? "return false;" : "return AddFriend('" + userlist.d[i].UserId + "')";
            }
            var firndsblock = '<div class="listfrnds"><div class="uinfoImg"><img src="../getImage.aspx?image=../Data/ProfileImages/' + userlist.d[i].UserImage + '&height=75&width=75&Aspect=true&type=1&bgc=FFFFFF"></div><div class="fridetail"><a href="UserInfo.aspx?UserId=' + userlist.d[i].UserId + '">' + userlist.d[i].FirstName + ' ' + userlist.d[i].LastName + '</a><p>' + userlist.d[i].Designation + '</p></div><div class="frndbtn"><input type="submit" class="addfrndnn btn_silvernn" value="' + reqbtnvalue + '" onclick="' + clickevent + '"></div></div>';
            $('#divFriends').append(firndsblock);
        }
    }
    else {
        $('#divFriends').html('');
        $('.norecords').show('');
        $get('ctl00_cphBody_lblNoRecords').innerHTML = "No Friend(s).";
    }
}

function OnGetAllNonFriendsError(userlist, context)
{ }

function AddFriend(FId) {
    var params = "";
    params = params + '{"FId":"' + FId + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/AddFriend",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnAddFriendSuccess,
        error: OnAddFriendError
    });
    return false;
}
function OnAddFriendSuccess(result, context) {
    BindNonFriends();
}
function OnAddFriendError(result, context)
{ }

function AcceptFriend(UId) {
    var params = "";
    params = params + '{"UserId":"' + UId + '"';
    params = params + ',"FriendUserId":"' + userid + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/AcceptFriend",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnAcceptFriendSuccess,
        error: OnAcceptFriendError
    });
    return false;
}
function OnAcceptFriendSuccess(request, context) {
    BindFriendRequests();
}
function OnAcceptFriendError(request, context) {
}


function RespondFriendRequest(UId) {
    var params = "";
    params = params + '{"UserId":"' + UId + '"';
    params = params + ',"FriendUserId":"' + userid + '"}';
    $.ajax({
        type: "POST",
        url: "Friends.aspx/AcceptFriend",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnRespondFriendRequestFriendSuccess,
        error: OnRespondFriendRequestFriendError
    });
    return false;
}
function OnRespondFriendRequestFriendSuccess(request, context) {
    BindNonFriends();
}
function OnRespondFriendRequestFriendError(request, context) {
}
function SearchFriends() {
    var Searchstring = $("#txtSearchFriends").val().replace(/ /g, '') != "" ? $("#txtSearchFriends").val() : "";
    BindNonFriends(Searchstring);
}