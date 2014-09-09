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
    public class DashboardWidgetDao
    {
        List<DashboardWidget> widgets;
        DashboardWidget widget;
        DataSet ds;

        public List<DashboardWidget> GetSelected(Guid UserId)
        {
            DbParam[] param = new DbParam[1];
            param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);

            ds = Db.GetDataSet("SP_tblDashboardWidget_Sel_Selected", param);

            if (Db.IsDataExists(ds))
            {
                widgets = new List<DashboardWidget>();
                foreach (DataRow dr in ds.Tables[0].Rows)
                    widgets.Add(GetObject(dr));
            }

            return widgets;
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
            obj.IsSelected = Db.ToBoolean(dr["IsSelected"]);
            return obj;
        }

        #endregion
    }
}
