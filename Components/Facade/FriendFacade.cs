using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class FriendFacade
    {
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
            return new FriendDao().Insert(objFriend);
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
            return new FriendDao().AcceptFriend(UserId, FriendUserId);
        }
    }
}
