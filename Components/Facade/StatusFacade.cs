using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//User Defiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class StatusFacade
    {
        public IList<Status> SelAll()
        {
            return new StatusDao().SelAll();
        }

        public IList<Status> SelAllByPaging(string SortBy, string SearchString, int maximumRows, int startRowIndex)
        {
            return new StatusDao().SelAllByPaging(SortBy, SearchString, maximumRows, startRowIndex);
        }

        public IList<Status> SelPostsForTimeLine(Guid UserId)
        {
            return new StatusDao().SelPostsForTimeLine(UserId);
        }
        public IList<Status> SelPhotosOnly(Guid UserId)
        {
            return new StatusDao().SelPhotosOnly(UserId);
        }

        public IList<Status> SelPostsForWall(Guid LoggedInUserId, Guid SelectedUserId)
        {
            return new StatusDao().SelPostsForWall(LoggedInUserId, SelectedUserId);
        }

        public IList<Status> SelPostsForWallByPaging(Guid LoggedInUserId, Guid SelectedUserId, string searchStriing, string sortBy, int startIndex, int pageSize, out int count)
        {
            return new StatusDao().SelPostsForWallByPaging(LoggedInUserId, SelectedUserId, searchStriing, sortBy, startIndex, pageSize, out count);
        }

        public int GetStatusCount(string SearchString)
        {
            return new StatusDao().GetStatusCount(SearchString);
        }

        public int InsertStatus(Status objStatus)
        {
            return new StatusDao().InsertStatus(objStatus);
        }

        /// <summary>
        /// Function : SharePost
        /// Description : Creates a Duplicate of selected post on the user wall
        /// Inputs : Status(obj)
        /// </summary>
        /// <returns>int</returns>
        public int SharePost(Status objStatus)
        {
            return new StatusDao().SharePost(objStatus);
        }

        public int DeleteStatus(Guid StatusId)
        {
            return new StatusDao().DeleteStatus(StatusId);
        }

        public IList<Status> SelNewsFeedByPaging(Guid UserId, int maximumRows, int startRowIndex)
        {
            return new StatusDao().SelNewsFeedByPaging(UserId, maximumRows, startRowIndex);
        }

        public int SelNewsFeedCount(Guid UserId)
        {
            return new StatusDao().SelNewsFeedCount(UserId);
        }
    }
}
