<%@ Page Title="Yuvaas Social - Profile" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
    AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Pages_Profile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <script src="../Js/Profile.js" type="text/javascript"></script>
    <script src="../js/fusioncharts/FusionCharts.js" type="text/javascript"></script>
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <asp:HiddenField ID="hdnUserId" runat="server" />
    <asp:HiddenField ID="hdnUserEmail" runat="server" />
    <div class="innerright">
        <div class="ppmain">
            <div class="wallinner">
                <div class="grpmain">
                    <div class="profiledesc">
                        <label ID="lblAbout" runat="server">
                            About:
                        </label>
                        <asp:Label ID="lblDesc" runat="server"></asp:Label>
                    </div>
                    <div style="float:left;width:12%;">
                        <img id="imgImage" runat="server" alt="" src="" />
                    </div>
                </div>
                <div class="grpmain">
                    <asp:Repeater ID="rpCharts" runat="server">
                        <ItemTemplate>
                            <asp:Repeater ID="rpChart" runat="server" DataSource='<%#Eval("ReportCharts") %>'
                                OnItemDataBound="rpChart_ItemDataBound">
                                <ItemTemplate>
                                    <div id="divChartContainer" runat="server" style="float: left; width: 99.8%;border-radius:5px 5px 3px 3px;margin: 20px 0 0;padding: 5px 0;border: 1px solid #CCC;">
                                        <div class="chartTitle">
                                            <h3><%#Eval("ChartName") %></h3>
                                        </div>
                                        <asp:HiddenField ID="hdnChartType" runat="server" />
                                        <asp:HiddenField ID="hdnChartContent" runat="server" />
                                        <div id="divChart" runat="server" align="center">
                                        </div>
                                        <asp:Literal ID="litChartScript" runat="server"></asp:Literal>
                                    </div>
                                    <div><img src="../images/btmbdr.png" alt="" /></div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
