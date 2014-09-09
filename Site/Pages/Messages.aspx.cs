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

public partial class Pages_Messages : BasePage
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
            //BindMembers();
            //Bind Inbox Messages
            GetAllMessagesForInbox();
        }
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

    /// <summary>
    /// Function : GetAllMessageByToUserId
    /// Inputs : N/A
    /// Output : N/A
    /// Description : Get All Messages for inbox
    /// </summary>
    void GetAllMessagesForInbox()
    {
        MessageDetails objMessageDetails = new MessageFacade().GetAllMessagesForInbox(0, 1000, "1=1", "CreatedOn Desc", new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessageDetails != null && objMessageDetails.MessageList.Count > 0)
        {
            divMessages.Style["display"] = "block";
            divSettings.Style["display"] = "block";
            divNoMessages.Style["display"] = "none";
            rptMessages.DataSource = objMessageDetails.MessageList;
        }
        else
        {
            divSettings.Style["display"] = "none";
            divMessages.Style["display"] = "none";
            divNoMessages.Style["display"] = "block";
            rptMessages.DataSource = null;
        }
        rptMessages.DataBind();
    }


    #region [WebMethods]

    [WebMethod]
    public static int InsertMessage(string ToUserNames, string MessageDesc)
    {
        return new MessageFacade().InsertMessage(new Guid(HttpContext.Current.Session["UserId"].ToString()), ToUserNames, MessageDesc);
    }

    [WebMethod]
    public static List<String> GetAllMembers()
    {
        return Membership.GetAllUsers().Cast<MembershipUser>().Select(x => x.UserName).Where(x => x.ToLower() != HttpContext.Current.Session["LoginId"].ToString().ToLower()).ToList();
    }

    [WebMethod]
    public static MessageDetails GetAllMessagesofSent(string Ticks, int StartIndex, int MaxIndex)
    {
        if (StartIndex > 0)
            StartIndex = ((StartIndex) * MaxIndex);
        MessageDetails objMessageDetails = new MessageFacade().GetAllMessagesForSent(StartIndex, MaxIndex, "1=1", "CreatedOn Desc", new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessageDetails != null)
            return objMessageDetails;
        else
            return null;

    }

    [WebMethod]
    public static MessageDetails GetAllMessagesofInbox(string Ticks, int StartIndex, int MaxIndex)
    {
        if (StartIndex > 0)
            StartIndex = ((StartIndex - 1) * MaxIndex);
        MessageDetails objMessageDetails = new MessageFacade().GetAllMessagesForInbox(StartIndex, MaxIndex, "1=1", "CreatedOn Desc", new Guid(HttpContext.Current.Session["UserId"].ToString()));
        if (objMessageDetails != null)
            return objMessageDetails;
        else
            return null;

    }

    [WebMethod]
    public static int DeleteMessage(string Ticks, string MessageId)
    {
        return new MessageFacade().DeleteMessage(MessageId);
    }

    #endregion
}