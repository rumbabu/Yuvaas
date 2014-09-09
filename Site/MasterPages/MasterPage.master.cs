using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Services;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;

public partial class MasterPages_MasterPage : System.Web.UI.MasterPage
{
    public string Path = ConfigurationManager.AppSettings["Path"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        SetMainTabs();
        if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
        {
            lnkUserName.InnerHtml = SessionManager.LoggedInUser.FirstName + " " + SessionManager.LoggedInUser.LastName;
            imgUser.Src = "../getImage.aspx?image=Data/ProfileImages/" + SessionManager.LoggedInUser.UserImage + "&height=30&width=30&Aspect=true&type=0"; ;
        }
    }

    private void SetMainTabs()
    {
        try
        {
            BasePage objBasePage = (BasePage)this.Page;
            if (objBasePage != null)
            {
                liUserProfile.Attributes.Add("class", "");
                liMessage.Attributes.Add("class", "");
                liFriends.Attributes.Add("class", "");
                liHome.Attributes.Add("class", "");
                switch (objBasePage.CurrentModule)
                {
                    case PageModule.Profile:
                        {
                            liUserProfile.Attributes.Add("class", "menusel");
                            liProfile.Attributes.Add("class", "menusel");
                            break;
                        }
                    case PageModule.Message:
                        {
                            liMessage.Attributes.Add("class", "menusel");
                            break;
                        }
                    case PageModule.Friends:
                        {
                            liFriends.Attributes.Add("class", "menusel");
                            break;
                        }
                    case PageModule.Home:
                        {
                            liHome.Attributes.Add("class", "menusel");
                            break;
                        }
                    default: { break; }
                }
            }
        }
        catch
        { }
    }
}
