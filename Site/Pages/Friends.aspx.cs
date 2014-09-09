using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;

public partial class Pages_Friends : BasePage
{
    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Friends;
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
        {
        }
        else
            Response.Redirect("../Default.aspx");
    }

    /// <summary>
    /// Function : GetAllUsersExcludingFriends
    /// Description : Get All Users except Friends
    /// Inputs : UserId
    /// <return>
    /// output : User[]
    /// </return>
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static User[] GetAllNonFriends(string timestamp, string SearchString)
    {
        IList<User> objUsers = null;
        try
        {
            if (SearchString != "1=1")
                SearchString = "FirstName like '%" + SearchString + "%' OR LastName like '%" + SearchString + "%'";
            objUsers = new UserFacade().GetAllUsersExcludingFriends(new Guid(HttpContext.Current.Session["UserId"].ToString()), 0, 20, SearchString, "FirstName ASC");
        }
        catch
        { }
        return objUsers != null ? objUsers.ToArray() : null;
    }

    /// <summary>
    /// Function : GetNonFriends
    /// Description : Get All Users except Friends
    /// Inputs : UserId
    /// <return>
    /// output : User[]
    /// </return>
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static User[] GetFriends(string timestamp)
    {
        IList<User> objUsers = null;
        try
        {
            objUsers = new List<User>();
            objUsers = new UserFacade().GetAllFriendsByUserId(new Guid(HttpContext.Current.Session["UserId"].ToString()));
        }
        catch
        { }
        return objUsers != null ? objUsers.ToArray() : null;
    }

    /// <summary>
    /// Function : GetAllUsersExcludingFriends
    /// Description : Get All Users except Friends
    /// Inputs : UserId
    /// <return>
    /// output : User[]
    /// </return>
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static User[] GetAllFriendRequests(string timestamp)
    {
        IList<User> objUsers = null;
        try
        {
            objUsers = new List<User>();
            objUsers = new UserFacade().GetAllFriendRequests(new Guid(HttpContext.Current.Session["UserId"].ToString()));
        }
        catch
        { }
        return objUsers != null ? objUsers.ToArray() : null;
    }

    /// <summary>
    /// Function : AddFirend
    /// Description : Get All Users except Friends
    /// Inputs : UserId
    /// <return>
    /// output : User[]
    /// </return>
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static int AddFriend(string FId)
    {
        int retVal = 0;
        try
        {
            Friend objFriend = new Friend();
            objFriend.UserId = new Guid(HttpContext.Current.Session["UserId"].ToString());
            objFriend.FriendUserId = new Guid(FId);
            objFriend.IsAccepted = false;
            objFriend.IsMailSent = true;
            objFriend.IsBlocked = false;
            objFriend.IsRead = false;
            retVal = new FriendFacade().Insert(objFriend);
        }
        catch
        { }
        return retVal;
    }

    /// <summary>
    /// Function : AcceptFriend
    /// Description : Get All Users except Friends
    /// Inputs : UserId
    /// <return>
    /// output : User[]
    /// </return>
    /// </summary>
    [WebMethod(EnableSession = true)]
    public static int AcceptFriend(string UserId, string FriendUserId)
    {
        int retVal = 0;
        try
        {
            retVal = new FriendFacade().AcceptFriend(new Guid(UserId), new Guid(FriendUserId));
        }
        catch
        { }
        return retVal;
    }
}