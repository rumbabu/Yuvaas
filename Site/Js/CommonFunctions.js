// JScript File

var arrInputElemnts = $("input[type='text']");
if (arrInputElemnts != null && arrInputElemnts.length > 0) {
    for (var index = 0; index < arrInputElemnts.length; index++) {
        if (arrInputElemnts[index].getAttribute("data-type")) {
            arrInputElemnts[index].setAttribute("onkeypress", "return  validateKey(event, '" + arrInputElemnts[index].getAttribute("data-type") + "', this);");
        }
    }
}

function isValidDate(date) {
    var valid = true;
    date = date.replace('/-/g', '');
    var month = parseInt(date.substring(0, 2), 10);
    var day = parseInt(date.substring(2, 4), 10);
    var year = parseInt(date.substring(4, 8), 10);
    if ((year < 1920)) valid = false;
    else if ((month < 1) || (month > 12)) valid = false;
    else if ((day < 1) || (day > 31)) valid = false;
    else if (((month == 4) || (month == 6) || (month == 9) || (month == 11)) && (day > 30)) valid = false;
    else if ((month == 2) && (((year % 400) == 0) || ((year % 4) == 0)) && ((year % 100) != 0) && (day > 29)) valid = false;
    else if ((month == 2) && ((year % 100) == 0) && (day > 29)) valid = false;

    return valid;
}
function onkeyup(e) {
    //    var code;
    //    if (!e) var e = window.event;
    //    if (e.keyCode) code = e.keyCode;
    //    else if (e.which) code = e.which;

    //    if (keycode == 8 || keycode == 46)
    return false;
}

function validateKey(event, type, obj) {
    var keyval = window.event ? window.event.keyCode : event.which;
    //console.log(obj);
    switch (type) {
        case 'date':
            $("#" + obj.id).datepicker();
            //obj.datepicker();
            AllowDate(event);
            break;
        case 'number':
            AllowNumerics(event);
            break;
        case 'decimal':
            AllowFloat(event, obj);
            break;
        case 'email':
            AllowEmail(event)
            break;
        case 'password':
            AllowPassword(event)
            break;
        case 'alphanumeric':
            AllowAlphaNumeric(event);
            break;
        case 'alphanumericwithoutspecialcharacters':
            AllowAlphaNumericWithOutSpecialCharacters(event);
            break;
        case 'allowalphanumericwithsomespecialcharacters':
            AllowAlphaNumericWithSomeSpecialCharacters(event);
            break;
    }
}

function RestirctEnter(event) {
    var keyval = window.event ? window.event.keyCode : event.which;
    if (keyval == 13) {
        if (window.event) {
            window.event.keyCode = null;
        }
        else {
            event.preventDefault();
        }
        return false;
    }
}

