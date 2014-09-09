var _PageSize, _CurrentPageIndex, _MaximumRecords;
$(document).ready(function () {
    _PageSize = 5;
    _CurrentPageIndex = 1;
    GetStatusListByUserId(" 1=1 ");
    //GetStatusList();
    document.body.setAttribute("onscroll", "GetNextStatusList();");
});

function GetStatusListByUserId(SearchString) {
    var params = "";
    params += '{"sortBy":" CreatedDate DESC "';
    params += ',"searchStriing":" 1 = 1 "';
    params += ',"pageSize":' + _PageSize + '';
    params += ',"startIndex":' + _CurrentPageIndex + '';
    params += ',"SelectedUserId":"' + SelectedUserId + '"';
    params += ',"LoggedInUserId":"' + LoggedInUserId + '"}';

    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/SelPostsForWallByPaging",
        data: params,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: onSuccessBindStatusList,
        error: onFailureBindStatusList
    });
}
/* Bind Status List and Comments */
function GetStatusList() {
    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/GetAllStatusListByUserId",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{}",
        success: onSuccessGetStatusList,
        failure: onfailureGetStatusList
    });
}
function onSuccessBindStatusList(result, context) {
    //$('#divFeeds').html('');
    if (result != null && result.d != null) {
        _MaximumRecords = parseInt(result.d.count);
        if (typeof (result.d.ObjStatus) != "undefined" && result.d.ObjStatus.length > 0) {
            var StatusList = result.d.ObjStatus;
            for (var i = 0; i < StatusList.length; i++) {
                var objPost = StatusList[i];
                var StatusImageHTML = '', LikeHTML = 'Like', ShareHTML = '', CommentHTML = "", CommentLikeHTML = "";

                //Status Image
                if (StatusList[i].StatusUrl != "") {
                    StatusImageHTML = '<div class="msgbody gallery"><a id="lnkProfileImg" rel="prettyPhoto" title="' + StatusList[i].StatusName + '" href="../getImage.aspx?image=../Data/Images/' + StatusList[i].StatusUrl + '&height=200&width=400&Aspect=true&type=5&bgc=FFFFFF">' +
                              '<img class="lazy" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/Images/' + StatusList[i].StatusUrl + '&height=200&width=400&Aspect=true&type=5&bgc=FFFFFF" alt=""></a></div>';
                }

                //Like
                if (StatusList[i].IsLiked)
                    LikeHTML = "Unlike";

                //Share
                if (LoggedInUserId != StatusList[i].UserId) {
                    ShareHTML = '<a class="Share" onclick="return SharePost(\'' + StatusList[i].StatusId + '\',\'' + StatusList[i].StatusName + '\',\'' + LoggedInUserId + '\',\'' + StatusList[i].StatusUrl + '\');" ' +
                'title="Share this post">Share</a>';
                }

                //Comment
                if (StatusList[i].comments != null && StatusList[i].comments.length > 0) {
                    for (var index = 0; index < StatusList[i].comments.length; index++) {
                        if (StatusList[i].comments[index].IsCommentLiked)
                            CommentLikeHTML = "Unlike";
                        else
                            CommentLikeHTML = "Like";
                        CommentHTML = '<div class="comprep" id="divComment_' + StatusList[i].comments[index].CommentId + '"><div class="comntlhs"><span class="comimg">' +
                    '<img class="lazy" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/ProfileImages/' + StatusList[i].comments[index].UserImage + '&height=30&width=30&Aspect=true&type=1&bgc=EFEFEF"/></span></div>' +
                    '<div class="comntrhs"><span class="comdel"><b><a href="TimeLine.aspx?UserId=' + StatusList[i].comments[index].UserId + '">' + StatusList[i].comments[index].UserName + '</a></b>' +
                    '&nbsp;&nbsp;' + StatusList[i].comments[index].CommentName + '</span><span class="coml">' + GetDateFormat(StatusList[i].comments[index].CreatedDate) +
                    '<a style="float:left;margin-right:5px;" id="CommentLike_' + StatusList[i].comments[index].CommentId + '" onclick="CommentLike(\'' + StatusList[i].comments[index].CommentId + '\',\'' + StatusList[i].StatusId + '\', \'' + StatusList[i].comments[index].CommentLikeId + '\')" title="Like this comment">' + CommentLikeHTML + '</a>' +
                    '<span class="fr"><a onclick="deleteComment(\'' + StatusList[i].comments[index].CommentId + '\',\'' + StatusList[i].StatusId + '\')"><img alt=\'Delete\' title=\'Delete\' src=\'../images/iconTrash.png\' /></a></span></span></div></div>'
                    }
                }
                $("#divFeeds").append('<div class="feed" id="divStatus_' + StatusList[i].StatusId + '">' +
                 '<div class="feedleft"><a><img class="lazy" style="width:50px;height:50px;" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/ProfileImages/' + StatusList[i].UserImage + '&height=50&width=50&Aspect=true&type=1&bgc=FFFFFF"></a></div>' +
                 '<div class="feedright"><div class="usernamemain"><a href="TimeLine.aspx?UserId=' + StatusList[i].UserId + '" class="username">' + (StatusList[i].UserName == "" ? "&nbsp;" : StatusList[i].UserName) + '</a>' +
                 '<a class="deletepost" onclick="deletepost(\'' + StatusList[i].StatusId + '\')"><img alt=\'Delete Post\' title=\'Delete Post\' src=\'../images/iconTrash.png\' /></a></div>' +
                 '<div class="msgbody">' + StatusList[i].StatusName + '</div>' + StatusImageHTML +
                 '<div class="limain"><div class="like coml likebar"><a id="StatusLike_' + StatusList[i].StatusId + '" onclick="StatusLike(\'' + StatusList[i].StatusId + '\',\'' + StatusList[i].LikeId + '\')" title="Like this post">' + LikeHTML + '</a>' +
                 ShareHTML + '<div class="likecount" id="divLikeCount_' + StatusList[i].StatusId + '" likecount="' + StatusList[i].LikesCount + '">' + ((StatusList[i].LikesCount == 1) ? ('1 like') : (StatusList[i].LikesCount) + " likes") + '</div><div class="postdate">' + StatusList[i].CreatedDate + '</div></div></div>' +
                 '<div class="compre" id="divCommentsMain_' + StatusList[i].StatusId + '">' + CommentHTML + '</div>' +
                 '<div class="combox"><textarea rows="1" cols="50" placeholder="Write a comment..." id="txtComment_' + StatusList[i].StatusId + '"></textarea>' +
                 '<a class="btn_silver fr" style="margin: 8px 0px 0px 0px; width: 40px; text-align: center;" onclick="PostComment(\'' + StatusList[i].StatusId + '\');">Post</a></div></div></div>'
            );
                resetGallery();
            }
            $(".lazy").show().lazyload({ effect: "fadeIn", effect_speed: 500, event: "load" });
            _CurrentPageIndex += _PageSize;
        }
        _isLoadMoreTriggered = false;
        HideLoading();
    }
}
function onFailureBindStatusList(result, content) {
}
function onSuccessGetStatusList(result, context) {
    $('#divFeeds').html('');
    if (result != null && result.d != null && result.d.length > 0) {
        var StatusList = result.d;
        for (var i = 0; i < StatusList.length; i++) {
            var objPost = StatusList[i];
            var StatusImageHTML = '', LikeHTML = 'Like', ShareHTML = '', CommentHTML = "", CommentLikeHTML = "";

            //Status Image
            if (StatusList[i].StatusUrl != "") {
                StatusImageHTML = '<div class="msgbody gallery"><a id="lnkProfileImg" rel="prettyPhoto" title="' + StatusList[i].StatusName + '" href="../getImage.aspx?image=../Data/Images/' + StatusList[i].StatusUrl + '&height=200&width=400&Aspect=true&type=5&bgc=FFFFFF">' +
                              '<img class="lazy" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/Images/' + StatusList[i].StatusUrl + '&height=200&width=400&Aspect=true&type=5&bgc=FFFFFF" alt=""></a></div>';
            }

            //Like
            if (StatusList[i].IsLiked)
                LikeHTML = "Unlike";

            //Share
            if (LoggedInUserId != StatusList[i].UserId) {
                ShareHTML = '<a class="Share" onclick="return SharePost(\'' + StatusList[i].StatusId + '\',\'' + StatusList[i].StatusName + '\',\'' + LoggedInUserId + '\',\'' + StatusList[i].StatusUrl + '\');" ' +
                'title="Share this post">Share</a>';
            }

            //Comment
            if (StatusList[i].comments != null && StatusList[i].comments.length > 0) {
                for (var index = 0; index < StatusList[i].comments.length; index++) {
                    if (StatusList[i].comments[index].IsCommentLiked)
                        CommentLikeHTML = "Unlike";
                    else
                        CommentLikeHTML = "Like";
                    CommentHTML = '<div class="comprep" id="divComment_' + StatusList[i].comments[index].CommentId + '"><div class="comntlhs"><span class="comimg">' +
                    '<img class="lazy" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/ProfileImages/' + StatusList[i].comments[index].UserImage + '&height=30&width=30&Aspect=true&type=1&bgc=EFEFEF"/></span></div>' +
                    '<div class="comntrhs"><span class="comdel"><b><a href="TimeLine.aspx?UserId=' + StatusList[i].comments[index].UserId + '">' + StatusList[i].comments[index].UserName + '</a></b>' +
                    '&nbsp;&nbsp;' + StatusList[i].comments[index].CommentName + '</span><span class="coml">' + GetDateFormat(StatusList[i].comments[index].CreatedDate) +
                    '<a style="float:left;margin-right:5px;" id="CommentLike_' + StatusList[i].comments[index].CommentId + '" onclick="CommentLike(\'' + StatusList[i].comments[index].CommentId + '\',\'' + StatusList[i].StatusId + '\', \'' + StatusList[i].comments[index].CommentLikeId + '\')" title="Like this comment">' + CommentLikeHTML + '</a>' +
                    '<span class="fr"><a onclick="deleteComment(\'' + StatusList[i].comments[index].CommentId + '\',\'' + StatusList[i].StatusId + '\')"><img alt=\'Delete\' title=\'Delete\' src=\'../images/iconTrash.png\' /></a></span></span></div></div>'
                }
            }
            $("#divFeeds").append('<div class="feed" id="divStatus_' + StatusList[i].StatusId + '">' +
                 '<div class="feedleft"><a><img class="lazy" style="width:50px;height:50px;" src="../Images/dot.png" data-original="../getImage.aspx?image=../Data/ProfileImages/' + StatusList[i].UserImage + '&height=50&width=50&Aspect=true&type=1&bgc=FFFFFF"></a></div>' +
                 '<div class="feedright"><div class="usernamemain"><a href="TimeLine.aspx?UserId=' + StatusList[i].UserId + '" class="username">' + (StatusList[i].UserName == "" ? "&nbsp;" : StatusList[i].UserName) + '</a>' +
                 '<a class="deletepost" onclick="deletepost(\'' + StatusList[i].StatusId + '\')"><img alt=\'Delete Post\' title=\'Delete Post\' src=\'../images/iconTrash.png\' /></a></div>' +
                 '<div class="msgbody">' + StatusList[i].StatusName + '</div>' + StatusImageHTML +
                 '<div class="limain"><div class="like coml likebar"><a id="StatusLike_' + StatusList[i].StatusId + '" onclick="StatusLike(\'' + StatusList[i].StatusId + '\',\'' + StatusList[i].LikeId + '\')" title="Like this post">' + LikeHTML + '</a>' +
                 ShareHTML + '<div class="likecount" id="divLikeCount_' + StatusList[i].StatusId + '" likecount="' + StatusList[i].LikesCount + '">' + ((StatusList[i].LikesCount == 1) ? ('1 like') : (StatusList[i].LikesCount) + " likes") + '</div><div class="postdate">' + StatusList[i].CreatedDate + '</div></div></div>' +
                 '<div class="compre" id="divCommentsMain_' + StatusList[i].StatusId + '">' + CommentHTML + '</div>' +
                 '<div class="combox"><textarea rows="1" cols="50" placeholder="Write a comment..." id="txtComment_' + StatusList[i].StatusId + '"></textarea>' +
                 '<a class="btn_silver fr" style="margin: 8px 0px 0px 0px; width: 40px; text-align: center;" onclick="PostComment(\'' + StatusList[i].StatusId + '\');">Post</a></div></div></div>'
            );
            resetGallery();
        }
        $(".lazy").show().lazyload({ effect: "fadeIn", effect_speed: 500, event: "load" });
    }
}
function onfailureGetStatusList(result, content) {
}
/* End of Bind Status List and Comments */

