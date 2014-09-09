<%@ Page Title="Yuvaas Social - TimeLine" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="TimeLine.aspx.cs" Inherits="Pages_TimeLine" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <link rel="stylesheet" href="../Css/prettyPhoto.css?v=1.1" />
    <script src="../Js/TimeLine.js" type="text/javascript"></script>
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="../Js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <div class="innerright">
        <div class="wallinner">
            <div class="updatestatus">
                <ul class="us">
                    <li class=""><a href="javascript:void(0);" class=""><span class="uiIconText"><i class="sx_a35373 sp_8noqk7 img">
                    </i>Update Status<i class=""> </i></span></a></li>
                    <li class=""><a href="javascript:void(0);" class="" onclick="performClick();" id="ancUploadImage"
                        style="color: #3B5998;"><span class="uiIconText"><i class="sx_48da95 sp_5t1i4q img">
                        </i>Add Photos<i class=""> </i></span></a><a href="javascript:void(0);" onclick="releaseUploadedFile();"
                            id="ancDelete" style="display: none; color: #3B5998;"><span class="uiIconText"><i
                                class="sx_48da95 sp_5t1i4q img"></i>Delete Image <i class=""></i></span><span>
                                    <img src="" alt="" /></span> </a></li>
                </ul>
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
            <div id="divFeeds" class="feeds">
            </div>
        </div>
        <asp:HiddenField ID="hdnUserName" runat="server" />
        <asp:HiddenField ID="hdnUserImagePath" runat="server" />
        <asp:HiddenField ID="hdnUserImage" runat="server" />
        <input type="hidden" id="hdnCurrentStatusId" value="" />
        <input type="hidden" id="hdnCurrentCommentId" value="" />
        <input type="hidden" id="hdnCurrentComment" value="" />
        <input type="hidden" id="hdnSelectedUserId" runat="server" value="" />
        <script type="text/javascript">
            var ImagePath = "<%= path %>";
            var LoggedInUserId = '<%= LoggedInUserId %>';
            var SelectedUserId = '<%= SelectedUserId %>';

            var updawardimg = '<%=updawardimg.ClientID %>';
            var hdnUserImage = '<%=hdnUserImage.ClientID %>';
            var hdnUserName = '<%=hdnUserName.ClientID %>';
            var hdnSelectedUserId = '<%=hdnSelectedUserId.ClientID %>';
            var hdnUserImagePath = '<%=userimagepath %>';
            $("#" + hdnSelectedUserId).val('<%=SelectedUserId %>');
        </script>
    </div>
</asp:Content>
