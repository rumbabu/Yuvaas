using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
    public class CommentDao
    {
        #region [Member parameters]

        IList<Comment> objComments;
        IList<Status> objStatuss;
        DataSet ds;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public CommentDetails SelLatestCommentsByStatusId(Guid StatusId)
        {
            CommentDetails objCommentDetails = null;
            try
            {
                DbParam[] param = new DbParam[]
                {
                    new DbParam("@StatusId",StatusId,SqlDbType.UniqueIdentifier)
                };

                ds = Db.GetDataSet("proc_tblComment_SelLatestComments", param);
                if (ds != null)
                {
                    objCommentDetails = new CommentDetails();
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        objComments = new List<Comment>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                            objComments.Add(GetObject(row));

                        objCommentDetails.CommentList = objComments;
                    }
                    if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        objCommentDetails.PageCount = Db.ToInteger(ds.Tables[1].Rows[0]["TotalCount"]);
                    }
                }
            }
            catch
            {
               
            }
            return objCommentDetails;
        }

        public IList<Comment> SelAll(Guid StatusId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@StatusId", StatusId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblComment_Sel", param);
                if (dt != null)
                {
                    objComments = new List<Comment>();
                    foreach (DataRow row in dt.Rows)
                        objComments.Add(GetObject(row));
                }
                return objComments;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        #endregion

        #region [Insert Methods]

        public Guid InsertComment(Comment objComment)
        {
            Guid retGuid = new Guid("00000000-0000-0000-0000-000000000000");
            DataRow dr = null;
            try
            {
                DbParam[] param = new DbParam[4];

                param[0] = new DbParam("@CommentId", objComment.CommentId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@CommentName", objComment.CommentName, SqlDbType.VarChar);
                param[2] = new DbParam("@StatusId", objComment.StatusId, SqlDbType.UniqueIdentifier);
                param[3] = new DbParam("@UserId", objComment.UserId, SqlDbType.UniqueIdentifier);

                //retVal = Db.Insert("proc_tblComment_Ins", param, true);
                dr = Db.GetDataRow("proc_tblComment_Ins", param);
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

        #region [Delete Methods]

        public int DeleteComment(Guid CommentId)
        {
            int intReturn = 0;
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@CommentId", CommentId, SqlDbType.UniqueIdentifier);

                intReturn = Db.Update("proc_tblComment_Del", param);
                return intReturn;
            }
            catch (Exception ex)
            {
                //  CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }
        #endregion

        #region [Mapper]

        Comment GetObject(DataRow dr)
        {
            try
            {
                Comment objComment = new Comment();
                objComment.CommentId = Db.ToGuid(dr["CommentId"]);
                objComment.CommentName = Db.ToString(dr["CommentName"]);
                objComment.StatusId = Db.ToGuid(dr["StatusId"]);
                objComment.UserId = Db.ToGuid(dr["UserId"]);
                objComment.CreatedDate = Db.ToDateTime(dr["CreatedDate"]).ToString("MM/dd/yyyy HH:mm:ss");
                objComment.ModifiedDate = Db.ToDateTime(dr["ModifiedDate"]).ToString("MM/dd/yyyy HH:mm:ss");
                objComment.UserName = Db.ToString(dr["UserName"]);
                objComment.UserImage = Db.ToString(dr["UserImage"]);
                return objComment;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion
    }
}