/* Perform Post message Action */
function PostMessage() {
    var sname = $.trim($("#txtPost").val());
    var surl = $("#hdnUploadedImagePath").val();
    var stype = surl != '' ? 'image' : 'text';
    //    if (LoggedInUserId != $("#" + hdnSelectedUserId).val())
    //        stype = "other";
    var Status = {
        StatusId: '00000000-0000-0000-0000-000000000000',
        StatusName: sname,
        StatusType: stype,
        StatusUrl: surl,
        UserId: $("#" + hdnSelectedUserId).val()
    };
    if (sname.length > 0) {
        $.ajax({
            type: "POST",
            url: "TimeLine.aspx/InsertStatus",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: '{"objStatus":' + JSON.stringify(Status) + '}',
            success: onSuccessPostMessage,
            error: onFailurePostMessage
        });
    }
    return false;
}
function onSuccessPostMessage(result, context) {
    if (result != null && result.d != null) {
        var StatusImageHTML = '', ShareHTML = '';
        ShareHTML = '<a class="Share" onclick="return SharePost(\'' + result.d + '\',\'' + $('#txtPost').val() + '\',\'' + LoggedInUserId + '\',\'' + $(hdnUploadedImagePath).val() + '\');" ' +
                'title="Share this post">Share</a>';
        if ($(hdnUploadedImagePath).val() != "") {
            StatusImageHTML = '<div class="msgbody gallery"><a id="lnkProfileImg" rel="prettyPhoto" title="' + $('#txtPost').val() + '" href="' + ImagePath + $(hdnUploadedImagePath).val() + '">' +
                              '<img src="../getImage.aspx?image=../Data/Images/' + $(hdnUploadedImagePath).val() + '&height=200&width=400&Aspect=true&type=1&bgc=FFFFFF" alt=""></a></div>';
        }
        $("#divFeeds").prepend('<div class="feed" id="divStatus_' + result.d + '">' +
                '<div class="feedleft"><a><img src="../getImage.aspx?image=../Data/ProfileImages/' + $(hdnUserImage).val() + '&height=50&width=50&Aspect=true&type=1&bgc=FFFFFF"></a></div>' +
                '<div class="feedright"><div class="usernamemain"><a href="TimeLine.aspx?UserId=' + LoggedInUserId + '" class="username">' + $("#" + hdnUserName).val() + '</a>' +
                '<a class="deletepost" onclick="deletepost(\'' + result.d + '\')"><img alt=\'Delete Post\' title=\'Delete Post\' src=\'../images/iconTrash.png\' /></a></div>' +
                '<div class="msgbody">' + $('#txtPost').val() + '</div>' + StatusImageHTML +
                '<div class="limain"><div class="like coml likebar"><a id="StatusLike_' + result.d + '" onclick="StatusLike(\'' + result.d + '\',\'\')" title="Like this post">Like</a>' +
                ShareHTML + '<div class="likecount" id="divLikeCount_' + result.d + '" likecount="0">0 Likes</div><div class="postdate">' + GetDateFormat(new Date()) + '</div></div></div>' +
                '<div class="compre" id="divCommentsMain_' + result.d + '"></div>' +
                '<div class="combox"><textarea rows="1" cols="50" placeholder="Write a comment..." id="txtComment_' + result.d + '"></textarea>' +
                '<a class="btn_silver fr" style="margin: 8px 0px 0px 0px; width: 40px; text-align: center;" onclick="PostComment(\'' + result.d + '\');">Post</a></div></div></div>'
        );
        $('#txtPost').val('');
        releaseUploadedFile();
        return false;
    }
}
function onFailurePostMessage(result, context) {
}
/* End of Perform Post message Action */

