using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.BusinessLayer.Facade;
using Yuvaas;

public partial class Pages_EditProfile : BasePage
{
    public string userimagepath = System.Configuration.ConfigurationManager.AppSettings["Path"].ToString() + "Data/ProfileImages/";

    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Profile;
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null && Session["LoginId"] != null && Session["Name"] != null)
        {
            if (!IsPostBack)
            {
                BindUserDetails();
            }
        }
        else
            Response.Redirect("../Default.aspx");
    }

    protected void BindUserDetails()
    {
        if (SessionManager.LoggedInUser != null)
        {
            txtFirstName.Text = SessionManager.LoggedInUser.FirstName;
            txtLastName.Text = SessionManager.LoggedInUser.LastName;
            txtDesignation.Text = SessionManager.LoggedInUser.Designation;
            
            txtUserCode.Text = CommonFunctions.GetStringValue(SessionManager.LoggedInUser.UserCode).Trim();
            txtUserCode.Enabled = String.IsNullOrWhiteSpace(SessionManager.LoggedInUser.UserCode);

            txtEmail.Text = SessionManager.LoggedInUser.EmailId;
            txtWorkAt.Text = SessionManager.LoggedInUser.WorkAt;

            if (SessionManager.LoggedInUser.DOB.ToString("MM/dd/yyyy") == "01/01/0001")
                SessionManager.LoggedInUser.DOB = DateTime.Now;
            
            txtDOB.Text = SessionManager.LoggedInUser.DOB.ToString("MM/dd/yyyy");
            hdnDate.Value = SessionManager.LoggedInUser.DOB.ToString("MM/dd/yyyy");
            hdnImage.Value = SessionManager.LoggedInUser.UserImage;
            
            if (CommonFunctions.getIntValue(SessionManager.LoggedInUser.Gender) == 1)
                rbMale.Checked = true;
            else if (CommonFunctions.getIntValue(SessionManager.LoggedInUser.Gender) == 2)
                rbFemale.Checked = true;
            
            imgUser.ImageUrl = "../getImage.aspx?image=../Data/ProfileImages/" + SessionManager.LoggedInUser.UserImage + "&height=100&width=100&Aspect=true&type=1";
            txtAbout.Text = SessionManager.LoggedInUser.About;
            txtDescription.Text = SessionManager.LoggedInUser.Description;
            txtAddress.Text = SessionManager.LoggedInUser.Address;
            txtCity.Text = SessionManager.LoggedInUser.City;
            txtState.Text = SessionManager.LoggedInUser.State;
            txtCountry.Text = SessionManager.LoggedInUser.Country;
            txtSchoolAt.Text = SessionManager.LoggedInUser.SchoolAt;
            txtCollegeAt.Text = SessionManager.LoggedInUser.CollegeAt;

            BindWidgets();
        }
    }

    protected void BindWidgets()
    {
        List<DashboardWidget> widgets = (new DashboardWidgetFacade()).GetSelected(SessionManager.LoggedInUser.UserId);
        cblDashboardWidgets.DataSource = widgets;
        cblDashboardWidgets.DataTextField = "WidgetName";
        cblDashboardWidgets.DataValueField = "DashboardWidgetId";
        cblDashboardWidgets.DataBind();

        foreach (ListItem item in cblDashboardWidgets.Items)
        {
            item.Selected = widgets.Find(w => w.DashboardWidgetId.ToString() == item.Value).IsSelected;
        }
    }

    protected void lnkUpdate_Click(object sender, EventArgs e)
    {
        int retvalue = 0;
        User objUser = new User();
        objUser.UserId = SessionManager.LoggedInUser.UserId;
        objUser.FirstName = txtFirstName.Text.Trim();
        objUser.LastName = txtLastName.Text.Trim();
        objUser.EmailId = txtEmail.Text.Trim();
        objUser.Designation = txtDesignation.Text.Trim();
        objUser.DOB = Convert.ToDateTime(hdnDate.Value);
        objUser.WorkAt = txtWorkAt.Text.Trim();
        objUser.CollegeAt = txtCollegeAt.Text.Trim();
        objUser.SchoolAt = txtSchoolAt.Text.Trim();
        
        if (rbMale.Checked)
            objUser.Gender = "1";
        else if (rbFemale.Checked)
            objUser.Gender = "2";
        else
            objUser.Gender = "0";

        objUser.UserImage = hdnImage.Value;
        objUser.About = txtAbout.Text.Trim();
        objUser.Description = txtDescription.Text.Trim();
        objUser.Address = txtAddress.Text.Trim();
        objUser.City = txtCity.Text.Trim();
        objUser.State = txtState.Text.Trim();
        objUser.Country = txtCountry.Text.Trim();
        objUser.UserCode = txtUserCode.Text.Trim().ToUpper();
        
        retvalue = new UserFacade().UpdateUser(objUser);

        SaveWidgets();

        if (retvalue > 0)
        {
            SessionManager.LoggedInUser = objUser;
            Response.Redirect("UserInfo.aspx");
        }
    }

    protected void SaveWidgets()
    {
        string widgetIds = "";

        foreach (ListItem item in cblDashboardWidgets.Items)
        {
            if (item.Selected)
                widgetIds += ("," + item.Value);
        }

        (new UserDashboardWidgetFacade()).SaveWidgets(widgetIds.Trim(','), SessionManager.LoggedInUser.UserId);
    }
}