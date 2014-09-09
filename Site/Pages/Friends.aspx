<%@ Page Title="Yuvaas Social - Friends" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Friends.aspx.cs" Inherits="Pages_Friends" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <script src="../Js/Friends.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userid = '<%= Session["UserId"].ToString().ToLower() %>';
    </script>
    <div class="innerright">
        <div class="wallinner">
            <div class="btn_silvernnnn">
                <a id="ancfrndReq" onclick="return BindFriendRequests();">Colleague Requests</a>
                <a id="ancNoFriends" class="frndsel" onclick="return BindNonFriends();">Find Colleagues</a>
                <a style="border: none;" id="ancFriends" onclick="return BindFriends();">Colleagues</a>
            </div>
            <div class="ppmain">
                <div class="wid100p" id="divSearch">
                    <div class="formmain">
                        
                        <div class="nametextfield">
                            <input id="txtSearchFriends" placeholder="search" /></div>
                    </div>
                    <a class="searchfrnd" id="ancSearch" onclick="return SearchFriends();">Search</a>
                </div>
                <div id="divFriends">
                </div>
                <div class="norecords" style="display: none;">
                    <asp:Label ID="lblNoRecords" runat="server">No Records Found.</asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
