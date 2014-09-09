using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;
using Yuvaas.DataLayer.DataObjects;
using System.Web.Security;

namespace Yuvaas.DataLayer.DataObjects
{
    public class UserDashboardWidgetDao
    {
        List<DashboardWidget> widgets;
        DashboardWidget widget;
        DataSet ds;

        public int SaveWidgets(string widgetIds, Guid userId)
        {
            DbParam[] param = new DbParam[2];
            param[0] = new DbParam("@WidgetIds", widgetIds, SqlDbType.VarChar);
            param[1] = new DbParam("@UserId", userId, SqlDbType.UniqueIdentifier);

            return Db.Update("SP_tblUserDashboardWidget_InsUpd", param);
        }

        #region [Mapper]

        DashboardWidget GetObject(DataRow dr)
        {
            DashboardWidget obj = new DashboardWidget();
            obj.DashboardWidgetId = Db.ToInteger(dr["DashboardWidgetId"]);
            obj.WidgetName = Db.ToString(dr["WidgetName"]);
            obj.IsActive = Db.ToBoolean(dr["IsActive"]);
            obj.CreatedOn = Db.ToDateTime(dr["CreatedOn"]);
            obj.ModifiedOn = Db.ToDateTime(dr["ModifiedOn"]);
            return obj;
        }

        #endregion
    }
}
