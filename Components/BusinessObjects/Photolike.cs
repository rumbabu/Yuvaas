using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class Photolike
    {
        public Guid PhotoLikeId { get; set; }
        public Guid PhotoId { get; set; }
        public Boolean IsLiked { get; set; }
        public Guid UserId { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
