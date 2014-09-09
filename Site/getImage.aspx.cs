using System;
using System.Data;
using DrawingImage = System.Drawing.Image;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.IO;

public partial class Shop_getImage : System.Web.UI.Page
{
    public enum AnchorPosition
    {
        Left,
        Right,
        Center,
        Top,
        Bottom
    }

    public enum ResizeType
    {
        Crop,
        FixedSize,
        ScaleByPercent,
        Resize,
        ForceResize,
        FixedWidth
    }

    private string _bgColor;
    public string bgColor
    {
        get { return _bgColor; }
        set { _bgColor = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string imagePath = "";
        int contWidth = 0;
        int ContHeight = 0;
        string resultImagePath = string.Empty;
        string ImageURL = string.Empty;
        bool aspectRatio = true;
        int percent = 100;
        int hRuler = 0;
        int vRuler = 0;
        int fontSize = 10;
        int textHeight = 60;
        string text = "";
        ResizeType resizeType = ResizeType.Resize;
        bgColor = "#000000";

        if (Request["image"] != null && Request["image"].ToString() != "")
            ImageURL = Request["image"].ToString();
        /*else
            throw new Exception("Image not found");*/

        if (Request["Width"] != null && Request["Width"].ToString() != "")
            contWidth = int.Parse(Request["Width"].ToString());
        else if (Request["W"] != null && Request["W"].ToString() != "")
            contWidth = int.Parse(Request["W"].ToString());

        if (Request["Height"] != null && Request["Height"].ToString() != "")
            ContHeight = int.Parse(Request["Height"].ToString());
        else if (Request["H"] != null && Request["H"].ToString() != "")
            ContHeight = int.Parse(Request["H"].ToString());

        if (Request["Aspect"] != null && Request["Aspect"].ToString() != "")
            aspectRatio = bool.Parse(Request["Aspect"].ToString());
        else if (Request["A"] != null && Request["A"].ToString() != "")
            aspectRatio = bool.Parse(Request["A"].ToString());

        if (Request["type"] != null && Request["type"].ToString() != "")
            resizeType = (ResizeType)int.Parse(Request["type"]);
        else if (Request["T"] != null && Request["T"].ToString() != "")
            resizeType = (ResizeType)int.Parse(Request["T"]);

        if (Request["percent"] != null && Request["percent"].ToString() != "")
            percent = int.Parse(Request["percent"].ToString());
        else if (Request["P"] != null && Request["P"].ToString() != "")
            percent = int.Parse(Request["P"].ToString());

        if (Request["HR"] != null && Request["HR"].ToString() != "")
            hRuler = int.Parse(Request["HR"].ToString());

        if (Request["VR"] != null && Request["VR"].ToString() != "")
            vRuler = int.Parse(Request["VR"].ToString());

        if (Request["FS"] != null && Request["FS"].ToString() != "")
            fontSize = int.Parse(Request["FS"].ToString());

        if (Request["TH"] != null && Request["TH"].ToString() != "")
            textHeight = int.Parse(Request["TH"].ToString());

        if (Request["D"] != null && Request["D"].ToString() != "")
            text = Request["D"].ToString();

        if (Request["BGC"] != null && Request["BGC"].ToString() != "")
            bgColor = "#" + Request["BGC"].ToString();

        if (!File.Exists(HttpContext.Current.Server.MapPath(ImageURL.Replace("../", ""))))
            ImageURL = "images/no_image.jpg";

        DrawingImage img = DrawingImage.FromFile(HttpContext.Current.Server.MapPath(ImageURL.Replace("../", "")));
        DrawingImage mainImg;

        switch (resizeType)
        {
            case ResizeType.Crop:
                mainImg = Crop(img, contWidth, ContHeight, AnchorPosition.Center, hRuler, vRuler, text, textHeight, fontSize);
                break;
            case ResizeType.FixedSize:
                mainImg = FixedSize(img, contWidth, ContHeight, hRuler, vRuler, text, textHeight, fontSize);
                break;
            case ResizeType.ScaleByPercent:
                mainImg = ScaleByPercent(img, percent);
                break;
            case ResizeType.ForceResize:
                mainImg = ReSize(img, contWidth, ContHeight, aspectRatio);
                break;
            case ResizeType.FixedWidth:
                mainImg = FixedWidth(img, contWidth, ContHeight, hRuler, vRuler, text, textHeight, fontSize);
                break;
            default:
                mainImg = Crop(img, contWidth, ContHeight, AnchorPosition.Center, hRuler, vRuler, text, textHeight, fontSize);
                break;
        }

        Response.ContentType = "image/jpeg";
        Response.Clear();
        Response.BufferOutput = true;
        mainImg.Save(Response.OutputStream, ImageFormat.Jpeg);
        mainImg.Dispose();
        img.Dispose();
        Response.End();
    }

    protected Image ScaleByPercent(Image imgPhoto, int Percent)
    {
        float nPercent = ((float)Percent / 100);

        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;

        int destX = 0;
        int destY = 0;
        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);


        Bitmap bmPhoto = new Bitmap(destWidth, destHeight,
                                  PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                                imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        grPhoto.Dispose();

        return bmPhoto;
    }

    protected Image FixedSize(Image imgPhoto, int Width, int Height, int HorizontalRuler, int VerticalRuler,
      string Text, int TextHeight, int FontSize)
    {
        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;
        int destX = 0;
        int destY = 0;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)Width / (float)sourceWidth);
        nPercentH = ((float)Height / (float)sourceHeight);
        if (nPercentH < nPercentW)
        {
            nPercent = nPercentH;
            destX = System.Convert.ToInt16((Width -
                          (sourceWidth * nPercent)) / 2);
        }
        else
        {
            nPercent = nPercentW;
            destY = System.Convert.ToInt16((Height -
                          (sourceHeight * nPercent)) / 2);
        }

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        Bitmap bmPhoto = new Bitmap(Width, Height, PixelFormat.Format64bppArgb);
        
