<%@ Page Title="Yuvaas Social - user Info" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="UserInfo.aspx.cs" Inherits="Pages_UserInfo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <script src="../Js/Profile.js" type="text/javascript"></script>
    <asp:ScriptManager ID="script" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div class="innerright">
        <div class="ppmain">
            <div class="wallinner">
                <div class="grpmain">
                    <div class="userinfo">
                        <b>Name :</b>
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Email Id :</b>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Gender :</b>
                        <asp:Label ID="lblGender" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>User Code :</b>
                        <asp:Label ID="lblUserCode" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Designation :</b>
                        <asp:Label ID="lblDesignation" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Works at :</b>
                        <asp:Label ID="lblWorksAt" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Description :</b>
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Studied at :</b>
                        <asp:Label ID="lblStudiedAt" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Date of Birth :</b>
                        <asp:Label ID="lblDOB" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Address :</b>
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>City :</b>
                        <asp:Label ID="lblCity" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>State :</b>
                        <asp:Label ID="lblState" runat="server"></asp:Label>
                    </div>
                    <div class="userinfo">
                        <b>Country :</b>
                        <asp:Label ID="lblCountry" runat="server"></asp:Label>
                    </div>
                    <div class="wid100p">
                        <a class="btn_silver" id="ancEdit" runat="server" href="EditProfile.aspx">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnUserId" runat="server" />
    <asp:HiddenField ID="hdnUserEmail" runat="server" />
</asp:Content>