function AllowAlphaNumericWithOutSpecialCharacters(event) {
    var validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
    var keyval = window.event ? window.event.keyCode : event.which;
    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (validChars.indexOf(String.fromCharCode(keyval)) == -1) {
            if (window.event) {
                window.event.keyCode = null;
                event.preventDefault();
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}
function AllowAlphaNumericWithSomeSpecialCharacters(event) {
    var validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890_- ";
    var keyval = window.event ? window.event.keyCode : event.which;
    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (validChars.indexOf(String.fromCharCode(keyval)) == -1) {
            if (window.event) {
                window.event.keyCode = null;
                event.preventDefault();
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}
function AllowAlphaNumeric(event) {
    var validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890_.,- ";
    var keyval = window.event ? window.event.keyCode : event.which;
    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (validChars.indexOf(String.fromCharCode(keyval)) == -1) {
            if (window.event) {
                window.event.keyCode = null;
                event.preventDefault();
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}

function AllowInt(event) {
    var validChars = "1234567890";
    var keyval = window.event ? window.event.keyCode : event.which;
    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (validChars.indexOf(String.fromCharCode(keyval)) == -1) {
            if (window.event) {
                window.event.keyCode = null;
                event.preventDefault();
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}

function AllowIntNew(e) {
    var k = window.event ? window.event.keyCode : e.which;
    /* numeric inputs can come from the keypad or the numeric row at the top */
    if ((k < 48 || k > 57) && (k < 96 || k > 105)) {
        e.preventDefault();
        window.event.keyCode = null;
        return false;
    }
}
// function to allow int and backspace and delete
function allowIntBackDel(e) {
    var k = window.event ? window.event.keyCode : e.which;
    /* numeric inputs can come from the keypad or the numeric row at the top */
    if ((k < 48 || k > 57) && (k < 96 || k > 105) && k != 8 && k != 46 && k != 37 && k != 39) {
        e.preventDefault();
        window.event.keyCode = null;
        return false;
    }
}

function AllowFloat(event, obj) {
    var keyval = window.event ? window.event.keyCode : event.which;
    if (keyval == 13) {
        //do nothing
    }
    else {
        if (!((keyval >= 48) && (keyval <= 57) || (keyval == 8))) {
            if (!(keyval == 46)) {
                window.event ? window.event.keyCode = null : event.preventDefault();
                return false;
            }
            else if (keyval == 46) {
                if (obj.value.lastIndexOf(".") != -1) {
                    window.event ? window.event.keyCode = null : event.preventDefault();
                    return false;
                }
            }
        }
    }
    return true;
}

function AllowNumerics(event) {
    var keyval = window.event ? window.event.keyCode : event.which;

    if ((!((((keyval >= 48) && (keyval <= 57)) || (keyval == 46))))) {
        if (!window.XMLHttpRequest) {
            window.event.keyCode = null;
            return false;
        }
        else if (navigator.userAgent.toLowerCase().indexOf("msie") > -1) {
            window.event.keyCode = null;
            return false;
        }
        else {
            if (!((keyval == 0) || (keyval <= 8))) {
                event.preventDefault();
                return false;
            }
        }
    }
}

function AllowPassword(event) {

    var pass = /[(\*\(\)\[\]\+\.\,\/\?\:\;\'\"\`\~\\#\$\%\^\&\<\>)+]/;

    var keyval = window.event ? window.event.keyCode : event.which;

    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (String.fromCharCode(keyval).match(pass)) {
            if (window.event) {
                window.event.keyCode = null;
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}

function AllowEmail(event) {

    var validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890_.-@, ";

    var keyval = window.event ? window.event.keyCode : event.which;
    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (validChars.indexOf(String.fromCharCode(keyval)) == -1) {
            if (window.event) {
                window.event.keyCode = null;
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}


function AllowDate(event) {
    var date = /(0[1-9]|1[012])+\/(0[1-9]|[12][0-9]|3[01])+\/(19|20)\d\d/;

    var keyval = window.event ? window.event.keyCode : event.which;

    if (!((keyval == 0) || (keyval <= 9) || (keyval == 127))) {
        if (!String.fromCharCode(keyval).match(date)) {
            if (window.event) {
                window.event.keyCode = null;
                return false;
            }
            else {
                event.preventDefault();
                return false;
            }
        }
    }
}




function IsValidURL(url) {
    var regexp = /((ftp|http|https):\/\/)?(www.|[a-zA-Z].)[a-zA-Z0-9\-\.]+\.(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
    return regexp.test(url);
}

function IsValidEmail(object) {
    var myRegxp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
    return myRegxp.test(object);
}

function IsValidMobileNo(object) {
    var pattern = /^\d{10}$/
    return pattern.test(object);
}

function Replace(strMessage, ExistingChar, ReplaceChar) {
    while (strMessage.lastIndexOf(ExistingChar) >= 0) {
        strMessage = strMessage.replace(ExistingChar, ReplaceChar);
    }
    return strMessage;
}
function IncludeAnd(strErr) {
    var lastindex = 0;
    if (strErr.indexOf(",") > -1) {
        lastindex = strErr.lastIndexOf(",")
        var strcheckstringwithcoma = "";
        var strcheckstringwithand = "";
        strcheckstring = strErr.substring(lastindex, parseInt(strErr.length));
        strcheckstringwithand = strcheckstring.replace(",", " and")
        strErr = strErr.replace(strcheckstring, strcheckstringwithand);
    }
    return Trim(strErr);
}

function CheckDateWithCurrentDate(obj) {
    var dt1 = parseInt(obj.substring(0, 2), 10);
    var mon1 = parseInt(obj.substring(3, 5), 10);
    var yr1 = parseInt(obj.substring(6, 10), 10);
    var date1 = new Date(yr1, mon1 - 1, dt1);
    if (new Date() < date1) {
        return false;
    }
    else {
        return true;
    }
}
function formatTime(time) {
    var result = false, m;
    var re = /^\s*([01]?\d|2[0-3]):?([0-5]\d)\s*$/;
    if ((m = time.match(re))) {
        result = true; //(m[1].length == 2 ? "" : "0") + m[1] + ":" + m[2];
    }
    return result;
}

function validateImageFormat(fileuploadid) {
    var extensions = new Array("png", "jpeg", "jpg", "gif", "bmp");
    var image_file = fileuploadid;
    var image_length = image_file.value.length;
    var pos = image_file.value.lastIndexOf('.') + 1;
    var ext = image_file.value.substring(pos, image_length);
    var final_ext = ext.toLowerCase();
    for (i = 0; i < extensions.length; i++)
        if (extensions[i] == final_ext) {
            return true;
        }
return false;
}

function validateImageFormatFromString(fileName) {
    var extensions = new Array("png", "jpeg", "jpg", "gif", "bmp");
    var image_file = fileName;
    var image_length = fileName.length;
    var pos = image_file.lastIndexOf('.') + 1;
    var ext = image_file.substring(pos, image_length);
    var final_ext = ext.toLowerCase();
    for (i = 0; i < extensions.length; i++)
        if (extensions[i] == final_ext) {
            return true;
        }
return false;
}

function validateXMLFileFormat(fileuploadid) {
    var extensions = new Array("xml");
    var image_file = fileuploadid;
    var image_length = image_file.value.length;
    var pos = image_file.value.indexOf('.') + 1;
    var ext = image_file.value.substring(pos, image_length);
    var final_ext = ext.toLowerCase();
    for (i = 0; i < extensions.length; i++)
        if (extensions[i] == final_ext) {
            return true;
        }
return false;
}
String.prototype.trim = function () {
    return this.replace(/^\s+/, '').replace(/\s+$/, '');
}

function ChkValidEmail(object) {
    var myRegxp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

    return myRegxp.test(object);
}

function ChkValidUrl(object) {
    var myRegxp = /(http|https):\/\/([a-zA-Z0-9.]|%[0-9A-Za-z]|\/|:[0-9]?)*/;

    return myRegxp.test(object);
}
function Trim(sString) {
    while (sString.substring(0, 1) == ' ') {
        sString = sString.substring(1, sString.length)
    }
    while (sString.substring(sString.length - 1, sString.length) == ' ') {
        sString = sString.substring(0, sString.length - 1);
    }
    return sString;
}

function AddItem(Text, Value, DropDownList) {
    // Create an Option object
    var opt = document.createElement("option");

    // Assign text and value to Option object
    opt.text = Text;
    opt.value = Value;

    // Add an Option object to Drop Down/List Box
    DropDownList.options.add(opt);

}

function validateFileFormat(fileuploadid) {
    var extensions = new Array("xls", "xlsx", "csv");
    var image_file = fileuploadid;
    var image_length = image_file.value.length;
    var pos = image_file.value.indexOf('.') + 1;
    var ext = image_file.value.substring(pos, image_length);
    var final_ext = ext.toLowerCase();
    for (i = 0; i < extensions.length; i++)
        if (extensions[i] == final_ext) {
            return true;
        }
return false;
}

function CloseModelExtenderPopup(ModelExtenderPopupName, returnFlag) {
    var mpu = $find(ModelExtenderPopupName);
    mpu.hide();
    return returnFlag;
}

function ShowModelExtenderPopup(ModelExtenderPopupName, returnFlag) {
    var mpu = $find(ModelExtenderPopupName);
    if (mpu != null)
        mpu.show();
    return returnFlag;
}



function ShowLoading() {
    $('#divLoading').show();
}

function HideLoading() {
    $('#divLoading').hide();
}


function loadPopupBox(message, RedirectURL) {
    //HideLoading();
    if (document.getElementById("ctl00_lblAlertMsgMaster") != null) {
        document.getElementById("ctl00_lblAlertMsgMaster").innerHTML = message;
        $('#ctl00_popup_box').fadeIn("slow", function () {
            $('#ctl00_popup_box').fadeOut(4000);
        });
    }
    else if (document.getElementById("lblAlertMsgMaster") != null) {
        document.getElementById("lblAlertMsgMaster").innerHTML = message;
        $('#popup_box').fadeIn("slow", function () {
            $('#popup_box').fadeOut(4000);
        });
    } setTimeout("window.location.href='" + RedirectURL + "';", 3000);
}

if (location.href.indexOf("Login.aspx") == -1) {
    $("#liPubReports").hover(function () { $(".submenu").show(); }, function () { $(".submenu").hide(); });
}


function showError(ele, mesg, color) {
    var prevCol;
    if (color != null && color != undefined) {
        prevCol = $('#' + ele).css('color');
        $('#' + ele).css('color', color);
    }
    if ($('#' + ele).text != undefined) {
        $('#' + ele).text(mesg);
        setTimeout(function () {
            $('#' + ele).text('');
            if (color != null && color != undefined) {
                $('#' + ele).css('color', prevCol);
            }
        }, 3000);
    }
    else if ($('#' + ele).html != undefined) {
        $('#' + ele).html(mesg);
        setTimeout(function () {
            $('#' + ele).html('');
            if (color != null && color != undefined) {
                $('#' + ele).css('color', prevCol);
            }
        }, 3000);
    }
}


$(window).scroll(function () {
    if ($(document).scrollTop() > 0) {
        $("#divScrollTop").show();
    }
    else {
        $("#divScrollTop").hide();
    }
});

$("#divScrollTop").live("click", function () {
    $("html,body").animate({ scrollTop: 0 }, '200');
});


$(document).ajaxSend(function () {
    //console.log("ajaxStart");
    ShowLoading();
});
$(document).ajaxStop(function () {
    //console.log("ajaxStop");
    HideLoading();
});





var EmptyString = '';
function postRequest(requestData, successCallback, callback) {
    // ShowLoader();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: requestData.url,
        data: requestData.data,
        dataType: "json",
        success: function (data) {
            if ($.isFunction(successCallback)) {
                successCallback(data, callback);
            }
            // HideLoader();
        },
        error: ajaxPost_Error
    });
}

function getXml(xmlPath, successCallback, callback) {
    // ShowLoader();
    $.ajax({
        type: "GET",
        url: xmlPath,
        dataType: "xml",
        success: function (data) {
            if ($.isFunction(successCallback)) {
                successCallback(data, callback);
            }
            // HideLoader();
        },
        error: ajaxPost_Error
    });
}

function postRequestWithArgs(requestData, successCallback, values, callback) {
    // ShowLoader();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: requestData.url,
        data: requestData.data,
        dataType: "json",
        success: function (data) {
            if ($.isFunction(successCallback)) {
                successCallback(data, values, callback);
            }
            // HideLoader();
        },
        error: ajaxPost_Error
    });
}

function ajaxPost_Error(jqXHR, textStatus, errorThrown) {
    // HideLoader();
    console.log("error:");
    console.log("jqXHR.status=" + jqXHR.status);
    console.log("textStatus=" + textStatus);
    console.log("errorThrown=" + errorThrown);
    if (jqXHR.status == 401) {
        alert("Your session expired. Please login again.");
        location.href = "../Login.aspx?ReturnUrl=" + location.href;
    }
    return false;
}

//function AllowNumerics(event, text) {
//    var charCode = window.event ? window.event.charCode : event.charCode;
//    var keyCode = window.event ? window.event.keyCode : event.keyCode;
//    if (!((charCode >= 48 && charCode <= 57) || charCode === 46 || keyCode === 38 || keyCode === 40 || charCode === 0 || keyCode === 8)) {
//        if (window.event) {
//            window.event.keyCode = null;
//        }
//        else if (navigator.userAgent.toLowerCase().indexOf("msie") > -1) {
//            window.event.keyCode = null;
//        }
//        else {
//            if (!((keyCode === 0) || (keyCode <= 8))) {
//                event.preventDefault();
//            }
//        }
//        return false;
//    }
//    else {
//        var textValue = $(text).val() === EmptyString ? 0 : parseInt($(text).val());
//        if (keyCode === 38) {
//            textValue++;
//            $(text).val(textValue);
//        }
//        else if (keyCode === 40) {
//            textValue--;
//            $(text).val(textValue);
//        }
//    }
//}

function formatDateTime(timeFormat, date) {
    var h = date.getHours();
    var m = date.getMinutes();
    var s = date.getSeconds();
    var period = EmptyString;
    if ((timeFormat != null || timeFormat != undefined) && timeFormat.length > 0) {
        var timeParts;
        timeParts = timeFormat.split(':');
        if (timeParts == null) {
            timeParts = timeFormat.split('/');
        }

        for (var index = 0; index < timeParts.length; index++) {
            switch (timeParts[index]) {
                case 'hh':
                    h = h < 10 ? '0' + h : h;
                    timeFormat = timeFormat.replace('hh', h);
                    break;
                case 'HH':
                    period = h >= 12 ? "PM" : "AM";
                    h = h == 12 ? h : h % 12;
                    h = h < 10 ? '0' + h : h;
                    timeFormat = timeFormat.replace('HH', h);
                    timeFormat = timeFormat + " " + period;
                    break;
                case 'mm':
                case 'MM':
                    m = m < 10 ? '0' + m : m;
                    timeFormat = timeFormat.replace('mm', m).replace('MM', m);
                    break;
            }
        }
        return timeFormat;
    }
}


function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
             .toString(16)
             .substring(1);
};

function guid() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
         s4() + '-' + s4() + s4() + s4();
}


$(window).bind('hashchange', function (event) {
    location.hash = '';
});
//****************************************** Date Format Method **************************
function formateDate(context) {
    var date = new Date(parseInt(context.replace("/Date(", "").replace(")/", "")));
    return date.format("MM/dd/yyyy") == "01/01/0001" ? "N/A" : date.format("MM/dd/yyyy");
};


