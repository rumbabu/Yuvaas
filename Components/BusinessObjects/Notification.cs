using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class NotificationDetails
    {
        public NotificationDetails()
        {
            NotificationList = new List<Notification>();
        }
        public IList<Notification> NotificationList { get; set; }

        public int PageCount { get; set; }
    }
   
    public class Notification
    {
        public Boolean IsPost { get; set; }
        public Boolean IsShared { get; set; }
        public Boolean IsCommented { get; set; }
        public Boolean IsLiked { get; set; }
        public Boolean IsCommentLiked { get; set; }

        public Guid StatusId { get; set; }
        public String StatusName { get; set; }
        public String StatusType { get; set; }
        public String StatusUrl { get; set; }
        public String CreatedDate { get; set; }

        public Guid CommentId { get; set; }
        public String CommentName { get; set; }


        public Guid UserId { get; set; }
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public String UserImage { get; set; }

        public Guid NUserId { get; set; }
        public String NFirstName { get; set; }
        public String NLastName { get; set; }
        public String NUserImage { get; set; }
   
    }
}
