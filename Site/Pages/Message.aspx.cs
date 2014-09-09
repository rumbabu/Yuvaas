using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using System.Web.Security;

public partial class Pages_Message : BasePage
{
    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Message;
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Bind Members in Network
            BindMembers();
            //Bind Messages
            BindAllRecentMessages();
            //Get All Messages By User
            BindMessagesByUser();
        }
    }

    void BindAllRecentMessages()
    {
        IList<Message> objMessages = new MessageFacade().SelAllFromUserId(new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessages != null && objMessages.Count > 0)
        {
            divMessages.Style["display"] = "block";
            divNoMessages.Style["display"] = "none";
            rptMessages.DataSource = objMessages;
        }
        else
        {
            divMessages.Style["display"] = "none";
            divNoMessages.Style["display"] = "";
            rptMessages.DataSource = null;
        }
        rptMessages.DataBind();
    }

    void BindMessagesByUser()
    {
        IList<Message> objMessages = new MessageFacade().SelMessagesForDefaultUser(new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessages != null && objMessages.Count > 0)
        {
            divUserMessages.Style["display"] = "block";
            divNoUserMessages.Style["display"] = "none";
            rptUserMessages.DataSource = objMessages;
        }
        else
        {
            divUserMessages.Style["display"] = "none";
            divNoUserMessages.Style["display"] = "block";
            rptUserMessages.DataSource = null;
        }
        rptUserMessages.DataBind();
    }

    /// <summary>
    /// Function : BindMembers
    /// Inputs : N/A
    /// Output : N/A
    /// Description : Get All Members in network
    /// </summary>
    void BindMembers()
    {
        IEnumerable<MembershipUser> list = Membership.GetAllUsers().Cast<MembershipUser>().Where(x => x.UserName.ToString().ToLower() != Session["LoginId"].ToString().ToLower());
        ddlMembers.DataSource = list;
        ddlMembers.DataBind();
    }

    [WebMethod]
    public static int InsertMessage(string ToUserNames, string MessageDesc)
    {
        return new MessageFacade().InsertMessage(new Guid(HttpContext.Current.Session["UserId"].ToString()), ToUserNames, MessageDesc);
    }

    [WebMethod]
    public static IList<Message> GetAllRecentMessages()
    {
        IList<Message> objMessages = new MessageFacade().SelAllFromUserId(new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessages != null)
            return objMessages;
        else
            return null;
    }

    [WebMethod]
    public static IList<Message> GetMessagebyToUserId(string ToUserId)
    {
        IList<Message> objMessages = new MessageFacade().SelAllToUserId(new Guid(HttpContext.Current.Session["UserId"].ToString()), new Guid(ToUserId));
        if (objMessages != null)
            return objMessages;
        else
            return null;
    }

    [WebMethod]
    public static List<String> GetAllMembers()
    {
        return Membership.GetAllUsers().Cast<MembershipUser>().Select(x => x.UserName).Where(x => x.ToLower() != HttpContext.Current.Session["LoginId"].ToString().ToLower()).ToList();
    }
}