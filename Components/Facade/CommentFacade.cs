using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//User Defiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class CommentFacade
    {
        public CommentDetails SelLatestCommentsByStatusId(Guid StatusId)
        {
            return new CommentDao().SelLatestCommentsByStatusId(StatusId);
        }
        public IList<Comment> SelAll(Guid StatusId)
        {
            return new CommentDao().SelAll(StatusId);
        }

        public Guid InsertComment(Comment objComment)
        {
            return new CommentDao().InsertComment(objComment);
        }

        public int DeleteComment(Guid CommentId)
        {
            return new CommentDao().DeleteComment(CommentId);
        }
    }
}
