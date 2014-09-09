using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Yuvaas.BusinessLayer.BusinessObjects
{
    public class DashboardWidget
    {
        public int DashboardWidgetId { get; set; }
        public String WidgetName { get; set; }
        public Boolean IsActive { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        public Boolean IsSelected { get; set; }
    }
}
