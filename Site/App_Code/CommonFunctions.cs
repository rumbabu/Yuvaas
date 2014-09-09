using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Web;
using System.IO;
using System.Net;
using System.Text;
using System.Net.Mail;
using System.Configuration;

namespace Yuvaas
{
    public static class CommonFunctions
    {

        #region [Validation]

        public static Boolean IsNull(Object obj)
        {
            Boolean boolReturn = false;

            try
            {
                switch (obj.GetType().ToString())
                {
                    case "DataSet":
                        {
                            var ds = (DataSet)obj;

                            if (ds != null)
                                if (ds.Tables.Count > 0)
                                    if (ds.Tables[0].Rows.Count > 0)
                                        boolReturn = true;

                            break;
                        }
                    case "DataTable":
                        {
                            var dt = (DataTable)obj;

                            if (dt != null)
                                if (dt.Rows.Count > 0)
                                    boolReturn = true;

                            break;
                        }
                    case "DataRow":
                        {
                            var dr = (DataTable)obj;

                            if (dr != null)
                                boolReturn = true;

                            break;
                        }
                    default:
                        {
                            //Do nothing.
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                // LogError(ex, WINIT.ErrorLog.LogSeverity.Error);
            }

            return boolReturn;
        }

        #endregion

        #region [Type casting]

        public static Int32 getIntValue(object objTest)
        {
            Int32 functionReturnValue = default(Int32);
            try
            {
                if (((objTest != null)) && ((!object.ReferenceEquals(objTest, System.DBNull.Value))))
                {
                    functionReturnValue = Convert.ToInt32(objTest);
                }
                else if (((objTest == null)) || ((object.ReferenceEquals(objTest, System.DBNull.Value))))
                {
                    functionReturnValue = 0;
                }

            }
            catch (Exception ex)
            {
                functionReturnValue = 0;
                //(new WINIT.ErrorLog.ErrorLog()).Log(ex, "Getting Integer Value", "getIntValue", "Common Functions");
            }

            return functionReturnValue;

        }



        public static string GetFormattedDouble(object obj)
        {
            try
            {
                if (obj != null && (!ReferenceEquals(obj, DBNull.Value)) && obj.ToString() != "")
                {
                    //return string.Format("{0:#,###,###.##}", Math.Round(Convert.ToDouble(obj.ToString()), 2).ToString());
                    string value = obj.ToString();
                    string formattedValue = "---";

                    if (value.Length == 0 || double.Parse(value) == 0)
                    {
                        formattedValue = "---";
                    }
                    else
                    {
                        double amount = double.Parse(value);
                        string fomrat = "{0:0,0}";

                        if (amount > Math.Floor(amount))
                        {
                            fomrat = "{0:0,0.00}";
                        }

                        if (float.Parse(value) < 0)
                        {
                            formattedValue = "<span style='color: red;'>(" + String.Format(fomrat, (0 - double.Parse(value))) + ")</span>";
                        }
                        else
                        {
                            formattedValue = String.Format(fomrat, double.Parse(value));
                        }
                    }
                    return formattedValue;
                }
            }
            catch (Exception ex) { }
            return "0.00";
        }
        public static string GetStringValue(object objTest)
        {
            try
            {
                return (objTest != null) && (!object.ReferenceEquals(objTest, System.DBNull.Value)) ? objTest.ToString() : "";
            }
            catch (Exception ex) { }
            return "";
        }

        public static string GetSubstring(object objTest, int length)
        {
            string strValue = "";
            if ((!object.ReferenceEquals(objTest, System.DBNull.Value)))
            {
                strValue = Convert.ToString(objTest);

                if (strValue.Length > length)
                {
                    strValue = strValue.Substring(0, (length > 3) ? length - 3 : length) + "...";
                }
            }

            return strValue;
        }

        public static double getDoubleValue(object objTest)
        {
            double functionReturnValue = 0;
            try
            {

                if ((!object.ReferenceEquals(objTest, System.DBNull.Value)))
                {
                    functionReturnValue = Convert.ToDouble(objTest);
                }
                else if ((object.ReferenceEquals(objTest, System.DBNull.Value)))
                {
                    functionReturnValue = 0.0;
                }

            }
            catch (Exception ex)
            {
                functionReturnValue = 0.0;
                //(new WINIT.ErrorLog.ErrorLog()).Log(ex, "Getting Double Value", "getIntValue", "Common Functions");
            }

            return functionReturnValue;

        }

        public static decimal getDecimalValue(object objTest)
        {
            decimal functionReturnValue = default(decimal);
            if ((!object.ReferenceEquals(objTest, System.DBNull.Value)))
            {
                functionReturnValue = Convert.ToDecimal(objTest);
            }
            else if ((object.ReferenceEquals(objTest, System.DBNull.Value)))
            {
                functionReturnValue = (decimal)0.0;
            }
            return functionReturnValue;
        }

        public static decimal getDecimalValueFromString(object objTest)
        {
            decimal functionReturnValue = default(decimal);
            if ((!object.ReferenceEquals(objTest, System.DBNull.Value)) && (!object.ReferenceEquals(objTest, "")))
            {
                functionReturnValue = Convert.ToDecimal(objTest);
            }
            else if ((object.ReferenceEquals(objTest, System.DBNull.Value)) || (object.ReferenceEquals(objTest, "")))
            {
                functionReturnValue = (decimal)0.0;
            }
            return functionReturnValue;
        }

        public static bool getBooleanValue(object objStatus)
        {
            bool returnVal = false;

            if ((!object.ReferenceEquals(objStatus, System.DBNull.Value)))
            {
                if (objStatus.ToString().ToLower() == "true" || objStatus.ToString().ToLower() == "1" || objStatus.ToString().ToLower() == "y" || objStatus.ToString().ToLower() == "active")
                {
                    returnVal = true;
                }

            }

            return returnVal;
        }

        public static string getDateTimeDDMMYYY(string strDate)
        {
            string strMMDDyyyy = string.Empty;
            if (string.IsNullOrEmpty(strDate) == false)
            {

                string[] arrDate = strDate.Split(new char[] { '.', '/' });
                if (arrDate.Length == 3)
                {
                    //DateTime dtDate = new DateTime(Convert.ToInt32(arrDate[2].ToString()), Convert.ToInt32(arrDate[0].ToString()), Convert.ToInt32(arrDate[1].ToString()));
                    strMMDDyyyy = arrDate[1].ToString() + "/" + arrDate[0].ToString() + "/" + arrDate[2].ToString();
                }
                else if ((arrDate.Length == 2) || (arrDate.Length == 1))
                {
                    strMMDDyyyy = "01/01/1900";
                }

            }
            else if (string.IsNullOrEmpty(strDate) == true)
            {
                strMMDDyyyy = "01/01/1900";
            }
            return strMMDDyyyy;

        }

        public static String Serialize<T>(this T source)
        {
            var xDoc = new XDocument();
            var xSerzer = new XmlSerializer(typeof(T));
            using (var xWriter = xDoc.CreateWriter())
            {
                xSerzer.Serialize(xWriter, source);
                xWriter.Close();
            }
            xDoc.Root.RemoveAttributes();

            return xDoc.ToString();
        }

        public static T DeSerializeData<T>(this T source, String ResponseString, String RootElement)
        {
            XmlSerializer ser;
            XmlRootAttribute xRoot = new XmlRootAttribute();
            xRoot.ElementName = RootElement; //xRoot.ElementName = "Repricing";//"Booking"
            xRoot.IsNullable = true;
            ser = new XmlSerializer(typeof(T), xRoot);
            StringReader stringReader;
            stringReader = new StringReader(ResponseString);
            XmlTextReader xmlReader;
            xmlReader = new XmlTextReader(stringReader);
            T obj;
            obj = (T)ser.Deserialize(xmlReader);
            xmlReader.Close();
            stringReader.Close();
            return obj;
        }
        #endregion

        public static string GetImageExtension(string strImage)
        {
            string[] arrImage = strImage.Split('.');
            string strExt = arrImage[arrImage.Length - 1];

            return strExt;
        }

        /// <summary>
        /// To get the file content as string.
        /// </summary>
        /// <param name="strEmailFilePath">string</param>
        /// <returns>string</returns>
        public static string GetFileContent(string strEmailFilePath)
        {
            StreamReader srFile = null;
            string strEmailBody = "";
            try
            {
                srFile = File.OpenText(HttpContext.Current.Server.MapPath(strEmailFilePath));
                strEmailBody = srFile.ReadToEnd();
            }
            catch { }
            finally
            {
                if (srFile != null)
                    srFile.Close();
            }
            return strEmailBody;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="Request">string</param>
        /// <param name="Server">string</param>
        /// <param name="Method">string</param>
        /// <returns>Response as string</returns>
        public static string POSTandReceiveData(string Request, string Server, string Method)
        {
            // Set encoding & get content Length
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] data = encoding.GetBytes(Request);

            // Prepare post request
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Server);
            request.Method = Method;

            if (request.Method.ToUpper() == "POST")
            {
                request.ContentType = "application/xml";
                request.ContentLength = data.Length;

                Stream requestStream = request.GetRequestStream();
                // Send the data
                requestStream.Write(data, 0, data.Length);
                requestStream.Close();
            }

            WebResponse locationResponse = null;
            string response = string.Empty;
            try
            {
                locationResponse = request.GetResponse();
                StreamReader sr = new StreamReader(locationResponse.GetResponseStream());
                response = sr.ReadToEnd();
                sr.Close();
            }
            catch (Exception exc)
            {
                response = exc.ToString();
            }
            finally
            {
                if ((locationResponse != null))
                    locationResponse.Close();
            }

            return response;
        }

        public static string GetEmailTemplateContent(string strEmailFilepath)
        {
            string functionReturnValue = null;
            StreamReader swfile = null;
            string strEmailBody = string.Empty;
            try
            {
                swfile = File.OpenText(HttpContext.Current.Server.MapPath(strEmailFilepath));
                strEmailBody = swfile.ReadToEnd();
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (swfile != null)
                {
                    swfile.Close();
                }
            }
            if (strEmailBody.Length > 0)
            {
                functionReturnValue = strEmailBody;
            }
            else
            {
                functionReturnValue = "";
            }
            return functionReturnValue;
        }

        public static bool SendEmail(string fromEmail, string toEmail, string subject, string message, bool isHTML, ref string response)
        {
            return SendEmail(fromEmail, toEmail, subject, message, isHTML, ref response, "");
        }

        public static bool SendEmail(string fromEmail, string toEmail, string subject, string message, bool isHTML, ref string response, string cc)
        {
            return SendEmail(fromEmail, toEmail, subject, message, isHTML, ref response, "", null);
        }

        public static bool SendEmail(string fromEmail, string toEmail, string subject, string message, bool isHTML, ref string response, string cc, IList<Attachment> attachments)
        {
            string smtphost = ConfigurationManager.AppSettings["SMTPServer"].ToString();
            int smtpport = 0;
            if (ConfigurationManager.AppSettings["SMTPPORT"] != null)
            {
                smtpport = Convert.ToInt32(ConfigurationManager.AppSettings["SMTPPORT"]);
            }

            //string smtpuser = ConfigurationManager.AppSettings["FROMEMAIL"].ToString();
            //string smtppwd = ConfigurationManager.AppSettings["FROMPWD"].ToString();

            MailMessage msg = new MailMessage(fromEmail, toEmail);
            SmtpClient NirmalMail = new SmtpClient();
            NirmalMail.Host = smtphost;
            //if (smtpport > 0)
            //    NirmalMail.Port = smtpport;
            //NirmalMail.Credentials = new System.Net.NetworkCredential(smtpuser, smtppwd);

            //NirmalMail.EnableSsl = true;

            msg.Subject = subject;
            msg.Body = message;
            msg.IsBodyHtml = isHTML;

            if (attachments != null)
            {
                if (attachments.Count > 0)
                {
                    foreach (Attachment attachment in attachments)
                    {
                        msg.Attachments.Add(attachment);
                    }
                }
            }

            if (cc.Length > 0)
            {
                msg.CC.Add(new MailAddress(cc));
            }

            try
            {
                NirmalMail.Send(msg);
            }
            catch (Exception exception)
            {
                response = exception.Message;
                return false;
            }

            return true;
        }

        public static string DecodeURL(object obj)
        {
            string strTemp = Convert.ToString(obj);
            string strDecoded = HttpUtility.UrlDecode(strTemp);
            byte[] strBytes = System.Convert.FromBase64String(strDecoded);
            string strBase64 = System.Text.Encoding.UTF8.GetString(strBytes);
            return strBase64;
        }

        public static string EncodeURL(object obj)
        {
            string strTemp = Convert.ToString(obj);
            byte[] strBytes = System.Text.Encoding.UTF8.GetBytes(strTemp);
            string strBase64 = System.Convert.ToBase64String(strBytes);
            string strEncoded = HttpUtility.UrlEncode(strBase64);
            return strEncoded;
        }

        public static string BuildURL(string url)
        {
            string applicationPath = "/";
            string host = "/";
            string protocol = "http://";
            
            applicationPath = HttpContext.Current.Request.ApplicationPath;
            host = HttpContext.Current.Request.Url.Host;

            if (HttpContext.Current.Request.ServerVariables["https"].ToString().ToLower() == "on")
            {
                protocol = "https://";
            }

            applicationPath = (applicationPath == "/") ? "" : applicationPath;

            url = protocol + host + applicationPath + url;
            if (url.IndexOf(applicationPath + applicationPath + "/") > -1)
            {
                url = url.Replace((applicationPath + applicationPath + "/"), applicationPath + "/");
            }
            return url;
        }

        public static string getFormattedDate(DateTime dt)
        {
            string returnString = string.Empty;
            try
            {
                if (DateTime.MinValue != dt)
                {
                    int year = dt.Year;
                    string month = dt.Month.ToString();
                    string day = dt.Day.ToString();
                    string hour = dt.Hour.ToString();
                    string minute = dt.Minute.ToString();
                    returnString = year + "-" + ((month.ToString().Length == 1) ? ("0" + month) : month) + "-" + ((day.ToString().Length == 1) ? ("0" + day) : day) + " " + ((hour.ToString().Length == 1) ? ("0" + hour) : hour) + ":" + ((minute.ToString().Length == 1) ? ("0" + minute) : minute) + ":00";
                }
                else
                {
                    returnString = DateTime.MinValue.ToString();
                }
            }
            catch { }
            return returnString;
        }

        public static string GetApplicationPath()
        {
            string protocol = "http://", host = "/", appPath = "/";

            host = HttpContext.Current.Request.Url.Host;
            appPath = HttpContext.Current.Request.ApplicationPath;

            if (HttpContext.Current.Request.ServerVariables["https"].ToUpper() == "ON")
                protocol = "https://";

            if (appPath == "/")
                appPath = "";

            return protocol + host + appPath;
        }
    }
}