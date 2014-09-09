using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class UserDashboardWidgetFacade
    {
        UserDashboardWidgetDao dao;

        public UserDashboardWidgetFacade()
        {
            dao = new UserDashboardWidgetDao();
        }

        public int SaveWidgets(string widgetIds, Guid userId)
        {
            return dao.SaveWidgets(widgetIds, userId);
        }
    }
}
