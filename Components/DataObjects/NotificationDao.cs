using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;
using Yuvaas.DataLayer.DataObjects;


/// <summary>
/// Summary description for NotificationDao
/// </summary>
namespace Yuvaas.DataLayer.DataObjects
{
    public class NotificationDao
    {
        
        #region [Notifications]

        public NotificationDetails GetNotifications(int StartIndex, int MaxSize)
        {
            NotificationDetails objNotificationDetails = null;
            IList<Notification> objNotifications = null;
            Notification ObjNotification = null;
            DataSet ds = new DataSet();
            DbParam[] param = new DbParam[2];
            param[0] = new DbParam("@StartIndex", StartIndex, SqlDbType.Int);
            param[1] = new DbParam("@MaxSize", MaxSize, SqlDbType.Int);
            ds = Db.GetDataSet("proc_tblStatus_SelNotifications", param);
            if (ds != null)
            {
                objNotificationDetails = new NotificationDetails();
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    objNotifications = new List<Notification>();
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        ObjNotification = new Notification();
                        ObjNotification.IsPost = Convert.ToBoolean(row["IsPost"]);
                        ObjNotification.IsShared = Convert.ToBoolean(row["IsShared"]);
                        ObjNotification.IsCommented = Convert.ToBoolean(row["IsCommented"]);
                        ObjNotification.IsLiked = Convert.ToBoolean(row["IsLiked"]);
                        ObjNotification.IsCommentLiked = Convert.ToBoolean(row["IsCommentLiked"]);

                        ObjNotification.StatusId = Db.ToGuid(row["StatusId"]);
                        ObjNotification.StatusName = Db.ToString(row["StatusName"]);
                        ObjNotification.StatusType = Db.ToString(row["StatusType"]);
                        ObjNotification.StatusUrl = Db.ToString(row["StatusUrl"]);
                        ObjNotification.CreatedDate = Db.ToString(row["CreatedDate"]);

                        ObjNotification.CommentId = Db.ToGuid(row["CommentId"]);
                        ObjNotification.CommentName = Db.ToString(row["CommentName"]);

                        ObjNotification.UserId = Db.ToGuid(row["UserId"]);
                        ObjNotification.FirstName = Db.ToString(row["FirstName"]);
                        ObjNotification.LastName = Db.ToString(row["LastName"]);
                        ObjNotification.UserImage = Db.ToString(row["UserImage"]);
                        ObjNotification.NUserId = Db.ToGuid(row["NUserId"]);
                        ObjNotification.NFirstName = Db.ToString(row["NFirstName"]);
                        ObjNotification.NLastName = Db.ToString(row["NLastName"]);
                        ObjNotification.NUserImage = Db.ToString(row["NUserImage"]);
                        objNotifications.Add(ObjNotification);
                    }
                    objNotificationDetails.NotificationList = objNotifications;
                }
                if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    int totalCount = Db.ToInteger(ds.Tables[1].Rows[0]["TotalCount"]);
                    objNotificationDetails.PageCount = (int)(totalCount / MaxSize);
                    if (totalCount > 0 && totalCount % MaxSize > 0)
                        objNotificationDetails.PageCount += 1;
                }
            }
            return objNotificationDetails;
        }
        
        #endregion

        
    }
}
