using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using Yuvaas;

public partial class Pages_UserInfo : BasePage
{
    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Profile;
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
        {
            if (Request["UserId"] == null || CommonFunctions.GetStringValue(Request["UserId"]) == CommonFunctions.GetStringValue(Session["UserId"]))
            {
                ancEdit.Style["display"] = "";
                BindUserDetails();
            }
            else
            {
                //ancEdit.Style["display"] = "none";
                //GetUserDetailsById(CommonFunctions.GetStringValue(Request["UserId"]));
                Response.Redirect("Profile.aspx?UserId=" + CommonFunctions.GetStringValue(Request["UserId"]));
            }
        }
        else
            Response.Redirect("../Default.aspx");
    }

    void GetUserDetailsById(string UserId)
    {
        User objUser = new UserFacade().GetProfileByUserId(new Guid(UserId));
        if (objUser != null)
        {
            lblName.Text = objUser.FirstName + " " + objUser.LastName;
            lblEmail.Text = objUser.EmailId == "" ? "-N/A-" : objUser.EmailId;
            lblGender.Text = (objUser.Gender == "1") ? "Male" : "Female";
            lblDescription.Text = objUser.Description == "" ? "-N/A-" : objUser.Description;
            lblStudiedAt.Text = objUser.CollegeAt == "" ? "-N/A-" : objUser.CollegeAt;
            lblDesignation.Text = objUser.Designation == "" ? "-N/A-" : objUser.Designation;
            lblUserCode.Text = String.IsNullOrWhiteSpace(objUser.UserCode) ? "-N/A-" : objUser.UserCode;
            lblWorksAt.Text = objUser.WorkAt == "" ? "-N/A-" : objUser.WorkAt;
            lblDOB.Text = objUser.DOB.ToString("MMM dd, yyyy");
            lblAddress.Text = objUser.Address == "" ? "-N/A-" : objUser.Address;
            lblCity.Text = objUser.City == "" ? "-N/A-" : objUser.City;
            lblState.Text = objUser.State == "" ? "-N/A-" : objUser.State;
            lblCountry.Text = objUser.Country == "" ? "-N/A-" : objUser.Country;
        }
    }

    protected void BindUserDetails()
    {
        if (SessionManager.LoggedInUser != null)
        {
            lblName.Text = SessionManager.LoggedInUser.FirstName + " " + SessionManager.LoggedInUser.LastName;
            lblEmail.Text = SessionManager.LoggedInUser.EmailId == "" ? "-N/A-" : SessionManager.LoggedInUser.EmailId;
            lblGender.Text = (SessionManager.LoggedInUser.Gender == "1") ? "Male" : "Female";
            lblDescription.Text = SessionManager.LoggedInUser.Description == "" ? "-N/A-" : SessionManager.LoggedInUser.Description;
            lblStudiedAt.Text = SessionManager.LoggedInUser.CollegeAt == "" ? "-N/A-" : SessionManager.LoggedInUser.CollegeAt;
            lblDesignation.Text = SessionManager.LoggedInUser.Designation == "" ? "-N/A-" : SessionManager.LoggedInUser.Designation;
            lblUserCode.Text = String.IsNullOrWhiteSpace(SessionManager.LoggedInUser.UserCode) ? "-N/A-" : SessionManager.LoggedInUser.UserCode;
            lblWorksAt.Text = SessionManager.LoggedInUser.WorkAt == "" ? "-N/A-" : SessionManager.LoggedInUser.WorkAt;
            lblDOB.Text = SessionManager.LoggedInUser.DOB.ToString("MMM dd, yyyy");
            lblAddress.Text = SessionManager.LoggedInUser.Address == "" ? "-N/A-" : SessionManager.LoggedInUser.Address;
            lblCity.Text = SessionManager.LoggedInUser.City == "" ? "-N/A-" : SessionManager.LoggedInUser.City;
            lblState.Text = SessionManager.LoggedInUser.State == "" ? "-N/A-" : SessionManager.LoggedInUser.State;
            lblCountry.Text = SessionManager.LoggedInUser.Country == "" ? "-N/A-" : SessionManager.LoggedInUser.Country;
        }
    }
}