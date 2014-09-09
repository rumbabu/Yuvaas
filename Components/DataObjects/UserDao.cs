using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas.BusinessLayer.BusinessObjects;
using System.Data;
using Yuvaas.DataLayer.DataObjects;
using System.Web.Security;

/// <summary>
/// Summary description for UserDao
/// </summary>
namespace Yuvaas.DataLayer.DataObjects
{
    public class UserDao
    {
        #region [Member parameters]
        User ObjUser;
        DataTable dt;
        DataRow dr;
        int intReturn;

        #endregion

        /// <summary>
        /// Function : CheckLogin
        /// Description :Check valid user
        /// Inputs : username, password
        /// <return>
        /// output : User class object
        /// </return>
        /// </summary>
        public User CheckLogin(string username, string password)
        {
            User objUser = null;
            DbParam[] param = new DbParam[2];
            param[0] = new DbParam("@LoginId", username, SqlDbType.VarChar);
            param[1] = new DbParam("@Password", password, SqlDbType.VarChar);

            dr = Db.GetDataRow("sp_tblUser_CheckLogin", param);

            if (dr != null)
            {
                GetObject(dr);
            }

            //if (Membership.ValidateUser(username, password))
            //{
            //    objUser = ForceLogin(username);
            //}
            return ObjUser;
        }

        public User ForceLogin(string UserName)
        {
            User objUser = null;
            DbParam[] param = new DbParam[] { new DbParam("@Username", UserName, SqlDbType.VarChar) };
            dr = Db.GetDataRow("sp_tblUser_ForceLogin", param);
            if (dr != null)
            {
                GetObject(dr);
            }
            return objUser;
        }

