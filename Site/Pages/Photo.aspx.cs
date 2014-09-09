using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;

public partial class Pages_Photo : BasePage
{
    public string path = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/Images/";

    public string userimagepath = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/ProfileImages/";

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
            GetAll();
        }
        else
            Response.Redirect("../Default.aspx");
    }
    public void GetAll()
    {
        //IList<Photo> objPhoto = new List<Photo>();
        //var photos = new PhotoFacade().SelPostsForTimeLine(new Guid(UserId));
        IList<Status> objStatus = new List<Status>();
        var status = new StatusFacade().SelPhotosOnly(new Guid(UserId));
        if (status != null)
            objStatus = (status.ToList());
        rptPhotos.DataSource = objStatus;
        rptPhotos.DataBind();
    }

    //[WebMethod]
    //public static int InsertPhoto(Photo objPhoto)
    //{
    //    objPhoto.UserId = new Guid(UserId);
    //    objPhoto.PermissionId = 4;
    //    return new PhotoFacade().InsertPhoto(objPhoto);
    //}
    //[WebMethod(EnableSession = true)]
    //public static int DeletePhoto(string PhotoId)
    //{
    //    Photo objPhoto = new Photo();
    //    objPhoto.PhotoId = new Guid(PhotoId);
    //    return (new PhotoFacade().DeletePhoto(objPhoto.PhotoId));
    //}

    [WebMethod(EnableSession = true)]
    public static int DeletePost(string StatusId)
    {
        return new StatusFacade().DeleteStatus(new Guid(StatusId));
    }
}