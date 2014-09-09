using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class Like
    {
        /// <summary>
        /// Get or Sets Like Id
        /// </summary>
       public Guid LikeId { get; set; }

        /// <summary>
        /// Get or Sets IsLiked
        /// </summary>
       public Boolean IsLiked { get; set; }

        /// <summary>
        /// Get or Sets Status Id
        /// </summary>
       public Guid StatusId { get; set; }

        /// <summary>
        /// Get or Sets UserId
        /// </summary>
       public Guid UserId { get; set; }

        /// <summary>
        /// Get or Sets CreatedDate
        /// </summary>
       public DateTime CreatedDate { get; set; }

        /// <summary>
        /// Get or Sets ModifiedDate
        /// </summary>
       public DateTime ModifiedDate { get; set; }
    }
}
