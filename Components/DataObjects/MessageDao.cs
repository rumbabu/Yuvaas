using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;

namespace Yuvaas.DataLayer.DataObjects
{
    public class MessageDao
    {
        #region [Member parameters]

        IList<Message> objMessages;
        //IList<Status> objStatuss;
        DataSet ds;
        DataTable dt;

        #endregion

        #region [Select Methods]

        public IList<Message> SelMessagesForDefaultUser(Guid FromUserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@FromUserId", FromUserId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblMessage_SelMessagesForDefaultUser", param);
                if (dt != null)
                {
                    objMessages = new List<Message>();
                    foreach (DataRow dr in dt.Rows)
                        objMessages.Add(GetObject(dr));
                }
                return objMessages;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                return null;
            }
        }

        public IList<Message> SelAllToUserId(Guid FromUserId, Guid ToUserId)
        {
            try
            {
                DbParam[] param = new DbParam[2];
                param[0] = new DbParam("@FromUserId", FromUserId, SqlDbType.UniqueIdentifier);
                param[1] = new DbParam("@ToUserId", ToUserId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblMessage_SelAllToUserId", param);
                if (dt != null)
                {
                    objMessages = new List<Message>();
                    foreach (DataRow dr in dt.Rows)
                        objMessages.Add(GetObject(dr));
                }
                return objMessages;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                return null;
            }
        }

        public IList<Message> SelAllFromUserId(Guid FromUserId)
        {
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@FromUserId", FromUserId, SqlDbType.UniqueIdentifier);
                dt = Db.GetDataTable("proc_tblMessage_SelAllFromUserId", param);
                if (dt != null)
                {
                    objMessages = new List<Message>();
                    foreach (DataRow dr in dt.Rows)
                        objMessages.Add(GetObject(dr));
                }
                return objMessages;
            }
            catch (Exception ex)
            {
                // CommonFunctions.LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
                return null;
            }
        }

        //Sent Message
        public MessageDetails GetAllMessagesForSent(int startRowIndex, int maximumRows, string SearchString, string SortBy, Guid FromUserId)
        {
            MessageDetails objMessageDetails = null;
            try
            {
                DbParam[] param = new DbParam[]{
                    new DbParam("@startRowIndex", startRowIndex, SqlDbType.Int),
                    new DbParam("@maximumRows", maximumRows, SqlDbType.Int),
                    new DbParam("@SearchString", SearchString, SqlDbType.VarChar),
                    new DbParam("@SortBy", SortBy, SqlDbType.VarChar),
                    new DbParam("@FromUserId", FromUserId, SqlDbType.UniqueIdentifier)
                };
                ds = Db.GetDataSet("proc_tblMessage_GetAllMessagesByFromUserId", param);
                if (ds != null)
                {
                    objMessageDetails = new MessageDetails();
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        objMessages = new List<Message>();
                        foreach (DataRow dr in ds.Tables[0].Rows)
                            objMessages.Add(GetObject(dr));

                        objMessageDetails.MessageList = objMessages;
                    }
                    if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        int totalCount = Db.ToInteger(ds.Tables[1].Rows[0]["TotalCount"]);
                        objMessageDetails.PageCount = (int)(totalCount / maximumRows);
                        if (totalCount > 0 && totalCount % maximumRows > 0)
                            objMessageDetails.PageCount += 1;
                    }
                }
                return objMessageDetails;
            }
            catch
            {
                return null;
            }
        }

        //Inbox Messages
        public MessageDetails GetAllMessagesForInbox(int startRowIndex, int maximumRows, string SearchString, string SortBy, Guid ToUserId)
        {
            MessageDetails objMessageDetails = null;
            try
            {
                DbParam[] param = new DbParam[]{
                    new DbParam("@startRowIndex", startRowIndex, SqlDbType.Int),
                    new DbParam("@maximumRows", maximumRows, SqlDbType.Int),
                    new DbParam("@SearchString", SearchString, SqlDbType.VarChar),
                    new DbParam("@SortBy", SortBy, SqlDbType.VarChar),
                    new DbParam("@ToUserId", ToUserId, SqlDbType.UniqueIdentifier)
                };
                ds = Db.GetDataSet("proc_tblMessage_GetAllMessagesByToUserId", param);
                if (ds != null)
                {
                    objMessageDetails = new MessageDetails();
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        objMessages = new List<Message>();
                        foreach (DataRow dr in ds.Tables[0].Rows)
                            objMessages.Add(GetObject(dr));

                        objMessageDetails.MessageList = objMessages;
                    }
                    if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        int totalCount = Db.ToInteger(ds.Tables[1].Rows[0]["TotalCount"]);
                        objMessageDetails.PageCount = (int)(totalCount / maximumRows);
                        if (totalCount > 0 && totalCount % maximumRows > 0)
                            objMessageDetails.PageCount += 1;
                    }
                }
                return objMessageDetails;
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region [Insert Methods]

        public int InsertMessage(Guid FromUserId, string ToUserNames, string MessageDesc)
        {
            int retVal = 0;
            try
            {
                DbParam[] param = new DbParam[]{
                    new DbParam("@FromUserId",FromUserId,SqlDbType.UniqueIdentifier),
                    new DbParam("@ToUserNames",ToUserNames,SqlDbType.VarChar),
                    new DbParam("@MessageDesc",MessageDesc,SqlDbType.VarChar)
                };
                retVal = Db.Insert("proc_tblMessage_Ins", param, true);
            }
            catch (Exception ex)
            {
            }
            return retVal;
        }

        #endregion

        #region [Delete Methods]

        public int DeleteMessage(string MessageIds)
        {
            int intReturn = 0;
            try
            {
                DbParam[] param = new DbParam[1];
                param[0] = new DbParam("@MessageIds", MessageIds, SqlDbType.VarChar);

                intReturn = Db.Update("proc_tblMessage_Del", param);
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

        Message GetObject(DataRow dr)
        {
            try
            {
                Message objMessage = new Message();
                objMessage.MessageId = Db.ToGuid(dr["MessageId"]);
                objMessage.FromUserId = Db.ToGuid(dr["FromUserId"]);
                objMessage.ToUserId = Db.ToGuid(dr["ToUserId"]);
                objMessage.MessageDesc = Db.ToString(dr["Message"]);
                objMessage.IsRead = Db.ToBoolean(dr["IsRead"]);
                objMessage.Createdon = Db.ToString(dr["Createdon"]);
                objMessage.FromUserName = Db.ToString(dr["FromUserName"]);
                objMessage.FromUserImage = Db.ToString(dr["FromUserImage"]);
                objMessage.ToUserName = Db.ToString(dr["ToUserName"]);
                objMessage.ToUserImage = Db.ToString(dr["ToUserImage"]);
                return objMessage;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

    }
}
