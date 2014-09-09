using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class Friend
    {
        /// <summary>
        /// 
        /// </summary>
        public Guid UserId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public Guid FriendUserId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool IsMailSent { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool IsAccepted { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool IsBlocked { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool IsRead { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public DateTime LastRequestedDate { get; set; }
    }
}
