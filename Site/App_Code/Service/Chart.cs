using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace Yuvaas.Service.Response
{
    public class Chart
    {
        [DataMember]
        public string ChartName { get; set; }
        [DataMember]
        public string ChartType { get; set; }
        [DataMember]
        public string ChartContent { get; set; }
    }
}