        //Format24bppRgb
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        //sojanya
        grPhoto.Clear(System.Drawing.ColorTranslator.FromHtml("#" + bgColor.Replace("#", "")));
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
        grPhoto.CompositingQuality = CompositingQuality.HighQuality;
        grPhoto.SmoothingMode = SmoothingMode.HighQuality;
        grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality;

        Pen pen = new Pen(System.Drawing.ColorTranslator.FromHtml("#" + bgColor.Replace("#", "")));
        pen.Width = 1.5F;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        if (Text.Length > 0)
        {
            StringFormat sf = new StringFormat();
            Font font = new Font("Arial", FontSize, FontStyle.Bold);
            Rectangle rect = new Rectangle();
            Color customColor = System.Drawing.ColorTranslator.FromHtml(bgColor);
            SolidBrush brush = new SolidBrush(customColor);

            rect.X = 0;
            rect.Y = Height - TextHeight;
            rect.Width = Width;
            rect.Height = TextHeight;

            sf.LineAlignment = StringAlignment.Center;
            sf.Alignment = StringAlignment.Center;

            grPhoto.FillRectangle(brush, rect);
            grPhoto.DrawString("\"" + Text + "\"", font, Brushes.White, rect, sf);
        }


        if (VerticalRuler > 0)
            grPhoto.DrawLine(pen, Width / 2, 0, Width / 2, Height);

        if (HorizontalRuler > 0)
            grPhoto.DrawLine(pen, 0, Height / 2, Width, Height / 2);



