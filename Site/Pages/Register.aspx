<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Pages_Register"  Trace ="true" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Yuvaas</title>
    <link href="../Css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../Css/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../Js/jquery-ui.min.js" type="text/javascript"></script>
</head>
<body style="background: #1C7A1C;">
    <form id="form1" runat="server" autocomplete="off">
    <div class="main">
        <div class="Loginpagemain">
            <div class="Loginpage">
                <div class="Loginpageleft">
                    <div class="formmain1">
                        <div class="formhead">
                            <h2>
                                Sign Up</h2>
                            <p>
                                It's free and always will be.</p>
                        </div>
                        <div class="forminnermain">
                            <label id="lblRegErrorMessage">
                            </label>
                            <div class="forminner">
                                <label>
                                    First Name</label><input id="txtFirstName" runat="server" placeholder="First Name"
                                        maxlength="50" data-type="alphanumeric" type="text" />
                            </div>
                            <div class="forminner">
                                <label>
                                    Last Name</label>
                                <input id="txtLastName" runat="server" placeholder="Last Name" type="text" maxlength="50"
                                    data-type="alphanumeric" />
                            </div>
                            <div class="forminner">
                                <label>
                                    Your e-mail</label>
                                <input id="txtEmail" runat="server" placeholder="Your e-mail" type="text" maxlength="100"
                                    data-type="email" />
                            </div>
                            <div class="forminner">
                                <label>
                                    Repeat e-mail</label>
                                <input id="txtRepeatEmail" placeholder="Repeat e-mail" type="text" maxlength="100"
                                    autocomplete="off" data-type="email" />
                            </div>
                            <div class="forminner">
                                <label>
                                    Password</label>
                                <input id="txtPassword" runat="server" placeholder="Password" type="password" maxlength="20"
                                    autocomplete="off" data-type="password" />
                            </div>
                            <div class="forminner">
                                <label>
                                    Phone
                                </label>
                                <input id="txtPhone" runat="server" placeholder="Phone" type="text" maxlength="10"
                                    data-type="number" />
                            </div>
                            <div class="forminner">
                                <label>
                                    I am
                                </label>
                                <%--<asp:DropDownList ID="ddlGender" runat="server">
                 <asp:ListItem Text="Male" Value="male"></asp:ListItem>
                 <asp:ListItem Text="Female" Value="female"></asp:ListItem>
                 </asp:DropDownList>--%>
                                <select id="ddlGender">
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                </select>
                            </div>
                            <div class="forminner">
                                <label>
                                    Birthday
                                </label>
                                <input id="txtBirthday" runat="server" placeholder="dd/mm/yyyy" type="text" maxlength="10"
                                    data-type="date" />
                                <%--<select style="margin-right:10px;width:65px;">
                 <option>Jan</option>
                 <option>Feb</option>
                 </select><select style="margin-right:10px;width:65px;">
                 <option>1</option>
                 <option>2</option>
                 </select>
                 <select style="margin-right:10px;width:65px;">
                 <option>1989</option>
                 <option>1990</option>
                 </select>--%>
                            </div>
                            <div class="signup">
                                <a id="lnkSignUp" href="#">
                                    <img src="../Images/signup.png" /></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="Loginpageright">
                    <div class="Loginpageleftlogo">
                        <img src="../Images/loglogo.png" />
                    </div>
                    <asp:Label ID="lblErrMsg" runat="server"></asp:Label>
                    <div class="inputbox" style="margin-top: 15px;">
                        <input id="txtEmailOrPhone" runat="server" type="text" maxlength="50" placeholder="Email Or Phone"
                            data-error-message="Email Or Phone" />
                    </div>
                    <div class="inputbox">
                        <input id="txtLoginPassword" runat="server" type="password" maxlength="20" placeholder="Password"
                            data-error-message="Password" />
                    </div>
                    <div class="keepme">
                        <div class="keepmeleft">
                            <img src="../Images/check.png" />
                        </div>
                        <div class="keepmeright">
                            <asp:CheckBox ID="chkRememberMe" runat="server" />
                            <label for="<%= chkRememberMe.ClientID %>">
                                Keep me logged in</label></div>
                    </div>
                    <div class="logbtn" style="margin-top: 13px;">
                        <div class="logbtnleft">
                            <a id="lnkLogin" runat="server" onserverclick="lnkLogin_click">
                                <img src="../Images/loginbtn.png" /></a>
                        </div>
                        <div class="logbtnright">
                            <a href="#">Forgot Password?</a></div>
                    </div>
                    <div class="line">
                        <img src="../Images/line.png" /></div>
                    <div class="get">
                        <div class="getleft">
                            <img src="../Images/phone.png" /></div>
                        <div class="getright">
                            <h2>
                                Heading out? Stay connected</h2>
                            <p>
                                Visit Yuvaas.com on your mobile phone.</p>
                            <div class="getimg">
                                <a href="#">
                                    <img src="../Images/get.png" /></a>
                            </div>
                        </div>
                    </div>
                    <div class="line">
                        <img src="../Images/line.png"></div>
                    <div class="copy">
                        <div class="copyleft">
                            Yuvaas @ 2014</div>
                        <div class="copyright">
                            <select>
                                <option>English (US)</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <script src="../Js/CommonFunctions.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(document).on("keypress", function (e) {
                if (e.keyCode == 13) {
                    $("#lnkLogin").trigger("click");
                }
            });
            $("#txtEmailOrMobileNo").focus();
            $("#txtBirthday").datepicker({ dateFormat: "mm/dd/yy" });
            var User = function () {
                //Login
                this.EmailOrPhone = $("#txtEmailOrPhone");
                this.LoginPassword = $("#txtLoginPassword");

                this.IsValid = true;
                this.FocusedElement = null;
                this.ValidateLogin = function () {
                    this.IsValid = true;
                    this.FocusedElement = null;
                    if (this.EmailOrPhone.val().trim() == "") {
                        this.EmailOrPhone.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || this.EmailOrPhone;
                    }
                    else if (!IsValidEmail(this.EmailOrPhone.val()) && !IsValidMobileNo(this.EmailOrPhone.val())) {
                        this.EmailOrPhone.css("border", "1px solid #f00");
                        this.FocusedElement = this.FocusedElement || this.EmailOrPhone;
                        this.IsValid = false;
                    }
                    else {
                        this.EmailOrPhone.css("border", "1px solid #0f0");
                    }

                    if (this.LoginPassword.val().trim() == "") {
                        this.LoginPassword.css("border", "1px solid #f00");
                        this.FocusedElement = this.FocusedElement || this.LoginPassword;
                        this.IsValid = false;
                    } else {
                        this.LoginPassword.css("border", "1px solid #0f0");
                    }
                    if (!this.IsValid) {
                        this.FocusedElement.focus();
                    }
                    return this.IsValid;
                }

                this.ValidateRegister = function () {
                    this.IsValid = true;
                    this.FocusedElement = null;
                    txtFirstName = $("#txtFirstName");
                    txtLastName = $("#txtLastName");
                    txtEmail = $("#txtEmail");
                    txtRepeatEmail = $("#txtRepeatEmail");
                    txtPassword = $("#txtPassword");
                    txtPhone = $("#txtPhone");
                    ddlGender = $("#ddlGender");
                    txtBirthday = $("#txtBirthday");

                    var objUser = {};

                    if (txtFirstName.val().trim() == "") {
                        txtFirstName.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtFirstName;
                    }
                    else {
                        txtFirstName.css("border", "1px solid #0f0");
                        objUser.FirstName = txtFirstName.val().trim();
                    }

                    if (txtLastName.val().trim() == "") {
                        txtLastName.css("border", "1px solid #f00");
                        this.FocusedElement = this.FocusedElement || txtLastName;
                        this.IsValid = false;
                    } else {
                        txtLastName.css("border", "1px solid #0f0");
                        objUser.LastName = txtLastName.val().trim();
                    }

                    if (txtEmail.val().trim() == "") {
                        txtEmail.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtEmail;
                    }
                    else if (!IsValidEmail(txtEmail.val())) {
                        txtEmail.css("border", "1px solid #f00");
                        this.FocusedElement = this.FocusedElement || txtEmail;
                        this.IsValid = false;
                    }
                    else {
                        txtEmail.css("border", "1px solid #0f0");
                        objUser.Email = txtEmail.val().trim();
                    }

                    if (txtEmail.val().trim() != txtRepeatEmail.val().trim()) {
                        txtRepeatEmail.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtRepeatEmail;
                    }
                    else {
                        txtRepeatEmail.css("border", "1px solid #0f0");
                    }

                    if (txtPassword.val().trim() == "") {
                        txtPassword.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtPassword;
                    }
                    else {
                        txtPassword.css("border", "1px solid #0f0");
                        objUser.Password = txtPassword.val().trim();
                    }

                    if (txtPhone.val().trim() == "") {
                        txtPhone.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtPhone;
                    } else if (!IsValidMobileNo(txtPhone.val())) {
                        txtPhone.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtPhone;
                    }
                    else {
                        txtPhone.css("border", "1px solid #0f0");
                        objUser.Phone = txtPhone.val().trim();
                    }

                    if (ddlGender.val().trim() == "") {
                        ddlGender.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || ddlGender;
                    }
                    else {
                        ddlGender.css("border", "1px solid #0f0");
                        objUser.Gender = ddlGender.val().trim();
                    }

                    if (txtBirthday.val().trim() == "") {
                        txtBirthday.css("border", "1px solid #f00");
                        this.IsValid = false;
                        this.FocusedElement = this.FocusedElement || txtBirthday;
                    }
                    else {
                        txtBirthday.css("border", "1px solid #0f0");
                        objUser.DOB = txtBirthday.val().trim();
                    }

                    if (!this.IsValid) {
                        this.FocusedElement.focus();
                    }
                    else {
                        console.log(objUser);
                        this.SaveUser(objUser);
                    }
                    return this.IsValid;
                }

                this.SaveUser = function (objUser) {
                    var requestData = { url: "register.aspx/SaveUser", data: JSON.stringify(objUser) };
                    postRequest(requestData, function (data) {
                        if (data) {
                            if (data.d > 0) {
                                $("input,select").val("");
                                $("#lblRegErrorMessage").text("You have registered successfully. Please login to expolre.");
                            }
                            else {
                                $("#lblRegErrorMessage").text("Error while processing request.");
                            }
                        }
                    });
                }
            }

            var user = new User();
            $("#lnkSignUp").on("click", function () { return user.ValidateRegister(); });
            $("#lnkLogin").on("click", function () { return user.ValidateLogin() ? __doPostBack('lnkLogin', '') : false; });
        });
    </script>
</body>
</html>
