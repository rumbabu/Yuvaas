using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Caching;

public partial class Caching_CachingDependencyTables : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        //Put the page into a default state.
        enabledTables.Visible = true;
        disableTable.Visible = true;
        enabledTablesMsg.Text = "Tables enabled for change notification:";

        tableName.Visible = true;
        enableTable.Visible = true;
        tableEnableMsg.Text = "Enable change notification on table(s):";
        enableTableErrorMsg.Text = "";
    }

    protected void Page_PreRender(object sender, System.EventArgs e)
    {
        try
        {
            string[] enabledTablesList = null;
            enabledTablesList = SqlCacheDependencyAdmin.GetTablesEnabledForNotifications(ConfigurationManager.AppSettings["ConnectionString"]);
            if (enabledTablesList.Length > 0)
            {
                enabledTables.DataSource = enabledTablesList;
                enabledTables.DataBind();
            }
            else
            {
                enabledTablesMsg.Text = "No tables are enabled for change notifications.";
                enabledTables.Visible = false;
                disableTable.Visible = false;
            }
        }
        catch (DatabaseNotEnabledForNotificationException ex)
        {
            enabledTables.Visible = false;
            disableTable.Visible = false;
            enabledTablesMsg.Text = "Cache notifications are not enabled in this database.";

            tableName.Visible = false;
            enableTable.Visible = false;
            tableEnableMsg.Text = "Must enable database for notifications before enabling tables.";
        }
    }
    protected void enableNotification_Click(object sender, System.EventArgs e)
    {
        SqlCacheDependencyAdmin.EnableNotifications(ConfigurationManager.AppSettings["ConnectionString"]);
    }
    protected void disableNotification_Click(object sender, System.EventArgs e)
    {
        SqlCacheDependencyAdmin.DisableNotifications(ConfigurationManager.AppSettings["ConnectionString"]);
    }
    protected void disableTable_Click(object sender, System.EventArgs e)
    {
        foreach (ListItem item in enabledTables.Items)
        {
            if (item.Selected)
            {
                SqlCacheDependencyAdmin.DisableTableForNotifications(ConfigurationManager.AppSettings["ConnectionString"], item.Text);
            }
        }
    }
    protected void enableTable_Click(object sender, System.EventArgs e)
    {
        try
        {
            if (tableName.Text.Contains(","))
            {
                string[] tables = null;
                tables = tableName.Text.Split(new Char[] { ',' });
                for (int i = 0; i <= tables.Length - 1; i++)
                {
                    tables[i] = tables[i].Trim();
                }

                SqlCacheDependencyAdmin.EnableTableForNotifications(ConfigurationManager.AppSettings["ConnectionString"], tables);
            }
            else
            {
                SqlCacheDependencyAdmin.EnableTableForNotifications(ConfigurationManager.AppSettings["ConnectionString"], tableName.Text);
            }
        }
        catch (HttpException ex)
        {
            enableTableErrorMsg.Text = "<br />" + "An error occured enabling a table.<br />" + "The error message was: " + ex.Message;
            enableTableErrorMsg.Visible = true;
        }
    }

}