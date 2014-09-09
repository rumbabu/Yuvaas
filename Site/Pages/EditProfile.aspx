<%@ Page Title="Yuvaas Social - Profile" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="Pages_EditProfile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <script src="../Js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        var txtDOB = "<%=txtDOB.ClientID %>";
        var hdnDate = "<%=hdnDate.ClientID %>";
        var txtFirstName = "<%=txtFirstName.ClientID %>";
        var rbMale = "<%=rbMale.ClientID %>";
        var rbFemale = "<%=rbFemale.ClientID %>";
        var txtAbout = "<%=txtAbout.ClientID %>";
        var lblErrMsg = "<%=lblErrMsg.ClientID %>";
        var ImagePath = "<%=userimagepath %>";
        var updawardimg = '<%=updawardimg.ClientID %>';
        var hdnImage = "<%=hdnImage.ClientID %>";
        var imgUser = "<%=imgUser.ClientID %>";
        $(document).ready(function () {
            $("#" + txtDOB).datepicker({ changeMonth: true, changeYear: true, dateFormat: "mm/dd/yy",
                onSelect: function (datestr) { $("#" + hdnDate).val(datestr); }
            });
        });
    </script>
    <script src="../Js/EditProfile.js" type="text/javascript"></script>
    <div class="innerright">
        <div class="ppmain" style="padding: 1.5em 2%;">
            <div class="wallinner">
                <div class="grpmain">
                    <div class="error">
                        <asp:Label ID="lblErrMsg" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                   
                        <div class="addfirstname">
                            <span>First Name: </span>
                            <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" MaxLength="100"></asp:TextBox>
                        </div>                    
                        <div class="addfirstname">
                            <span>Last Name: </span>
                                <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" MaxLength="100"></asp:TextBox>
                        </div> 
                        <div class="addfirstname">
                            <span>Email: </span>
                                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" MaxLength="250"></asp:TextBox>
                        </div>
                        <div class="addgendermain">
                            <span>Gender: </span>
                                <span class="addgender"><asp:RadioButton ID="rbMale" runat="server" Text="Male" /> 
                                    <asp:RadioButton ID="rbFemale" runat="server" Text="Female" /></span>
                        </div>          
                        <div class="formmain mrg_addimg">
                            <asp:Image ID="imgUser" runat="server" />
                            <asp:HiddenField ID="hdnImage" runat="server" />
                            <a id="ancChangeImg" onclick="performClick();">Change Image</a>
                            <asp:FileUpload size="1" Style="visibility: hidden;" ID="updawardimg" name="updawardimg"
                                onchange="return ajaxFileUploader();" runat="server" accept="image/*" />
                        </div>
                        <div class="addfirstname">
                            <span>Designation: </span>
                                <asp:TextBox ID="txtDesignation" runat="server" placeholder="Designation" MaxLength="200"></asp:TextBox>
                        </div>    
                        <div class="addfirstname">
                            <span>User Code: </span>
                                <asp:TextBox ID="txtUserCode" runat="server" MaxLength="20"></asp:TextBox>
                            
                        </div>
                        <div class="addfirstname">
                            <span>Company: </span>
                                <asp:TextBox ID="txtWorkAt" runat="server" placeholder="Work At" MaxLength="400"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>DOB: </span>
                                <asp:TextBox ID="txtDOB" runat="server" placeholder="Date of Birth" ReadOnly="true"
                                    onkeypress="return false;"></asp:TextBox>
                            <asp:HiddenField ID="hdnDate" runat="server" />
                        </div>
                        <div class="addfirstname">
                            <span>About: </span>
                                <asp:TextBox ID="txtAbout" runat="server" placeholder="About" CssClass="abouttextarea"
                                    TextMode="MultiLine" Height="50"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>Description: </span>
                                <asp:TextBox ID="txtDescription" runat="server" placeholder="Description" CssClass="abouttextarea"
                                    TextMode="MultiLine" Height="50"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>College: </span>
                                <asp:TextBox ID="txtCollegeAt" runat="server" placeholder="College At" MaxLength="400"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>School: </span>
                                <asp:TextBox ID="txtSchoolAt" runat="server" placeholder="School At" MaxLength="400"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>Address: </span>
                                <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" MaxLength="500"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>City: </span>
                                <asp:TextBox ID="txtCity" runat="server" placeholder="City" MaxLength="200"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>State: </span>
                                <asp:TextBox ID="txtState" runat="server" placeholder="State" MaxLength="200"></asp:TextBox>
                        </div>
                        <div class="addfirstname">
                            <span>Country: </span>
                                <asp:TextBox ID="txtCountry" runat="server" placeholder="Country" MaxLength="200"></asp:TextBox>
                        </div>
                        <div class="addreports">
                            <span>Reports: </span>
                                <asp:CheckBoxList ID="cblDashboardWidgets" runat="server" RepeatColumns="1" RepeatDirection="Vertical" class="addcheckboxs">
                                </asp:CheckBoxList>
                           
                        </div>
                 
                    <div class="wid100p">
                        <asp:LinkButton ID="lnkUpdate" runat="server" CssClass="btn_silver" OnClientClick="return Validate();"
                            OnClick="lnkUpdate_Click">Update</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