        public User GetProfileByUserId(Guid UserId)
        {
            DataSet ds = new DataSet();
            DbParam[] param = new DbParam[1];
            param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
            ds = Db.GetDataSet("sp_tblUser_GetProfileByUserId", param);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ObjUser = new User();
                    ObjUser.UserId = Db.ToGuid(dr["UserId"]);
                    ObjUser.FirstName = Db.ToString(dr["FirstName"]);
                    ObjUser.LastName = Db.ToString(dr["LastName"]);
                    ObjUser.EmailId = Db.ToString(dr["EmailId"]);
                    ObjUser.Password = Db.ToString(dr["Password"]);
                    ObjUser.LoginId = Db.ToString(dr["LoginId"]);
                    ObjUser.Description = Db.ToString(dr["Description"]);
                    ObjUser.About = Db.ToString(dr["About"]);
                    ObjUser.UserImage = Db.ToString(dr["UserImage"]);
                    ObjUser.DOB = Db.ToDateTime(dr["DOB"]);
                    ObjUser.Address = Db.ToString(dr["Address"]);
                    ObjUser.City = Db.ToString(dr["City"]);
                    ObjUser.State = Db.ToString(dr["State"]);
                    ObjUser.Country = Db.ToString(dr["Country"]);
                    ObjUser.Gender = Db.ToString(dr["Gender"]);
                    ObjUser.WorkAt = Db.ToString(dr["WorkAt"]);
                    ObjUser.Designation = Db.ToString(dr["Designation"]);
                    ObjUser.CollegeAt = Db.ToString(dr["CollegeAt"]);
                    ObjUser.SchoolAt = Db.ToString(dr["SchoolAt"]);
                    ObjUser.UserCode = Db.ToString(dr["UserCode"]);
                }
            }
            return ObjUser;
        }

        /// <summary>
        /// Function : UpdateUser
        /// Description : Uodate User
        /// Inputs : objUser
        /// </summary>
        /// <param name="objUser"></param>
        /// <returns></returns>
        public int UpdateUser(User objUser)
        {
            DbParam[] param = new DbParam[] { 
                new DbParam("@UserId", objUser.UserId, SqlDbType.UniqueIdentifier),
                new DbParam("@FirstName", objUser.FirstName, SqlDbType.NVarChar),
                new DbParam("@LastName", objUser.LastName, SqlDbType.NVarChar),
                new DbParam("@EmailId", objUser.EmailId, SqlDbType.NVarChar),
                new DbParam("@DOB", objUser.DOB, SqlDbType.DateTime),
                new DbParam("@Designation", objUser.Designation, SqlDbType.NVarChar),
                new DbParam("@WorkAt", objUser.WorkAt, SqlDbType.NVarChar),
                new DbParam("@CollegeAt", objUser.CollegeAt, SqlDbType.NVarChar),
                new DbParam("@SchoolAt", objUser.SchoolAt, SqlDbType.NVarChar),
                new DbParam("@Gender", objUser.Gender, SqlDbType.VarChar),
                new DbParam("@UserImage", objUser.UserImage, SqlDbType.NVarChar),
                new DbParam("@About", objUser.About, SqlDbType.NVarChar),
                new DbParam("@Description", objUser.Description, SqlDbType.NVarChar),
                new DbParam("@Address", objUser.Address, SqlDbType.NVarChar),
                new DbParam("@City", objUser.City, SqlDbType.NVarChar),
                new DbParam("@State", objUser.State, SqlDbType.NVarChar),
                new DbParam("@Country", objUser.Country, SqlDbType.NVarChar),
                new DbParam("@UserCode", objUser.UserCode, SqlDbType.VarChar)
                };
            return Db.Update("proc_tblUser_Update", param, true);
        }


        /// <summary>
        /// Function : InsertUser
        /// Description : Insert User
        /// Inputs : objUser
        /// </summary>
        /// <param name="objUser"></param>
        /// <returns></returns>
        public int InsertUser(User objUser)
        {
            DbParam[] param = new DbParam[] { 
                new DbParam("@FirstName", objUser.FirstName, SqlDbType.NVarChar),
                new DbParam("@LastName", objUser.LastName, SqlDbType.NVarChar),
                new DbParam("@EmailId", objUser.EmailId, SqlDbType.NVarChar),
                new DbParam("@Password", objUser.Password, SqlDbType.VarChar),
                new DbParam("@LoginId", objUser.LoginId, SqlDbType.DateTime),
                new DbParam("@DOB", objUser.DOB, SqlDbType.DateTime),
                new DbParam("@Description", objUser.Description, SqlDbType.NVarChar),
                new DbParam("@UserImage", objUser.UserImage, SqlDbType.NVarChar),
                new DbParam("@Address", objUser.Address, SqlDbType.NVarChar),
                new DbParam("@City", objUser.City, SqlDbType.NVarChar),
                new DbParam("@State", objUser.State, SqlDbType.NVarChar),
                new DbParam("@Country", objUser.Country, SqlDbType.NVarChar),
                new DbParam("@Gender", objUser.Gender, SqlDbType.VarChar),
                new DbParam("@Designation", objUser.Designation, SqlDbType.NVarChar),
                new DbParam("@WorkAt", objUser.WorkAt, SqlDbType.NVarChar),
                new DbParam("@CollegeAt", objUser.CollegeAt, SqlDbType.NVarChar),
                new DbParam("@SchoolAt", objUser.SchoolAt, SqlDbType.NVarChar),
                new DbParam("@About", objUser.About, SqlDbType.NVarChar),
                new DbParam("@Phone", objUser.Phone, SqlDbType.VarChar)
                };
            return Db.Update("sp_tblUser_INS", param, true);
        }



        #region [Friends]

        /// <summary>
        /// Function : GetAllUsersExcludingFriends
        /// Description : Get All Users except Friends
        /// Inputs : UserId
        /// <return>
        /// output : IList<User>
        /// </return>
        /// </summary>
        public IList<User> GetAllUsersExcludingFriends(Guid UserId, int StartIndex, int MaxSize, string SearchString, string SortExpression)
        {
            IList<User> objUsers = null;
            ObjUser = null;
            DataSet ds = new DataSet();
            DbParam[] param = new DbParam[] { 
                new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier),
                new DbParam("@StartIndex", StartIndex, SqlDbType.Int),
                new DbParam("@MaxSize", MaxSize, SqlDbType.Int),
                new DbParam("@SearchString", SearchString, SqlDbType.VarChar),
                new DbParam("@SortExpression", SortExpression, SqlDbType.VarChar)
            };
            ds = Db.GetDataSet("sp_tblUser_GetNonFriends", param);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                objUsers = new List<User>();
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ObjUser = new User();
                    ObjUser.friend = new Friend();
                    ObjUser.UserId = Db.ToGuid(row["UserId"]);
                    ObjUser.FirstName = Db.ToString(row["FirstName"]);
                    ObjUser.LastName = Db.ToString(row["LastName"]);
                    ObjUser.EmailId = Db.ToString(row["EmailId"]);
                    ObjUser.Password = Db.ToString(row["Password"]);
                    ObjUser.LoginId = Db.ToString(row["LoginId"]);
                    ObjUser.UserImage = Db.ToString(row["UserImage"]);
                    ObjUser.Designation = Db.ToString(row["Designation"]);
                    ObjUser.friend.UserId = Db.ToGuid(row["RUserId"]);
                    ObjUser.friend.FriendUserId = Db.ToGuid(row["FriendUserId"]);
                    ObjUser.friend.IsMailSent = Db.ToBoolean(row["IsMailSent"]);
                    ObjUser.friend.IsAccepted = Db.ToBoolean(row["IsAccepted"]);
                    ObjUser.friend.IsBlocked = Db.ToBoolean(row["IsBlocked"]);
                    ObjUser.friend.IsRead = Db.ToBoolean(row["IsRead"]);
                    ObjUser.friend.LastRequestedDate = Db.ToDateTime(row["LastReqestedDate"]);
                    objUsers.Add(ObjUser);
                }
            }
            return objUsers;
        }

        /// <summary>
        /// Function : GetAllFriendsByUserId
        /// Description : Get All Users except Friends
        /// Inputs : UserId
        /// <return>
        /// output : IList<User>
        /// </return>
        /// </summary>
        public IList<User> GetAllFriendsByUserId(Guid UserId)
        {
            IList<User> objUsers = null;
            ObjUser = null;
            DataSet ds = new DataSet();
            DbParam[] param = new DbParam[1];
            param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
            ds = Db.GetDataSet("sp_tblUser_GetFriendsByUserId", param);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                objUsers = new List<User>();

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ObjUser = new User();
                    ObjUser.UserId = Db.ToGuid(row["UserId"]);
                    ObjUser.FirstName = Db.ToString(row["FirstName"]);
                    ObjUser.LastName = Db.ToString(row["LastName"]);
                    ObjUser.EmailId = Db.ToString(row["EmailId"]);
                    ObjUser.Password = Db.ToString(row["Password"]);
                    ObjUser.LoginId = Db.ToString(row["LoginId"]);
                    ObjUser.UserImage = Db.ToString(row["UserImage"]);
                    ObjUser.Designation = Db.ToString(row["Designation"]);
                    objUsers.Add(ObjUser);
                }
            }
            return objUsers;
        }

        /// <summary>
        /// Function : GetAllFriendRequests
        /// Description : Get All friendRequests
        /// Inputs : UserId
        /// <return>
        /// output : IList<User>
        /// </return>
        /// </summary>
        public IList<User> GetAllFriendRequests(Guid UserId)
        {
            IList<User> objUsers = null;
            ObjUser = null;
            DataSet ds = new DataSet();
            DbParam[] param = new DbParam[1];
            param[0] = new DbParam("@UserId", UserId, SqlDbType.UniqueIdentifier);
            ds = Db.GetDataSet("sp_tblUser_GetFriendsRequests", param);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                objUsers = new List<User>();

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ObjUser = new User();
                    ObjUser.UserId = Db.ToGuid(row["UserId"]);
                    ObjUser.FirstName = Db.ToString(row["FirstName"]);
                    ObjUser.LastName = Db.ToString(row["LastName"]);
                    ObjUser.EmailId = Db.ToString(row["EmailId"]);
                    ObjUser.Password = Db.ToString(row["Password"]);
                    ObjUser.LoginId = Db.ToString(row["LoginId"]);
                    ObjUser.UserImage = Db.ToString(row["UserImage"]);
                    ObjUser.Designation = Db.ToString(row["Designation"]);
                    objUsers.Add(ObjUser);
                }
            }
            return objUsers;
        }

        #endregion

        #region [Mapper]

        User GetObject(DataRow dr)
        {
            ObjUser = new User();
            ObjUser.UserId = Db.ToGuid(dr["UserId"]);
            ObjUser.FirstName = Db.ToString(dr["FirstName"]);
            ObjUser.LastName = Db.ToString(dr["LastName"]);
            ObjUser.EmailId = Db.ToString(dr["EmailId"]);
            ObjUser.Password = Db.ToString(dr["Password"]);
            ObjUser.LoginId = Db.ToString(dr["LoginId"]);
            ObjUser.Description = Db.ToString(dr["Description"]);
            ObjUser.UserImage = Db.ToString(dr["UserImage"]);
            ObjUser.DOB = Db.ToDateTime(dr["DOB"]);
            ObjUser.Address = Db.ToString(dr["Address"]);
            ObjUser.City = Db.ToString(dr["City"]);
            ObjUser.State = Db.ToString(dr["State"]);
            ObjUser.Country = Db.ToString(dr["Country"]);
            ObjUser.Gender = Db.ToString(dr["Gender"]);
            ObjUser.WorkAt = Db.ToString(dr["WorkAt"]);
            ObjUser.Designation = Db.ToString(dr["Designation"]);
            ObjUser.CollegeAt = Db.ToString(dr["CollegeAt"]);
            ObjUser.SchoolAt = Db.ToString(dr["SchoolAt"]);
            ObjUser.About = Db.ToString(dr["About"]);
            return ObjUser;
        }

        #endregion
    }
}
