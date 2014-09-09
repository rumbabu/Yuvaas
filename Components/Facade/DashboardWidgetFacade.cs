using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class DashboardWidgetFacade
    {
        DashboardWidgetDao dao;

        public DashboardWidgetFacade()
        {
            dao = new DashboardWidgetDao();
        }

        public List<DashboardWidget> GetSelected(Guid UserId)
        {
            return dao.GetSelected(UserId);
        }
    }
}
