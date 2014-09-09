using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class Photo
    {
        public Photo()
        {
        }
        public IList<Comment> comments { get; set; }
        public Guid PhotoId { get; set; }
        public String PhotoUrl { get; set; }
        public String PhotoStatus { get; set; }
        public String PhotoType { get; set; }
        public Boolean IsShared { get; set; }
        public Boolean IsLiked { get; set; }
        public Guid UserId { get; set; }
        public Int32 PermissionId { get; set; }
        public Boolean IsHidden { get; set; }
        public Boolean IsArchived { get; set; }
        public Boolean IsShared1 { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string UserImage { get; set; }
        public string UserName { get; set; }
    }
}
