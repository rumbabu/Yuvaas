<%@ Page Title="Yuvaas Social - Photo" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Photo.aspx.cs" Inherits="Pages_Photo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <link rel="stylesheet" href="../Css/prettyPhoto.css?v=1.1" />
    <script src="../Js/Photo.js" type="text/javascript"></script>
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="../Js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <div class="innerright">
        <div class="wallinner">
            <ul class="photos">
                <asp:Repeater ID="rptPhotos" runat="server">
                    <ItemTemplate>
                        <li onmouseover='<%# "return showactions(" + Container.ItemIndex +");" %>' onmouseout='<%# "return hideactions(" + Container.ItemIndex +");" %>'>
                            <div class="imgdelete">
                                <a class="dn" id="<%# "deletestatus_" + Container.ItemIndex %>" onclick='<%# "deletestatus(\"" + Eval("StatusId").ToString() +"\");" %>'>
                                    <img src="../Images/imgdelete.png" width="20px;" height="20px;" /></a>
                                <a class="dn" style="margin-top: 164px; color: #fff; float: left; width: 50%; text-align: left;"
                                    id="<%# "lblName_" + Container.ItemIndex %>">
                                    <%#Eval("StatusName") %></a>
                            </div>
                            <div class="imggallery">
                                <img alt="photo" id="imgStatus" src='<%# "../Data/Images/"+Eval("StatusUrl") %>'
                                    runat="server" /></div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <asp:HiddenField ID="hdnUserName" runat="server" />
    <asp:HiddenField ID="hdnUserImagePath" runat="server" />
    <asp:HiddenField ID="hdnUserImage" runat="server" />
    <input type="hidden" id="hdnCurrentStatusId" value="" />
    <input type="hidden" id="hdnCurrentCommentId" value="" />
    <input type="hidden" id="hdnCurrentComment" value="" />
    <script type="text/javascript">
        var ImagePath = "<%=path %>";
        var hdnUserImage = '<%=hdnUserImage.ClientID %>';
        var hdnUserName = '<%=hdnUserName.ClientID %>';
        var hdnUserImagePath = '<%=userimagepath %>';
        var LoggedInUserId = '<%=LoggedInUserId %>';
    </script>
</asp:Content>
