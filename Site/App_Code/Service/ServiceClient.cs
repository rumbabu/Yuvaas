using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Yuvaas.Service.Response;
using System.Configuration;
using OAuth;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;

namespace Yuvaas.Service
{
    public class ServiceClient
    {
        public ServiceClient()
        {
            //Constructor
        }

        public ReportResponse GetReport(String userCode, int widgetId)
        {
            ReportResponse reportResponse = new ReportResponse();

            string serverURL = ConfigurationManager.AppSettings["ServerURL"];
            string consumerKey = ConfigurationManager.AppSettings["ConsumerKey"];
            string consumerSecret = ConfigurationManager.AppSettings["ConsumerSecret"];

            var uri = new Uri(serverURL + "Services/MystoreReportServices.svc/jauth/GetReportByType");

            string url, param;
            var oAuth = new OAuthBase();
            var nonce = oAuth.GenerateNonce();
            var timeStamp = oAuth.GenerateTimeStamp();
            var signature = oAuth.GenerateSignature(uri, consumerKey,
            consumerSecret, string.Empty, string.Empty, "GET", timeStamp, nonce,
            OAuthBase.SignatureTypes.HMACSHA1, out url, out param);

            object[] reportParams = new object[4] {url,
                "UserCode=" + userCode.ToUpper() + "&ReportDate=" + DateTime.Now.ToString() + "&WidgetId=" + widgetId.ToString(),
                param,
                HttpUtility.UrlEncode(signature) };

            string reqUrl = string.Format("{0}?{1}&{2}&oauth_signature={3}", reportParams);

            try
            {
                WebRequest request = WebRequest.Create(reqUrl);
                request.Method = "GET";
                request.ContentType = "application/json; charset=utf-8";
                request.Timeout = 10 * 60000;

                WebResponse responce = request.GetResponse();
                Stream reader = responce.GetResponseStream();
                StreamReader sReader = new StreamReader(reader);
                string strResponse = sReader.ReadToEnd();
                sReader.Close();

                //response
                JavaScriptSerializer jsSerzer = new JavaScriptSerializer();
                reportResponse = jsSerzer.Deserialize<ReportResponse>(strResponse);
            }
            catch (Exception ex)
            {
                reportResponse.ReportCharts = null;
                reportResponse.ReportsCount = 0;
            }

            return reportResponse;
        }
    }
}