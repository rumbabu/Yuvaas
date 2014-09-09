<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Pages_Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Yuvaas</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0" name="viewport">
    <%-- <link href="../Css/StyleSheet.css?V=1.1" rel="stylesheet" type="text/css" />
    <link href="../Css/ResponsiveStyleSheet.css" rel="stylesheet" type="text/css" />--%>
    <link type="text/css" rel="Stylesheet" href="../HttpCombiner/HttpCombiner.ashx?s=Set_Css_MasterPage&t=text/css&v=0" />
    <%-- <script src="../Js/jquery.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_Jquery&t=type/javascript&v=2">
    </script>
    <link rel="stylesheet" type="text/css" href="../Css/fb/x3bsMJyVkPp.css" />
    <link rel="stylesheet" type="text/css" href="../Css/fb/4rzkhBmT64_.css" />
    <link rel="stylesheet" type="text/css" href="../Css/fb/bRpKCC99nTG.css" />
    <link rel="stylesheet" type="text/css" href="../Css/fb/O-kOURbVD7n.css" />
    <%--<script src="../Js/jquery-ui.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_UI&t=type/javascript&v=2">
    </script>
    <%--  <script src="../Js/jquery.ui.touch-punch.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_TouchPunch&t=type/javascript&v=2">
    </script>
    <%--  <script src="../Js/facescroll.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_FaceScroll&t=type/javascript&v=2">
    </script>
    <%--<script src="../Js/modernizr.custom.02212.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_modernizr&t=type/javascript&v=2">
    </script>
    <%-- <script src="../Js/jquery.lazyload.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../HttpCombiner/HttpCombiner.ashx?s=Set_Javascript_LazyLoad&t=type/javascript&v=2">
    </script>
    <script src="../Js/Master.js" type="text/javascript"></script>
    <!-- html5.js for IE less than 9 -->
    <!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <!-- css3-mediaqueries.js for IE less than 9 -->
    <!--[if lt IE 9]>
	<script src="../Js/ie8.js"></script>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
        <div id="menu" class="slidepanel" style="display: none;">
            <ul id="ulMenu">
                <li><a href="../Pages/NewsFeed.aspx">News Feed <span>
                    <img src="../images/news.png" alt="" /></span> </a></li>
                <li><a href="../Pages/TimeLine.aspx">Wall <span>
                    <img src="../images/chat.png" alt="" /></span> </a></li>
                <li><a href="../Pages/Profile.aspx">Profile <span>
                    <img src="../images/new.png" alt="" /></span> </a></li>
                <li style="display: none;"><a href="../Pages/Messages.aspx">Messages <span>
                    <img src="../images/message.png" alt="" /></span> </a></li>
                <li><a href="../Pages/Friends.aspx">Friends <span>
                    <img src="../images/user.png" alt="" /></span></a></li>
                <li><a href="../Default.aspx">Logout <span>
                    <img src="../images/logout1.png" alt="" /></span></a></li>
            </ul>
        </div>
        <div class="headermain">
            <div class="iphonemenu">
                <a href="javascript:void(0);" onclick="slideFadeToggle();">
                    <img src="../images/menuip.png" alt="" /></a></div>
            <div class="header">
                <div class="headerprofile">
                    <img src="../Images/prphoto.png" /></div>
                <div class="headerleft">
                    <a href="../Pages/NewsFeed.aspx">
                        <img style="" src="../images/logo.png" alt="logo" />
                    </a>
                </div>
                <div class="menu">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="conmain">
                <div id="content" class="fb_content clearfix">
                    <div>
                        <div class="_50dz">
                            <style type="text/css">
                                .product_desc
                                {
                                    width: 440px;
                                }
                            </style>
                            <div style="background: #edf0f5">
                                <div class="pvl" style="width: 1000px; margin: 0 auto">
                                    <div class="_7d _6_ _76">
                                        <h1 class="inlineBlock _3ma _6n _6s _6v" style="padding: 42px 0 24px; font-size: 28px;
                                            line-height: 36px">
                                            Connect with friends and the<br>
                                            world around you on Yuvaas.
                                        </h1>
                                        <div class="mtl pbm">
                                            <div class="_6a _6b mrl" style="text-align: center; width: 55px">
                                                <img class="img dn" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/851565_602269956474188_918638970_n.png"
                                                    alt="" style="vertical-align: middle"></div>
                                            <div class="_6a _6b product_desc">
                                                <span class="mtl _3ma _6p _6s _6v">See photos and updates </span><span class="mlm _6q _6t _mf">
                                                    from friends in News Feed. </span>
                                            </div>
                                        </div>
                                        <div class="mtl pbm">
                                            <div class="_6a _6b mrl" style="text-align: center; width: 55px">
                                                <img class="img dn" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/851585_216271631855613_2121533625_n.png"
                                                    alt="" style="vertical-align: middle"></div>
                                            <div class="_6a _6b product_desc">
                                                <span class="mtl _3ma _6p _6s _6v">Share what's new </span><span class="mlm _6q _6t _mf">
                                                    in your life on your Timeline. </span>
                                            </div>
                                        </div>
                                        <div class="mtl pbm">
                                            <div class="_6a _6b mrl" style="text-align: center; width: 55px">
                                                <img class="img dn" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/851558_160351450817973_1678868765_n.png"
                                                    alt="" style="vertical-align: middle"></div>
                                            <div class="_6a _6b product_desc">
                                                <span class="mtl _3ma _6p _6s _6v">Find more </span><span class="mlm _6q _6t _mf">of
                                                    what you're looking for with Graph Search. </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="_6_ _74">
                                        <h1 class="mbs _3ma _6n _6s _6v" style="font-size: 36px">
                                            Sign Up</h1>
                                        <h2 class="mbl _3m9 _6o _6s _mf">
                                            It’s free and always will be.</h2>
                                        <div>
                                            <div>
                                                <noscript>
                                                    &lt;div id="no_js_box"&gt;&lt;h2&gt;JavaScript is disabled on your browser.&lt;/h2&gt;&lt;p&gt;Please
                                                    enable JavaScript on your browser or upgrade to a JavaScript-capable browser to
                                                    register for Facebook.&lt;/p&gt;&lt;/div&gt;</noscript><div class="_58mf">
                                                        <div id="reg_box" class="registration_redesign">
                                                            <form method="post" id="reg" name="reg" action="https://m.facebook.com/r.php" onsubmit="return function(event){return false;}.call(this,event)!==false &amp;&amp; window.Event &amp;&amp; Event.__inlineSubmit &amp;&amp; Event.__inlineSubmit(this,event)">
                                                            <input type="hidden" name="lsd" value="AVpkA--v" autocomplete="off"><div id="reg_form_box"
                                                                class="large_form">
                                                                <div class="clearfix _58mh">
                                                                    <div class="mbm _3-90 lfloat _ohe">
                                                                        <div class="_5dbb" id="u_0_0">
                                                                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                                                                <div class="placeholder" aria-hidden="true">
                                                                                    First name</div>
                                                                                <input type="text" class="inputtext _58mg _5dba _2ph-" data-type="text" name="firstname"
                                                                                    aria-required="1" placeholder="First name" id="u_0_1" aria-label="First name"></div>
                                                                            <i class="_5dbc img sp_9vUokIDmpP8 sx_116e5b"></i><i class="_5dbd img sp_9vUokIDmpP8 sx_fa2374">
                                                                            </i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="mbm rfloat _ohf">
                                                                        <div class="_5dbb" id="u_0_2">
                                                                            <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                                                                <div class="placeholder" aria-hidden="true">
                                                                                    Last name</div>
                                                                                <input type="text" class="inputtext _58mg _5dba _2ph-" data-type="text" name="lastname"
                                                                                    aria-required="1" placeholder="Last name" id="u_0_3" aria-label="Last name"></div>
                                                                            <i class="_5dbc img sp_9vUokIDmpP8 sx_116e5b"></i><i class="_5dbd img sp_9vUokIDmpP8 sx_fa2374">
                                                                            </i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="mbm">
                                                                    <div class="_5dbb" id="u_0_4">
                                                                        <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                                                            <div class="placeholder" aria-hidden="true">
                                                                                Email</div>
                                                                            <input type="text" class="inputtext _58mg _5dba _2ph-" data-type="text" name="reg_email__"
                                                                                aria-required="1" placeholder="Email" id="u_0_5" aria-label="Email"></div>
                                                                        <i class="_5dbc img sp_9vUokIDmpP8 sx_116e5b"></i><i class="_5dbd img sp_9vUokIDmpP8 sx_fa2374">
                                                                        </i>
                                                                    </div>
                                                                </div>
                                                                <div class="mbm" id="u_0_6">
                                                                    <div class="_5dbb" id="u_0_7">
                                                                        <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                                                            <div class="placeholder" aria-hidden="true">
                                                                                Re-enter email</div>
                                                                            <input type="text" class="inputtext _58mg _5dba _2ph-" data-type="text" name="reg_email_confirmation__"
                                                                                aria-required="1" placeholder="Re-enter email" id="u_0_8" aria-label="Re-enter email"></div>
                                                                        <i class="_5dbc img sp_9vUokIDmpP8 sx_116e5b"></i><i class="_5dbd img sp_9vUokIDmpP8 sx_fa2374">
                                                                        </i>
                                                                    </div>
                                                                </div>
                                                                <div class="mbm">
                                                                    <div class="_5dbb" id="u_0_9">
                                                                        <div class="uiStickyPlaceholderInput uiStickyPlaceholderEmptyInput">
                                                                            <div class="placeholder" aria-hidden="true">
                                                                                New password</div>
                                                                            <input type="password" class="inputtext _58mg _5dba _2ph-" data-type="text" name="reg_passwd__"
                                                                                aria-required="1" placeholder="" id="u_0_a" value="New password" aria-label="New password"></div>
                                                                        <i class="_5dbc img sp_9vUokIDmpP8 sx_116e5b"></i><i class="_5dbd img sp_9vUokIDmpP8 sx_fa2374">
                                                                        </i>
                                                                    </div>
                                                                </div>
                                                                <div class="_58mq _5dbb" id="u_0_b">
                                                                    <div class="mtm mbs _58mr">
                                                                        Birthday</div>
                                                                    <div class="_5k_5">
                                                                        <span class="_5k_4" data-type="selectors" data-name="birthday_wrapper" id="u_0_c"><span>
                                                                            <select name="birthday_month" id="month" class="_5dba">
                                                                                <option value="0" selected="1">Month</option>
                                                                                <option value="1">Jan</option>
                                                                                <option value="2">Feb</option>
                                                                                <option value="3">Mar</option>
                                                                                <option value="4">Apr</option>
                                                                                <option value="5">May</option>
                                                                                <option value="6">Jun</option>
                                                                                <option value="7">Jul</option>
                                                                                <option value="8">Aug</option>
                                                                                <option value="9">Sep</option>
                                                                                <option value="10">Oct</option>
                                                                                <option value="11">Nov</option>
                                                                                <option value="12">Dec</option>
                                                                            </select><select name="birthday_day" id="day" class="_5dba"><option value="0" selected="1">
                                                                                Day</option>
                                                                                <option value="1">1</option>
                                                                                <option value="2">2</option>
                                                                                <option value="3">3</option>
                                                                                <option value="4">4</option>
                                                                                <option value="5">5</option>
                                                                                <option value="6">6</option>
                                                                                <option value="7">7</option>
                                                                                <option value="8">8</option>
                                                                                <option value="9">9</option>
                                                                                <option value="10">10</option>
                                                                                <option value="11">11</option>
                                                                                <option value="12">12</option>
                                                                                <option value="13">13</option>
                                                                                <option value="14">14</option>
                                                                                <option value="15">15</option>
                                                                                <option value="16">16</option>
                                                                                <option value="17">17</option>
                                                                                <option value="18">18</option>
                                                                                <option value="19">19</option>
                                                                                <option value="20">20</option>
                                                                                <option value="21">21</option>
                                                                                <option value="22">22</option>
                                                                                <option value="23">23</option>
                                                                                <option value="24">24</option>
                                                                                <option value="25">25</option>
                                                                                <option value="26">26</option>
                                                                                <option value="27">27</option>
                                                                                <option value="28">28</option>
                                                                                <option value="29">29</option>
                                                                                <option value="30">30</option>
                                                                                <option value="31">31</option>
                                                                            </select><select name="birthday_year" id="year" class="_5dba"><option value="0" selected="1">
                                                                                Year</option>
                                                                                <option value="2014">2014</option>
                                                                                <option value="2013">2013</option>
                                                                                <option value="2012">2012</option>
                                                                                <option value="2011">2011</option>
                                                                                <option value="2010">2010</option>
                                                                                <option value="2009">2009</option>
                                                                                <option value="2008">2008</option>
                                                                                <option value="2007">2007</option>
                                                                                <option value="2006">2006</option>
                                                                                <option value="2005">2005</option>
                                                                                <option value="2004">2004</option>
                                                                                <option value="2003">2003</option>
                                                                                <option value="2002">2002</option>
                                                                                <option value="2001">2001</option>
                                                                                <option value="2000">2000</option>
                                                                                <option value="1999">1999</option>
                                                                                <option value="1998">1998</option>
                                                                                <option value="1997">1997</option>
                                                                                <option value="1996">1996</option>
                                                                                <option value="1995">1995</option>
                                                                                <option value="1994">1994</option>
                                                                                <option value="1993">1993</option>
                                                                                <option value="1992">1992</option>
                                                                                <option value="1991">1991</option>
                                                                                <option value="1990">1990</option>
                                                                                <option value="1989">1989</option>
                                                                                <option value="1988">1988</option>
                                                                                <option value="1987">1987</option>
                                                                                <option value="1986">1986</option>
                                                                                <option value="1985">1985</option>
                                                                                <option value="1984">1984</option>
                                                                                <option value="1983">1983</option>
                                                                                <option value="1982">1982</option>
                                                                                <option value="1981">1981</option>
                                                                                <option value="1980">1980</option>
                                                                                <option value="1979">1979</option>
                                                                                <option value="1978">1978</option>
                                                                                <option value="1977">1977</option>
                                                                                <option value="1976">1976</option>
                                                                                <option value="1975">1975</option>
                                                                                <option value="1974">1974</option>
                                                                                <option value="1973">1973</option>
                                                                                <option value="1972">1972</option>
                                                                                <option value="1971">1971</option>
                                                                                <option value="1970">1970</option>
                                                                                <option value="1969">1969</option>
                                                                                <option value="1968">1968</option>
                                                                                <option value="1967">1967</option>
                                                                                <option value="1966">1966</option>
                                                                                <option value="1965">1965</option>
                                                                                <option value="1964">1964</option>
                                                                                <option value="1963">1963</option>
                                                                                <option value="1962">1962</option>
                                                                                <option value="1961">1961</option>
                                                                                <option value="1960">1960</option>
                                                                                <option value="1959">1959</option>
                                                                                <option value="1958">1958</option>
                                                                                <option value="1957">1957</option>
                                                                                <option value="1956">1956</option>
                                                                                <option value="1955">1955</option>
                                                                                <option value="1954">1954</option>
                                                                                <option value="1953">1953</option>
                                                                                <option value="1952">1952</option>
                                                                                <option value="1951">1951</option>
                                                                                <option value="1950">1950</option>
                                                                                <option value="1949">1949</option>
                                                                                <option value="1948">1948</option>
                                                                                <option value="1947">1947</option>
                                                                                <option value="1946">1946</option>
                                                                                <option value="1945">1945</option>
                                                                                <option value="1944">1944</option>
                                                                                <option value="1943">1943</option>
                                                                                <option value="1942">1942</option>
                                                                                <option value="1941">1941</option>
                                                                                <option value="1940">1940</option>
                                                                                <option value="1939">1939</option>
                                                                                <option value="1938">1938</option>
                                                                                <option value="1937">1937</option>
                                                                                <option value="1936">1936</option>
                                                                                <option value="1935">1935</option>
                                                                                <option value="1934">1934</option>
                                                                                <option value="1933">1933</option>
                                                                                <option value="1932">1932</option>
                                                                                <option value="1931">1931</option>
                                                                                <option value="1930">1930</option>
                                                                                <option value="1929">1929</option>
                                                                                <option value="1928">1928</option>
                                                                                <option value="1927">1927</option>
                                                                                <option value="1926">1926</option>
                                                                                <option value="1925">1925</option>
                                                                                <option value="1924">1924</option>
                                                                                <option value="1923">1923</option>
                                                                                <option value="1922">1922</option>
                                                                                <option value="1921">1921</option>
                                                                                <option value="1920">1920</option>
                                                                                <option value="1919">1919</option>
                                                                                <option value="1918">1918</option>
                                                                                <option value="1917">1917</option>
                                                                                <option value="1916">1916</option>
                                                                                <option value="1915">1915</option>
                                                                                <option value="1914">1914</option>
                                                                                <option value="1913">1913</option>
                                                                                <option value="1912">1912</option>
                                                                                <option value="1911">1911</option>
                                                                                <option value="1910">1910</option>
                                                                                <option value="1909">1909</option>
                                                                                <option value="1908">1908</option>
                                                                                <option value="1907">1907</option>
                                                                                <option value="1906">1906</option>
                                                                                <option value="1905">1905</option>
                                                                            </select></span></span><a class="mlm _58ms dn" href="https://www.facebook.com/#"
                                                                                ajaxify="/help/ajax/reg_birthday" title="Click for more information" rel="async"
                                                                                role="button">Why do I need to provide my birthday?</a><i class="_5dbc _5k_6 img sp_9vUokIDmpP8 sx_116e5b"></i><i
                                                                                    class="_5dbd _5k_7 img sp_9vUokIDmpP8 sx_fa2374"></i></div>
                                                                </div>
                                                                <div class="mtm _5wa2 _5dbb" id="u_0_f">
                                                                    <span class="_5k_3" data-type="radio" data-name="gender_wrapper" id="u_0_g"><span
                                                                        class="_5k_2 _5dba">
                                                                        <input type="radio" name="sex" value="1" id="u_0_d"><label class="_58mt" for="u_0_d">Female</label></span><span
                                                                            class="_5k_2 _5dba"><input type="radio" name="sex" value="2" id="u_0_e"><label class="_58mt"
                                                                                for="u_0_e">Male</label></span></span><i class="_5dbc _5k_6 img sp_9vUokIDmpP8 sx_116e5b"></i><i
                                                                                    class="_5dbd _5k_7 img sp_9vUokIDmpP8 sx_fa2374"></i></div>
                                                                <div class="_58mu" id="u_0_h">
                                                                    <p class="_58mv">
                                                                        By clicking Sign Up, you agree to our <a href="https://www.facebook.com/legal/terms"
                                                                            target="_blank" rel="nofollow">Terms</a> and that you have read our <a href="https://www.facebook.com/about/privacy"
                                                                                target="_blank" rel="nofollow">Data Use Policy</a>, including our <a href="https://www.facebook.com/help/cookies"
                                                                                    target="_blank" rel="nofollow">Cookie Use</a>.</p>
                                                                </div>
                                                                <div class="clearfix">
                                                                    <button type="submit" class="_6j mvm _6wk _6wl _58mi _3ma _6o _6v" name="websubmit"
                                                                        id="u_0_i">
                                                                        Sign Up</button><span class="hidden_elem _58ml" id="u_0_l"><img class="img" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/GsNJNwuI-UM.gif"
                                                                            alt="" width="16" height="11"></span></div>
                                                            </div>
                                                            <input type="hidden" autocomplete="off" id="referrer" name="referrer" value=""><input
                                                                type="hidden" autocomplete="off" id="asked_to_login" name="asked_to_login"><input
                                                                    type="hidden" autocomplete="off" id="terms" name="terms" value="on"><input type="hidden"
                                                                        autocomplete="off" id="ab_test_data" name="ab_test_data" value=""><input type="hidden"
                                                                            autocomplete="off" id="reg_instance" name="reg_instance" value="6OnlU07Uc89J0D_oKIK3irtP"><input
                                                                                type="hidden" autocomplete="off" id="contactpoint_label" name="contactpoint_label"
                                                                                value="email_only"><input type="hidden" autocomplete="off" id="locale" name="locale"
                                                                                    value="en_US"><input type="hidden" autocomplete="off" id="abtest_registration_group"
                                                                                        name="abtest_registration_group" value="1"><div id="reg_captcha" class="_58mw hidden_elem">
                                                                                            <div class="dn">
                                                                                                <h2 id="security_check_header">
                                                                                                    Security Check</h2>
                                                                                                <div id="outer_captcha_box">
                                                                                                    <div id="captcha_box">
                                                                                                        <div class="field_error hidden_elem" id="captcha_response_error">
                                                                                                            This field is required.</div>
                                                                                                        <div id="captcha" class="captcha" data-captcha-class="ReCaptchaCaptcha">
                                                                                                            <input type="hidden" autocomplete="off" id="captcha_persist_data" name="captcha_persist_data"
                                                                                                                value="AZmpNWF4TX6IBLh49zacc9eOZjpKiAEyigiMP8-KyqBVSnd8wSZvIWWHEy9iYev0gNFWTHSNDu1tcFMFf_KTAZCekFFNXJcaXxvnXLEl0T1j2VvkjRBFz6qXlj_rMCHBDvLAXNXNBMji-uOvFZHIYwbaLLWNLp8twmY_QyFkQsooCbh2jKDqdfoUfLlW4F0rOCMz1rscq26RZ_7KP7omhhRLVxlgBtLUV9fJK24HLnofvVxAQchn0oyZSz3qOaVdslg8ayrh7qeGKX4cqLQz_CUb5CeOix4hwR4hj0oWX99-bPWOXMsKmlyII0jeVF1RgW49gUnqxHAw7PbYJX_72aF-b1tcKjJjE4s_6GRKs2Gimg"><div
                                                                                                                    id="recaptcha_scripts" style="display: none">
                                                                                                                </div>
                                                                                                            <input type="hidden" autocomplete="off" id="captcha_session" name="captcha_session"
                                                                                                                value="4iUeQFsE80HppnyFarsTQg"><input type="hidden" autocomplete="off" id="extra_challenge_params"
                                                                                                                    name="extra_challenge_params" value="authp=nonce.tt.time.new_audio_default&amp;psig=dutr3AwhiyyQKQlSqGO0nUoyXsM&amp;nonce=4iUeQFsE80HppnyFarsTQg&amp;tt=ZgZD3sHf-f-87a7YlEiFpo1oCM8&amp;time=1408860393&amp;new_audio_default=1"><input
                                                                                                                        type="hidden" autocomplete="off" id="recaptcha_type" name="recaptcha_type" value="password"><div
                                                                                                                            class="recaptcha_text">
                                                                                                                            <div class="recaptcha_only_if_image">
                                                                                                                                Enter both words below, separated by a space.<br>
                                                                                                                                Can't read the words below? <a href="https://www.facebook.com/#" onclick="Recaptcha.reload(); return false"
                                                                                                                                    id="recaptcha_reload_btn" role="button">Try different words</a> or <a href="https://www.facebook.com/#"
                                                                                                                                        onclick="Recaptcha.switch_type(&quot;audio&quot;); return false;" role="button">
                                                                                                                                        an audio captcha</a>.</div>
                                                                                                                            <div class="recaptcha_only_if_audio" style="display: none">
                                                                                                                                Please enter the words or numbers you hear.<br>
                                                                                                                                <a href="https://www.facebook.com/#" onclick="Recaptcha.reload(); return false" id="recaptcha_reload_btn"
                                                                                                                                    role="button">Try different words</a> or <a class="recaptcha_only_if_audio" href="https://www.facebook.com/#"
                                                                                                                                        onclick="Recaptcha.switch_type(&quot;image&quot;); return false;" role="button">
                                                                                                                                        back to text</a>.</div>
                                                                                                                        </div>
                                                                                                            <span id="recaptcha_play_audio"></span>
                                                                                                            <div class="audiocaptcha">
                                                                                                            </div>
                                                                                                            <div id="recaptcha_image" class="captcha_image">
                                                                                                            </div>
                                                                                                            <div id="recaptcha_loading">
                                                                                                                Loading...<img class="captcha_loading img" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/GsNJNwuI-UM.gif"
                                                                                                                    alt="" width="16" height="11"></div>
                                                                                                            <div class="captcha_input">
                                                                                                                <label>
                                                                                                                    Text in the box:</label><div class="field_container">
                                                                                                                        <input type="text" name="captcha_response" id="captcha_response" autocomplete="off"
                                                                                                                            aria-label="Captcha input. Type the words listed above to continue. Additionally you may also try the audio captcha by clicking the link above."></div>
                                                                                                                <a class="mlm" href="https://www.facebook.com/#" onclick="CSS.show($(&#39;captcha_whats_this&#39;)); return false;"
                                                                                                                    role="button">What's this?</a><div id="captcha_whats_this" class="hidden_elem">
                                                                                                                        <div class="fsl fwb">
                                                                                                                            Security Check</div>
                                                                                                                        This is a standard security test that we use to prevent spammers from creating fake
                                                                                                                        accounts and spamming users.</div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div id="captcha_buttons" class="_58p2 clearfix hidden_elem">
                                                                                                    <div class="_58mx _58mm">
                                                                                                        <div class="_58mz">
                                                                                                            &nbsp;
                                                                                                        </div>
                                                                                                        <a class="_58my" href="https://www.facebook.com/#" role="button" id="u_0_j">Back</a></div>
                                                                                                    <div class="_58mm">
                                                                                                        <div class="clearfix">
                                                                                                            <button type="submit" class="_6j mvm _6wk _6wl _58me _58mi _3ma _6o _6v" id="u_0_k">
                                                                                                                Sign Up</button><span class="hidden_elem _58ml" id="u_0_m"><img class="img" src="./Welcome to Facebook - Log In, Sign Up or Learn More_files/GsNJNwuI-UM.gif"
                                                                                                                    alt="" width="16" height="11"></span></div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                            </form>
                                                            <div id="reg_error" class="_58mn hidden_elem">
                                                                <div id="reg_error_inner" class="_58mo">
                                                                    An error occurred. Please try again.</div>
                                                            </div>
                                                            <div id="reg_pages_msg" class="_58mk dn">
                                                                <a href="https://www.facebook.com/pages/create/">Create a Page</a> for a celebrity,
                                                                band or business.</div>
                                                        </div>
                                                    </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
