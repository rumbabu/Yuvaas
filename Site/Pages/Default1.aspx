<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default1.aspx.cs" Inherits="_Default1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div>
    <script language="javascript" type="text/javascript">
        function popup() {
            var a = window.open("chating.aspx", 'width=250,height=500,left=350,top=120')
        }
    </script>
    
    </div>
    <asp:TextBox ID="TextBox1" runat="server" Height="72px" TextMode="MultiLine"></asp:TextBox>
    <br />
    <br />
    Nickname:<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br />
    <br />
    Message:<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
    </form>
</body>
</html>
