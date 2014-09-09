<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CachingDependencyTables.aspx.cs"
    Inherits="Caching_CachingDependencyTables" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100%; float: left;">
        <div style="width: 23%; float: left; margin-right: 15px; background-color: #f2fcf1;
            border: 1px solid #bcdbb9; margin-top: 10px; border-radius: 5px; -moz-border-radius: 5px;
            -webkit-border-radius: 5px;">
            <table style="margin-top: 2px; float: left; margin-bottom: 15px; min-width: 260px;"
                align="left">
                <tr>
                    <td colspan="2" style="padding-left: 12px;">
                        <span style="font-weight: bold;">
                            <asp:Label ID="enabledTablesMsg" runat="server" Text="Tables enabled for change notification:" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 12px;">
                        <asp:ListBox ID="enabledTables" runat="server" SelectionMode="multiple" Style="width: 280px;
                            height: 400px; overflow-y: scroll;"></asp:ListBox>
                        <br />
                        <asp:Button ID="disableTable" runat="server" Text="Remove Notification For Selected Table(s)"
                            Style="margin-top: 15px;" OnClick="disableTable_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 100px;">
            <table style="margin-top: 15px; margin-bottom: 15px; background-color: #f2fcf1; height: 100px;
                width: 325px; border: 1px solid #bcdbb9; margin-top: 10px; border-radius: 5px;
                -moz-border-radius: 5px; -webkit-border-radius: 5px;">
                <tr>
                    <td colspan="2">
                        <span style="font-weight: bold; padding-left: 25px;">Database support for change notifications:</span>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="enableNotification" runat="server" Text="On" Style="width: 75px;"
                            OnClick="enableNotification_Click" />
                    </td>
                    <td align="center">
                        <asp:Button ID="disableNotification" runat="server" Text="Off" Style="width: 75px;"
                            OnClick="disableNotification_Click" />
                    </td>
                </tr>
            </table>
            <div style="margin: 15px 25px 15px 25px; height: 3px; background-color: #EEEEEE;
                width: 17%;">
            </div>
            <table style="margin-top: 2px; margin-bottom: 15px; background-color: #f2fcf1; height: 100px;
                width: 325px; border: 1px solid #bcdbb9; margin-top: 10px; border-radius: 5px;
                -moz-border-radius: 5px; -webkit-border-radius: 5px;">
                <tr>
                    <td colspan="2">
                        <span style="font-weight: bold; width: 200px; padding-left: 25px;">
                            <asp:Label ID="tableEnableMsg" runat="server" Text="Enable change notification on table:" /></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="tableName" runat="server" Style="height: 22px; border: 1px solid #bbb;
                            border-radius: 3px; -moz-border-radius: 3px; -webkit-border-radius: 3px; box-shadow: inset 1px 1px 2px 0 #ebebeb;
                            -moz-box-shadow: inset 1px 1px 2px 0 #ebebeb; -webkit-box-shadow: inset 1px 1px 2px 0 #ebebeb;
                            font-size: 13px; padding: 0 5px; width: 250px;" /><br />
                        <asp:Button ID="enableTable" runat="server" Text="Enable Table(s)" Style="margin-top: 15px;
                            width: 120px;" OnClick="enableTable_Click" /><br />
                        <asp:Label ID="enableTableErrorMsg" runat="server" Visible="false" Width="250px"
                            ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
