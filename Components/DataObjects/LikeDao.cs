using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//UserDefiend Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;


namespace Yuvaas.DataLayer.DataObjects
{
    public class LikeDao
    {
        #region [Member parameters]

        IList<Like> objLikes;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<Like> SelAll()
        {
            try
            {
                dt = Db.GetDataTable("proc_tblLike_SelAll", null);
                if (dt != null)
                {
                    objLikes = new List<Like>();
                    foreach (DataRow row in dt.Rows)
                        objLikes.Add(GetObject(row));
                }
                return objLikes;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Like> LikeSelByUserId(Guid UserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[1] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblLike_SelByUserId", null);
                if (dt != null)
                {
                    objLikes = new List<Like>();
                    foreach (DataRow row in dt.Rows)
                        objLikes.Add(GetObject(row));
                }
                return objLikes;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }
        #endregion

        #region [Insert Methods]

        public Guid InsertLike(Like objLike)
        {
            Guid retGuid = new Guid("00000000-0000-0000-0000-000000000000");
            DataRow dr = null;
            try
            {
                DbParam[] param = new DbParam[4];

                param[0] = new DbParam("@LikeId", objLike.LikeId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@StatusId", objLike.StatusId, SqlDbType.UniqueIdentifier);
                param[2] = new DbParam("@IsLiked", objLike.IsLiked, SqlDbType.Bit);
                param[3] = new DbParam("@UserId", objLike.UserId, SqlDbType.UniqueIdentifier);

                dr = Db.GetDataRow("proc_tblLike_Ins", param);
                if (dr != null && dr[0] != null)
                    retGuid = Db.ToGuid(dr[0]);

                return retGuid;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        #endregion

        #region [Mapper]

        Like GetObject(DataRow dr)
        {
            try
            {
                Like objLike = new Like();
                objLike.LikeId = Db.ToGuid(dr["LikeId"]);
                objLike.StatusId = Db.ToGuid(dr["StatusId"]);
                objLike.IsLiked = Db.ToBoolean(dr["IsLiked"]);
                objLike.UserId = Db.ToGuid(dr["UserId"]);
                objLike.CreatedDate = Db.ToDateTime(dr["CreatedDate"]);
                objLike.ModifiedDate = Db.ToDateTime(dr["ModifiedDate"]);

                return objLike;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion
    }
}
