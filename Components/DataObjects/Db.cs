using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;

namespace Yuvaas.DataLayer.DataObjects
{
    /// <summary>
    /// class that manages all lower level ADO.NET data base access.
    /// </summary>
    public static class Db
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        #region [Insert/Update Handlers]

        /// <summary>
        /// Executes Update statements in the database.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <param name="getId"></param>
        /// <returns></returns>
        public static int Update(string spName, DbParam[] spParams, bool getId)
        {
            using (DbConnection connection = (new SqlConnection()))
            {
                int retValue = 0;
                connection.ConnectionString = connectionString;

                using (DbCommand command = (new SqlCommand()))
                {
                    command.Connection = connection;
                    command.CommandText = spName;
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandTimeout = 1800;

                    if (spParams != null)
                    {
                        AssignParameters(command, spParams);
                    }

                    connection.Open();

                    try
                    {
                        if (getId)
                        {
                            SqlParameter spParameter = new SqlParameter("lngReturn", SqlDbType.Int);
                            spParameter.Direction = ParameterDirection.ReturnValue;
                            command.Parameters.Add(spParameter);

                            command.ExecuteNonQuery();
                            retValue = int.Parse(spParameter.Value.ToString());
                        }
                        else
                        {
                            retValue = command.ExecuteNonQuery();
                        }
                        AssignOutputParameters(command, spParams);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                        }

                        connection.Dispose();
                    }

                    return retValue;
                }
            }
        }

        public static bool Update(DataSet ds, string spInsert, string spUpdate, string spDelete, DbParam[] spParams, bool getId)
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            bool blnReturnValue = true;

            using (SqlConnection connection = (new SqlConnection()))
            {
                connection.ConnectionString = connectionString;

                adapter.InsertCommand = (SqlCommand)AssignParameters(new SqlCommand(spInsert), spParams);
                adapter.UpdateCommand = (SqlCommand)AssignParameters(new SqlCommand(spUpdate), spParams);
                adapter.DeleteCommand = (SqlCommand)AssignParameters(new SqlCommand(spDelete), spParams);

                adapter.InsertCommand.CommandType = CommandType.StoredProcedure;
                adapter.UpdateCommand.CommandType = CommandType.StoredProcedure;
                adapter.DeleteCommand.CommandType = CommandType.StoredProcedure;

                adapter.InsertCommand.Connection = connection;
                adapter.UpdateCommand.Connection = connection;
                adapter.DeleteCommand.Connection = connection;
                try
                {
                    connection.Open();
                    adapter.Update(ds, ds.Tables[0].TableName);
                }
                catch (Exception ex)
                {
                    blnReturnValue = false;
                    throw ex;
                }
                finally
                {
                    if (connection.State != ConnectionState.Closed)
                    {
                        connection.Close();
                    }
                }
            }

            return blnReturnValue;
        }

        /// <summary>
        /// Executes Update statements in the database.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        public static int Update(string spName, DbParam[] spParams)
        {
            return Update(spName, spParams, false);
        }

        /// <summary>
        /// Executes Insert statements in the database. Optionally returns new identifier.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <param name="getId"></param>
        /// <returns></returns>
        public static int Insert(string spName, DbParam[] spParams, bool getId)
        {
            using (DbConnection connection = (new SqlConnection()))
            {
                int retValue = 0;
                connection.ConnectionString = connectionString;

                using (DbCommand command = (new SqlCommand()))
                {

                    command.Connection = connection;
                    command.CommandText = spName;
                    command.CommandType = CommandType.StoredProcedure;

                    if (spParams != null)
                    {
                        AssignParameters(command, spParams);
                    }

                    connection.Open();

                    try
                    {
                        if (getId)
                        {
                            SqlParameter spParameter = new SqlParameter("lngReturn", SqlDbType.Int);
                            spParameter.Direction = ParameterDirection.ReturnValue;
                            command.Parameters.Add(spParameter);

                            command.ExecuteNonQuery();
                            retValue = int.Parse(spParameter.Value.ToString());
                        }
                        else
                        {
                            retValue = command.ExecuteNonQuery();
                        }
                        AssignOutputParameters(command, spParams);

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                        }

                        connection.Dispose();
                    }

                    return retValue;
                }
            }
        }

        /// <summary>
        /// Executes Insert statements in the database.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        public static void Insert(string spName, DbParam[] spParams)
        {
            Insert(spName, spParams, false);
        }

        #endregion

        #region Data Retrieve Handlers

        /// <summary>
        ///  Populates a DataSet according to a stored procedure and parameters.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(string spName, DbParam[] spParams)
        {
            return GetDataSet(spName, spParams, null);
        }

        /// <summary>
        /// overloaded method to populate a DataSet according to a stored procedure and parameters.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <param name="Timeout"></param>
        /// <returns></returns>
        public static DataSet GetDataSet(string spName, DbParam[] spParams, int? Timeout)
        {
            using (DbConnection connection = (new SqlConnection()))
            {
                connection.ConnectionString = connectionString;

                using (DbCommand command = (new SqlCommand()))
                {
                    command.Connection = connection;
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = spName;

                    if (Timeout.HasValue)
                    {
                        command.CommandTimeout = Timeout.Value;
                    }

                    if (spParams != null)
                    {
                        AssignParameters(command, spParams);
                    }

                    using (DbDataAdapter adapter = (new SqlDataAdapter()))
                    {
                        adapter.SelectCommand = command;

                        DataSet ds = new DataSet();
                        adapter.Fill(ds);

                        return ds;
                    }
                }
            }
        }

        /// <summary>
        /// overloaded method to populate a DataTable according to a stored procedure and parameters.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        public static DataTable GetDataTable(string spName, DbParam[] spParams)
        {
            DataTable dt = null;
            DataSet ds = GetDataSet(spName, spParams);

            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                }
            }
            return dt;
        }

        /// <summary>
        /// overloaded method to populate a DataRow according to a stored procedure and parameters.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        public static DataRow GetDataRow(string spName, DbParam[] spParams)
        {
            DataRow row = null;

            DataTable dt = GetDataTable(spName, spParams);

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    row = dt.Rows[0];
                }
            }

            return row;
        }

        /// <summary>
        /// Executes a stored procedure and returns a scalar value.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        public static object GetScalar(string spName, DbParam[] spParams)
        {
            using (DbConnection connection = (new SqlConnection()))
            {
                connection.ConnectionString = connectionString;

                using (DbCommand command = (new SqlCommand()))
                {
                    command.Connection = connection;
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = spName;

                    if (spParams != null)
                    {
                        AssignParameters(command, spParams);
                    }

                    connection.Open();
                    return command.ExecuteScalar();
                }
            }
        }

        #endregion

        #region Utility methods

        /// <summary>
        /// Assigns paramets to DbCommand
        /// </summary>
        /// <param name="command"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        private static DbCommand AssignParameters(DbCommand command, DbParam[] spParams)
        {
            if (spParams != null)
            {
                foreach (DbParam spParam in spParams)
                {
                    SqlParameter spParameter = new SqlParameter();

                    spParameter.SqlDbType = spParam.ParamType;
                    spParameter.ParameterName = spParam.ParamName;
                    spParameter.Value = spParam.ParamValue;
                    spParameter.Direction = spParam.ParamDirection;
                    spParameter.SourceColumn = spParam.ParamSourceColumn;
                    spParameter.Size = spParam.Size;

                    command.Parameters.Add(spParameter);
                }
            }

            return command;
        }

        /// <summary>
        /// Assigns paramets to DbCommand
        /// </summary>
        /// <param name="command"></param>
        /// <param name="spParams"></param>
        /// <returns></returns>
        private static DbCommand AssignOutputParameters(DbCommand command, DbParam[] spParams)
        {
            if (spParams != null)
            {
                if (spParams.Length > 0)
                {
                    var outparams = from c in spParams
                                    where c.ParamDirection == ParameterDirection.InputOutput ||
                                        c.ParamDirection == ParameterDirection.Output
                                    select c;

                    foreach (DbParam param in outparams)
                    {
                        if (command.Parameters[param.ParamName] != null)
                        {
                            param.ParamValue = command.Parameters[param.ParamName].Value;
                        }
                    }
                }
            }
            return command;
        }

        /// <summary>
        /// Escapes an input string for database processing, that is, 
        /// surround it with quotes and change any quote in the string to 
        /// two adjacent quotes (i.e. escape it). 
        /// If input string is null or empty a NULL string is returned.
        /// </summary>
        /// <param name="s">Input string.</param>
        /// <returns>Escaped output string.</returns>
        public static string Escape(string s)
        {
            if (String.IsNullOrEmpty(s))
                return "NULL";
            else
                return "'" + s.Trim().Replace("'", "''") + "'";
        }

        /// <summary>
        /// Escapes an input string for database processing, that is, 
        /// surround it with quotes and change any quote in the string to 
        /// two adjacent quotes (i.e. escape it). 
        /// Also trims string at a given maximum length.
        /// If input string is null or empty a NULL string is returned.
        /// </summary>
        /// <param name="s">Input string.</param>
        /// <param name="maxLength">Maximum length of output string.</param>
        /// <returns>Escaped output string.</returns>
        public static string Escape(string s, int maxLength)
        {
            if (String.IsNullOrEmpty(s))
                return "NULL";
            else
            {
                s = s.Trim();
                if (s.Length > maxLength) s = s.Substring(0, maxLength - 1);
                return "'" + s.Trim().Replace("'", "''") + "'";
            }
        }

        /// <summary>
        /// converts an object to double value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static double ToDouble(object value)
        {
            double retValue = 0;

            if (value != DBNull.Value)
            {
                double.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }

        /// <summary>
        ///  converts an object to integer value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static int ToInteger(object value)
        {
            int retValue = 0;

            if (value != DBNull.Value)
            {
                int.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }
        /// <summary>
        ///  converts an object to long value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static long ToLong(object value)
        {
            long retValue = 0;

            if (value != DBNull.Value)
            {
                long.TryParse(value.ToString(), out retValue);
            }
            return retValue;
        }
        /// <summary>
        ///  converts an object to string value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ToString(object value)
        {
            string retValue = "";

            if (value != DBNull.Value)
            {
                retValue = value.ToString();
            }

            return retValue;
        }

        public static decimal ToDecimal(object value)
        {
            decimal retValue = 0;

            if (value != DBNull.Value)
            {
                decimal.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }

        /// <summary>
        ///  converts an object to boolean value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static bool ToBoolean(object value)
        {
            bool retValue = false;

            if (value != DBNull.Value)
            {
                bool.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }

        /// <summary>
        ///  converts an object to datetime value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static DateTime ToDateTime(object value)
        {
            DateTime retValue = new DateTime();

            if (value != DBNull.Value)
            {
                DateTime.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }

        /// <summary>
        ///  converts an object to Guid value
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static Guid ToGuid(object value)
        {
            Guid retValue = new Guid("00000000-0000-0000-0000-000000000000");

            if (value != DBNull.Value)
            {
                Guid.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }
        public static float ToFloat(object value)
        {
            float retValue = 0;

            if (value != DBNull.Value)
            {
                float.TryParse(value.ToString(), out retValue);
            }

            return retValue;
        }

        public static Int64 ToBigInteger(object value)
        {
            int retValue = 0;

            if (value != DBNull.Value)
            {
                try
                {
                    retValue = int.Parse(value.ToString());
                }
                catch (Exception ex)
                {
                }
            }

            return retValue;
        }

        public static bool IsDataExists(object obj)
        {
            if (obj != null)
            {
                switch (obj.GetType().ToString().ToUpper())
                {
                    case "SYSTEM.DATA.DATASET":
                        {
                            DataSet ds = obj as DataSet;
                            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                                return true;
                        }
                        break;
                    case "SYSTEM.DATA.DATATABLE":
                        {
                            DataTable dt = obj as DataTable;
                            if (dt != null && dt.Rows.Count > 0)
                                return true;
                        }
                        break;
                    case "SYSTEM.DATA.DATAROW":
                        {
                            DataRow dr = obj as DataRow;
                            if (dr != null)
                                return true;
                        }
                        break;
                }
            }
            return false;
        }
        #endregion
    }
}
