using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//UserDefiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;


namespace Yuvaas.BusinessLayer.Facade
{
   public class CommentLikeFacade
    {
       public IList<CommentLike> SelAll()
       {
           return new CommentLikeDao().SelAll();
       }

       public IList<CommentLike> LikeSelByUserId(Guid UserId)
       {
           return new CommentLikeDao().LikeSelByUserId(UserId);
       }

       public Guid InsertCommentLike(CommentLike objCommentLike)
       {
           return new CommentLikeDao().InsertCommentLike(objCommentLike);
       }
    }
}
