using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace Yuvaas.Service.Response
{
    public class BaseResponse
    {
        [DataMember]
        public string Message { get; set; }
        [DataMember]
        public int StatusCode { get; set; }
        [DataMember]
        public int ModifiedDate { get; set; }
        [DataMember]
        public int ModifiedTime { get; set; }
        [DataMember(IsRequired = false, EmitDefaultValue = false)]
        public DateTime ServerDateTime { get; set; }
    }
}