using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Caching;

public partial class Caching_CacheExample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        if (Cache["Date1"] != null)
        {
            Response.Write("Cache");
        }
        else
        {
            Response.Write("Insert to Cache");
            DateTime date1 = DateTime.Now;
            Cache.Insert("Date1", date1, null, DateTime.Now.AddSeconds(20), TimeSpan.Zero, CacheItemPriority.Default, new CacheItemRemovedCallback(CachedItemRemoveCallBack));
        }
    }

    private void CachedItemRemoveCallBack(string key, object value,
                CacheItemRemovedReason reason)
    {
        if (key == "Date1")
        {
            Cache.Remove("Date1");
        }
    }
}