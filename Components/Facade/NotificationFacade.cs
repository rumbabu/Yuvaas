using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Yuvaas;
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

/// <summary>
/// Summary description for NotificationFacade
/// </summary>
namespace Yuvaas.BusinessLayer.Facade
{
    public class NotificationFacade
    {
        public NotificationDetails GetNotifications(int StartIndex, int MaxSize)
        {
            return new NotificationDao().GetNotifications(StartIndex, MaxSize);
        }
    }
}
