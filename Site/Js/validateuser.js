function validateUser() {
    var str = "";
    if (document.getElementById("txtUserName").value.replace(/^\s+|\s+$/, '') == "") {
        str += " Username,"
    }
    if (document.getElementById("txtPassword").value.replace(/^\s+|\s+$/, '') == "") {
        str += " Password,";
    }
    if (str != "") {
        str = str.substring(0, str.length - 1);
        document.getElementById("lblErrMsg").innerHTML = "The following field(s) have invalid value(s):" + str + ".";

        return false;
    }
    else {
        javascript: __doPostBack('ancLogin', '')
    }

}