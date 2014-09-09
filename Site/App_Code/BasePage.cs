using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Yuvaas;
/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public PageModule CurrentModule { get; set; }

    protected override void OnInit(EventArgs e)
    {
        if (Session["UserId"] == null && Session["LoginId"] == null && Session["Name"] == null)
        {
            Response.Redirect(CommonFunctions.GetApplicationPath());
        }
    }
}