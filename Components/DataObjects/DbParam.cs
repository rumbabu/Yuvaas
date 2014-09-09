using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace Yuvaas.DataLayer.DataObjects
{
    public class DbParam
    {
        #region [Constructor]

        public DbParam()
        {

        }

        public DbParam(String paramName, Object paramValue, SqlDbType paramType)
        {
            ParamName = paramName;
            ParamValue = paramValue;
            ParamType = paramType;
            ParamDirection = ParameterDirection.Input;
        }

        public DbParam(String paramName, Object paramValue, String paramSourceColumn, SqlDbType paramType)
            : this(paramName, paramValue, paramType)
        {
            ParamSourceColumn = paramSourceColumn;
        }

        public DbParam(String paramName, Object paramValue, SqlDbType paramType, ParameterDirection paramDirection)
            : this(paramName, paramValue, paramType)
        {
            ParamDirection = paramDirection;
        }
        public DbParam(string paramName, string paramValue, string paramSourceColumn, SqlDbType paramType, ParameterDirection paramDirection, int Size)
        {
            this.ParamDirection = paramDirection;
            this.ParamName = paramName;
            this.ParamType = paramType;
            this.ParamValue = paramValue;
            this.ParamSourceColumn = paramSourceColumn;
            this.Size = Size;
        }

        #endregion

        #region [Properties]

        public String ParamName { get; set; }

        public Object ParamValue { get; set; }

        public String ParamSourceColumn { get; set; }

        public SqlDbType ParamType { get; set; }

        public ParameterDirection ParamDirection { get; set; }

        public int Size { get; set; }

        #endregion
    }
}