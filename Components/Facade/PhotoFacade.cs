using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//User Defiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class PhotoFacade
    {
        public IList<Photo> SelAll()
        {
            return new PhotoDao().SelAll();
        }

        public IList<Photo> SelAllByPaging(string SortBy, string SearchString, int maximumRows, int startRowIndex)
        {
            return new PhotoDao().SelAllByPaging(SortBy, SearchString, maximumRows, startRowIndex);
        }

        public IList<Photo> SelPostsForTimeLine(Guid UserId)
        {
            return new PhotoDao().SelPostsForTimeLine(UserId);
        }

        public IList<Photo> SelPostsForWall(Guid LoggedInUserId, Guid SelectedUserId)
        {
            return new PhotoDao().SelPostsForWall(LoggedInUserId, SelectedUserId);
        }

        public int GetPhotoCount(string SearchString)
        {
            return new PhotoDao().GetPhotoCount(SearchString);
        }

        public int InsertPhoto(Photo objPhoto)
        {
            return new PhotoDao().InsertPhoto(objPhoto);
        }

        /// <summary>
        /// Function : SharePost
        /// Description : Creates a Duplicate of selected post on the user wall
        /// Inputs : Photo(obj)
        /// </summary>
        /// <returns>int</returns>
        public int SharePost(Photo objPhoto)
        {
            return new PhotoDao().SharePost(objPhoto);
        }

        public int DeletePhoto(Guid PhotoId)
        {
            return new PhotoDao().DeletePhoto(PhotoId);
        }
    }
}
