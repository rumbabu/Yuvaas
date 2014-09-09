using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Yuvaas.BusinessLayer.BusinessObjects;

namespace Yuvaas.DataLayer.DataObjects
{
    public class FriendDao
    {
        #region [Member parameters]

        Friend ObjFriend;
        DataTable dt;
        DataRow dr;
        int intReturn;

        #endregion

        /// <summary>
        /// Function : Insert
        /// Description : Add Friend For a User
        /// Inputs : Friend(obj)
        /// <return>
        /// output : int
        /// </return>
        /// </summary>
        public int Insert(Friend objFriend)
        {
            intReturn = 0;
            DbParam[] param = new DbParam[6];
            param[0] = new DbParam("@UserId", objFriend.UserId, SqlDbType.UniqueIdentifier);
            param[1] = new DbParam("@FriendUserId", objFriend.FriendUserId, SqlDbType.UniqueIdentifier);
            param[2] = new DbParam("@IsAccepted", objFriend.IsAccepted, SqlDbType.Bit);
            param[3] = new DbParam("@IsBlocked", objFriend.IsBlocked, SqlDbType.Bit);
            param[4] = new DbParam("@IsMailSent", objFriend.IsMailSent, SqlDbType.Bit);
            param[5] = new DbParam("@IsRead", objFriend.IsRead, SqlDbType.Bit);
            intReturn = Db.Insert("sp_tblFriendList_Ins", param, true);
            return intReturn;
        }

        /// <summary>
        /// Function : AcceptFriend
        /// Description : Accept Friend For a User
        /// Inputs : Friend(obj)
        /// <return>
        /// output : int
        /// </return>
        /// </summary>
        public int AcceptFriend(Guid UserId, Guid FriendUserId)
        {
            intReturn = 0;
            DbParam[] param = new DbParam[2];
            param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
            param[1] = new DbParam("@FriendUserId", FriendUserId, SqlDbType.UniqueIdentifier);
            intReturn = Db.Update("sp_tblFriendList_AcceptFriend", param, true);
            return intReturn;
        }

        #region [Mapper]

        Friend GetObject(DataRow dr)
        {
            ObjFriend = new Friend();
            ObjFriend.UserId = Db.ToGuid(dr["UserId"]);
            ObjFriend.FriendUserId = Db.ToGuid(dr["FriendUserId"]);
            ObjFriend.IsAccepted = Db.ToBoolean(dr["IsAccepted"]);
            ObjFriend.IsBlocked = Db.ToBoolean(dr["IsBlocked"]);
            ObjFriend.IsMailSent = Db.ToBoolean(dr["IsMailSent"]);
            ObjFriend.IsRead = Db.ToBoolean(dr["IsRead"]);
            ObjFriend.LastRequestedDate = Db.ToDateTime(dr["LastRequestedDate"]);
            return ObjFriend;
        }

        #endregion
    }
}
