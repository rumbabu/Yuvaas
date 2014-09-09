using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//User Defiened Namespaces
using Yuvaas.BusinessLayer.BusinessObjects;
using Yuvaas.DataLayer.DataObjects;

namespace Yuvaas.BusinessLayer.Facade
{
    public class MessageFacade
    {

        #region [Select Methods]

        public IList<Message> SelMessagesForDefaultUser(Guid FromUserId)
        {
            return new MessageDao().SelMessagesForDefaultUser(FromUserId);
        }

        public IList<Message> SelAllToUserId(Guid FromUserId, Guid ToUserId)
        {
            return new MessageDao().SelAllToUserId(FromUserId, ToUserId);
        }

        public IList<Message> SelAllFromUserId(Guid FromUserId)
        {
            return new MessageDao().SelAllFromUserId(FromUserId);
        }

        public MessageDetails GetAllMessagesForSent(int startRowIndex, int maximumRows, string SearchString, string SortBy, Guid FromUserId)
        {
            return new MessageDao().GetAllMessagesForSent(startRowIndex, maximumRows, SearchString, SortBy, FromUserId);
        }

        public MessageDetails GetAllMessagesForInbox(int startRowIndex, int maximumRows, string SearchString, string SortBy, Guid ToUserId)
        {
            return new MessageDao().GetAllMessagesForInbox(startRowIndex, maximumRows, SearchString, SortBy, ToUserId);
        }

        #endregion

        #region [Insert Methods]

        public int InsertMessage(Guid FromUserId, string ToUserNames, string MessageDesc)
        {
            return new MessageDao().InsertMessage(FromUserId, ToUserNames, MessageDesc);
        }

        #endregion

        #region [Delete Methods]

        public int DeleteMessage(string MessageIds)
        {
            return new MessageDao().DeleteMessage(MessageIds);
        }

        #endregion
    }
}
