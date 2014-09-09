using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//UserDefiened Namespaces
using Yuvaas.DataLayer.DataObjects;
using Yuvaas.BusinessLayer.BusinessObjects;

namespace Yuvaas.BusinessLayer.Facade
{
  public  class PermissionsFacade
    {

      public IList<Permissions> SelAll()
      {
          return new PermissionsDao().SelAll();
      }
    }
}
