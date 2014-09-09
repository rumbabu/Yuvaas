using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class MessageDetails
    {
        public MessageDetails()
        {
            MessageList = new List<Message>();
        }

        public IList<Message> MessageList { get; set; }

        public int PageCount { get; set; }
    }

    public class Message
    {
        public Guid MessageId { get; set; }
        public Guid FromUserId { get; set; }
        public Guid ToUserId { get; set; }
        public string MessageDesc { get; set; }
        public bool IsRead { get; set; }
        public string Createdon { get; set; }
        public string FromUserName { get; set; }
        public string FromUserImage { get; set; }
        public string ToUserName { get; set; }
        public string ToUserImage { get; set; }
    }
}
