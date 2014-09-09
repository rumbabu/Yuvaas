using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using Yuvaas;

public partial class UserControls_UserProfile : System.Web.UI.UserControl
{
    public string Path = ConfigurationManager.AppSettings["Path"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        BasePage objBasePage = (BasePage)this.Page;
        if (objBasePage != null)
        {
            string PageModule = objBasePage.CurrentModule.ToString();
            if (PageModule.ToLower() == "wall")
            {
                if (Request["UserId"] != null && CommonFunctions.GetStringValue(Request["UserId"]) != null)
                {
                    string UserId = CommonFunctions.GetStringValue(Request["UserId"]);
                    User objUser = new UserFacade().GetProfileByUserId(new Guid(UserId));
                    if (objUser != null)
                    {
                        imgProgile.Src = "../getImage.aspx?image=Data/ProfileImages/" + objUser.UserImage + "&height=80&width=80&Aspect=true&type=1&bgc=FFFFFF";
                        lblName.Text = objUser.FirstName + " " + objUser.LastName;
                        lblGender.Text = objUser.Gender == "1" ? "Male" : "Female";
                        lblCity.Text = objUser.City;
                    }
                }
                else
                {
                    if (SessionManager.LoggedInUser != null)
                    {
                        imgProgile.Src = "../getImage.aspx?image=Data/ProfileImages/" + SessionManager.LoggedInUser.UserImage + "&height=80&width=80&Aspect=true&type=1&bgc=FFFFFF";
                        lblName.Text = SessionManager.LoggedInUser.FirstName + " " + SessionManager.LoggedInUser.LastName;
                        lblGender.Text = SessionManager.LoggedInUser.Gender == "1" ? "Male" : "Female";
                        lblCity.Text = SessionManager.LoggedInUser.City;
                        //lblState.Text = objUser.State;
                    }
                }
            }
            else
            {
                if (SessionManager.LoggedInUser != null)
                {
                    imgProgile.Src = "../getImage.aspx?image=Data/ProfileImages/" + SessionManager.LoggedInUser.UserImage + "&height=80&width=80&Aspect=true&type=1&bgc=FFFFFF";
                    lblName.Text = SessionManager.LoggedInUser.FirstName + " " + SessionManager.LoggedInUser.LastName;
                    lblGender.Text = SessionManager.LoggedInUser.Gender == "1" ? "Male" : "Female";
                    lblCity.Text = SessionManager.LoggedInUser.City;
                    //lblState.Text = objUser.State;
                }
            }
        }
        
    }
}