        grPhoto.Dispose();
        return bmPhoto;
    }

    protected Image Crop(Image imgPhoto, int Width,
                    int Height, AnchorPosition Anchor, int HorizontalRuler, int VerticalRuler,
      string Text, int TextHeight, int FontSize)
    {
        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;
        int destX = 0;
        int destY = 0;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)Width / (float)sourceWidth);
        nPercentH = ((float)Height / (float)sourceHeight);

        sourceWidth = (nPercentW <= 0.25) ? (int)(sourceWidth * 0.75) : sourceWidth;
        sourceHeight = (nPercentH <= 0.25) ? (int)(sourceHeight * 0.75) : sourceHeight;

        nPercentW = ((float)Width / (float)sourceWidth);
        nPercentH = ((float)Height / (float)sourceHeight);

        if (nPercentW > 1)
        {
            nPercentW = 1;
            Width = sourceWidth;
        }

        if (nPercentH > 1)
        {
            nPercentH = 1;
            Height = sourceHeight;
        }

        if (nPercentH < nPercentW)
        {
            nPercent = nPercentW;

            if (nPercent != 1.0)
            {
                switch (Anchor)
                {
                    case AnchorPosition.Top:
                        destY = 0;
                        break;
                    case AnchorPosition.Bottom:
                        destY = (int)
                            (Height - (sourceHeight * nPercent));
                        break;
                    default:

                        destY = (int)
                        ((Height - (sourceHeight * nPercent)) / 2);

                        destX = -(int)
                          ((Width - (sourceWidth * nPercentH)) / 2);

                        break;
                }
            }
        }
        else
        {
            nPercent = nPercentH;

            if (nPercent != 1.0)
            {
                switch (Anchor)
                {
                    case AnchorPosition.Left:
                        destX = 0;
                        break;
                    case AnchorPosition.Right:
                        destX = (int)
                          (Width - (sourceWidth * nPercent));
                        break;
                    default:
                        destX = (int)
                     ((Width - (sourceWidth * nPercent)) / 2);

                        destY = -(int)
                           ((Height - (sourceHeight * nPercentW)) / 2);

                        break;
                }
            }
        }

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        if (nPercent == nPercentW)
        {
            destWidth -= destX;
        }
        else
        {
            destHeight -= destY;
        }

        Bitmap bmPhoto = new Bitmap(Width, Height, PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        grPhoto.Clear(System.Drawing.ColorTranslator.FromHtml(bgColor));
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
        grPhoto.CompositingQuality = CompositingQuality.HighQuality;
        grPhoto.SmoothingMode = SmoothingMode.HighQuality;
        grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        Pen pen = new Pen(System.Drawing.ColorTranslator.FromHtml(bgColor));
        pen.Width = 1.5F;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        if (Text.Length > 0)
        {
            StringFormat sf = new StringFormat();
            Font font = new Font("Arial", FontSize, FontStyle.Bold);
            Rectangle rect = new Rectangle();
            Color customColor = System.Drawing.ColorTranslator.FromHtml(bgColor);
            SolidBrush brush = new SolidBrush(customColor);

            rect.X = 0;
            rect.Y = Height - TextHeight;
            rect.Width = Width;
            rect.Height = TextHeight;

            sf.LineAlignment = StringAlignment.Center;
            sf.Alignment = StringAlignment.Center;

            grPhoto.FillRectangle(brush, rect);
            grPhoto.DrawString("\"" + Text + "\"", font, Brushes.White, rect, sf);
        }


        if (VerticalRuler > 0)
            grPhoto.DrawLine(pen, Width / 2, 0, Width / 2, Height);

        if (HorizontalRuler > 0)
            grPhoto.DrawLine(pen, 0, Height / 2, Width, Height / 2);

        grPhoto.Dispose();
        return bmPhoto;
    }

    protected Image ReSize(Image imgPhoto, int Width, int Height, bool AspectRatio)
    {
        DrawingImage mainImg;
        int height, width;

        if (Height > imgPhoto.Height && Width > imgPhoto.Width)
        {
            height = imgPhoto.Height;
            width = imgPhoto.Width;
        }
        else if (AspectRatio == true)
        {

            if (((double)imgPhoto.Height / Height) > ((double)imgPhoto.Width / (double)Width))
            {
                height = Height;
                width = (int)(imgPhoto.Width * ((double)Height / (double)imgPhoto.Height));
            }
            else
            {
                width = Width;
                height = (int)(imgPhoto.Height * ((double)Width / (double)imgPhoto.Width));
            }
        }
        else
        {
            height = Height;
            width = Width;
        }

        IntPtr ptr = IntPtr.Zero;

        //mainImg = imgPhoto.GetThumbnailImage(width, height, aa, ptr);

        Bitmap bmPhoto = new Bitmap(width, height, PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
        grPhoto.CompositingQuality = CompositingQuality.HighQuality;
        grPhoto.SmoothingMode = SmoothingMode.HighQuality;
        grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality;

        grPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, width + 3, height + 3),
            new Rectangle(1, 1, imgPhoto.Width + 2, imgPhoto.Height + 2), GraphicsUnit.Pixel);

        grPhoto.Dispose();

        return bmPhoto;
    }

    protected Image FixedWidth(Image imgPhoto, int Width, int Height, int HorizontalRuler, int VerticalRuler,
      string Text, int TextHeight, int FontSize)
    {
        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;
        int destX = 0;
        int destY = 0;
        float nPercent = 0;

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        if (sourceWidth >= 200)
        {
            destWidth = Width;
            destHeight = (sourceHeight * Width) / sourceWidth;
        }
        else
        {
            destWidth = sourceWidth;
            destHeight = sourceHeight;
            destX = (Width - sourceWidth) / 2;
        }

        Bitmap bmPhoto = new Bitmap(Width, destHeight,
                          PixelFormat.Format64bppArgb);

        //Format24bppRgb
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                         imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        //sojanya
        grPhoto.Clear(System.Drawing.ColorTranslator.FromHtml(bgColor));
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
        grPhoto.CompositingQuality = CompositingQuality.HighQuality;
        grPhoto.SmoothingMode = SmoothingMode.HighQuality;
        grPhoto.PixelOffsetMode = PixelOffsetMode.HighQuality;

        Pen pen = new Pen(System.Drawing.ColorTranslator.FromHtml(bgColor));
        pen.Width = 1.5F;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        if (Text.Length > 0)
        {
            StringFormat sf = new StringFormat();
            Font font = new Font("Arial", FontSize, FontStyle.Bold);
            Rectangle rect = new Rectangle();
            Color customColor = System.Drawing.ColorTranslator.FromHtml(bgColor);
            SolidBrush brush = new SolidBrush(customColor);

            rect.X = 0;
            rect.Y = Height - TextHeight;
            rect.Width = Width;
            rect.Height = TextHeight;

            sf.LineAlignment = StringAlignment.Center;
            sf.Alignment = StringAlignment.Center;

            grPhoto.FillRectangle(brush, rect);
            grPhoto.DrawString("\"" + Text + "\"", font, Brushes.White, rect, sf);
        }

        if (VerticalRuler > 0)
            grPhoto.DrawLine(pen, Width / 2, 0, Width / 2, Height);

        if (HorizontalRuler > 0)
            grPhoto.DrawLine(pen, 0, Height / 2, Width, Height / 2);

        grPhoto.Dispose();
        return bmPhoto;
    }

    private bool aa()
    {
        return false;
    }
}
