using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using Yuvaas;

namespace SRChat
{
    public partial class Pages_NewsFeed : BasePage
    {
        public string path = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/Images/";

        public string userimagepath = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/ProfileImages/";

        public int MaxRecords
        {
            set { ViewState["MaxRecords"] = value; }
            get { return CommonFunctions.getIntValue(ViewState["MaxRecords"]); }
        }

        public static string UserId = "";

        public static string LoggedInUserId = "";

        protected override void OnInit(EventArgs e)
        {
            CurrentModule = PageModule.Home;
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
            {
                LoggedInUserId = SessionManager.LoggedInUser.UserId.ToString();
                hdnUserImage.Value = SessionManager.LoggedInUser.UserImage;
                UserId = Session["UserId"].ToString();
                hdnUserName.Value = Session["Name"].ToString();
                MaxRecords = new StatusFacade().SelNewsFeedCount(new Guid(Session["UserId"].ToString()));
            }
            else
                Response.Redirect("../Default.aspx");
        }

        [WebMethod(EnableSession = true)]
        public static IList<Status> GetAllStatusListByUserId()
        {
            //return new CommentFacade().SelPostsForWall(new Guid(UserId)).ToList();
            return new StatusFacade().SelPostsForTimeLine(new Guid(UserId)).ToList();
        }

        [WebMethod(EnableSession = true)]
        public static IList<Status> GetNewsFeedByUserId(string UserId, int PageSize, int CurrentPageIndex)
        {
            return new StatusFacade().SelNewsFeedByPaging(new Guid(UserId), PageSize, CurrentPageIndex).ToList();
        }

        [WebMethod(EnableSession = true)]
        public static int GetNewsFeedCount(string UserId, int PageSize, int CurrentPageIndex)
        {
            return new StatusFacade().SelNewsFeedCount(new Guid(UserId));
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
            objStatus.UserId = new Guid(UserId);
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
            objComment.UserId = new Guid(UserId);
            return new CommentFacade().InsertComment(objComment);
        }

        [System.Web.Services.WebMethod]
        public static Guid InsertStatusLike(Like objLike)
        {
            objLike.UserId = new Guid(UserId);
            return new LikeFacade().InsertLike(objLike);
        }

        [System.Web.Services.WebMethod]
        public static Guid InsertCommentLike(CommentLike objCommentLike)
        {
            objCommentLike.UserId = new Guid(UserId);
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

        [WebMethod(EnableSession = true)]
        public static NotificationDetails GetAllNotifications(string Ticks, int StartIndex, int MaxIndex)
        {
            if (StartIndex > 0)
                StartIndex = ((StartIndex) * MaxIndex);
            NotificationDetails objNotificationDetails = new NotificationFacade().GetNotifications(StartIndex, MaxIndex);
            if (objNotificationDetails != null)
            {
                return objNotificationDetails;
            }
            else
            {
                return null;
            }
        }

        [WebMethod(EnableSession = true)]
        public static CommentDetails GetLatestCommentsByStatusId(string Ticks, string StatusId)
        {
            CommentDetails objCommentDetails = new CommentFacade().SelLatestCommentsByStatusId(new Guid(StatusId));
            if (objCommentDetails != null)
            {
                return objCommentDetails;
            }
            else
            {
                return null;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string DeletePost(string StatusId)
        {
            if (new StatusFacade().DeleteStatus(new Guid(StatusId)) > 0)
            {
                return StatusId;
            }
            else
            {
                return "";
            }
        }

        [WebMethod(EnableSession = true)]
        public static int DeleteComment(string CommentId)
        {
            return new CommentFacade().DeleteComment(new Guid(CommentId));
        }
    }
}