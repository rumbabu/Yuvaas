using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//User Defiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
   public class PermissionsDao
    {
        #region [Member parameters]

       IList<Permissions> objPermissionss;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<Permissions> SelAll()
        {
            try
            {
                dt = Db.GetDataTable("proc_tblPermissions_SelAll", null);
                if (dt != null)
                {
                    objPermissionss = new List<Permissions>();
                    foreach (DataRow row in dt.Rows)
                        objPermissionss.Add(GetObject(row));
                }
                return objPermissionss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }
        #endregion

        #region [Mapper]

        Permissions GetObject(DataRow dr)
        {
            try
            {
                Permissions objPermissions = new Permissions();
                objPermissions.PermissionId = Db.ToInteger(dr["PermissionId"]);
                objPermissions.PermissionDetails = Db.ToString(dr["PermissionDetails"]);

                return objPermissions;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        #endregion

    }
}
