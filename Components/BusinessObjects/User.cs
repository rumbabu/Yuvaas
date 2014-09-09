using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Yuvaas.BusinessLayer.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public class User
    {
        /// <summary>
        /// 
        /// </summary>
        public Guid UserId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FirstName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string LastName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Phone { get; set; }
        public string EmailId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Password { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string LoginId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string About { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string UserImage { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime DOB { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string City { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string State { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Country { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Gender { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string WorkAt { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Designation { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CollegeAt { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string SchoolAt { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public Friend friend { get; set; }

        /// <summary>
        /// UserCode same as MyStore
        /// </summary>
        public string UserCode { get; set; }
    }
}
