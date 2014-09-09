using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class CommentDetails
    {
        public CommentDetails()
        {
            CommentList = new List<Comment>();
        }
        public IList<Comment> CommentList { get; set; }

        public int PageCount { get; set; }
    }

    public class Comment
    {
        /// <summary>
        /// Get or Sets Comment Id
        /// </summary>
        public Guid CommentId { get; set; }

        /// <summary>
        /// Get or Sets Comment
        /// </summary>
        public string CommentName { get; set; }

        /// <summary>
        /// Get or Sets Status Id
        /// </summary>
        public Guid StatusId { get; set; }
        /// <summary>
        /// Get or Sets PhotoId
        /// </summary>
        public Guid PhotoId { get; set; }

        /// <summary>
        /// Get or Sets UserId
        /// </summary>
        public Guid UserId { get; set; }

        /// <summary>
        /// Get or Sets CreatedDate
        /// </summary>
        public string CreatedDate { get; set; }

        /// <summary>
        /// Get or Sets ModifiedDate
        /// </summary>
        public string ModifiedDate { get; set; }

        /// <summary>
        /// Get or Sets UserName
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// Get or Sets UserImage
        /// </summary>
        public string UserImage { get; set; }

        /// <summary>
        /// Get or Sets IsCommentLiked
        /// </summary>
        public bool IsCommentLiked { get; set; }

        /// <summary>
        /// Get or Sets Comment LikeId
        /// </summary>
        public Guid CommentLikeId { get; set; }
    }
}
