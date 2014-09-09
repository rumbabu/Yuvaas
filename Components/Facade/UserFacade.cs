using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

/// <summary>
/// Summary description for UserFacade
/// </summary>
namespace Yuvaas.BusinessLayer.Facade
{
    public class UserFacade
    {

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
            return new UserDao().CheckLogin(username, password);
        }

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
            return new UserDao().GetAllUsersExcludingFriends(UserId, StartIndex, MaxSize, SearchString, SortExpression);
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
            return new UserDao().GetAllFriendsByUserId(UserId);
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
            return new UserDao().GetAllFriendRequests(UserId);
        }

        public User GetProfileByUserId(Guid UserId)
        {
            return new UserDao().GetProfileByUserId(UserId);
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
            return new UserDao().UpdateUser(objUser);
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
            return new UserDao().InsertUser(objUser);
        }
    }
}
