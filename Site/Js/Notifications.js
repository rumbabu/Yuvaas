var PageSize = 10, CurrentPageIndex = 0, MaxPageCount = 0;
$(document).ready(function () {
    $('#ulNotifications').html('');
    GetAllNotifications();
});
jQuery(function () { // on page DOM load
    //$('#divNotifications').alternateScroll();
})
/* Bind Status List and Comments */
function GetAllNotifications() {
    $.ajax({
        type: "POST",
        url: "../pages/Newsfeed.aspx/GetAllNotifications",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{'Ticks':'" + new Date().toString() + "','StartIndex':'" + CurrentPageIndex + "','MaxIndex':'" + PageSize + "'}",
        success: onSuccessGetAllNotifications,
        failure: onfailureGetAllNotifications
    });
}
function onSuccessGetAllNotifications(Notificationresult, context) {
    if (Notificationresult != null) {
        if (Notificationresult.d != null) {
            var result = Notificationresult.d.NotificationList;
            MaxPageCount = parseInt(Notificationresult.d.PageCount, 10);
            for (var index = 0; index < result.length; index++) {
                var msg = "";
                if (result[index].IsPost == true) {
                    msg = " updated his status.";
                }
                if (result[index].IsShared == true) {
                    msg = " shared " + result[index].FirstName + " " + result[index].LastName + " link.";
                }
                else if (result[index].IsCommented == true) {
                    msg = " commented on " + result[index].FirstName + " " + result[index].LastName + " post";
                }
                else if (result[index].IsLiked == true) {
                    msg = " likes " + result[index].FirstName + " " + result[index].LastName + " link.";
                }
                else if (result[index].IsCommentLiked == true) {
                    msg = " likes " + result[index].FirstName + " " + result[index].LastName + " comment.";
                }

                $('#ulNotifications').append('<li><a href="../Pages/Profile.aspx?UserId=' + result[index].NUserId +'" ><span class="spnimg"><img src="../getImage.aspx?image=../Data/ProfileImages/' + result[index].NUserImage + '&height=28&width=28&Aspect=true&type=1&bgc=ffffff"/></span>' +
                '<span class="spnmsg"><h5>' + result[index].NFirstName + " " + result[index].NLastName + '</h5>' + msg + '</span></a></li>');
            }
        }
    }
}

function onfailureGetAllNotifications(result, context) {

}
function GetNextPageData(newContentTop) {
    var objList = $('#divNotifications').find(".alt-scroll-content")[0];
    var scrollTop = parseInt(newContentTop, 10); //parseInt($(objList).css("top"), 10);
    var scrollHeight = parseInt($(objList).height(), 10);
    if (scrollTop < 0) {
        scrollTop = -scrollTop;
        if (scrollTop > (scrollHeight - 600)) {
            if (PageSize > CurrentPageIndex) {
                CurrentPageIndex++;
                GetAllNotifications();
            }
        }
    }
}