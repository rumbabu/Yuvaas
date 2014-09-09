<%@ Page Title="Yuvaas Social - Login" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Yuvaas - Login</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0" name="viewport">
    <%-- <link href="Css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="Css/ResponsiveStyleSheet.css" rel="stylesheet" type="text/css" />--%>
    <%--<link type="text/css" rel="Stylesheet" href="HttpCombiner/HttpCombiner.ashx?s=Set_Css_MasterPage&t=text/css&v=0" />--%>
    <script src="Js/validateuser.js" type="text/javascript"></script>
    <%--  <script src="Js/modernizr.custom.02212.js" type="text/javascript"></script>--%>
    <%--<script type="text/javascript" src="HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_modernizr&t=type/javascript&v=2">
    </script>--%>
    <!-- html5.js for IE less than 9 -->
    <!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <!-- css3-mediaqueries.js for IE less than 9 -->
    <!--[if lt IE 9]>
	<script src="Js/ie8.js"></script>
<![endif]-->
</head>
<body class="bodybg">
    <div class="main">
        <div class="container">
            <form id="form1" runat="server" defaultbutton="ancLogin">
            <div id="divLogin" runat="server" class="loginbox">
                <div class="loginmain">
                    <div class="loginmiddle">
                        <div class="logintop">
                            &nbsp;
                        </div>
                        <div class="logintitle">
                            &nbsp;
                        </div>
                        <div class="error">
                            <asp:Label ID="lblErrMsg" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="loginformrep">
                            <asp:TextBox ID="txtUserName" runat="server" placeholder="User Name" MaxLength="100"
                                AutoCompleteType="DisplayName"></asp:TextBox>
                        </div>
                        <div class="loginformrep">
                            <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" MaxLength="50"
                                TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="loginformrep">
                            <asp:DropDownList ID="ddlDomain" runat="server">
                                <asp:ListItem Selected="True" Text="Yuvaas.com" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="width100p webclass">
                            <asp:CheckBox ID="chkRememberme" runat="server" Checked="false" />&nbsp;Remember
                            me next time
                        </div>
                        <div class="loginbtn">
                            <asp:LinkButton CssClass="btn_gold fl" ID="ancLogin" runat="server" OnClientClick="return validateUser();"
                                OnClick="ancLogin_click" Text="Login"></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
            <div id="divForgotPassword" runat="server" style="display: none;">
                <div>
                    UserName:
                    <input type="text" id="txtForgotUserName" />
                </div>
            </div>
            </form>
        </div>
    </div>
</body>
</html>