/* Perform Post Comment Action */
function PostComment(StatusId) {
    var cName = $('#txtComment_' + StatusId).val();
    $('#hdnCurrentComment').val(cName);
    $('#hdnCurrentStatusId').val(StatusId);
    var Comment = {
        StatusId: StatusId,
        CommentName: cName
    };
    if (cName.length > 0) {
        $.ajax({
            type: "POST",
            url: "TimeLine.aspx/InsertComment",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: '{"objComment":' + JSON.stringify(Comment) + '}',
            success: onSuccessPostComment,
            error: onFailurePostComment
        });
    }
    return false;
}
function onSuccessPostComment(result, context) {
    if (result != null && result.d != null && result.d != '00000000-0000-0000-0000-000000000000') {
        $('#txtComment_' + $('#hdnCurrentStatusId').val()).val('');
        var divComEle, spnEle, imgEle, spnNameEle, spnDateEle, anclikeEle;
        divComEle = document.createElement("div");
        divComEle.className = "comprep";
        divComEle.setAttribute("Id", "divComment_" + result.d);
        // start Comments Image
        var divLeft = document.createElement("div");
        divLeft.setAttribute("class", "comntlhs");

        spnEle = document.createElement("span");
        spnEle.className = "comimg";

        imgEle = document.createElement("img");
        imgEle.className = "lazy";
        imgEle.setAttribute("src", "../getImage.aspx?image=../Data/ProfileImages/" + $("#" + hdnUserImage).val() + "&height=30&width=30&Aspect=true&type=1&bgc=EFEFEF");
        spnEle.appendChild(imgEle);

        divLeft.appendChild(spnEle);
        divComEle.appendChild(divLeft);
        // end Comments Image

        // start Comments
        var divRight = document.createElement("div");
        divRight.setAttribute("class", "comntlhs");

        spnNameEle = document.createElement("span");
        spnNameEle.className = "comdel";
        userhref = "TimeLine.aspx?UserId=" + LoggedInUserId;
        spnNameEle.innerHTML = "<b><a href='" + userhref + "'>" + $('#' + hdnUserName).val() + "<a></b>&nbsp;&nbsp;" + $('#hdnCurrentComment').val();
        divRight.appendChild(spnNameEle);

        spnDateEle = document.createElement("span");
        spnDateEle.className = "coml";
        var d = new Date();
        var month = new Array();
        month[0] = "January";
        month[1] = "February";
        month[2] = "March";
        month[3] = "April";
        month[4] = "May";
        month[5] = "June";
        month[6] = "July";
        month[7] = "August";
        month[8] = "September";
        month[9] = "October";
        month[10] = "November";
        month[11] = "December";
        spnDateEle.innerHTML = month[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds() + " · ";

        var anclikeComEle = document.createElement("a");
        anclikeComEle.innerHTML = "Like";
        anclikeComEle.setAttribute("style", 'float:left;margin-right:5px;');
        anclikeComEle.setAttribute("id", "CommentLike_" + result.d);
        anclikeComEle.setAttribute("onclick", "CommentLike('" + result.d + "','" + $('#hdnCurrentStatusId').val() + "')");
        anclikeComEle.setAttribute("title", "Like this comment");
        spnDateEle.appendChild(anclikeComEle);

        var spndelComm = document.createElement("span");
        spndelComm.setAttribute("class", "fr");
        spndelComm.innerHTML = "<a onclick='deleteComment(\"" + result.d + "\",\"" + $('#hdnCurrentStatusId').val() + "\")'><img alt=\'Delete\' title=\'Delete\' src=\'../images/iconTrash.png\' /></a>";
        spnDateEle.appendChild(spndelComm);

        divRight.appendChild(spnDateEle);

        divComEle.appendChild(divRight);

        document.getElementById("divCommentsMain_" + $('#hdnCurrentStatusId').val()).appendChild(divComEle);
    }
}
function onFailurePostComment(result, context) {
}
/* End of Perform Post comment Action */

/* Status-like Action */
function StatusLike(StatusId, LikeId) {
    $('#hdnCurrentStatusId').val(StatusId);
    if (LikeId == '')
        LikeId = '00000000-0000-0000-0000-000000000000';
    var StatusLike = {
        LikeId: LikeId,
        StatusId: StatusId,
        IsLiked: ($("#StatusLike_" + StatusId).html() == "Like")
    }
    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/InsertStatusLike",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: '{"objLike":' + JSON.stringify(StatusLike) + '}',
        success: onSuccessStatusLike,
        error: onFailureStatusLike
    });
}
function onSuccessStatusLike(result, context) {
    if (result != null && result.d != null && result.d != '00000000-0000-0000-0000-000000000000') {
        var StatusId = $('#hdnCurrentStatusId').val();
        var likeCount = $("#divLikeCount_" + StatusId).attr('likeCount');
        if ($("#StatusLike_" + StatusId).html() == "Unlike") {
            $("#StatusLike_" + StatusId).html('Like');
            likeCount--;
            var likes = (likeCount == 1) ? ('1 like') : (likeCount) + " likes";
            $("#divLikeCount_" + StatusId).html(likes);
            $("#divLikeCount_" + StatusId).attr("likeCount", likeCount);
        }
        else {
            $("#StatusLike_" + StatusId).html('Unlike');
            likeCount++;
            var likes = (likeCount == 1) ? ('1 like') : (likeCount) + " likes";
            $("#divLikeCount_" + StatusId).html(likes);
            $("#divLikeCount_" + StatusId).attr("likeCount", likeCount);
        }
        //document.getElementById("StatusLike_" + StatusId).setAttribute("likeId", result.d);
        return false;
    }
}
function onFailureStatusLike(result, context) {
}
/* End of Status-like Action */

