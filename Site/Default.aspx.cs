using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using Yuvaas;
using System.Web.Security;
//using ASPNETChatControl;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    public string Path = ConfigurationManager.AppSettings["Path"].ToString();

    /// <summary>
    /// Function : Page_Load
    /// Description :This is the  pageload function 
    /// Inputs : sender, eventArgs
    /// <return>
    /// output : N/A
    /// </return>
    /// </summary>
    /// 
    protected void Page_Load(object sender, EventArgs e)
    {
        //IEnumerable<MembershipUser> list = Membership.GetAllUsers().Cast<MembershipUser>();
        //if (list != null)
        //{
        //    int count = list.Count();
        //}
        //this.ClientTarget = "uplevel";
        //if (!IsPostBack)
        //{
        //    Session.Abandon();
        //    Session.Clear();
        //    LoadCookie();
        //}

        Response.Redirect("Pages/Register.aspx");
    }

    /// <summary>
    /// Function : ancLogin_click
    /// Description :This is the User Defined Function for Checking Login User
    /// Inputs : sender, eventArgs
    /// <return>
    /// output : N/A
    /// </return>
    /// </summary>
    protected void ancLogin_click(object sender, EventArgs e)
    {
        User objUser = new UserFacade().CheckLogin(txtUserName.Text.Trim(), txtPassword.Text.Trim());
        if (objUser != null)
        {
            SessionManager.LoggedInUser = objUser;

            Session["LoginId"] = objUser.LoginId;
            Session["UserId"] = objUser.UserId;
            Session["Name"] = objUser.FirstName + " " + objUser.LastName;
            if (chkRememberme.Checked == true)
                SaveLoginCookie();
            else
                DeleteLoginCookie();

            //if (ChatControl.CurrentChatSession != null)
            //{
            //    ChatControl.StopSession();
            //}

            //ChatControl.StartSession(SessionManager.LoggedInUser.LoginId, SessionManager.LoggedInUser.FirstName + " " + SessionManager.LoggedInUser.LastName, SessionManager.LoggedInUser.UserImage);

            Response.Redirect("Pages/NewsFeed.aspx");
        }
        else
        {
            lblErrMsg.Text = "Invalid User.";
        }
    }

    #region Cookies
    /// <summary>
    /// Procedure Name - SaveLoginCookie
    /// Procedure Type - User Defined Function
    /// Return Type - Void
    /// Parameters - Void
    /// Description - This is the User Defined Function for Saving LoginCookoie
    /// </summary>
    private void SaveLoginCookie()
    {
        HttpCookie cookie = new HttpCookie("YuvaasUsers");
        cookie.Values.Add("UserName", txtUserName.Text);
        cookie.Expires = DateTime.Now.AddDays(14);
        Response.Cookies.Add(cookie);
    }

    /// <summary>
    /// Procedure Name - DeleteLoginCookie
    /// Procedure Type - User Defined Function
    /// Return Type - Void
    /// Parameters - Void
    /// Description - This is the User Defined Function for deleting LoginCookoie
    /// </summary>
    private void DeleteLoginCookie()
    {
        HttpCookie cookie = Request.Cookies["YuvaasUsers"];
        if (cookie != null)
        {
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);
        }
    }

    /// <summary>
    /// Procedure Name - LoadCookie
    /// Procedure Type - User Defined Function
    /// Return Type - Void
    /// Parameters - Void
    /// Description - This is the User Defined Function for Loading Cookie
    /// </summary>
    private void LoadCookie()
    {
        HttpCookie cookie = Request.Cookies["YuvaasUsers"];
        if (Request.Cookies["YuvaasUsers"] == null)
        {
            if (Request["UserName"] != null)
                txtUserName.Text = Request["UserName"].ToString();
            else
                txtUserName.Focus();
        }
        else
        {
            txtUserName.Text = cookie.Values.Get("UserName");
            chkRememberme.Checked = true;
        }
    }

    #endregion
}