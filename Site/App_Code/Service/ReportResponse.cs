using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace Yuvaas.Service.Response
{
    public class ReportResponse : BaseResponse
    {
        [DataMember]
        public int WidgetId { get; set; }
        [DataMember]
        public string WidgetName { get; set; }
        [DataMember]
        public int ReportsCount { get; set; }
        [DataMember]
        public Chart[] ReportCharts { get; set; }
    }
}