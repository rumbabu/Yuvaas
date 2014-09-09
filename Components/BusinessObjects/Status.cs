using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class StatusDetails
    {
        public StatusDetails()
        {
            Statuslist = new List<Status>();
        }

        public List<Status> Statuslist { get; set; }

        public int PageCount { get; set; }
    }

    public class Status
    {
        public Status()
        {
            this.comments = new List<Comment>();
        }
        /// <summary>
        /// Get or Sets Status Id
        /// </summary>
        public Guid StatusId { get; set; }

        /// <summary>
        /// Get or Sets Status
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// Get or Sets Status Type
        /// </summary>
        public string StatusType { get; set; }

        /// <summary>
        /// Get or Sets Status Url
        /// </summary>
        public string StatusUrl { get; set; }

        /// <summary>
        /// Get or Sets UserId
        /// </summary>
        public Guid UserId { get; set; }

        /// <summary>
        /// Get or Sets Permission Id
        /// </summary>
        public int PermissionId { get; set; }

        /// <summary>
        /// Get or Sets IsHidden
        /// </summary>
        public bool IsHidden { get; set; }

        /// <summary>
        /// Get or Sets IsArchived
        /// </summary>
        public bool ISArchived { get; set; }

        /// <summary>
        /// Get or Sets IsArchived
        /// </summary>
        public bool IsShared { get; set; }

        /// <summary>
        /// Get or Sets Status Created Date
        /// </summary>
        public string CreatedDate { get; set; }

        /// <summary>
        /// Get or Sets UserName
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// Get or Sets UserImage
        /// </summary>
        public string UserImage { get; set; }

         /// <summary>
        /// Get or Sets Is Liked
        /// </summary>
        public bool IsLiked { get; set; }

        /// <summary>
        /// Get or Sets LikeId
        /// </summary>
        public Guid LikeId { get; set; }

        public int LikesCount { get; set; }

        public IList<Comment> comments { get; set; }
    }
}