/* Comment-like Action */
function CommentLike(CommentId, StatusId, CommentLikeId) {
    $('#hdnCurrentCommentId').val(CommentId);
    var CommentLike = {
        CommentLikeId: CommentLikeId,
        CommentId: CommentId,
        StatusId: StatusId,
        IsLiked: ($("#CommentLike_" + CommentId).html() == "Like")
    }
    if (document.getElementById('CommentLike_' + CommentId).getAttribute('commentLikeId') != null) {
        CommentLike = {
            CommentLikeId: document.getElementById('CommentLike_' + CommentId).getAttribute('commentLikeId'),
            CommentId: CommentId,
            StatusId: StatusId,
            IsLiked: ($("#CommentLike_" + CommentId).html() == "Like")
        };
    }
    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/InsertCommentLike",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: '{"objCommentLike":' + JSON.stringify(CommentLike) + '}',
        success: onSuccessCommentLike,
        error: onFailureCommentLike
    });
}
function onSuccessCommentLike(result, context) {
    if (result != null && result.d != null && result.d != '00000000-0000-0000-0000-000000000000') {
        var CommentId = $('#hdnCurrentCommentId').val();
        if ($("#CommentLike_" + CommentId).html() == "Unlike") {
            $("#CommentLike_" + CommentId).html('Like');
        }
        else {
            $("#CommentLike_" + CommentId).html('Unlike');
        }
        //document.getElementById("CommentLike_" + CommentId).setAttribute("commentLikeId", result.d);
    }
}
function onFailureCommentLike(result, context) {
}
/* End of Comment-like Action */

