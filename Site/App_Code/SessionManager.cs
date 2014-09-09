using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Yuvaas.BusinessLayer.BusinessObjects;

/// <summary>
/// Summary description for SessionManager
/// </summary>
public static class SessionManager
{
    public static User LoggedInUser
    {
        get { return ((User)(HttpContext.Current.Session["LoggedInUser"])); }
        set { HttpContext.Current.Session["LoggedInUser"] = value; }
    }

}