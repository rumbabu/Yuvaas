/* Perform Post message Action */
function PostMessage() {
    $('#txtPost').next().find('a').removeAttr('onclick');
    var sname = $.trim($("#txtPost").val());
    var surl = $("#hdnUploadedImagePath").val();
    var stype = surl.length == 0 ? 'text' : 'image';
    var Photo = {
        PhotoId: '00000000-0000-0000-0000-000000000000',
        PhotoStatus: sname,
        PhotoType: stype,
        PhotoUrl: surl
    };
    $.ajax({
        type: "POST",
        url: "Photo.aspx/InsertPhoto",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: '{"objPhoto":' + JSON.stringify(Photo) + '}',
        success: onSuccessPostMessage,
        error: onFailurePostMessage
    });
    $('#txtPost').next().find('a').attr('onclick', 'PostMessage();');
    return false;
}
function onSuccessPostMessage(result, context) {
    if (result != null && result.d != null && result.d > 0) {
        $('#txtPost').val('');
        releaseUploadedFile();
        GetPhotoList();
        return false;
    }
}
function onFailurePostMessage(result, context) {
}
var index;
function showactions(index) {
    $('#deletestatus_' + index).show();
    $('#deletestatus_' + index).removeClass("dn");
    $('#lblName_' + index).show();
    $('#lblName_' + index).removeClass("dn");
}
function hideactions(index) {
    $('#deletestatus_' + index).hide();
    $('#lblName_' + index).hide();
}
function deletestatus(StatusId) {
    var params = '{"StatusId":"' + StatusId + '"}';
    $.ajax({
        type: "POST",
        url: "Photo.aspx/DeletePost",
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