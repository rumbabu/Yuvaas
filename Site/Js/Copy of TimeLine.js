$(document).ready(function () {
    GetStatusList();
});

function GetStatusListByUserId(SearchString) {
    var params = "";
    params += '{"SortBy":"' + SortBy + '"';
    params += ',"SearchString":"' + SearchString + '"';
    params += ',"PageSize":' + PageSize + '';
    params += ',"CurrentPageIndex":' + CurrentPageIndex + '}';

    $.ajax({
        type: "POST",
        url: "TimeLine.aspx/GetStatusByUserId",
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
function onSuccessGetStatusList(result, context) {
    $('#divFeeds').html('');
    if (result != null && result.d != null && result.d.length > 0) {
        var StatusList = result.d;
        var divEle, ancDelPost, divFeedEle, divFeedleft, divFeedRight, ancEle, userimgEle, divMsgEle, ancImg, divpostImgEle, postImgEle, divlinksEle, divComEle, ancComEle, divLikeEle, anclikeEle, ancShare, divCompEle, divComboxEle, txtAreaEle, ancPostCommEle, divComEle, spnEle, imgEle, spnNameEle, spnDateEle;
        for (var i = 0; i < StatusList.length; i++) {
            var objPost = StatusList[i];
            divFeedEle = document.createElement("div");
            divFeedEle.className = "feed";
            divFeedEle.setAttribute("id", StatusList[i].StatusId);
            divFeedleft = document.createElement("div");
            divFeedleft.className = "feedleft";

            ancEle = document.createElement("a");

            userimgEle = document.createElement("img");
            userimgEle.setAttribute("src", "../getImage.aspx?image=../Data/ProfileImages/" + StatusList[i].UserImage + "&height=50&width=50&Aspect=true&type=0");
            userimgEle.setAttribute("width", "73px");
            userimgEle.setAttribute("height", "54px");
            ancEle.appendChild(userimgEle);
            divFeedleft.appendChild(ancEle);
            divFeedEle.appendChild(divFeedleft);

            divFeedRight = document.createElement("div");
            divFeedRight.className = "feedright";

            divEle = document.createElement("div")
            divEle.setAttribute("class", "usernamemain");

            ancEle = document.createElement("a");
            ancEle.setAttribute("href", "TimeLine.aspx?UserId=" + StatusList[i].UserId);
            ancEle.setAttribute("class", "username");
            ancEle.innerHTML = StatusList[i].UserName;
            divEle.appendChild(ancEle);
            ancDelPost = document.createElement("a");
            ancDelPost.setAttribute("class", "deletepost");
            ancDelPost.setAttribute("onclick", "deletepost(\'" + StatusList[i].StatusId + "\')");
            ancDelPost.innerHTML = "Delete Post";
            divEle.appendChild(ancDelPost);
            divFeedRight.appendChild(divEle);

            divMsgEle = document.createElement("div");
            divMsgEle.className = "msgbody";
            divMsgEle.innerHTML = StatusList[i].StatusName;
            divFeedRight.appendChild(divMsgEle);

            if (StatusList[i].StatusUrl != "") {
                divpostImgEle = document.createElement("div");
                divpostImgEle.className = "msgbody gallery";

                ancImg = document.createElement("a");
                ancImg.setAttribute("id", "lnkProfileImg");
                ancImg.setAttribute("rel", "prettyPhoto");
                ancImg.setAttribute("title", StatusList[i].StatusName);
                ancImg.setAttribute("href", ImagePath + StatusList[i].StatusUrl);

                postImgEle = document.createElement("img");
                postImgEle.setAttribute("src", "../getImage.aspx?image=../Data/Images/" + StatusList[i].StatusUrl + "&height=200&width=400&Aspect=true&type=0");
                postImgEle.setAttribute("alt", StatusList[i].UserName);
                ancImg.appendChild(postImgEle);

                divpostImgEle.appendChild(ancImg);

                divFeedRight.appendChild(divpostImgEle);
            }

            divlinksEle = document.createElement("div");
            divlinksEle.className = "limain";

            divLikeEle = document.createElement("div");
            divLikeEle.className = "like coml likebar";

            anclikeEle = document.createElement("a");
            if (StatusList[i].IsLiked)
                anclikeEle.innerHTML = "Unlike";
            else
                anclikeEle.innerHTML = "Like";
            anclikeEle.setAttribute("id", "StatusLike_" + StatusList[i].StatusId);
            anclikeEle.setAttribute("onclick", "StatusLike('" + StatusList[i].StatusId + "', '" + StatusList[i].LikeId + "')");
            anclikeEle.setAttribute("title", "Like this post");
            divLikeEle.appendChild(anclikeEle);

            if (LoggedInUserId != StatusList[i].UserId) {
                ancShare = document.createElement("a");
                ancShare.innerHTML = "Share";
                ancShare.setAttribute("onclick", "return SharePost('" + StatusList[i].StatusId + "','" + StatusList[i].StatusName + "','" + LoggedInUserId + "','" + StatusList[i].StatusUrl + "');");
                ancShare.className = "Share";
                ancShare.setAttribute("title", "Share this post");
                divLikeEle.appendChild(ancShare);
            }

            var divLikeCount = document.createElement("div");
            var likes = (StatusList[i].LikesCount == 1) ? ('1 like') : (StatusList[i].LikesCount) + " likes";
            divLikeCount.innerHTML = likes;
            divLikeCount.className = "likecount";
            divLikeCount.setAttribute("id", "divLikeCount_" + StatusList[i].StatusId);
            divLikeCount.setAttribute("likeCount", StatusList[i].LikesCount);
            divLikeEle.appendChild(divLikeCount);

            divLikeCount = document.createElement("div");
            divLikeCount.innerHTML = StatusList[i].CreatedDate;
            divLikeCount.className = "postdate";
            divLikeEle.appendChild(divLikeCount);

            divlinksEle.appendChild(divLikeEle);
            divFeedRight.appendChild(divlinksEle);

            divCompEle = document.createElement("div");
            divCompEle.className = "compre";
            divCompEle.setAttribute("id", "divComments_" + StatusList[i].StatusId);
            if (StatusList[i].comments != null && StatusList[i].comments.length > 0) {
                for (var index = 0; index < StatusList[i].comments.length; index++) {
                    divComEle = document.createElement("div");
                    divComEle.className = "comprep";

                    // start Comments Image
                    var divLeft = document.createElement("div");
                    divLeft.setAttribute("class", "cmmtimg");

                    spnEle = document.createElement("span");
                    spnEle.className = "comimg";

                    imgEle = document.createElement("img");
                    imgEle.setAttribute("src", "../getImage.aspx?image=../Data/ProfileImages/" + StatusList[i].comments[index].UserImage + "&height=30&width=30&Aspect=true&type=0");
                    spnEle.appendChild(imgEle);

                    divLeft.appendChild(spnEle);
                    divComEle.appendChild(divLeft);
                    // end Comments Image

                    // start Comments
                    var divRight = document.createElement("div");
                    divRight.setAttribute("class", "cmmtdesc");

                    spnNameEle = document.createElement("span");
                    spnNameEle.className = "comdel";
                    var usersrc = "TimeLine.aspx?UserId=" + StatusList[i].comments[index].UserId;
                    spnNameEle.innerHTML = "<b><a href='" + usersrc + "'>" + StatusList[i].comments[index].UserName + "</a></b>&nbsp;&nbsp;" + StatusList[i].comments[index].CommentName;
                    divRight.appendChild(spnNameEle);

                    spnDateEle = document.createElement("span");
                    spnDateEle.className = "coml";
                    //var d = new Date();
                    var d = new Date(StatusList[i].comments[index].CreatedDate);
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
                    if (StatusList[i].comments[index].IsCommentLiked)
                        anclikeComEle.innerHTML = "Unlike";
                    else
                        anclikeComEle.innerHTML = "Like";
                    anclikeComEle.setAttribute("id", "CommentLike_" + StatusList[i].comments[index].CommentId);
                    anclikeComEle.setAttribute("onclick", "CommentLike('" + StatusList[i].comments[index].CommentId + "', '" + StatusList[i].StatusId + "', '" + StatusList[i].comments[index].CommentLikeId + "')");
                    anclikeComEle.setAttribute("title", "Like this comment");
                    spnDateEle.appendChild(anclikeComEle);

                    divRight.appendChild(spnDateEle);
                    divComEle.appendChild(divRight);
                    divCompEle.appendChild(divComEle);
                }
            }

            divFeedRight.appendChild(divCompEle);

            divComboxEle = document.createElement("div");
            divComboxEle.className = "combox";

            txtAreaEle = document.createElement("textarea");
            txtAreaEle.setAttribute("rows", "1");
            txtAreaEle.setAttribute("cols", "50");
            txtAreaEle.setAttribute("placeholder", "Write a comment...");
            txtAreaEle.setAttribute("id", "txtComment_" + StatusList[i].StatusId);
            divComboxEle.appendChild(txtAreaEle);
            ancPostCommEle = document.createElement("a");
            ancPostCommEle.className = "btn_silver fr";
            ancPostCommEle.setAttribute("style", "margin: 8px 0px 0px 0px; width: 40px; text-align: center;");
            ancPostCommEle.setAttribute("onclick", "PostComment('" + StatusList[i].StatusId + "');");
            ancPostCommEle.innerHTML = "Post";
            divComboxEle.appendChild(ancPostCommEle);
            divFeedRight.appendChild(divComboxEle);
            divFeedEle.appendChild(divFeedRight);
            //document.getElementById("divFeeds").insertBefore(divFeedEle, document.getElementById("divFeeds").firstChild);
            document.getElementById("divFeeds").appendChild(divFeedEle);

            resetGallery();
        }

        $("#txtPost").val('');
        releaseUploadedFile();
    }
}
function onfailureGetStatusList(result, content) {
}
/* End of Bind Status List and Comments */

/* Perform Post message Action */
function PostMessage() {
    var sname = $.trim($("#txtPost").val());
    var surl = $("#hdnUploadedImagePath").val();
    var stype = surl != '' ? 'text' : 'image';
    if (LoggedInUserId == $("#" + hdnSelectedUserId).val())
        stype = "other";
    var Status = {
        StatusId: '00000000-0000-0000-0000-000000000000',
        StatusName: sname,
        StatusType: stype,
        StatusUrl: surl,
        UserId : $("#" + hdnSelectedUserId).val()
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
    if (result != null && result.d != null && result.d > 0) {
        $('#txtPost').val('');
        releaseUploadedFile();
        GetStatusList();
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

        // start Comments Image
        var divLeft = document.createElement("div");
        divLeft.setAttribute("style", "float:left;width:9%");

        spnEle = document.createElement("span");
        spnEle.className = "comimg";

        imgEle = document.createElement("img");
        imgEle.setAttribute("src", "../getImage.aspx?image=../Data/ProfileImages/" + $("#" + hdnUserImage).val() + "&height=30&width=30&Aspect=true&type=0");
        spnEle.appendChild(imgEle);

        divLeft.appendChild(spnEle);
        divComEle.appendChild(divLeft);
        // end Comments Image

        // start Comments
        var divRight = document.createElement("div");
        divRight.setAttribute("style", "float:right; width:90%");

        spnNameEle = document.createElement("span");
        spnNameEle.className = "comdel";
        userhref = "TimeLine.aspx?UserId=" + LoggedInUser;
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
        anclikeComEle.setAttribute("id", "CommentLike_" + result.d);
        anclikeComEle.setAttribute("onclick", "CommentLike('" + result.d + "','" + $('#hdnCurrentStatusId').val() + "')");
        anclikeComEle.setAttribute("title", "Like this comment");
        spnDateEle.appendChild(anclikeComEle);
        divRight.appendChild(spnDateEle);

        divComEle.appendChild(divRight);
        document.getElementById("divComments_" + $('#hdnCurrentStatusId').val()).appendChild(divComEle);
    }
}
function onFailurePostComment(result, context) {
}
/* End of Perform Post comment Action */

/* Status-like Action */
function StatusLike(StatusId, LikeId) {
    $('#hdnCurrentStatusId').val(StatusId);
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
        GetStatusList();
    }
}
function onFailureDeletePost(result, context) {
}