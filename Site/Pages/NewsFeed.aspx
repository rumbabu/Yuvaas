<%@ Page Title="Yuvaas - News Feed" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="NewsFeed.aspx.cs" Inherits="SRChat.Pages_NewsFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    
    <link rel="stylesheet" href="../Css/prettyPhoto.css?v=1.1" />
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../Css/jquery-ui.css" />
    <script src="../Js/jquery-1.8.2.js"></script>
    <script src="../Js/jquery-ui.js"></script>
    <script type="text/javascript" src="../Js/jquery.dialogextend.1_0_1.js"></script>
    
    <div class="innerright">
        <div class="wallinner">
            <div class="updatestatus">
                <ul class="us">
                    <li class=""><a href="javascript:void(0);" class=""><span class="uiIconText"><i class="sx_a35373 sp_8noqk7 img">
                    </i>Update Status<i class=""> </i></span></a></li>
                    <li class=""><a href="javascript:void(0);" class="" onclick="performClick();" id="ancUploadImage">
                        <span class="uiIconText"><i class="sx_48da95 sp_5t1i4q img"></i>Add Photos<i class="">
                        </i></span></a><a href="javascript:void(0);" class="dn" onclick="releaseUploadedFile();"
                            id="ancDelete"><span class="uiIconText"><i class="sx_48da95 sp_5t1i4q img"></i>Delete
                                Image <i class=""></i></span><span>
                                    <img src="" alt="" /></span> </a></li>
                </ul>
                <%-- <ul>
                    <li><a href="javascript:void(0);">Update Status <span>
                        <img src="" alt="" /></span> </a></li>
                    <li><a href="javascript:void(0);" onclick="performClick();" id="ancUploadImage">Upload
                        Image</a> <a href="javascript:void(0);" onclick="releaseUploadedFile();" id="ancDelete">
                            Delete Image <span>
                                <img src="" alt="" /></span> </a></li>
                </ul>--%>
            </div>
            <div class="psbox">
                <div class="mhht">
                    <textarea rows="2" cols="50" id="txtPost" placeholder="What's on your mind?"></textarea>
                    <div class="area">
                        <a class="btn_silver" style="width: 35px; float: right; margin: 0px 3px 0px 0px;
                            text-align: center;" onclick="PostMessage();">Post</a></div>
                    <div id="divUploadImage" class="msgbodynn" style="display: none">
                        <img id="imgUploadedImage" src="" width="150" height="150" alt="" />
                        <input type="hidden" id="hdnUploadedImagePath" value="" />
                    </div>
                </div>
            </div>
            <div class="upimg">
                <asp:FileUpload size="1" Style="visibility: hidden;" ID="updawardimg" name="updawardimg"
                    onchange="return ajaxFileUploader();" runat="server" accept="image/*" />
            </div>
            <div id="divFeedContent" class="feeds">
                <div id="divFeeds">
                </div>
                <%--<div id="divLoader"><img src="../Images/LoadingIndicator-32.png" alt="Loading..." /></div>--%>
            </div>
        </div>
    </div>
    <div class="innerads">
        <ul>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
            <li><a>
                <img src="../Images/addimg.png" />
                <h2>
                    dfgnujdfbhfd</h2>
                <p>
                    df ishdbuidfhu</p>
            </a></li>
        </ul>
    </div>
    <asp:HiddenField ID="hdnCommentsHTML" runat="server" />
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <asp:HiddenField ID="hdnUserImagePath" runat="server" />
    <asp:HiddenField ID="hdnUserImage" runat="server" />
    <input type="hidden" id="hdnCurrentStatusId" value="" />
    <input type="hidden" id="hdnCurrentCommentId" value="" />
    <input type="hidden" id="hdnCurrentComment" value="" />
    <input type="hidden" id="hdnSelectedUserId" runat="server" value="" />
    <script type="text/javascript">

        var ImagePath = "<%=path %>";
        var updawardimg = '<%=updawardimg.ClientID %>';
        var hdnUserImage = '<%=hdnUserImage.ClientID %>';
        var hdnUserName = '<%=hdnUserName.ClientID %>';
        var hdnUserImagePath = '<%=userimagepath %>';
        var LoggedInUserId = '<%=LoggedInUserId %>';
        var hdnSelectedUserId = '<%=hdnSelectedUserId.ClientID %>';
        var hdnCommentsHTML = '<%=hdnCommentsHTML.ClientID %>';
        var _MaximumRecords = parseInt('<%= MaxRecords %>');
        var _UserId = '<%= Session["UserId"].ToString() %>';

    </script>
    <script src="../Js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="../Js/NewsFeed.js" type="text/javascript"></script>
    
</asp:Content>
