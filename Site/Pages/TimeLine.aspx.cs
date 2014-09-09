using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;

public partial class Pages_TimeLine : BasePage
{
    public string path = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/Images/";

    public string userimagepath = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/ProfileImages/";

    public static string LoggedInUserId = "";

    public static string SelectedUserId = "";

    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Wall;
        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
        {
            LoggedInUserId = SessionManager.LoggedInUser.UserId.ToString();

            if (Request["UserId"] != null)
            {
                SelectedUserId = Request["UserId"].ToString();
                User objUser = new UserFacade().GetProfileByUserId(new Guid(SelectedUserId));
                if (objUser != null)
                {
                    hdnUserImage.Value = objUser.UserImage;
                    hdnUserName.Value = objUser.FirstName + " " + objUser.LastName;
                }
            }
            else
            {
                SelectedUserId = Session["UserId"].ToString();
                hdnUserImage.Value = SessionManager.LoggedInUser.UserImage;
                hdnUserName.Value = Session["Name"].ToString();
            }
        }
        else
            Response.Redirect("../Default.aspx");
    }

    [WebMethod(EnableSession = true)]
    public static IList<Status> GetAllStatusListByUserId()
    {
        return new StatusFacade().SelPostsForWall(new Guid(LoggedInUserId), new Guid(SelectedUserId));
    }

    [WebMethod(EnableSession = true)]
    public static object SelPostsForWallByPaging(string LoggedInUserId, string SelectedUserId, string searchStriing, string sortBy, int startIndex, int pageSize)
    {
        int count = 0;
        IList<Status> ObjStatus = new StatusFacade().SelPostsForWallByPaging(new Guid(LoggedInUserId), new Guid(SelectedUserId), searchStriing, sortBy, startIndex, pageSize, out count);
        return new { ObjStatus = ObjStatus, count = count };
    }

    [WebMethod(EnableSession = true)]
    public static List<Status> GetStatusByUserId(string SortBy, string SearchString, int PageSize, int CurrentPageIndex)
    {
        return new StatusFacade().SelAllByPaging(SortBy, SearchString, PageSize, CurrentPageIndex).ToList();
    }

    [WebMethod]
    public static string InsertStatus(Status objStatus)
    {
        objStatus.StatusId = Guid.NewGuid();
        objStatus.PermissionId = 4;
        if (new StatusFacade().InsertStatus(objStatus) > 0)
        {
            return objStatus.StatusId.ToString();
        }
        else
        {
            return "";
        }
    }

    [WebMethod]
    public static Guid InsertComment(Comment objComment)
    {
        objComment.UserId = new Guid(LoggedInUserId);
        return new CommentFacade().InsertComment(objComment);
    }

    [System.Web.Services.WebMethod]
    public static Guid InsertStatusLike(Like objLike)
    {
        objLike.UserId = new Guid(LoggedInUserId);
        return new LikeFacade().InsertLike(objLike);
    }

    [System.Web.Services.WebMethod]
    public static Guid InsertCommentLike(CommentLike objCommentLike)
    {
        objCommentLike.UserId = new Guid(LoggedInUserId);
        return new CommentLikeFacade().InsertCommentLike(objCommentLike);
    }

    [WebMethod]
    public static int SharePost(string StatusId, string StatusName, string UserId, string Image)
    {
        Status objStatus = new Status();
        objStatus.StatusName = StatusName;
        objStatus.UserId = new Guid(UserId);
        objStatus.StatusUrl = Image;
        objStatus.PermissionId = 4;
        objStatus.StatusType = "image";
        objStatus.IsHidden = false;
        objStatus.ISArchived = false;
        objStatus.IsShared = true;
        return new StatusFacade().SharePost(objStatus);
    }
}