function ShowLoading() {
    $('#divLoader').show();
    $('#fade').show();
}
function HideLoading() {
    $('#divLoader').hide();
    $('#fade').hide();
}

/* Ajax image upload */
function ajaxFileUploader() {
    ShowLoading();
    var ImageFolderPath = "Data\\Images\\";
    $.ajaxFileUpload({
        url: '../FileUploader.ashx?Path=' + ImageFolderPath,
        secureuri: false,
        fileElementId: updawardimg,
        dataType: 'json',
        data: {
            name: 'logan',
            id: 'id'
        },
        success: function (data, status) {
            if (typeof (data.error) != 'undefined') {
                BindUploadedFile(data.msg);
                document.getElementById(updawardimg).value = "";
            }
        },
        error: function (data, status, e) {
            alert(e);
            return false;
        }
    });
    HideLoading()
    return false;
}
function BindUploadedFile(fileName) {
    $("#hdnUploadedImagePath").val(fileName);
    $("#imgUploadedImage").attr("src", "../Data/Images/" + fileName);
    $("#ancDelete").show();
    $("#ancUploadImage").hide();
    $("#divUploadImage").show();
}
function releaseUploadedFile() {
    $("#hdnUploadedImagePath").val("");
    $("#imgUploadedImage").attr("src", "");
    $("#ancDelete").hide();
    $("#ancUploadImage").show();
    $("#divUploadImage").hide();
}
function performClick() {
    $('#' + updawardimg).click();
    return false;
}
/* End of Ajax Image upload */

