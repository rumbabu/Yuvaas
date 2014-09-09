using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//UserDefiend NameSpaces
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
    public class CommentLikeDao
    {
        #region [Member parameters]

        IList<CommentLike> objCommentLikes;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<CommentLike> SelAll()
        {
            try
            {
                dt = Db.GetDataTable("proc_tblCommentLike_Sel", null);
                if (dt != null)
                {
                    objCommentLikes = new List<CommentLike>();
                    foreach (DataRow row in dt.Rows)
                        objCommentLikes.Add(GetObject(row));
                }
                return objCommentLikes;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<CommentLike> LikeSelByUserId(Guid UserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[1] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblCommentLike_SelByUserId", null);
                if (dt != null)
                {
                    objCommentLikes = new List<CommentLike>();
                    foreach (DataRow row in dt.Rows)
                        objCommentLikes.Add(GetObject(row));
                }
                return objCommentLikes;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        #endregion

        #region [Insert Methods]

        public Guid InsertCommentLike(CommentLike objCommentLike)
        {
            Guid retGuid = new Guid("00000000-0000-0000-0000-000000000000");
            DataRow dr = null;
            try
            {
                DbParam[] param = new DbParam[5];

                param[0] = new DbParam("@CommentLikeId", objCommentLike.CommentLikeId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@StatusId", objCommentLike.StatusId, SqlDbType.UniqueIdentifier);
                param[2] = new DbParam("@CommentId", objCommentLike.CommentId, SqlDbType.UniqueIdentifier);
                param[3] = new DbParam("@UserId", objCommentLike.UserId, SqlDbType.UniqueIdentifier);//@IsLiked
                param[4] = new DbParam("@IsLiked", objCommentLike.IsLiked, SqlDbType.Bit);//

                //retVal = Db.Insert("proc_tblCommentLike_Ins", param, true);
                dr = Db.GetDataRow("proc_tblCommentLike_Ins", param);
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

        CommentLike GetObject(DataRow dr)
        {
            try
            {
                CommentLike objCommentLike = new CommentLike();
                objCommentLike.CommentLikeId = Db.ToGuid(dr["CommentLikeId"]);
                objCommentLike.StatusId = Db.ToGuid(dr["StatusId"]);
                objCommentLike.CommentId = Db.ToGuid(dr["CommentId"]);
                objCommentLike.UserId = Db.ToGuid(dr["UserId"]);
                objCommentLike.IsLiked = Db.ToBoolean(dr["IsLiked"]);
                objCommentLike.CreatedDate = Db.ToDateTime(dr["CreatedDate"]);
                objCommentLike.ModifiedDate = Db.ToDateTime(dr["ModifiedDate"]);

                return objCommentLike;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion
    }
}
