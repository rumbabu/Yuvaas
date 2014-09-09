using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
    public class PhotoDao
    {
        #region [Member parameters]

        IList<Photo> objPhotos;
        IList<Comment> objComments;
        DataSet ds;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<Photo> SelAll()
        {
            try
            {
                dt = Db.GetDataTable("", null);
                if (dt != null)
                {
                    objPhotos = new List<Photo>();
                    foreach (DataRow row in dt.Rows)
                        objPhotos.Add(GetPhotoObject(row));
                }
                return objPhotos;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Photo> SelAllByPaging(string SortBy, string SearchString, int maximumRows, int startRowIndex)
        {
            try
            {
                DbParam[] param = new DbParam[4];

                param[0] = new DbParam("@SortBy", SortBy, SqlDbType.VarChar);
                param[1] = new DbParam("@SearchString", SearchString, SqlDbType.VarChar);
                param[2] = new DbParam("@maximumRows", maximumRows, SqlDbType.Int);
                param[3] = new DbParam("@startRowIndex", startRowIndex, SqlDbType.Int);

                dt = Db.GetDataTable("SP_tblPhoto_SelByPaging", param);

                if (dt != null)
                {
                    objPhotos = new List<Photo>();
                    foreach (DataRow row in dt.Rows)
                        objPhotos.Add(GetPhotoObject(row));
                }
                return objPhotos;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Photo> SelPostsForTimeLine(Guid UserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
                ds = Db.GetDataSet("proc_tblPhoto_SelAllforNewsFeed", param);
                if (ds != null && ds.Tables.Count > 1)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objPhotos = new List<Photo>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Photo objPhoto = GetPhotoObject(row);
                            DataRow[] rows;
                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                rows = ds.Tables[1].Select("PhotoId = '" + Db.ToGuid(row["PhotoId"]) + "'");
                                objComments = new List<Comment>();
                                foreach (DataRow row1 in rows)
                                {
                                    objComments.Add(GetCommentObject(row1));
                                }
                                objPhoto.comments = objComments;
                            }
                            objPhotos.Add(objPhoto);
                        }
                    }
                }
                return objPhotos;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public IList<Photo> SelPostsForWall(Guid LoggedInUserId, Guid SelectedUserId)
        {
            try
            {
                DbParam[] param = new DbParam[2];
                param[0] = new DbParam("@LoggedInUserId", LoggedInUserId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@SelectedUserId", SelectedUserId, SqlDbType.UniqueIdentifier);

                ds = Db.GetDataSet("proc_tblPhoto_SelforWall", param);
                if (ds != null && ds.Tables.Count > 1)
                {
                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        objPhotos = new List<Photo>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            Photo objPhoto = GetPhotoObject(row);
                            //objPhoto.UserImage = Db.ToString(row["UserImage"]);
                            //objPhoto.UserName = Db.ToString(row["UserName"]);
                            //objPhoto.LikesCount = Db.ToInteger(row["LikesCount"]);

                            DataRow[] rows;
                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                rows = ds.Tables[1].Select("PhotoId = '" + Db.ToGuid(row["PhotoId"]) + "'");
                                objComments = new List<Comment>();
                                foreach (DataRow row1 in rows)
                                {
                                    objComments.Add(GetCommentObject(row1));
                                }
                                objPhoto.comments = objComments;
                            }
                            objPhotos.Add(objPhoto);
                        }
                    }
                }
                return objPhotos;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                throw ex;
            }
        }

        public int GetPhotoCount(string SearchString)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                int UserProfileCount = 0;
                object obj;

                param[0] = new DbParam("@SearchString", SearchString, SqlDbType.VarChar);

                obj = Db.GetScalar("SP_tblPhoto_SelCount", param);

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

        public int InsertPhoto(Photo objPhoto)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[11];

                param[0] = new DbParam("@PhotoId", objPhoto.PhotoId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@PhotoUrl", objPhoto.PhotoUrl, SqlDbType.VarChar);
                param[2] = new DbParam("@PhotoStatus", objPhoto.PhotoStatus, SqlDbType.VarChar);
                param[3] = new DbParam("@PhotoType", objPhoto.PhotoType, SqlDbType.VarChar);
                param[4] = new DbParam("@IsShared", objPhoto.IsShared, SqlDbType.Bit);
                param[5] = new DbParam("@IsLiked", objPhoto.IsLiked, SqlDbType.Bit);
                param[6] = new DbParam("@UserId", objPhoto.UserId, SqlDbType.UniqueIdentifier);
                param[7] = new DbParam("@PermissionId", objPhoto.PermissionId, SqlDbType.Int);
                param[8] = new DbParam("@IsHidden", objPhoto.IsHidden, SqlDbType.Bit);
                param[9] = new DbParam("@IsArchived", objPhoto.IsArchived, SqlDbType.Bit);
                param[10] = new DbParam("@IsShared1", objPhoto.IsShared1, SqlDbType.Bit);

                retVal = Db.Insert("SP_tblPhoto_Ins", param, true);

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
        /// Inputs : Photo(obj)
        /// </summary>
        /// <returns>int</returns>
        public int SharePost(Photo objPhoto)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[11];

                param[0] = new DbParam("@PhotoId", objPhoto.PhotoId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@PhotoUrl", objPhoto.PhotoUrl, SqlDbType.VarChar);
                param[2] = new DbParam("@PhotoStatus", objPhoto.PhotoStatus, SqlDbType.VarChar);
                param[3] = new DbParam("@PhotoType", objPhoto.PhotoType, SqlDbType.VarChar);
                param[4] = new DbParam("@IsShared", objPhoto.IsShared, SqlDbType.Bit);
                param[5] = new DbParam("@IsLiked", objPhoto.IsLiked, SqlDbType.Bit);
                param[6] = new DbParam("@UserId", objPhoto.UserId, SqlDbType.UniqueIdentifier);
                param[7] = new DbParam("@PermissionId", objPhoto.PermissionId, SqlDbType.Int);
                param[8] = new DbParam("@IsHidden", objPhoto.IsHidden, SqlDbType.Bit);
                param[9] = new DbParam("@IsArchived", objPhoto.IsArchived, SqlDbType.Bit);
                param[10] = new DbParam("@IsShared1", objPhoto.IsShared1, SqlDbType.Bit);

                retVal = Db.Insert("SP_tblPhoto_Share", param, true);

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

        public int DeletePhoto(Guid PhotoId)
        {
            int intReturn = 0;
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@PhotoId", PhotoId, SqlDbType.UniqueIdentifier);

                intReturn = Db.Update("proc_tblPhoto_Del", param);
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

        Photo GetPhotoObject(DataRow dr)
        {
            try
            {
                Photo objPhoto = new Photo();
                objPhoto.PhotoId = Db.ToGuid((dr["PhotoId"]));
                objPhoto.PhotoUrl = Db.ToString(dr["PhotoUrl"]);
                objPhoto.PhotoStatus = Db.ToString(dr["PhotoStatus"]);
                objPhoto.PhotoType = Db.ToString(dr["PhotoType"]);
                objPhoto.IsShared = Db.ToBoolean(dr["IsShared"]);
                objPhoto.IsLiked = Db.ToBoolean(dr["IsLiked"]);
                objPhoto.UserId = Db.ToGuid((dr["UserId"]));
                objPhoto.PermissionId = Db.ToInteger(dr["PermissionId"]);
                objPhoto.IsHidden = Db.ToBoolean(dr["IsHidden"]);
                objPhoto.IsArchived = Db.ToBoolean(dr["IsArchived"]);
                objPhoto.IsShared1 = Db.ToBoolean(dr["IsShared1"]);
                objPhoto.CreatedDate = Db.ToDateTime(dr["CreatedDate"]);
                objPhoto.ModifiedDate = Db.ToDateTime(dr["ModifiedDate"]);
                if (dr.Table.Columns.Contains("UserName"))
                    objPhoto.UserName = Db.ToString(dr["UserName"]);
                if (dr.Table.Columns.Contains("UserImage"))
                    objPhoto.UserImage = Db.ToString(dr["UserImage"]);
                //if (dr.Table.Columns.Contains("LikesCount"))
                //    objPhoto.LikesCount = Db.ToInteger(dr["LikesCount"]);
                //if (dr.Table.Columns.Contains("IsLiked"))
                //    objPhoto.IsLiked = Db.ToBoolean(dr["IsLiked"]);
                //if (dr.Table.Columns.Contains("LikeId"))
                //    objPhoto.LikeId = Db.ToGuid(dr["LikeId"]);
                return objPhoto;
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
                objComment.PhotoId = Db.ToGuid(dr["PhotoId"]);
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