function resetGallery() {
    $(".feeds a[rel^='prettyPhoto']").prettyPhoto({ theme: 'facebook' });
}

function SharePost(StatusId, StatusName, LoggedUserId, Image) {
    var params = '{"StatusId":"' + StatusId + '","StatusName":"' + StatusName + '","UserId":"' + LoggedUserId + '","Image":"' + Image + '"}';
    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/SharePost",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: params,
        success: onSuccessSharePost,
        error: onFailureSharePost
    });
}
function onSuccessSharePost(result, context) {
    if (result) {
        if (result.d != null) {
            GetStatusList();
        }
    }
}
function onFailureSharePost(result, context) {
}
function deletepost(StatusId) {
    var params = '{"StatusId":"' + StatusId + '"}';
    $.ajax({
        type: "POST",
        url: "NewsFeed.aspx/DeletePost",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: params,
        success: onSuccessDeletePost,
        error: onFailureDeletePost
    });
}
function onSuccessDeletePost(result, context) {
    if (result.d != null) {
        $("#divFeeds > #divStatus_" + result.d + "").remove();
    }
}
function onFailureDeletePost(result, context) {
}
function GetDateFormat(date) {
    var d = new Date(date);
    var month = new Array();
    month[0] = "January";
    month[1] = "February";
    month[2] = "March";
    month[3] = "April";
    month[4] = "May";
    month[5] = "June";
    month[6] = "July";
    month[7] = "August";
    month[8] = "September";
    month[9] = "October";
    month[10] = "November";
    month[11] = "December";
    return month[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
}
function deleteComment(CommentId, StatusId) {
    $("#divCommentsMain_" + StatusId).find('div[id^="divComment_"]').each(function (index) {
        if (this.id.replace("divComment_", "") == CommentId) {
            var params = '{"CommentId":"' + CommentId + '"}';
            $.ajax({
                type: "POST",
                url: "NewsFeed.aspx/DeleteComment",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: params,
                success: onSuccessDeleteComment,
                error: onFailureDeleteComment
            });
            $(this).remove();
        }
    });
}
function onSuccessDeleteComment(result, context) {
    if (result.d != null)
    { }
}
function onFailureDeleteComment(result, context) {
}


var _isLoadMoreTriggered = false;

function GetNextStatusList() {
    var scrollTop = parseInt(window.document.body.scrollTop || window.document.documentElement.scrollTop, 10);
    var scrollHeight = parseInt(window.document.body.scrollHeight || window.document.documentElement.scrollHeight, 10);
    var screenHeight = parseInt($(window).height(), 10);

    //console.log($('html,body').offset().top - $(window).height() + $(document).height() + "    " + _CurrentPageIndex + "," + _CurrentPageIndex);

    if (_CurrentPageIndex > _MaximumRecords) {
        document.body.removeAttribute("onscroll");
        return false;
    }


    //if (scrollTop + screenHeight > (scrollHeight - 100)) {
    //Pagging is not implemented.
    //        if (MaxPageCount >= CurrentPageIndex && ProcessStarted == 0) {
    //            CurrentPageIndex++;
    //            isOnScroll = true;
    //            GetStatusList();
    //        }
    if ($('html,body').offset().top - $(window).height() + $(document).height() <= 200 & !_isLoadMoreTriggered) {
        _isLoadMoreTriggered = true;
        GetStatusListByUserId(" 1=1 ");
    }
}