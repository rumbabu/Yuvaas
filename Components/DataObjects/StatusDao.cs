using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
    public class StatusDao
    {
        #region [Member parameters]

        IList<Status> objStatuss;
        IList<Comment> objComments;
        DataSet ds;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<Status> SelAll()
        {
            try
            {
                dt = Db.GetDataTable("", null);
                if (dt != null)
                {
                    objStatuss = new List<Status>();
                    foreach (DataRow row in dt.Rows)
                        objStatuss.Add(GetStatusObject(row));
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Status> SelAllByPaging(string SortBy, string SearchString, int maximumRows, int startRowIndex)
        {
            try
            {
                DbParam[] param = new DbParam[4];

                param[0] = new DbParam("@SortBy", SortBy, SqlDbType.VarChar);
                param[1] = new DbParam("@SearchString", SearchString, SqlDbType.VarChar);
                param[2] = new DbParam("@maximumRows", maximumRows, SqlDbType.Int);
                param[3] = new DbParam("@startRowIndex", startRowIndex, SqlDbType.Int);

                dt = Db.GetDataTable("SP_tblStatus_SelByPaging", param);

                if (dt != null)
                {
                    objStatuss = new List<Status>();
                    foreach (DataRow row in dt.Rows)
                        objStatuss.Add(GetStatusObject(row));
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Status> SelNewsFeedByPaging(Guid UserId, int maximumRows, int startRowIndex)
        {
            try
            {
                DbParam[] param = new DbParam[3];

                param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@maximumRows", maximumRows, SqlDbType.Int);
                param[2] = new DbParam("@startRowIndex", startRowIndex, SqlDbType.Int);

                dt = Db.GetDataTable("[proc_tblStatus_SelAllforNewsFeedBypaging]", param);

                if (dt != null)
                {
                    objStatuss = new List<Status>();
                    foreach (DataRow row in dt.Rows)
                        objStatuss.Add(GetStatusObject(row));
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public int SelNewsFeedCount(Guid UserId)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[1];

                param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);

                dt = Db.GetDataTable("proc_tblStatus_SelAllforNewsFeedCount", param);

                if (dt != null && dt.Rows.Count > 0)
                {
                    retVal = Db.ToInteger(dt.Rows[0]["TotalCount"].ToString());
                }
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
            return retVal;
        }

        public IList<Status> SelPostsForTimeLine(Guid UserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                ds = Db.GetDataSet("proc_tblStatus_SelAllforNewsFeed", param);
                if (ds != null && ds.Tables.Count > 1)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objStatuss = new List<Status>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Status objStatus = GetStatusObject(row);
                            DataRow[] rows;
                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                rows = ds.Tables[1].Select("StatusId = '" + Db.ToGuid(row["StatusId"]) + "'");
                                objComments = new List<Comment>();
                                foreach (DataRow row1 in rows)
                                {
                                    objComments.Add(GetCommentObject(row1));
                                }
                                objStatus.comments = objComments;
                            }
                            objStatuss.Add(objStatus);
                        }
                    }
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }
        public IList<Status> SelPhotosOnly(Guid UserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                ds = Db.GetDataSet("proc_tblPhoto_SelAllforNewsFeed", param);
                if (ds != null && ds.Tables.Count > 0)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objStatuss = new List<Status>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Status objStatus = GetStatusObject(row);
                            objStatuss.Add(objStatus);
                        }
                    }
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Status> SelPostsForWall(Guid LoggedInUserId, Guid SelectedUserId)
        {
            try
            {
                DbParam[] param = new DbParam[2];
                param[0] = new DbParam("@LoggedInUserId", LoggedInUserId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@SelectedUserId", SelectedUserId, SqlDbType.UniqueIdentifier);

                ds = Db.GetDataSet("proc_tblStatus_SelforWall", param);
                if (ds != null && ds.Tables.Count > 1)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objStatuss = new List<Status>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Status objStatus = GetStatusObject(row);
                            objStatus.UserImage = Db.ToString(row["UserImage"]);
                            objStatus.UserName = Db.ToString(row["UserName"]);
                            objStatus.LikesCount = Db.ToInteger(row["LikesCount"]);

                            DataRow[] rows;
                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                rows = ds.Tables[1].Select("StatusId = '" + Db.ToGuid(row["StatusId"]) + "'");
                                objComments = new List<Comment>();
                                foreach (DataRow row1 in rows)
                                {
                                    objComments.Add(GetCommentObject(row1));
                                }
                                objStatus.comments = objComments;
                            }
                            objStatuss.Add(objStatus);
                        }
                    }
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Status> SelPostsForWallByPaging(Guid LoggedInUserId, Guid SelectedUserId, string searchStriing, string sortBy, int startIndex, int pageSize, out int count)
        {
            try
            {
                count = 0;
                DbParam[] param = new DbParam[6];
                param[0] = new DbParam("@LoggedInUserId", LoggedInUserId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@SelectedUserId", SelectedUserId, SqlDbType.UniqueIdentifier);
                param[2] = new DbParam("@StartIndex", startIndex, SqlDbType.Int);
                param[3] = new DbParam("@PageSize", pageSize, SqlDbType.Int);
                param[4] = new DbParam("@SortExpression", sortBy, SqlDbType.VarChar);
                param[5] = new DbParam("@SearchString", searchStriing, SqlDbType.VarChar);

                ds = Db.GetDataSet("proc_tblStatus_SelForWall_ByPaging", param);
                if (ds != null && ds.Tables.Count > 1)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objStatuss = new List<Status>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Status objStatus = GetStatusObject(row);
                            objStatus.UserImage = Db.ToString(row["UserImage"]);
                            objStatus.UserName = Db.ToString(row["UserName"]);
                            objStatus.LikesCount = Db.ToInteger(row["LikesCount"]);

                            DataRow[] rows;
                            if (ds.Tables.Count > 2 && ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                            {
                                rows = ds.Tables[2].Select("StatusId = '" + Db.ToGuid(row["StatusId"]) + "'");
                                objComments = new List<Comment>();
                                foreach (DataRow row1 in rows)
                                {
                                    objComments.Add(GetCommentObject(row1));
                                }
                                objStatus.comments = objComments;
                            }
                            objStatuss.Add(objStatus);
                        }
                    }
                    if (ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                    {
                        count = Db.ToInteger(ds.Tables[1].Rows[0].ItemArray[0]);
                    }
                }
                return objStatuss;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public int GetStatusCount(string SearchString)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                int UserProfileCount = 0;
                object obj;

                param[0] = new DbParam("@SearchString", SearchString, SqlDbType.VarChar);

                obj = Db.GetScalar("SP_tblStatus_SelCount", param);

                if (obj != null)
                {
                    UserProfileCount = Db.ToInteger(obj);
                }
                return UserProfileCount;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        #endregion

        #region [Insert Methods]

        public int InsertStatus(Status objStatus)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[8];

                param[0] = new DbParam("@StatusId", objStatus.StatusId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@StatusName", objStatus.StatusName, SqlDbType.NVarChar);
                param[2] = new DbParam("@StatusType", objStatus.StatusType, SqlDbType.VarChar);
                param[3] = new DbParam("@StatusUrl", objStatus.StatusUrl, SqlDbType.NVarChar);
                param[4] = new DbParam("@UserId", objStatus.UserId, SqlDbType.UniqueIdentifier);
                param[5] = new DbParam("@PermissionId", objStatus.PermissionId, SqlDbType.Int);
                param[6] = new DbParam("@IsHidden", objStatus.IsHidden, SqlDbType.Bit);
                param[7] = new DbParam("@IsArchived", objStatus.ISArchived, SqlDbType.Bit);

                retVal = Db.Insert("SP_tblStatus_Ins", param, true);

                return retVal;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        /// <summary>
        /// Function : SharePost
        /// Description : Creates a Duplicate of selected post on the user wall
        /// Inputs : Status(obj)
        /// </summary>
        /// <returns>int</returns>
        public int SharePost(Status objStatus)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[9];

                param[0] = new DbParam("@StatusId", objStatus.StatusId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@StatusName", objStatus.StatusName, SqlDbType.NVarChar);
                param[2] = new DbParam("@StatusType", objStatus.StatusType, SqlDbType.VarChar);
                param[3] = new DbParam("@StatusUrl", objStatus.StatusUrl, SqlDbType.NVarChar);
                param[4] = new DbParam("@UserId", objStatus.UserId, SqlDbType.UniqueIdentifier);
                param[5] = new DbParam("@PermissionId", objStatus.PermissionId, SqlDbType.Int);
                param[6] = new DbParam("@IsHidden", objStatus.IsHidden, SqlDbType.Bit);
                param[7] = new DbParam("@IsArchived", objStatus.ISArchived, SqlDbType.Bit);
                param[8] = new DbParam("@IsShared", objStatus.IsShared, SqlDbType.Bit);

                retVal = Db.Insert("SP_tblStatus_Share", param, true);

                return retVal;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        #endregion

        #region [Delete Methods]

        public int DeleteStatus(Guid StatusId)
        {
            int intReturn = 0;
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@StatusId", StatusId, SqlDbType.UniqueIdentifier);

                intReturn = Db.Update("proc_tblStatus_Del", param);
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

        Status GetStatusObject(DataRow dr)
        {
            try
            {
                Status objStatus = new Status();
                objStatus.StatusId = Db.ToGuid(dr["StatusId"]);
                objStatus.StatusName = Db.ToString(dr["StatusName"]);
                objStatus.StatusType = Db.ToString(dr["StatusType"]);
                objStatus.StatusUrl = Db.ToString(dr["StatusUrl"]);
                objStatus.CreatedDate = Db.ToDateTime(dr["CreatedDate"]).ToString("MMMM d, yyyy HH:mm:ss");
                objStatus.UserId = Db.ToGuid(dr["UserId"]);
                objStatus.PermissionId = Db.ToInteger(dr["PermissionId"]);
                objStatus.IsHidden = Db.ToBoolean(dr["IsHidden"]);
                objStatus.ISArchived = Db.ToBoolean(dr["IsArchived"]);
                if (dr.Table.Columns.Contains("UserName"))
                objStatus.UserName = Db.ToString(dr["UserName"]);
                if (dr.Table.Columns.Contains("UserImage"))
                    objStatus.UserImage = Db.ToString(dr["UserImage"]);
                if (dr.Table.Columns.Contains("LikesCount"))
                    objStatus.LikesCount = Db.ToInteger(dr["LikesCount"]);
                if (dr.Table.Columns.Contains("IsLiked"))
                    objStatus.IsLiked = Db.ToBoolean(dr["IsLiked"]);
                if (dr.Table.Columns.Contains("LikeId"))
                    objStatus.LikeId = Db.ToGuid(dr["LikeId"]);
                return objStatus;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        Comment GetCommentObject(DataRow dr)
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
                if (dr.Table.Columns.Contains("IsCommentLiked"))
                    objComment.IsCommentLiked = Db.ToBoolean(dr["IsCommentLiked"]);
                if (dr.Table.Columns.Contains("CommentLikeId"))
                    objComment.CommentLikeId = Db.ToGuid(dr["CommentLikeId"]);
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
