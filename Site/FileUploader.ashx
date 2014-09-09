<%@ WebHandler Language="C#" Class="AjaxFileUploader" %>
using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Configuration;


/// <summary>
/// Summary description for AjaxFileUploader
/// </summary>
public class AjaxFileUploader : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            string path = context.Request["Path"] != null ? context.Request["Path"].ToString() : ConfigurationManager.AppSettings["ImageFolderPath"].ToString();
            //if (!Directory.Exists(path))
            //    Directory.CreateDirectory(path);

            HttpPostedFile file = context.Request.Files[0];

            string fileName;

            if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
            {
                string[] files = file.FileName.Split(new char[] { '\\' });
                fileName = files[files.Length - 1];
            }
            else
            {
                fileName = file.FileName;
            }
            int indexOfDot = fileName.LastIndexOf('.');
            if (indexOfDot > 235)
                indexOfDot = 235;
            if (indexOfDot > 0)
            {
                fileName = fileName.Substring(0, indexOfDot) + DateTime.Now.Ticks + fileName.Substring(indexOfDot);
                fileName = fileName.Replace(' ', '_');
            }
            string strFileName = fileName;
            fileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, path + fileName);
            file.SaveAs(fileName);



            string msg = "{";
            msg += string.Format("error:'{0}',\n", string.Empty);
            msg += string.Format("msg:'{0}'\n", strFileName);
            msg += "}";
            context.Response.Write(msg);
        }
    }

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }
}
