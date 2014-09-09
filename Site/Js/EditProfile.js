function Validate() {
    var str = "";
    if ($("#" + txtFirstName).val() == "") {
        str += "First Name, ";
    }
    if ($('#' + rbMale).is(':checked') == false && $('#' + rbFemale).is(':checked') == false) {
        str += "Gender, ";
    }
    if ($("#" + txtAbout).val() == "") {
        str += "About, ";
    }
    if (str != "") {
        $("#" + lblErrMsg).html("The following fields have invalid values : " + str.substring(0, str.length - 2) + ".");
        window.location = "#" + lblErrMsg
        return false;
    }
    else {
        $("#" + lblErrMsg).html("");
        return true;
    }
}

/* Ajax image upload */
function ajaxFileUploader() {
    var ImageFolderPath = "Data\\ProfileImages\\";
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
    return false;
}
function BindUploadedFile(fileName) {
    $("#" + hdnImage).val(fileName);
    $("#" + imgUser).attr("src", "../Data/ProfileImages/" + fileName);
}
function performClick() {
    $('#' + updawardimg).click();
    return false;
}
/* End of Ajax Image upload */