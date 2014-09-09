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
using Yuvaas.Service;
using Yuvaas.Service.Response;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Pages_Profile : BasePage
{
    static String UserId
    {
        get
        {
            if (HttpContext.Current.Request.QueryString["UserId"] != null
                && !String.IsNullOrWhiteSpace(CommonFunctions.GetStringValue(HttpContext.Current.Request.QueryString["UserId"])))
            {
                return CommonFunctions.GetStringValue(HttpContext.Current.Request.QueryString["UserId"]).Trim();
            }
            else if (HttpContext.Current.Session["UserId"] != null
                && !String.IsNullOrWhiteSpace(CommonFunctions.GetStringValue(HttpContext.Current.Session["UserId"])))
            {
                return CommonFunctions.GetStringValue(HttpContext.Current.Session["UserId"]).Trim();
            }
            else
            {
                return Guid.Empty.ToString();
            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        CurrentModule = PageModule.Profile;
        base.OnInit(e);
    }
    /// <summary>
    /// Function: Page_Load
    /// Description : On load of page
    /// Inputs : 
    /// </summary>
    /// <returns>
    /// Output: N/A
    /// </returns>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null && Session["LoginId"] != null)
        {
            //lblDesc.Text = SessionManager.LoggedInUser.About != "" ? SessionManager.LoggedInUser.About : "-N/A-";
            hdnUserId.Value = (Session["UserId"].ToString());
            hdnUserEmail.Value = Session["LoginId"].ToString();
            BindUserProfile();
        }
    }

    public void BindUserProfile()
    {
        Guid userId = Guid.Empty;
        Guid.TryParse(UserId, out userId);

        User user = (new UserFacade()).GetProfileByUserId(userId);
        if (user != null)
        {
            lblAbout.InnerText = "About " + user.FirstName + " " + user.LastName + ":";
            lblDesc.Text = user.About;
            imgImage.Src = "../getImage.aspx?image=Data/ProfileImages/" + user.UserImage + "&height=80&width=80&Aspect=true&type=1&bgc=FFFFFF";
        }

        BindReports(user);
    }

    protected void BindReports(User user)
    {
        List<ReportResponse> reports = new List<ReportResponse>();
        List<DashboardWidget> widgets = (new DashboardWidgetFacade()).GetSelected(user.UserId);
        if (widgets != null && widgets.Count > 0)
        {
            ServiceClient client = new ServiceClient();
            foreach (DashboardWidget widget in widgets)
            {
                if (widget.IsSelected)
                {
                    ReportResponse report = client.GetReport(user.UserCode, widget.DashboardWidgetId);
                    if (report != null && report.StatusCode == 200
                        && report.ReportCharts != null && report.ReportCharts.Length > 0)
                    {
                        reports.Add(report);
                    }
                }
            }
        }

        rpCharts.DataSource = reports;
        rpCharts.DataBind();
    }

    protected void rpChart_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Literal litChartScript = (Literal)e.Item.FindControl("litChartScript");
        HtmlGenericControl divChartContainer = (HtmlGenericControl)e.Item.FindControl("divChartContainer");
        HtmlGenericControl divChart = (HtmlGenericControl)e.Item.FindControl("divChart");

        StringBuilder sb = new StringBuilder();
        Chart[] charts = (Chart[])(sender as Repeater).DataSource;
        Chart chartItem = (Chart)e.Item.DataItem;
        int width = 670 /*/ charts.Length*/, height = 250;

        //divChartContainer.Style["width"] = (100 / charts.Length) + "%";

        sb.AppendLine("<script type='text/javascript'>");
        sb.AppendLine("GALLERY_RENDERER = \"javascript\";");
        sb.AppendLine("if (GALLERY_RENDERER && GALLERY_RENDERER.search(/javascript|flash/i) == 0) FusionCharts.setCurrentRenderer(GALLERY_RENDERER);");
        sb.AppendLine("var chart = new FusionCharts('../Js/Charts/Data/" + chartItem.ChartType + ".swf', \"ClientCollections\", \"" + width + "\", \"" + height + "\", \"0\", \"1\");");
        sb.AppendLine("chart.setXMLData(\"" + chartItem.ChartContent.Replace("\"", "'") + "\");");
        sb.AppendLine("chart.render('" + divChart.ClientID + "');");
        sb.AppendLine("</script>");

        litChartScript.Text = sb.ToString();
    }

    [WebMethod]
    public static User BindProfile()
    {
        Guid userId = Guid.Empty;
        Guid.TryParse(UserId, out userId);

        return new UserFacade().GetProfileByUserId(userId);
    }
}