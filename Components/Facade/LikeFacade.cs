using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//UserDefiend Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class LikeFacade
    {
        public Guid InsertLike(Like objLike)
        {
            return new LikeDao().InsertLike(objLike);
        }

        public IList<Like> LikeSelByUserId(Guid UserId)
        {
            return new LikeDao().LikeSelByUserId(UserId);
        }

        public IList<Like> SelAll()
        {
            return new LikeDao().SelAll();
        }
    }
}
