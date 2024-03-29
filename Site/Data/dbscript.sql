USE [Yuvaas]
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetNonFriends_TEST]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetNonFriends_TEST] --'391E7219-C1D7-493C-A3B3-5B37047BCE17',0,10,'1=1','UserId ASC'      
@UserId AS UNIQUEIDENTIFIER,              
@StartIndex AS INT = 0,                                    
@MaxSize AS INT = 100,                                    
@SearchString AS VARCHAR(1000) = '1=1',                                    
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                    
AS                                    
BEGIN                                    
DECLARE @strQueryPaging VARCHAR(max)                                    
DECLARE @strQueryAll VARCHAR(max)                                    
                    
SET @strQueryAll = 'SELECT U.*,UP.UserImage,UP.Designation,FL1.FriendUserId,FL1.IsMailSent,FL1.IsAccepted,FL1.IsBlocked,FL1.IsRead,FL1.LastReqestedDate
FROM tblUser U
INNER JOIN tblUserProfile UP ON U.UserId = UP.UserId
LEFT JOIN 
(SELECT * FROM 
tblFriendList FL WHERE FL.UserId='''+ CAST(@UserId as varchar(50)) +''') AS FL1
ON U.UserId = FL1.FriendUserId
WHERE U.UserId<>'''+ CAST(@UserId as varchar(50)) +'''
AND U.UserId NOT IN (SELECT FL.FriendUserId FROM tblFriendList FL 
WHERE FL.UserId='''+ CAST(@UserId as varchar(50)) +'''
AND FL.IsAccepted=1 AND FL.IsBlocked=0)
AND U.UserId NOT IN (SELECT FL.UserId FROM tblFriendList FL 
WHERE FL.FriendUserId='''+ CAST(@UserId as varchar(50)) +''' 
AND FL.IsAccepted=1 AND FL.IsBlocked=0) AND ' + @SearchString    

SET @strQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                    
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                    
                          
EXEC(@strQueryPaging)                         
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetNonFriends_Old]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetNonFriends_Old]        
--sp_tblUser_GetNonFriends '1241AB3B-7A82-4979-9E7E-638CB274A732',0,10,'1=1','UserId ASC'        
@UserId AS UNIQUEIDENTIFIER,              
@StartIndex AS INT = 0,                                    
@MaxSize AS INT = 100,                                    
@SearchString AS VARCHAR(1000) = '1=1',                                    
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                    
AS                                    
BEGIN                                    
DECLARE @strQueryPaging VARCHAR(max)                                    
DECLARE @strQueryAll VARCHAR(max)                                    
                    
SET @strQueryAll = 'SELECT TF.*,F.FriendUserId,F.IsMailSent,F.IsAccepted,F.IsBlocked,F.IsRead,F.LastReqestedDate FROM     
(SELECT U.UserId,U.FirstName,U.LastName,U.EmailId,U.Password,U.LoginId,UP.UserImage,UP.Designation    
FROM tbluser U     
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId    
where U.UserId <> ''' + CAST(@UserId as varchar(50)) + ''' AND U.UserId not in (Select     
CASE WHEN UserId = ''' + CAST(@UserId as varchar(50)) + ''' THEN     
 FriendUserId     
ELSE     
 UserId     
END AS SelUserId    
FROM tblFriendlist     
WHERE IsAccepted=1 AND IsBlocked = 0)) AS TF    
LEFT JOIN tblFriendList F ON TF.UserId = CASE WHEN F.UserId = ''' + CAST(@UserId as varchar(50)) + ''' THEN     
 F.FriendUserId     
ELSE     
 F.UserId    
END WHERE IsNULL(IsAccepted,0) = 0 AND ' + @SearchString                             
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                    
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                    
                          
EXEC(@strQueryPaging)                         
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetNonFriends]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetNonFriends] --'391E7219-C1D7-493C-A3B3-5B37047BCE17',0,10,'1=1','UserId ASC'          
@UserId AS UNIQUEIDENTIFIER,                  
@StartIndex AS INT = 0,                                        
@MaxSize AS INT = 100,                                        
@SearchString AS VARCHAR(1000) = '1=1',                                        
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                        
AS                                        
BEGIN                                        
DECLARE @strQueryPaging VARCHAR(max)                                        
DECLARE @strQueryAll VARCHAR(max)                                        
                        
SET @strQueryAll = 'SELECT U.*,UP.UserImage,UP.Designation,FL1.UserId AS RUserId,FL1.FriendUserId,FL1.IsMailSent,FL1.IsAccepted,FL1.IsBlocked,FL1.IsRead,FL1.LastReqestedDate    
FROM tblUser U    
INNER JOIN tblUserProfile UP ON U.UserId = UP.UserId    
LEFT JOIN     
(SELECT * FROM     
tblFriendList FL WHERE FL.UserId='''+ CAST(@UserId as varchar(50)) +'''
OR FL.FriendUserId='''+ CAST(@UserId as varchar(50)) +'''
) AS FL1    
ON U.UserId = FL1.FriendUserId  OR  U.UserId = FL1.UserId 
WHERE U.UserId<>'''+ CAST(@UserId as varchar(50)) +'''    
AND U.UserId NOT IN (SELECT FL.FriendUserId FROM tblFriendList FL     
WHERE FL.UserId='''+ CAST(@UserId as varchar(50)) +'''    
AND FL.IsAccepted=1 AND FL.IsBlocked=0)    
AND U.UserId NOT IN (SELECT FL.UserId FROM tblFriendList FL     
WHERE FL.FriendUserId='''+ CAST(@UserId as varchar(50)) +'''     
AND FL.IsAccepted=1 AND FL.IsBlocked=0) AND ' + @SearchString        
    
SET @strQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                        
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                        
                              
EXEC(@strQueryPaging)                             
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetFriendsRequests]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetFriendsRequests]      
--sp_tblUser_GetFriendsRequests '391E7219-C1D7-493C-A3B3-5B37047BCE17',0,10,'1=1','UserId ASC'        
@UserId AS UNIQUEIDENTIFIER,              
@StartIndex AS INT = 0,                                    
@MaxSize AS INT = 100,                                    
@SearchString AS VARCHAR(1000) = '1=1',                                    
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                    
AS                                    
BEGIN                                    
DECLARE @strQueryPaging VARCHAR(max)                                    
DECLARE @strQueryAll VARCHAR(max)                                    
                    
SET @strQueryAll = 'SELECT U.*,UP.UserImage,UP.Designation FROM tblUser U 
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId
WHERE U.UserId IN   
(SELECT UserId FROM tblFriendList WHERE FriendUserId = ''' + CAST(@UserId as varchar(50)) + ''' AND IsAccepted=0)   
AND ' + @SearchString                             
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                    
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                    
                          
EXEC(@strQueryPaging)                         
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetFriendsByUserId_v1]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetFriendsByUserId_v1]        
--sp_tblUser_GetFriendsByUserId '391E7219-C1D7-493C-A3B3-5B37047BCE17',0,5,'1=1','UserId ASC'      
@UserId UNIQUEIDENTIFIER,             
@StartIndex AS INT = 0,                                  
@MaxSize AS INT = 5,                                  
@SearchString AS VARCHAR(1000) = '1=1',                                  
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                  
AS                                  
BEGIN                                  
DECLARE @strQueryPaging VARCHAR(max)                                  
DECLARE @strQueryAll VARCHAR(max)                                  
SET @StartIndex=@StartIndex+1                      
SET @strQueryAll = 'SELECT U.*,UP.Description,UP.UserImage,UP.DOB,UP.Address,UP.City,UP.State,UP.Country,UP.Gender,UP.WorkAt,  
UP.Designation,UP.CollegeAt,UP.SchoolAt FROM tblUser U   
LEFT JOIN tblUserProfile UP ON U.UserId = UP.UserId     
WHERE U.UserId != ''' + CAST(@UserId as varchar(50)) + ''' AND U.UserId IN (      
SELECT CASE WHEN F.UserId = ''' + CAST(@UserId as varchar(50)) + ''' THEN F.FriendUserId      
 ELSE F.UserId      
 END      
FROM tblFriendList F      
WHERE (F.FriendUserId = ''' + CAST(@UserId as varchar(50)) + ''' OR F.UserId = ''' + CAST(@UserId as varchar(50)) + ''')      
 AND F.IsAccepted = 1      
)'                           
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                  
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                  
                        
EXEC(@strQueryPaging)                       
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetFriendsByUserId_Old]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetFriendsByUserId_Old]
@UserId UNIQUEIDENTIFIER,     
@StartIndex AS INT = 0,                          
@MaxSize AS INT = 5,                          
@SearchString AS VARCHAR(1000) = '1=1',                          
@SortExpression AS VARCHAR(100) = 'UserId ASC'                          
AS                          
BEGIN                          
DECLARE @strQueryPaging VARCHAR(max)                          
DECLARE @strQueryAll VARCHAR(max)                          
SET @StartIndex=@StartIndex+1              
SET @strQueryAll = 'SELECT U.FirstName,U.LastName,U.EmailId,U.LoginId,UP.* 
FROM tblUser U INNER JOIN tblUserProfile UP ON U.UserId=UP.UserId                                    
INNER JOIN tblFriendList F ON F.UserId = UP.UserId                                    
WHERE ' + @SearchString                   
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                          
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                          
                
EXEC(@strQueryPaging)               
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetFriendsByUserId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetFriendsByUserId]          
--sp_tblUser_GetFriendsByUserId '4146000E-5833-4BF6-AE3E-CF2E9D3FFA2C',0,5,'1=1','UserId ASC'        
@UserId UNIQUEIDENTIFIER,               
@StartIndex AS INT = 0,                                    
@MaxSize AS INT = 100,                                    
@SearchString AS VARCHAR(1000) = '1=1',                                    
@SortExpression AS VARCHAR(100) = 'UserId ASC'                                    
AS                                    
BEGIN                                    
DECLARE @strQueryPaging VARCHAR(max)                                    
DECLARE @strQueryAll VARCHAR(max)                                    
SET @StartIndex=@StartIndex+1                        
SET @strQueryAll = 'SELECT FT.*,U.FirstName,U.LastName,U.EmailId,U.Password,U.LoginId,UP.UserImage,UP.Designation 
FROM (Select *,   
CASE WHEN UserId = ''' + CAST(@UserId as varchar(50)) + ''' THEN   
 FriendUserId   
ELSE   
 UserId   
END AS SelUserId  
FROM tblFriendlist   
where (UserId=''' + CAST(@UserId as varchar(50)) + ''' OR FriendUserId=''' + CAST(@UserId as varchar(50)) + ''')   
AND IsAccepted=1 AND IsBlocked = 0) AS FT  
INNER JOIN tblUser U ON FT.SelUserId = U.UserId                             
INNER JOIN tblUserProfile UP ON U.UserId = UP.UserId'                             
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                    
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                    
                          
EXEC(@strQueryPaging)                         
End
GO
/****** Object:  StoredProcedure [dbo].[SP_tblStatus_SelCount]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblStatus_SelCount] 
@SearchString as varchar(1000) = '1=1'    
AS    
BEGIN    
    
DECLARE @StrQueryAll VARCHAR(MAX)    
        
SET @StrQueryAll = 'SELECT * FROM tblStatus WHERE '  + @SearchString    
    
EXEC('SELECT COUNT(*) AS StatusCount FROM (' + @StrQueryAll + ') as T')          
    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblStatus_SelByPaging]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblStatus_SelByPaging]   
@startRowIndex INT = 0,    
@maximumRows INT = 10,    
@SearchString VARCHAR(1000) = ' 1=1',    
@SortBy VARCHAR(100) = ' StatusId DESC'
AS
BEGIN
   
DECLARE @StrQueryPaging VARCHAR(MAX)    
DECLARE @StrQueryAll VARCHAR(MAX)    
    
SET @StrQueryAll = 'SELECT * FROM tblStatus WHERE '  + @SearchString    
    
SET @StrQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @SortBy  + ') AS ind,    
 * FROM (' + @StrQueryAll + ') AS T) AS Q WHERE ind > '          
 + cast(@startRowIndex AS VARCHAR(10)) + ' AND IND <= ' + cast((@startRowIndex + @maximumRows)  AS VARCHAR(10))          
    
EXEC(@StrQueryPaging)     
  
END
GO
/****** Object:  Table [dbo].[tblChatSession]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblChatSession](
	[SessionId] [uniqueidentifier] NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[CustomerImage] [varchar](300) NULL,
	[FriendId] [uniqueidentifier] NULL,
	[FriendType] [varchar](50) NULL,
	[DeviceToken] [varchar](300) NULL,
	[DeviceType] [varchar](50) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUsedOn] [datetime] NOT NULL,
	[Email] [varchar](300) NULL,
	[Mobile] [varchar](50) NULL,
 CONSTRAINT [PK_tblChatSession] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelNotifications]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelNotifications]   
--proc_tblStatus_SelNotifications 0,100  
@StartIndex AS INT = 0,                                          
@MaxSize AS INT = 10                                       
AS  
BEGIN  
  
DECLARE @strQueryPaging VARCHAR(max)                                          
DECLARE @strQueryAll VARCHAR(max)  
  
SET @strQueryAll = 'SELECT DISTINCT   
CAST(1 AS BIT) As IsPost,  
CAST(ISNULL(S.IsShared,0) AS BIT) IsShared,  
0 AS IsCommented,  
0 As IsLiked,  
0 As IsCommentLiked,  
S.StatusId, S.StatusName, S.StatusType, S.StatusUrl,  
''00000000-0000-0000-0000-000000000000'' CommentId,  
'''' CommentName,S.CreatedDate,  
U.UserId, U.FirstName, U.LastName, UP.UserImage,  
U.UserId AS NUserId, U.FirstName AS NFirstName, U.LastName AS NLastName, UP.UserImage AS NUserImage    
FROM tblStatus S  
INNER JOIN tblUser U ON U.UserId = S.UserId   
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId  
  
UNION   
SELECT DISTINCT   
0 AS IsPost,  
0 As IsShared,  
1 AS IsCommented,  
0 As IsLiked,  
0 As IsCommentLiked,  
S.StatusId, S.StatusName, S.StatusType, S.StatusUrl,  
C.CommentId,C.CommentName,S.CreatedDate,  
U.UserId, U.FirstName, U.LastName, UP.UserImage,   
U1.UserId AS NUserId, U1.FirstName AS NFirstName, U1.LastName AS NLastName, UP1.UserImage AS NUserImage  
FROM tblComment C  
INNER JOIN tblStatus S ON S.StatusId = C.StatusId  
INNER JOIN tblUser U ON U.UserId = S.UserId   
INNER JOIN tblUser U1 ON U1.UserId = C.UserId   
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId  
INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId  
  
UNION   
SELECT DISTINCT   
0 AS IsPost,  
0 As IsShared,  
0 AS IsCommented,  
1 As IsLiked,  
0 As IsCommentLiked,  
S.StatusId, S.StatusName, S.StatusType, S.StatusUrl,  
L.LikeId,'''' AS CommentName,S.CreatedDate,  
U.UserId, U.FirstName, U.LastName, UP.UserImage,   
U1.UserId AS NUserId, U1.FirstName AS NFirstName, U1.LastName AS NLastName, UP1.UserImage AS NUserImage  
FROM tblLike L  
INNER JOIN tblStatus S ON S.StatusId = L.StatusId  
INNER JOIN tblUser U ON U.UserId = S.UserId   
INNER JOIN tblUser U1 ON U1.UserId = L.UserId   
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId  
INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId  
WHERE ISNULL(L.IsLiked,0) = 1  
UNION   
SELECT DISTINCT   
0 AS IsPost,  
0 As IsShared,  
0 AS IsCommented,  
0 As IsLiked,  
1 As IsCommentLiked,  
S.StatusId, S.StatusName, S.StatusType, S.StatusUrl,  
CL.CommentLikeId,'''' AS CommentName,S.CreatedDate,  
U.UserId, U.FirstName, U.LastName, UP.UserImage ,   
U1.UserId AS NUserId, U1.FirstName AS NFirstName, U1.LastName AS NLastName, UP1.UserImage AS NUserImage  
FROM tblCommentLike CL  
INNER JOIN tblStatus S ON S.StatusId = CL.StatusId  
INNER JOIN tblUser U ON U.UserId = S.UserId   
INNER JOIN tblUser U1 ON U1.UserId = CL.UserId   
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId  
INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId  
WHERE ISNULL(CL.IsLiked,0) = 1'  
  
SET @strQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY CreatedDate DESC) as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                          
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                          
                                
EXEC(@strQueryPaging)    
  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelForWall_ByPaging]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelForWall_ByPaging] --'391E7219-C1D7-493C-A3B3-5B37047BCE17'     
@LoggedInUserId UNIQUEIDENTIFIER,     
@SelectedUserId UNIQUEIDENTIFIER,    
@StartIndex INT = 0,    
@PageSize INT = 10,    
@SortExpression VARCHAR(100) = ' CreatedDate DESC ',    
@SearchString VARCHAR(MAX) = ' 1 = 1 '     
AS     
BEGIN    
    
DECLARE @QueryAll VARCHAR(MAX)    
DECLARE @QueryPaging VARCHAR(MAX)    
DECLARE @QueryComment VARCHAR(MAX)    
    
SET @QueryAll = 'SELECT ROW_NUMBER() OVER (ORDER BY ' + @SortExpression + ') AS RowNum, * FROM    
(    
SELECT DISTINCT S.*, (U.FirstName +'' ''+ISNULL(U.LastName,'''')) AS UserName, UP.UserImage,     
ISNULL(L.IsLiked,0) AS [IsLiked],     
(SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],     
ISNULL(L.LikeId ,''00000000-0000-0000-0000-000000000000'') AS LikeId     
FROM tblStatus S     
INNER JOIN tblUser U ON S.UserId = U.UserId     
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId     
LEFT OUTER JOIN tblLike L ON L.StatusId = S.StatusId AND L.UserId = ''' + CAST(@LoggedInUserId AS VARCHAR(36)) + '''    
LEFT OUTER JOIN tblComment C On S.StatusId = C.StatusId     
WHERE S.UserId = ''' + CAST(@SelectedUserId AS VARCHAR(36)) + ''' OR C.UserId = ''' + CAST(@SelectedUserId AS VARCHAR(36)) + '''     
 AND ' + @SearchString + ') AS T1'    
    
SET @QueryPaging = 'SELECT * FROM (' + @QueryAll + ') AS T2 WHERE RowNum >= ' + CAST(@StartIndex AS VARCHAR(10)) + ' AND RowNum < ' + CAST((@StartIndex + @PageSize) AS VARCHAR(10))    
    
EXEC(@QueryPaging)    
EXEC('SELECT COUNT(1) AS Count FROM (' + @QueryAll + ') AS T2')    
    
SET @QueryComment = 'SELECT DISTINCT C.*,(U.FirstName +'' ''+ISNULL(U.LastName,'''')) AS UserName,UP.UserImage,     
ISNULL(CL.IsLiked,0) AS [IsCommentLiked],     
ISNULL(CL.CommentLikeId, ''00000000-0000-0000-0000-000000000000'') AS CommentLikeId     
FROM tblComment C     
INNER JOIN tblUser U ON C.UserId = U.UserId     
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId     
INNER JOIN tblStatus S ON S.StatusId = C.StatusId AND S.UserId = ''' + CAST(@SelectedUserId AS VARCHAR(36)) + ''' OR C.UserId = ''' + CAST(@SelectedUserId AS VARCHAR(36)) + '''    
LEFT OUTER JOIN tblCommentLike CL ON CL.StatusId = C.StatusId AND CL.CommentId = C.CommentId AND CL.UserId = ''' + CAST(@LoggedInUserId AS VARCHAR(36)) + '''    
WHERE C.StatusId IN (    
 SELECT StatusId FROM (' + @QueryAll + ') AS T2    
 WHERE RowNum BETWEEN ' + CAST(@StartIndex AS VARCHAR(10)) + ' AND ' + CAST((@StartIndex + @PageSize) AS VARCHAR(10)) + ')    
ORDER BY C.ModifiedDate ASC'    
    
EXEC(@QueryComment)    
     
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_GetAllMessagesByToUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_GetAllMessagesByToUserId]    
@startRowIndex AS INT = 1,                                                          
@maximumRows AS INT = 10,                                                          
@SearchString AS VARCHAR(MAX) = ' 1 = 1',                                                          
@SortBy AS VARCHAR(100) = 'CreatedOn DESC',    
@ToUserId UNIQUEIDENTIFIER = '7B242AE8-8145-4BB0-919B-8AAFC2E3D4CA'   
AS    
BEGIN    
     
 DECLARE @strQueryPaging VARCHAR(MAX)                                                          
 DECLARE @strQueryAll VARCHAR(MAX)                                                         
 SET @startRowIndex = @startRowIndex + 1                                                        
 SET @strQueryAll = 'SELECT M.*,U.FirstName + '' '' + ISNULL(U.LastName,'''') As FromUserName,UP.UserImage AS FromUserImage            
 ,U1.FirstName + '' '' + ISNULL(U1.LastName,'''') As ToUserName,UP1.UserImage AS ToUserImage              
 FROM tblMessage M              
 INNER JOIN tblUser U ON U.UserId = M.FromUserId               
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId              
 INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId               
 INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId      
 WHERE ToUserId = '''+ CAST(@ToUserId as VARCHAR(50)) +''''    
     
 SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortBy + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                                          
 + CAST(@startRowIndex AS VARCHAR(10)) + ' and ind < ' + CAST((@startRowIndex + @maximumRows)  AS VARCHAR(10))                                                 
                                                     
 EXEC(@strQueryPaging)                                                          
                                                   
 EXEC('SELECT COUNT(1) AS TotalCount FROM (' + @strQueryAll + ') AS T')    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_GetAllMessagesByFromUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_GetAllMessagesByFromUserId]  
@startRowIndex AS INT = 0,                                                        
@maximumRows AS INT = 20,                                                        
@SearchString AS VARCHAR(MAX) = ' 1 = 1',                                                        
@SortBy AS VARCHAR(100) = 'CreatedOn DESC',  
@FromUserId UNIQUEIDENTIFIER ='7B242AE8-8145-4BB0-919B-8AAFC2E3D4CA' 
AS  
BEGIN  
   
 DECLARE @strQueryPaging VARCHAR(MAX)                                                        
 DECLARE @strQueryAll VARCHAR(MAX)                                                       
 SET @startRowIndex = @startRowIndex + 1                                                      
 SET @strQueryAll = 'SELECT M.*,U.FirstName + '' '' + ISNULL(U.LastName,'''') As FromUserName,UP.UserImage AS FromUserImage          
 ,U1.FirstName + '' '' + ISNULL(U1.LastName,'''') As ToUserName,UP1.UserImage AS ToUserImage            
 FROM tblMessage M            
 INNER JOIN tblUser U ON U.UserId = M.FromUserId             
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId            
 INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId             
 INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId    
 WHERE FromUserId = '''+ CAST(@FromUserId as VARCHAR(50)) +''''  
   
 SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortBy + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                                        
 + CAST(@startRowIndex AS VARCHAR(10)) + ' and ind < ' + CAST((@startRowIndex + @maximumRows)  AS VARCHAR(10))                                               
                                                   
 EXEC(@strQueryPaging)                                                        
                                                 
 EXEC('SELECT COUNT(1) AS TotalCount FROM (' + @strQueryAll + ') AS T')  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_Del]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_Del] 
@MessageIds VARCHAR(MAX)
AS
BEGIN
	exec('DELETE FROM tblMessage WHERE MessageId in (' + @MessageIds + ')')
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforNewsFeedCount]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforNewsFeedCount]    
 --[proc_tblStatus_SelAllforNewsFeedCount] 0,5,'1241AB3B-7A82-4979-9E7E-638CB274A732'    
@UserId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'          
AS                  
BEGIN     
    
DECLARE @strQueryPaging VARCHAR(max)                                                  
DECLARE @strQueryAll VARCHAR(max)      
  
          
SET @strQueryAll = 'SELECT S.*,(U.FirstName + '' '' + ISNULL(U.LastName,'''')) AS UserName,UP.UserImage,            
ISNULL(L.IsLiked,0) AS [IsLiked],                    
(SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],            
ISNULL(L.LikeId ,''00000000-0000-0000-0000-000000000000'') AS LikeId  FROM tblStatus S                     
INNER JOIN tblUser U ON S.UserId = U.UserId                    
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId                    
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId='''+ CAST(@UserId AS VARCHAR(50)) +''''   
  
   
--SET @strQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY CreatedDate DESC) as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                                  
--  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                                                  
                                        
--EXEC(@strQueryPaging)  
  
exec('select Count(*) as TotalCount from (' + @strQueryAll +') as C')   
  
--CREATE TABLE #tmpStatus(RowNumber INT,StatusId UNIQUEIDENTIFIER)  
--Inserting Status in temp Table  
--INSERT INTO #tmpStatus  
--SELECT * FROM(SELECT ROW_NUMBER() OVER(ORDER BY S.CreatedDate DESC) AS ind, S.StatusId FROM tblStatus S                     
--INNER JOIN tblUser U ON S.UserId = U.UserId                    
--INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId                    
--LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId= CAST(@UserId AS VARCHAR(50)))AS T  
--WHERE ind >=  cast(@StartIndex AS VARCHAR(10)) AND ind < cast((@StartIndex + @MaxSize)  AS VARCHAR(10))  
  
--SELECT * from #tmpStatus  
      
  
--Get the comments by status Id's in temp table  
--SELECT * FROM(SELECT ROW_NUMBER() OVER (PARTITION BY C.StatusId ORDER BY C.CreatedDate) AS Id,(SELECT COUNT(1) FROM tblComment WHERE StatusId=C.StatusId) AS TotalCommentsCount,  
--C.*,(U.FirstName +' '+ISNULL(U.LastName,'''')) AS UserName,UP.UserImage,            
--ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],            
--ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId              
--FROM tblComment C                  
--INNER JOIN tblUser U ON C.UserId = U.UserId                        
--INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId            
--LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId  
--WHERE C.StatusId IN (SELECT StatusId FROM #tmpStatus)) AS T WHERE id >= 1 AND id < 3  
   
--DROP TABLE #tmpStatus         
              
END
GO
/****** Object:  Table [dbo].[tblUserProfile]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUserProfile](
	[UserId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[About] [nvarchar](max) NULL,
	[UserImage] [nvarchar](250) NULL,
	[DOB] [datetime] NULL,
	[Address] [varchar](500) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Country] [nvarchar](100) NULL,
	[Gender] [varchar](10) NULL,
	[WorkAt] [nvarchar](200) NULL,
	[Designation] [nvarchar](100) NULL,
	[CollegeAt] [nvarchar](200) NULL,
	[SchoolAt] [nvarchar](200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUserDashboardWidget]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserDashboardWidget](
	[UserId] [uniqueidentifier] NOT NULL,
	[WidgetId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[EmailId] [nvarchar](250) NULL,
	[Password] [nvarchar](50) NULL,
	[LoginId] [nvarchar](50) NULL,
	[UserCode] [varchar](20) NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[tblUser] ADD [Phone] [varchar](20) NULL
ALTER TABLE [dbo].[tblUser] ADD [CreatedOn] [datetime] NULL
ALTER TABLE [dbo].[tblUser] ADD  CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFriendList]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFriendList](
	[UserId] [uniqueidentifier] NOT NULL,
	[FriendUserId] [uniqueidentifier] NOT NULL,
	[IsMailSent] [bit] NULL,
	[IsAccepted] [bit] NULL,
	[IsBlocked] [bit] NULL,
	[IsRead] [bit] NULL,
	[LastReqestedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblFriendList] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[FriendUserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDashboardWidget]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDashboardWidget](
	[DashboardWidgetId] [int] NOT NULL,
	[WidgetName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_tblDashboardWidget] PRIMARY KEY CLUSTERED 
(
	[DashboardWidgetId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPermissions]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPermissions](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionDetails] [varchar](50) NULL,
 CONSTRAINT [PK_tblPermissions] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMessage]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMessage](
	[MessageId] [uniqueidentifier] NOT NULL,
	[FromUserId] [uniqueidentifier] NOT NULL,
	[ToUserId] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[IsRead] [bit] NULL,
	[Createdon] [datetime] NULL,
 CONSTRAINT [PK_tblMessage] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetUsersExcludingFriends_OLD]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetUsersExcludingFriends_OLD]      
@StartIndex AS INT = 0,                            
@MaxSize AS INT = 5,                            
@SearchString AS VARCHAR(1000) = '1=1',                            
@SortExpression AS VARCHAR(100) = 'UserId ASC'                            
AS                            
BEGIN                            
DECLARE @strQueryPaging VARCHAR(max)                            
DECLARE @strQueryAll VARCHAR(max)                            
SET @StartIndex=@StartIndex+1                
SET @strQueryAll = 'SELECT U.FirstName,U.LastName,U.EmailId,U.LoginId,UP.*   
FROM tblUser U INNER JOIN tblUserProfile UP ON U.UserId=UP.UserId                                      
WHERE U.UserId NOT IN (SELECT FriendUserId FROM tblFriendList WHERE UserId = U.UserId) AND ' + @SearchString                     
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                            
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                            
                  
EXEC(@strQueryPaging)                 
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetUsersExcludingFriends]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetUsersExcludingFriends]     
@StartIndex AS INT = 0,                          
@MaxSize AS INT = 5,                          
@SearchString AS VARCHAR(1000) = '1=1',                          
@SortExpression AS VARCHAR(100) = 'UserId ASC'                          
AS                          
BEGIN                          
DECLARE @strQueryPaging VARCHAR(max)                          
DECLARE @strQueryAll VARCHAR(max)                          
SET @StartIndex=@StartIndex+1              
SET @strQueryAll = 'SELECT U.FirstName,U.LastName,U.EmailId,U.LoginId,UP.* 
FROM tblUser U INNER JOIN tblUserProfile UP ON U.UserId=UP.UserId                                    
WHERE U.UserId NOT IN (SELECT FriendUserId FROM tblFriendList WHERE UserId = U.UserId) AND ' + @SearchString                   
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                          
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                          
                
EXEC(@strQueryPaging)               
End
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_SelFriendsByPaging]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_tblUser_SelFriendsByPaging] --0,10,'1=1','FirstName ASC','387167e6-da9b-41d4-9539-fa00fab1566b'
@startRowIndex AS INT = 1,                                                      
@maximumRows AS INT = 10,                                                      
@SearchString AS VARCHAR(MAX) = ' 1 = 1',                                                      
@SortBy AS VARCHAR(100) = 'FirstName DESC',
@UserId UNIQUEIDENTIFIER 
AS                                                      
BEGIN                                                      
                                                  
DECLARE @strQueryPaging VARCHAR(MAX)                                                      
DECLARE @strQueryAll VARCHAR(MAX)                                                     
SET @startRowIndex = @startRowIndex + 1                                                    
SET @strQueryAll = 'SELECT U.FirstName,U.LastName,U.EmailId,FL.IsMailSent,FL.IsAccepted,FL.IsBlocked,FL.IsRead
 FROM tblUser U LEFT JOIN tblFriendList FL ON FL.FrienduserId = U.UserId
where '+ @SearchString +' and FL.UserId='''+ CAST(@UserId as VARCHAR(50)) +''''

  SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortBy + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                                      
  + CAST(@startRowIndex AS VARCHAR(10)) + ' and ind < ' + CAST((@startRowIndex + @maximumRows)  AS VARCHAR(10))                                             
                                                    
EXEC(@strQueryPaging)                                                      
                                                  
EXEC('SELECT COUNT(1) AS Count FROM (' + @strQueryAll + ') AS T')                                                                                                   
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_SELAllByPaging]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_SELAllByPaging]     
@StartIndex AS INT = 0,                          
@MaxSize AS INT = 5,                          
@SearchString AS VARCHAR(1000) = '1=1',                          
@SortExpression AS VARCHAR(100) = 'UserId ASC'                          
AS                          
BEGIN                          
DECLARE @strQueryPaging VARCHAR(max)                          
DECLARE @strQueryAll VARCHAR(max)                          
SET @StartIndex=@StartIndex+1              
SET @strQueryAll = 'SELECT U.FirstName,U.LastName,U.EmailId,U.LoginId,UP.* FROM tblUser U inner join tblUserProfile UP ON U.UserId=UP.UserId                  
 where '+ @SearchString                    
                        
SET @strQueryPaging = 'select * from (select row_number() over(order by ' + @SortExpression + ') as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                          
  + cast(@StartIndex AS VARCHAR(10)) + ' and ind < ' + cast((@StartIndex + @MaxSize)  AS VARCHAR(10))                          
                
EXEC(@strQueryPaging)               
End
GO
/****** Object:  Table [dbo].[tblChatHistory]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblChatHistory](
	[HistoryId] [uniqueidentifier] NOT NULL,
	[CustomerId] [varchar](50) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[CustomerImage] [varchar](300) NULL,
	[FriendId] [uniqueidentifier] NULL,
	[FriendType] [varchar](50) NULL,
	[DeviceToken] [varchar](300) NULL,
	[DeviceType] [varchar](50) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUsedOn] [datetime] NOT NULL,
	[Email] [varchar](300) NULL,
	[Mobile] [varchar](50) NULL,
 CONSTRAINT [PK_tblChatHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09/04/2014 22:07:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split](@String nvarchar(MAX), @Delimiter char(1))    
RETURNS @Results TABLE ( ResultId int , Items nvarchar(MAX))    
AS    
    
    
    BEGIN    
    DECLARE @INDEX INT    
    DECLARE @SLICE nvarchar(4000)    
    
declare @intcount int    
    
    -- HAVE TO SET TO 1 SO IT DOESNT EQUAL ZERO FIRST TIME IN LOOP    
    SELECT @INDEX = 1    
    
set @intcount=1    
    
    WHILE @INDEX !=0    
    
    
        BEGIN     
         -- GET THE INDEX OF THE FIRST OCCURENCE OF THE SPLIT CHARACTER    
         SELECT @INDEX = CHARINDEX(@Delimiter,@STRING)    
         -- NOW PUSH EVERYTHING TO THE LEFT OF IT INTO THE SLICE VARIABLE    
         IF @INDEX !=0    
          SELECT @SLICE = LEFT(@STRING,@INDEX - 1)    
         ELSE    
          SELECT @SLICE = @STRING    
         -- PUT THE ITEM INTO THE RESULTS SET    
         INSERT INTO @Results(ResultId,Items) VALUES(@intcount,@SLICE)    
 set @intcount =@intcount+1    
         -- CHOP THE ITEM REMOVED OFF THE MAIN STRING    
         SELECT @STRING = RIGHT(@STRING,LEN(@STRING) - @INDEX)    
         -- BREAK OUT IF WE ARE DONE    
         IF LEN(@STRING) = 0 BREAK    
    END    
    RETURN    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblUserDashboardWidget_InsUpd]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblUserDashboardWidget_InsUpd]
@WidgetIds VARCHAR(MAX),
@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @tblIds TABLE(Id INT IDENTITY(1,1), WidgetId INT)
	INSERT INTO @tblIds
	SELECT Items FROM dbo.Split(@WidgetIds, ',')
	
	DELETE
	FROM tblUserDashboardWidget
	WHERE UserId = @UserId
	
	INSERT INTO tblUserDashboardWidget
	SELECT @UserId, WidgetId FROM @tblIds
	
	return 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_INS]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_INS]  --sp_tblUser_INS 'POORNIMA','NALLURI','poornima.nalluri@winitsoftware.com','poornima.nalluri@winitsoftware.com','123456Aa','','','','','','','','','','','','',''  
	   @FirstName VARCHAR(200)  
      ,@LastName VARCHAR(200)  
      ,@EmailId VARCHAR(200)  
      ,@Password VARCHAR(50)  
      ,@LoginId VARCHAR(200)=''  
      ,@DOB DATETIME=Null  
      ,@Description NVARCHAR(MAX)=''  
      ,@UserImage NVARCHAR(250)=''  
      ,@Address VARCHAR(200)=''   
      ,@City VARCHAR(200)=''   
      ,@State VARCHAR(200)=''   
      ,@Country VARCHAR(200)=''   
      ,@Gender VARCHAR(10)=''   
      ,@Designation VARCHAR(200)=''   
      ,@WorkAt VARCHAR(200)=''   
      ,@CollegeAt VARCHAR(200)=''   
      ,@SchoolAt VARCHAR(200)=''
	  ,@About NVARCHAR(MAX)=''      
      ,@Phone VARCHAR(20)=''  
AS  
BEGIN  
DECLARE @retValue INT   
DECLARE @UserId uniqueidentifier  
IF EXISTS(SELECT @LoginId FROM tblUser WHERE Phone=@Phone OR EmailId=@EmailId)  
BEGIN  
 SET @retValue=0  
END  
ELSE  
 BEGIN  
 SET @UserId=NEWid()  
   INSERT INTO tblUser(  
        UserId   
         ,FirstName  
        ,LastName  
        ,EmailId  
        ,[Password]  
        ,LoginId 
        ,Phone 
       )  
    VALUES(  
        @UserId  
        ,@FirstName   
        ,@LastName   
        ,@EmailId   
        ,@Password   
        ,@LoginId
        ,@Phone   
      )  
        
 INSERT INTO tblUserProfile(  
        UserId   
        ,[Description]  
        ,UserImage  
        ,DOB  
        ,Address  
        ,City  
        ,State  
        ,Country  
        ,Gender  
        ,WorkAt  
        ,Designation  
        ,CollegeAt  
        ,SchoolAt  
         )         
     VALUES   (  
        @UserId  
        ,@Description   
        ,@UserImage   
        ,@DOB   
        ,@Address   
        ,@City   
        ,@State   
        ,@Country   
        ,@Gender  
        ,@WorkAt   
        ,@Designation   
        ,@CollegeAt   
        ,@SchoolAt   
      )  
  SET @retValue=1      
  END  
RETURN @retValue   
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_GetProfileByUserId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_GetProfileByUserId]  
@UserId uniqueidentifier  
AS  
BEGIN  
SELECT * FROM tblUserProfile UP
INNER JOIN tblUser U On U.UserId = UP.UserId WHERE U.UserId=@UserId  
END
GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblStatus](
	[StatusId] [uniqueidentifier] NOT NULL,
	[StatusName] [nvarchar](max) NULL,
	[StatusType] [varchar](10) NULL,
	[StatusUrl] [nvarchar](500) NULL,
	[UserId] [uniqueidentifier] NULL,
	[PermissionId] [int] NULL,
	[IsHidden] [bit] NULL,
	[IsArchived] [bit] NULL,
	[IsShared] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[proc_tblPermissions_SelAll]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_tblPermissions_SelAll]
as
select * from tblPermissions
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_SelMessagesForDefaultUser]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_SelMessagesForDefaultUser]    
@FromUserId UNIQUEIDENTIFIER         
AS          
BEGIN          
        
 DECLARE @ToUserId UNIQUEIDENTIFIER        
 SET @ToUserId = (SElect ToUserId FROM(SELECT DISTINCT TOP 1 M.ToUserId,M.CreatedOn         
 FROM tblMessage M          
 Inner Join tblMessage M2 on M.FromUserId = M2.ToUserId    
 Where (M.FromUserId = @FromUserId) Or (M.ToUserId = @FromUserId)  
And M.CreatedOn = (SELECT MAX(CreatedOn) FROM tblMessage WHERE (FromUserId = @FromUserId) Or (ToUserId = @FromUserId))          
 ORDER BY M.CreatedOn DESC) AS T)      
         
 SELECT M.*,U.FirstName + ' ' + ISNULL(U.LastName,'') As FromUserName,UP.UserImage AS FromUserImage        
 ,U1.FirstName + ' ' + ISNULL(U1.LastName,'') As ToUserName,UP1.UserImage AS ToUserImage          
 FROM tblMessage M          
 INNER JOIN tblUser U ON U.UserId = M.FromUserId           
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId          
 INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId           
 INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId         
 WHERE (ToUserId = @ToUserId OR FromUserId = @ToUserId) AND (ToUserId = @FromUserId OR FromUserId = @FromUserId)        
 ORDER BY CreatedOn DESC        
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_SelAllToUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_SelAllToUserId]    
@FROMUserId UNIQUEIDENTIFIER,   
@ToUserId UNIQUEIDENTIFIER    
AS    
BEGIN    
 SELECT M.*,U.FirstName + ' ' + ISNULL(U.LastName,'') As FromUserName,UP.UserImage AS FromUserImage    
 ,U1.FirstName + ' ' + ISNULL(U1.LastName,'') As ToUserName,UP1.UserImage AS ToUserImage      
 FROM tblMessage M      
 INNER JOIN tblUser U ON U.UserId = M.FromUserId       
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId      
 INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId       
 INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId    
 WHERE (ToUserId = @ToUserId OR FromUserId = @ToUserId) AND (ToUserId = @FromUserId OR FromUserId = @FromUserId)        
 ORDER BY CreatedOn DESC            
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_SelAllFromUserIdTemp]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_SelAllFromUserIdTemp]
@FromUserId UNIQUEIDENTIFIER        
AS        
BEGIN        
 SELECT DISTINCT TOP 1 M.*,U.FirstName + ' ' + ISNULL(U.LastName,'') As FromUserName,UP.UserImage AS FromUserImage    
 ,U1.FirstName + ' ' + ISNULL(U1.LastName,'') As ToUserName,UP1.UserImage AS ToUserImage      
 FROM tblMessage M      
 INNER JOIN tblUser U ON U.UserId = M.FromUserId       
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId      
INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId       
INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId
Inner Join tblMessage M2 on M.FromUserId = M2.ToUserId
Where (M.FromUserId = @FromUserId) Or (M.ToUserId = @FromUserId)
And M.CreatedOn = (SELECT MAX(CreatedOn) FROM tblMessage WHERE (FromUserId = @FromUserId) Or (ToUserId = @FromUserId))          
ORDER BY CreatedOn DESC      
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_SelAllFromUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_SelAllFromUserId]
@FromUserId UNIQUEIDENTIFIER        
AS        
BEGIN        
 SELECT DISTINCT M.*,U.FirstName + ' ' + ISNULL(U.LastName,'') As FromUserName,UP.UserImage AS FromUserImage    
 ,U1.FirstName + ' ' + ISNULL(U1.LastName,'') As ToUserName,UP1.UserImage AS ToUserImage      
 FROM tblMessage M      
 INNER JOIN tblUser U ON U.UserId = M.FromUserId       
INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId      
INNER JOIN tblUser U1 ON U1.UserId = M.ToUserId       
INNER JOIN tblUserProfile UP1 ON UP1.UserId = U1.UserId
Inner Join tblMessage M2 on M.FromUserId = M2.ToUserId
Where (M.FromUserId = @FromUserId) Or (M.ToUserId = @FromUserId)
And M.CreatedOn = (SELECT MAX(CreatedOn) FROM tblMessage WHERE (FromUserId = @FromUserId) Or (ToUserId = @FromUserId))          
ORDER BY CreatedOn DESC      
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblMessage_Ins]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblMessage_Ins]
@FromUserId UNIQUEIDENTIFIER,
@ToUserNames VARCHAR(MAX),
@MessageDesc VARCHAR(MAX)
AS
BEGIN
	DECLARE @Username VARCHAR(200)
	DECLARE @UserId UNIQUEIDENTIFIER
	DECLARE Cursor_chkUserName CURSOR  FOR
	SELECT Items FROM dbo.Split(@ToUserNames,',')
	
	OPEN Cursor_chkUserName
	FETCH NEXT FROM Cursor_chkUserName INTO @Username
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM tblUser WHERE LoginId = @Username)  
		BEGIN  
			INSERT INTO tblUser(FirstName,LoginId)VALUES(@Username,@Username)  
			SET @UserId = (SELECT UserId FROM tblUser Where LoginId = @Username)  
			INSERT INTO tblUserProfile(UserId,UserImage)VALUES(@UserId,'no_image.jpg')  
		END 
		ELSE
		BEGIN
			SET @UserId = (SELECT UserId FROM tblUser Where LoginId = @Username)  
		END
		
		INSERT INTO tblMessage(FromUserId,ToUserId,[Message])VALUES(@FromUserId,@UserId,@MessageDesc)
		 
		FETCH NEXT FROM Cursor_chkUserName INTO @Username
	END
	
	CLOSE Cursor_chkUserName
	DEALLOCATE Cursor_chkUserName
	RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblUser_Update]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblUser_Update]    
@UserId UNIQUEIDENTIFIER,    
@FirstName NVARCHAR(50),    
@LastName NVARCHAR(50),    
@EmailId NVARCHAR(250),    
@DOB DATETIME,    
@Designation VARCHAR(200),    
@WorkAt NVARCHAR(400),    
@CollegeAt NVARCHAR(400),    
@SchoolAt NVARCHAR(400),    
@Gender VARCHAR(10),    
@UserImage NVARCHAR(250),    
@About NVARCHAR(MAX),    
@Description NVARCHAR(MAX),    
@Address NVARCHAR(500),    
@City NVARCHAR(200),    
@State NVARCHAR(200),    
@Country NVARCHAR(200),  
@UserCode VARCHAR(20)    
AS    
BEGIN    
 UPDATE tblUser     
 SET    
  FirstName = @FirstName,    
  LastName = @LastName,    
  EmailId = @EmailId,  
  UserCode = @UserCode  
 WHERE     
  UserId = @UserId    
      
 UPDATE tblUserProfile    
 SET    
  Description = @Description,    
  About = @About,    
  UserImage = @UserImage,    
  DOB = @DOB,    
  Address = @Address,    
  City = @City,    
  State = @State,    
  Country = @Country,    
  Gender = @Gender,    
  WorkAt = @WorkAt,    
  Designation = @Designation,    
  CollegeAt = @CollegeAt,    
  SchoolAt = @SchoolAt  
 WHERE    
  UserId = @UserId    
RETURN 1    
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblChatSession_INS]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_tblChatSession_INS]              
@SessionId UNIQUEIDENTIFIER,            
@CustomerId VARCHAR(50),              
@CustomerName NVARCHAR(200),            
@CustomerImage VARCHAR(300),            
@FriendType VARCHAR(50),            
@DeviceToken VARCHAR(300),              
@DeviceType VARCHAR(50),      
@Email VARCHAR(300),      
@Mobile VARCHAR(50),
@FriendId UNIQUEIDENTIFIER      
AS              
BEGIN              
          
IF @CustomerName = '(null)'          
BEGIN          
 SET @CustomerName = 'guest'          
END          
          
IF @CustomerImage = '(null)'          
BEGIN          
 SET @CustomerImage = 'guest'          
END  
  
 
          
IF EXISTS(SELECT 1 FROM tblChatSession WHERE CustomerId = @CustomerId AND DeviceToken = @DeviceToken AND FriendType = @FriendType)              
BEGIN              
 RETURN -1              
END              
ELSE              
BEGIN              
 INSERT INTO tblChatSession              
 (              
 SessionId,              
 CustomerId,            
 CustomerName,            
 CustomerImage,            
 FriendType,  
 FriendId,  
 DeviceToken,              
 DeviceType,              
 CreatedOn,              
 LastUsedOn,      
 Email,      
 Mobile      
 )              
 VALUES              
 (              
 @SessionId,              
 @CustomerId,              
 @CustomerName,            
 @CustomerImage,            
 @FriendType,  
 @FriendId,  
 @DeviceToken,              
 @DeviceType,              
 GETUTCDATE(),  
 GETUTCDATE(),  
 @Email,      
 @Mobile      
 )              
 RETURN 1              
END              
END
GO
/****** Object:  Table [dbo].[tblChatMessage]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChatMessage](
	[MessageId] [uniqueidentifier] NOT NULL,
	[SessionId] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](3000) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[FromCustomer] [bit] NULL,
 CONSTRAINT [PK_tblChatMessage] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblChatHistoryMessage]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChatHistoryMessage](
	[MessageId] [uniqueidentifier] NOT NULL,
	[HistoryId] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](3000) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[FromCustomer] [bit] NULL,
 CONSTRAINT [PK_tblChatHistoryMessage] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_tblFriendList_Upd]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_tblFriendList_Upd]
@UserId UNIQUEIDENTIFIER,
@FriendUserId UNIQUEIDENTIFIER,
@IsMailSent BIT,
@IsAccepted BIT,
@IsBlocked BIT,
@IsRead BIT,
@LastReqestedDate DATETIME
AS       
BEGIN 
DECLARE @ReturnValue INT
SET @ReturnValue=-1
	if((Select COUNT(UserId) from tblFriendList Where UserId = @UserId and FriendUserId != @FriendUserId)>0)
			BEGIN
				Update tblFriendList Set  
				IsMailSent = @IsMailSent,
				IsAccepted = @IsAccepted,
				IsBlocked = @IsBlocked,
				IsRead = @IsRead,
				LastReqestedDate = @LastReqestedDate
				Where UserId = @UserId and FriendUserId != @FriendUserId 
				Set @ReturnValue=1	
			END
		ELSE
			BEGIN
			Set @ReturnValue=-1	 
			END
		return @ReturnValue
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblFriendList_Ins]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_tblFriendList_Ins]  
@UserId UNIQUEIDENTIFIER,  
@FriendUserId UNIQUEIDENTIFIER,  
@IsMailSent BIT,  
@IsAccepted BIT,  
@IsBlocked BIT,  
@IsRead BIT  
AS  
BEGIN  
 DECLARE @ReturnValue INT  
 SET @ReturnValue=1  
  IF NOT EXISTS(SELECT 1 FROM tblFriendList WHERE UserId = @UserId AND FriendUserId = @FriendUserId)
   BEGIN  
   INSERT INTO tblFriendList  
   (  
   UserId,  
   FriendUserId,  
   IsMailSent,  
   IsAccepted,  
   IsBlocked,  
   IsRead,  
   LastReqestedDate  
   )  
   VALUES  
   (  
   @UserId,  
   @FriendUserId,  
   @IsMailSent,  
   @IsAccepted,  
   @IsBlocked,  
   @IsRead,  
   GETDATE()  
   )  
   SET @ReturnValue=-1 -- Sucsessfully Insert Record  
  END   
     
  ELSE  
  BEGIN  
  SET @ReturnValue=-1 -- Duplicate Record  
  END   
    
  return @ReturnValue  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblFriendList_AcceptFriend]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblFriendList_AcceptFriend]  
@UserId UNIQUEIDENTIFIER  
,@FriendUserId UNIQUEIDENTIFIER  
AS  
BEGIN  
 UPDATE tblFriendList  
 SET  
  IsAccepted = 1  
 WHERE   
  UserId = @UserId  AND FriendUserId=@FriendUserId
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblDashboardWidget_SelActive]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblDashboardWidget_SelActive]
AS
BEGIN
	SELECT *
	FROM tblDashboardWidget
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblDashboardWidget_Sel_Selected]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblDashboardWidget_Sel_Selected] --'d8d06a75-083f-4274-8672-203099966719'
@UserId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT DW.*, CASE WHEN ISNULL(UDW.WidgetId, 0) > 0 THEN 'True' ELSE 'False' END AS [IsSelected]
	FROM tblDashboardWidget DW
	LEFT JOIN tblUserDashboardWidget UDW ON UDW.WidgetId = DW.DashboardWidgetId AND UDW.UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatSession_Upd_Initiate]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatSession_Upd_Initiate]    
@SessionId UNIQUEIDENTIFIER,    
@FriendId UNIQUEIDENTIFIER    
AS    
BEGIN    
IF NOT EXISTS(SELECT 1 FROM tblChatSession WHERE SessionId = @SessionId)    
BEGIN    
 RETURN -1    
END    
ELSE IF EXISTS(SELECT 1 FROM tblChatSession WHERE SessionId = @SessionId AND FriendId = @FriendId)  
BEGIN  
 RETURN -2  
END  
ELSE    
BEGIN    
 UPDATE tblChatSession    
 SET FriendId = @FriendId    
 WHERE SessionId = @SessionId    
     
 RETURN 1    
END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatSession_Sel_ByFriendId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_tblChatSession_Sel_ByFriendId]  
@FriendId UNIQUEIDENTIFIER  
AS  
BEGIN  
 SELECT S.* FROM tblChatSession S  
 WHERE S.FriendId = @FriendId  
 ORDER BY S.CreatedOn ASC  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatSession_Sel_ByDeviceTokenAndType]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatSession_Sel_ByDeviceTokenAndType]  
@DeviceToken VARCHAR(300),  
@DeviceType VARCHAR(50)  
AS  
BEGIN  
 SELECT *  
 FROM tblChatSession  
 WHERE DeviceToken = @DeviceToken AND DeviceType = @DeviceType  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_ForceLogin]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tblUser_ForceLogin]     
@Username VARCHAR(100)    
AS    
BEGIN    
DECLARE @UserId UNIQUEIDENTIFIER    
 IF NOT EXISTS(SELECT 1 FROM tblUser WHERE LoginId = @Username)    
 BEGIN    
  INSERT INTO tblUser(FirstName,LoginId)VALUES(@Username,@Username)    
  SET @UserId = (SELECT UserId FROM tblUser Where LoginId = @Username)    
  INSERT INTO tblUserProfile(UserId,UserImage)VALUES(@UserId,'no_image.jpg')    
 END    
 SELECT U.*,UP.Description,UP.UserImage,UP.DOB,UP.Address,UP.City,UP.State,UP.Country,UP.Gender,UP.WorkAt,            
 UP.Designation,UP.CollegeAt,UP.SchoolAt,UP.About             
 FROM tblUser U             
 INNER JOIN tblUserProfile UP ON U.UserId= UP.UserId AND LoginId = @Username    
     
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tblUser_CheckLogin]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_tblUser_CheckLogin]     
@LoginId NVARCHAR(50),          
@Password  NVARCHAR(50)          
AS          
BEGIN          
 IF EXISTS(SELECT * FROM tblUser WHERE ((LoginId = @LoginId OR EmailId=@LoginId OR Phone=@LoginId) AND [Password] = @Password))                                  
 BEGIN                       
  SELECT U.*,UP.Description,UP.UserImage,UP.DOB,UP.Address,UP.City,UP.State,UP.Country,UP.Gender,UP.WorkAt,        
  UP.Designation,UP.CollegeAt,UP.SchoolAt,UP.About         
  FROM tblUser U         
  LEFT JOIN tblUserProfile UP ON U.UserId= UP.UserId        
  WHERE ((U.LoginId = @LoginId OR U.EmailId=@LoginId OR U.Phone=@LoginId) AND U.Password = @Password)                        
 END           
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblStatus_Share]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblStatus_Share]      
(      
@StatusId UNIQUEIDENTIFIER,    
@StatusName NVARCHAR(MAX),      
@StatusType VARCHAR(10),      
@StatusUrl NVARCHAR(500),      
@UserId UNIQUEIDENTIFIER,      
@PermissionId INT,      
@IsHidden BIT,      
@IsArchived BIT,      
@IsShared BIT      
)      
AS      
BEGIN      
  
INSERT INTO tblStatus   
(  
 StatusId,  
 StatusName,   
 StatusType,   
 StatusUrl,   
 UserId,   
 PermissionId,   
 IsHidden,   
 IsArchived,   
 IsShared,   
 CreatedDate,   
 ModifiedDate  
)       
VALUES (  
 NEWID(),  
 @StatusName,   
 @StatusType,   
 @StatusUrl,   
 @UserId,   
 @PermissionId,  
 @IsHidden,   
 @IsArchived,   
 @IsShared,   
 GETDATE(),  
 GETDATE()  
 )     
RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblStatus_Ins]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblStatus_Ins]  
(  
@StatusId UNIQUEIDENTIFIER,
@StatusName NVARCHAR(MAX),  
@StatusType VARCHAR(10),  
@StatusUrl NVARCHAR(500),  
@UserId UNIQUEIDENTIFIER,  
@PermissionId INT,  
@IsHidden BIT,  
@IsArchived BIT  
)  
AS  
BEGIN  
IF NOT EXISTS(SELECT 1 FROM tblStatus WHERE StatusId=@StatusId)
BEGIN
INSERT INTO tblStatus (StatusId,StatusName, StatusType, StatusUrl, UserId, PermissionId, IsHidden, IsArchived, CreatedDate, ModifiedDate)   
VALUES (NEWID(),@StatusName, @StatusType, @StatusUrl, @UserId, @PermissionId, @IsHidden, @IsArchived, GETDATE(),GETDATE()) 
RETURN 1 
END
ELSE
BEGIN
UPDATE tblStatus SET StatusName=@StatusName,StatusType=@StatusType,StatusUrl=@StatusUrl,ModifiedDate=GETDATE()
WHERE StatusId=@StatusId
RETURN 2
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatSession_MOVE_BySessionId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatSession_MOVE_BySessionId]  
@SessionId UNIQUEIDENTIFIER  
AS  
BEGIN  
 DECLARE @HistoryId UNIQUEIDENTIFIER = NEWID()  
  
 INSERT INTO tblChatHistory  
 (HistoryId,CustomerId,CustomerName,CustomerImage,FriendId,FriendType,DeviceToken,DeviceType,CreatedOn,LastUsedOn)  
 (SELECT @HistoryId,CustomerId,CustomerName,CustomerImage,FriendId,FriendType,DeviceToken,DeviceType,CreatedOn,LastUsedOn  
 FROM tblChatSession WHERE SessionId = @SessionId)  
  
 INSERT INTO tblChatHistoryMessage  
 (MessageId,HistoryId,[Message],CreatedOn,FromCustomer)  
 (SELECT NEWID(),@HistoryId,[Message],CreatedOn,FromCustomer  
 FROM tblChatMessage WHERE SessionId = @SessionId)  
  
 DELETE FROM tblChatMessage WHERE SessionId = @SessionId  
 DELETE FROM tblChatSession WHERE SessionId = @SessionId  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatSession_Sel_NewSessions]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatSession_Sel_NewSessions] --'Agent'    
@AgentType VARCHAR(50)        
AS        
BEGIN        
 SELECT CS.*,    
 CASE WHEN ISNULL(CM.MessageId, '00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' THEN 'false'    
 ELSE 'true' END [HasCustomerPosted],  
 DATEDIFF(S, GETUTCDATE(), CS.LastUsedOn) [IdleTime]  
 FROM tblChatSession CS    
 LEFT OUTER JOIN tblChatMessage CM ON CM.SessionId = CS.SessionId    
 WHERE CS.FriendId IS NULL AND CS.FriendType = @AgentType        
 ORDER BY CS.CreatedOn ASC    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatMessage_Sel_ByUserId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatMessage_Sel_ByUserId] --'040676f5-a508-48d4-84e3-691af01a6bce'      
@UserId UNIQUEIDENTIFIER,    
@TimeStamp DATETIME      
AS      
BEGIN      
    
 SELECT GETUTCDATE() AS CurrentTime    
     
 SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage,      
 U.FirstName [FriendName], '' [FriendImage]      
 FROM tblChatMessage M      
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId      
 INNER JOIN tblUser U ON U.UserId = S.FriendId      
 WHERE U.UserId = @UserId    
 AND DATEDIFF(MILLISECOND, @TimeStamp, M.CreatedOn) > 0       
 ORDER BY M.SessionId, M.CreatedOn ASC      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatMessage_Sel_BySessionId_Sync]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatMessage_Sel_BySessionId_Sync]  
@SessionId UNIQUEIDENTIFIER,  
@TimeStamp DATETIME = '1990-01-01 00:00:00.000'  
AS    
BEGIN  
 SELECT GETUTCDATE() AS CurrentTime      
  
IF(@TimeStamp = '1990-01-01 00:00:00.000')  
BEGIN  
 SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage,    
 U.FirstName [FriendName], UP.UserImage [FriendImage]    
 FROM tblChatMessage M    
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId    
 LEFT OUTER JOIN tblUser U ON U.UserId = S.FriendId    
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId   
 WHERE M.SessionId = @SessionId  
 ORDER BY M.CreatedOn ASC    
END  
ELSE  
BEGIN  
 SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage,    
 U.FirstName [FriendName], UP.UserImage [FriendImage]    
 FROM tblChatMessage M    
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId    
 LEFT OUTER JOIN tblUser U ON U.UserId = S.FriendId 
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId      
 WHERE M.SessionId = @SessionId  
 AND DATEDIFF(MILLISECOND, @TimeStamp, M.CreatedOn) > 0  
 ORDER BY M.CreatedOn ASC    
END  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatMessage_Sel_BySessionId]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatMessage_Sel_BySessionId] --'040676f5-a508-48d4-84e3-691af01a6bce'  
@SessionId UNIQUEIDENTIFIER  
AS  
BEGIN  
 SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage,  
 U.FirstName [FriendName], UP.UserImage [FriendImage]  
 FROM tblChatMessage M  
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId  
 LEFT OUTER JOIN tblUser U ON U.UserId = S.FriendId  
 INNER JOIN tblUserProfile UP ON UP.UserId = U.UserId 
 WHERE M.SessionId = @SessionId  
 ORDER BY M.CreatedOn ASC  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatMessage_Sel]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_tblChatMessage_Sel]      
@MessageId UNIQUEIDENTIFIER      
AS      
BEGIN      
 SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage, S.DeviceToken, S.DeviceType,    
 U.FirstName [FriendName], U.UserId As [FriendId], U.EmailId [FriendEmail], '' [FriendImage]  
 FROM tblChatMessage M     
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId     
 LEFT OUTER JOIN tblUser U ON U.UserId = S.FriendId     
 WHERE M.MessageId = @MessageId     
 ORDER BY M.CreatedOn ASC    
    
 /*SELECT M.*, S.CustomerId, S.CustomerName, S.CustomerImage,      
 U.FirstName [FriendName], U.UserImage [FriendImage], S.DeviceToken, S.DeviceType      
 FROM tblChatMessage M      
 INNER JOIN tblChatSession S ON S.SessionId = M.SessionId      
 LEFT OUTER JOIN tblUser U ON U.UserId = S.FriendId      
 WHERE M.MessageId = @MessageId      
 ORDER BY M.CreatedOn ASC*/    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_tblChatMessage_Ins]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_tblChatMessage_Ins]    
@MessageId UNIQUEIDENTIFIER,    
@SessionId UNIQUEIDENTIFIER,    
@Message NVARCHAR(3000),    
@FromCustomer BIT    
AS    
BEGIN    
 INSERT INTO tblChatMessage    
 (    
  MessageId,    
  SessionId,    
  [Message],    
  CreatedOn,    
  FromCustomer    
 )    
 VALUES    
 (    
  @MessageId,    
  @SessionId,    
  @Message,    
  GETUTCDATE(), --GETDATE(),    
  @FromCustomer    
 )    
     
 UPDATE tblChatSession    
 SET LastUsedOn = GETUTCDATE() --GETDATE()    
    
 RETURN 1    
END
GO
/****** Object:  Table [dbo].[tblLike]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLike](
	[LikeId] [uniqueidentifier] NOT NULL,
	[StatusId] [uniqueidentifier] NULL,
	[IsLiked] [bit] NULL,
	[UserId] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tblLike] PRIMARY KEY CLUSTERED 
(
	[LikeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblComment]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblComment](
	[CommentId] [uniqueidentifier] NOT NULL,
	[CommentName] [varchar](max) NOT NULL,
	[StatusId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tblComment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCommentLike]    Script Date: 09/04/2014 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommentLike](
	[CommentLikeId] [uniqueidentifier] NOT NULL,
	[StatusId] [uniqueidentifier] NULL,
	[CommentId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[IsLiked] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_tblCommentLike] PRIMARY KEY CLUSTERED 
(
	[CommentLikeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_tblLike_SelByUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblLike_SelByUserId]
@UserId uniqueidentifier
as
begin
select * from tblLike where UserId=@UserId
end
GO
/****** Object:  StoredProcedure [dbo].[proc_tblLike_SelAll]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblLike_SelAll]
as
begin
select * from tblLike 
end
GO
/****** Object:  StoredProcedure [dbo].[proc_tblLike_Ins]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblLike_Ins]     
@LikeId uniqueidentifier,    
@StatusId uniqueidentifier,    
@IsLiked bit,    
@UserId uniqueidentifier    
AS    
BEGIN    
	IF NOT EXISTS(SELECT 1 FROM tblLike WHERE LikeId = @LikeId AND UserId = @UserId)    
	BEGIN    
		DECLARE @LID UNIQUEIDENTIFIER
		SET @LID = NEWID()
		INSERT INTO tblLike    
			(LikeId, StatusId, IsLiked, UserId, CreatedDate, ModifiedDate)
		VALUES    
			(@LID, @StatusId, @IsLiked, @UserId, GETDATE(), GETDATE())    
		      
		SELECT @LID;
	END    
	ELSE    
	BEGIN    
		UPDATE tblLike    
			SET IsLiked = @IsLiked, ModifiedDate = GETDATE()    
			WHERE  LikeId=@LIKEID    
	      
		SELECT @LIKEID;    
	 END    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforTimeline_test]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforTimeline_test] --'00000000-0000-0000-0000-000000000000'      
@UserId UNIQUEIDENTIFIER      
AS      
BEGIN      
SELECT S.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage FROM tblStatus S       
INNER JOIN tblUser U ON S.UserId = U.UserId      
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId      
WHERE S.UserId=@UserId   
OR S.UserId IN (SELECT FriendUserId FROM tblFriendList FL   
WHERE FL.UserId = @UserId AND ISNULL(FL.IsAccepted,0) = 1 AND ISNULL(FL.IsBlocked,0) = 0)  
      
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage FROM tblComment C      
INNER JOIN tblUser U ON C.UserId = U.UserId      
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId      
WHERE C.StatusId IN (SELECT S.StatusId FROM tblStatus S WHERE UserId=@UserId OR   
UserId IN (SELECT FriendUserId FROM tblFriendList FL   
WHERE FL.UserId = @UserId AND ISNULL(FL.IsAccepted,0) = 1 AND ISNULL(FL.IsBlocked,0) = 0))   
  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforTimeline_Old]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforTimeline_Old] --'00000000-0000-0000-0000-000000000000'        
@UserId UNIQUEIDENTIFIER        
AS        
BEGIN        
SELECT S.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage FROM tblStatus S         
INNER JOIN tblUser U ON S.UserId = U.UserId        
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId     
ORDER BY S.CreatedDate DESC  
        
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName, UP.UserImage  
FROM tblComment C  
INNER JOIN tblStatus S ON S.StatusId = C.StatusId  
INNER JOIN tblUser U ON U.UserId = C.UserId  
LEFT OUTER JOIN tblUserProfile UP ON UP.UserId = U.UserId  
ORDER BY C.CreatedDate ASC  
    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforTimeline]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforTimeline] --'00000000-0000-0000-0000-000000000000'          
@UserId UNIQUEIDENTIFIER          
AS          
BEGIN          
SELECT DISTINCT S.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,   
(select COUNT(1) from tbllike where StatusId=s.StatusId and IsLiked =1) as [LikesCount] FROM tblStatus S           
INNER JOIN tblUser U ON S.UserId = U.UserId          
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId 
LEFT JOIN tblComment C On S.StatusId = C.StatusId
WHERE S.UserId = @UserId OR C.UserId = @UserId       
ORDER BY S.CreatedDate DESC    
          
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName, UP.UserImage    
FROM tblComment C    
INNER JOIN tblStatus S ON S.StatusId = C.StatusId    
INNER JOIN tblUser U ON U.UserId = C.UserId    
LEFT OUTER JOIN tblUserProfile UP ON UP.UserId = U.UserId    
ORDER BY C.CreatedDate ASC   
      
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblComment_Sel]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblComment_Sel]
@StatusId UNIQUEIDENTIFIER
AS
BEGIN

SELECT C.*,(U.FirstName +' '+U.LastName) As UserName,UP.UserImage FROM tblComment C 
INNER JOIN tblUser U ON C.UserId = U.UserId
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId
WHERE C.StatusId=@StatusId

END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblComment_Ins]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblComment_Ins] --'00000000-0000-0000-0000-000000000000'  
@CommentId UNIQUEIDENTIFIER,  
@CommentName VARCHAR(MAX),  
@StatusId UNIQUEIDENTIFIER,  
@UserId UNIQUEIDENTIFIER  
AS  
BEGIN  
	IF NOT EXISTS(SELECT 1 FROM tblComment WHERE CommentId=@CommentId)  
	BEGIN      
		DECLARE @LID UNIQUEIDENTIFIER
		SET @LID = NEWID()
		INSERT INTO tblComment(CommentId,CommentName,StatusId,UserId,CreatedDate,ModifiedDate)  
		VALUES(@LID,@CommentName,@StatusId,@UserId,GETDATE(),GETDATE())  
		SELECT @LID  
	END  
	ELSE  
	BEGIN  
		UPDATE tblComment SET CommentName=@CommentName,ModifiedDate=GETDATE()  
		WHERE CommentId=@CommentId  
		SELECT @CommentId  
	END 
  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblPhoto_SelAllforNewsFeed]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblPhoto_SelAllforNewsFeed] --'7B242AE8-8145-4BB0-919B-8AAFC2E3D4CA'                
@UserId UNIQUEIDENTIFIER                
AS                
BEGIN                
SELECT S.*,(U.FirstName + ' ' + ISNULL(U.LastName,'')) AS UserName,UP.UserImage,          
  ISNULL(L.IsLiked,0) AS [IsLiked],                  
 (SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],          
  ISNULL(L.LikeId ,'00000000-0000-0000-0000-000000000000') AS LikeId  FROM tblStatus S                   
INNER JOIN tblUser U ON S.UserId = U.UserId                  
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId AND s.StatusType <> 'text' and s.StatusUrl <> ''                  
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId=@UserId     
ORDER BY S.ModifiedDate DESC      
            
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelforWall]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelforWall] --'391E7219-C1D7-493C-A3B3-5B37047BCE17'            
@LoggedInUserId UNIQUEIDENTIFIER,  
@SelectedUserId UNIQUEIDENTIFIER            
AS            
BEGIN            
SELECT DISTINCT S.*, (U.FirstName +' '+U.LastName) AS UserName, UP.UserImage,  
  ISNULL(L.IsLiked,0) AS [IsLiked],          
 (SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],  
  ISNULL(L.LikeId ,'00000000-0000-0000-0000-000000000000') AS LikeId    
FROM tblStatus S               
INNER JOIN tblUser U ON S.UserId = U.UserId              
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId       
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId=@LoggedInUserId  
LEFT JOIN tblComment C On S.StatusId = C.StatusId     
WHERE S.UserId=@SelectedUserId  OR C.UserId = @SelectedUserId
ORDER BY S.CreatedDate DESC          
            
SELECT DISTINCT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,  
 ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],  
 ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId    
FROM tblComment C        
INNER JOIN tblUser U ON C.UserId = U.UserId              
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId   
INNER JOIN tblStatus S ON S.StatusId = C.StatusId AND S.UserId = @SelectedUserId  OR C.UserId = @SelectedUserId
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId AND TCL.UserId=@LoggedInUserId  
ORDER BY C.ModifiedDate ASC    
  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelforWall_TestPaging]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelforWall_TestPaging] --'4146000e-5833-4bf6-ae3e-cf2e9d3ffa2c' ,10,1  
  @UserId UNIQUEIDENTIFIER ,  
  @PageSize AS INT = 0,                                  
  @CurrentPageIndex AS INT = 10                                                                 
AS              
BEGIN  
   
 SELECT DISTINCT S.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage ,          
 (select COUNT(1) from tbllike where StatusId=s.StatusId and IsLiked =1) as [LikesCount]  ,     
 ISNULL((select IsLiked from tbllike where StatusId=s.StatusId and UserId=@UserId),0) as IsLiked,    
 ISNULL(TL.LikeId ,'00000000-0000-0000-0000-000000000000') AS  LikeId     
 into #temp         
 FROM  tblStatus S               
 INNER JOIN tblUser U ON S.UserId = U.UserId              
 INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId      
 LEFT JOIN tblComment C ON S.StatusId= C.StatusId  
 LEFT OUTER JOIN tblLike TL ON  TL.StatusId=S.StatusId  AND TL.UserId=@UserId           
 --inner JOIN tbllike TL ON TL.UserId = U.UserId AND TL.StatusId = S.StatusId            
 WHERE S.UserId=@UserId  
 OR C.UserId=@UserId  
 ORDER BY S.CreatedDate DESC   
 --select * from  #temp         
      
    DECLARE @strQueryPaging VARCHAR(MAX)                                                            
    DECLARE @strQueryAll VARCHAR(MAX)    
    SELECT * into #temp3  FROM (SELECT ROW_NUMBER() OVER(ORDER BY CreatedDate) as ind,*   
    FROM (SELECT * FROM #temp) as T) as Q where ind >=1  and ind < 10
    select * from #temp3  
      --cast(@CurrentPageIndex as varchar(10))
      --cast((@CurrentPageIndex + @PageSize)  as varchar(10))  
   SELECT DISTINCT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage  ,    
ISNULL((SELECT IsLiked FROM tblCommentLike WHERE  StatusId =C.StatusId AND CommentId=C.CommentId AND UserId=C.UserId),0) as IsLiked    
,ISNULL(TCL.CommentLikeId   ,'00000000-0000-0000-0000-000000000000') AS  CommentLikeId  
   FROM tblComment C              
   INNER JOIN tblUser U ON C.UserId = U.UserId              
   INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId    
   LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId=C.StatusId AND   TCL.CommentId=C.CommentId AND TCL.UserId=C.UserId       
   WHERE C.StatusId IN       
   (SELECT S.StatusId FROM #temp3 S INNER JOIN tblComment C ON S.StatusId= C.StatusId   
   WHERE S.UserId=@UserId OR C.UserId=@UserId)   
   drop table #temp3  
   DROP TABLE #TEMP       
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelforWall_Test]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelforWall_Test] --'391E7219-C1D7-493C-A3B3-5B37047BCE17'          
@LoggedInUserId UNIQUEIDENTIFIER,
@SelectedUserId UNIQUEIDENTIFIER          
AS          
BEGIN          
SELECT S.*, (U.FirstName +' '+U.LastName) AS UserName, UP.UserImage,
	 ISNULL(L.IsLiked,0) AS [IsLiked],        
	(SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],
	 ISNULL(L.LikeId ,'00000000-0000-0000-0000-000000000000') AS LikeId  
FROM tblStatus S             
INNER JOIN tblUser U ON S.UserId = U.UserId            
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId     
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId=@LoggedInUserId     
WHERE S.UserId=@SelectedUserId
ORDER BY S.CreatedDate DESC        
          
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,
	ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],
	ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId  
FROM tblComment C      
INNER JOIN tblUser U ON C.UserId = U.UserId            
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId 
INNER JOIN tblStatus S ON S.StatusId = C.StatusId AND S.UserId = @SelectedUserId
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId AND TCL.UserId=@LoggedInUserId
ORDER BY C.ModifiedDate ASC  

END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelforWall_Old]    Script Date: 09/04/2014 22:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelforWall_Old] --'391E7219-C1D7-493C-A3B3-5B37047BCE17'          
@UserId UNIQUEIDENTIFIER          
AS          
BEGIN          
SELECT S.*, (U.FirstName +' '+U.LastName) AS UserName, UP.UserImage,
	 ISNULL(L.IsLiked,0) AS [IsLiked],        
	(SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId) AS [LikesCount],
	 ISNULL(L.LikeId ,'00000000-0000-0000-0000-000000000000') AS LikeId  
FROM tblStatus S             
INNER JOIN tblUser U ON S.UserId = U.UserId            
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId     
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId=@UserId     
WHERE S.UserId=@UserId
ORDER BY S.CreatedDate DESC        
          
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,
	ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],
	ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId  
FROM tblComment C      
INNER JOIN tblUser U ON C.UserId = U.UserId            
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId 
INNER JOIN tblStatus S ON S.StatusId = C.StatusId AND S.UserId = @UserId
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId AND TCL.UserId=@UserId
ORDER BY C.ModifiedDate ASC  

END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblComment_Del]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblComment_Del]    
@CommentId UNIQUEIDENTIFIER    
AS    
BEGIN    
    
DELETE FROM tblCommentLike WHERE CommentId=@CommentId    
DELETE FROM tblComment WHERE CommentId=@CommentId    
RETURN 1    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforNewsFeedBypaging]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforNewsFeedBypaging]    
 --[proc_tblStatus_SelAllforNewsFeedBypaging] 0,5,'1241AB3B-7A82-4979-9E7E-638CB274A732'    
@startRowIndex AS INT = 0,                                                  
@maximumRows AS INT = 10,                  
@UserId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'          
AS                  
BEGIN     
    
DECLARE @strQueryPaging VARCHAR(max)                                                  
DECLARE @strQueryAll VARCHAR(max)      
  
          
SET @strQueryAll = 'SELECT S.*,(U.FirstName + '' '' + ISNULL(U.LastName,'''')) AS UserName,UP.UserImage,            
ISNULL(L.IsLiked,0) AS [IsLiked],                    
(SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],            
ISNULL(L.LikeId ,''00000000-0000-0000-0000-000000000000'') AS LikeId  FROM tblStatus S                     
INNER JOIN tblUser U ON S.UserId = U.UserId                    
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId                    
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId='''+ CAST(@UserId AS VARCHAR(50)) +''''   
  
   
SET @strQueryPaging = 'SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY CreatedDate DESC) as ind,* from (' + @strQueryAll + ') as T) as Q where ind >= '                                                  
  + cast(@startRowIndex AS VARCHAR(10)) + ' and ind < ' + cast((@startRowIndex + @maximumRows)  AS VARCHAR(10))                                                  
                                        
EXEC(@strQueryPaging)  
  
exec('select Count(*) as TotalCount from (' + @strQueryAll +') as C')   
  
CREATE TABLE #tmpStatus(RowNumber INT,StatusId UNIQUEIDENTIFIER)  
--Inserting Status in temp Table  
INSERT INTO #tmpStatus  
SELECT * FROM(SELECT ROW_NUMBER() OVER(ORDER BY S.CreatedDate DESC) AS ind, S.StatusId FROM tblStatus S                     
INNER JOIN tblUser U ON S.UserId = U.UserId                    
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId                    
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId= CAST(@UserId AS VARCHAR(50)))AS T  
WHERE ind >=  cast(@startRowIndex AS VARCHAR(10)) AND ind < cast((@startRowIndex + @maximumRows)  AS VARCHAR(10))  
  
--SELECT * from #tmpStatus  
      
  
--Get the comments by status Id's in temp table  
SELECT * FROM(SELECT ROW_NUMBER() OVER (PARTITION BY C.StatusId ORDER BY C.CreatedDate) AS Id,(SELECT COUNT(1) FROM tblComment WHERE StatusId=C.StatusId) AS TotalCommentsCount,  
C.*,(U.FirstName +' '+ISNULL(U.LastName,'''')) AS UserName,UP.UserImage,            
ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],            
ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId              
FROM tblComment C                  
INNER JOIN tblUser U ON C.UserId = U.UserId                        
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId            
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId  
WHERE C.StatusId IN (SELECT StatusId FROM #tmpStatus)) AS T WHERE id >= 1 AND id < 3  
   
DROP TABLE #tmpStatus         
              
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_SelAllforNewsFeed]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblStatus_SelAllforNewsFeed] --'00000000-0000-0000-0000-000000000000'        
@UserId UNIQUEIDENTIFIER        
AS        
BEGIN        
SELECT S.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,  
  ISNULL(L.IsLiked,0) AS [IsLiked],          
 (SELECT COUNT(1) from tblLike WHERE StatusId = S.StatusId AND IsLiked = 1) AS [LikesCount],  
  ISNULL(L.LikeId ,'00000000-0000-0000-0000-000000000000') AS LikeId  FROM tblStatus S           
INNER JOIN tblUser U ON S.UserId = U.UserId          
INNER JOIN tblUserProfile UP ON S.UserId = UP.UserId          
LEFT OUTER JOIN tblLike L ON L.StatusId=S.StatusId AND L.UserId=@UserId 
ORDER BY S.ModifiedDate DESC  
  
SELECT C.*,(U.FirstName +' '+U.LastName) AS UserName,UP.UserImage,  
 ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],  
 ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId    
FROM tblComment C        
INNER JOIN tblUser U ON C.UserId = U.UserId              
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId  
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId AND TCL.UserId=@UserId  
ORDER BY C.ModifiedDate ASC  
    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblStatus_Del]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_tblStatus_Del]  
@StatusId UNIQUEIDENTIFIER  
AS  
BEGIN  
 DELETE FROM tblLike WHERE StatusId = @StatusId  
 DELETE FROM tblCommentLike WHERE StatusId = @StatusId  
 DELETE FROM tblComment WHERE StatusId = @StatusId  
 DELETE FROM tblStatus WHERE StatusId = @StatusId  
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblCommentLike_SelByUserId]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblCommentLike_SelByUserId]
@UserId UNIQUEIDENTIFIER 
AS
BEGIN
SELECT * FROM tblCommentLike WHERE UserId=@UserId
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblCommentLike_Sel]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_tblCommentLike_Sel]
as
begin
select * from  tblCommentLike
end
GO
/****** Object:  StoredProcedure [dbo].[proc_tblCommentLike_InsBackup]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_tblCommentLike_InsBackup]  
@CommentLikeId  uniqueidentifier,  
@StatusId uniqueidentifier,  
@CommentId uniqueidentifier,  
@UserId uniqueidentifier,  
@IsLiked bit  
AS  
BEGIN  
 IF NOT EXISTS(SELECT 1 FROM tblCommentLike WHERE CommentLikeId = @CommentLikeId AND UserId = @UserId)  
 BEGIN       
  DECLARE @LID UNIQUEIDENTIFIER    
  SET @LID = NEWID()    
  INSERT INTO tblCommentLike  
       (CommentLikeId, StatusId, CommentId, UserId, IsLiked, CreatedDate, ModifiedDate)  
    VALUES  
       (  
       @LID, @StatusId, @CommentId, @UserId, @IsLiked, GETDATE(),GETDATE())        
  SELECT @LID;   
 END  
 ELSE  
 BEGIN  
  UPDATE tblCommentLike  
   SET IsLiked = @IsLiked, ModifiedDate = GETDATE()  
   WHERE CommentLikeId = @CommentLikeId       
            
  SELECT @CommentLikeId;        
 END  
  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblCommentLike_Ins]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_tblCommentLike_Ins]    
@CommentLikeId  uniqueidentifier,    
@StatusId uniqueidentifier,    
@CommentId uniqueidentifier,    
@UserId uniqueidentifier,    
@IsLiked bit    
AS    
BEGIN    
 IF NOT EXISTS(SELECT 1 FROM tblCommentLike WHERE CommentId = @CommentId AND UserId = @UserId AND StatusId=@StatusId)    
 BEGIN         
  DECLARE @LID UNIQUEIDENTIFIER      
  SET @LID = NEWID()      
  INSERT INTO tblCommentLike    
       (CommentLikeId, StatusId, CommentId, UserId, IsLiked, CreatedDate, ModifiedDate)    
    VALUES    
       (    
       @LID, @StatusId, @CommentId, @UserId, @IsLiked, GETDATE(),GETDATE())          
  SELECT @LID;     
 END    
 ELSE    
 BEGIN    
  UPDATE tblCommentLike    
   SET IsLiked = @IsLiked, ModifiedDate = GETDATE()    
   WHERE CommentId = @CommentId AND UserId = @UserId AND StatusId=@StatusId        
              
  SELECT CommentLikeId from tblCommentLike WHERE CommentId = @CommentId AND UserId = @UserId AND StatusId=@StatusId           
 END    
    
END
GO
/****** Object:  StoredProcedure [dbo].[proc_tblComment_SelLatestComments]    Script Date: 09/04/2014 22:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--proc_tblComment_SelLatestComments 'A0193151-A1BD-47FE-B479-C643D78D5451'

CREATE PROC [dbo].[proc_tblComment_SelLatestComments]    
@StatusId UNIQUEIDENTIFIER    
AS    
BEGIN    
    
SELECT C.*,(U.FirstName +''+ISNULL(U.LastName,'')) AS UserName,UP.UserImage,            
 ISNULL(TCL.IsLiked,0) AS [IsCommentLiked],            
 ISNULL(TCL.CommentLikeId, '00000000-0000-0000-0000-000000000000') AS CommentLikeId              
FROM tblComment C                  
INNER JOIN tblUser U ON C.UserId = U.UserId                        
INNER JOIN tblUserProfile UP ON C.UserId = UP.UserId            
LEFT OUTER JOIN tblCommentLike TCL ON TCL.StatusId = C.StatusId AND TCL.CommentId=C.CommentId    
WHERE C.StatusId = @StatusId        
ORDER BY C.ModifiedDate ASC  
  
SELECT COUNT(1) AS TotalCount FROM tblComment WHERE StatusId = @StatusId    
    
END
GO
/****** Object:  Default [DF_tblChatSession_SessionId]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblChatSession] ADD  CONSTRAINT [DF_tblChatSession_SessionId]  DEFAULT (newid()) FOR [SessionId]
GO
/****** Object:  Default [DF_tblCommentLike_CommentLikeId]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblCommentLike] ADD  CONSTRAINT [DF_tblCommentLike_CommentLikeId]  DEFAULT (newid()) FOR [CommentLikeId]
GO
/****** Object:  Default [DF_tblFriendList_IsMailSent]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblFriendList] ADD  CONSTRAINT [DF_tblFriendList_IsMailSent]  DEFAULT ((0)) FOR [IsMailSent]
GO
/****** Object:  Default [DF_tblFriendList_IsAccepted]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblFriendList] ADD  CONSTRAINT [DF_tblFriendList_IsAccepted]  DEFAULT ((0)) FOR [IsAccepted]
GO
/****** Object:  Default [DF_tblFriendList_IsBlocked]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblFriendList] ADD  CONSTRAINT [DF_tblFriendList_IsBlocked]  DEFAULT ((0)) FOR [IsBlocked]
GO
/****** Object:  Default [DF_tblFriendList_IsRead]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblFriendList] ADD  CONSTRAINT [DF_tblFriendList_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
/****** Object:  Default [DF_tblFriendList_LastReqested]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblFriendList] ADD  CONSTRAINT [DF_tblFriendList_LastReqested]  DEFAULT (getdate()) FOR [LastReqestedDate]
GO
/****** Object:  Default [DF_tblMessage_MessageId]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblMessage] ADD  CONSTRAINT [DF_tblMessage_MessageId]  DEFAULT (newid()) FOR [MessageId]
GO
/****** Object:  Default [DF_tblMessage_IsRead]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblMessage] ADD  CONSTRAINT [DF_tblMessage_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
/****** Object:  Default [DF_tblMessage_Createdon]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblMessage] ADD  CONSTRAINT [DF_tblMessage_Createdon]  DEFAULT (getdate()) FOR [Createdon]
GO
/****** Object:  Default [DF_tblUser_UserId]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblUser] ADD  CONSTRAINT [DF_tblUser_UserId]  DEFAULT (newid()) FOR [UserId]
GO
/****** Object:  Default [DF_tblUser_CreatedOn]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblUser] ADD  CONSTRAINT [DF_tblUser_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  ForeignKey [FK_tblChatHistoryMessage_tblChatHistory]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblChatHistoryMessage]  WITH CHECK ADD  CONSTRAINT [FK_tblChatHistoryMessage_tblChatHistory] FOREIGN KEY([HistoryId])
REFERENCES [dbo].[tblChatHistory] ([HistoryId])
GO
ALTER TABLE [dbo].[tblChatHistoryMessage] CHECK CONSTRAINT [FK_tblChatHistoryMessage_tblChatHistory]
GO
/****** Object:  ForeignKey [FK_tblChatMessage_tblChatSession]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblChatMessage]  WITH CHECK ADD  CONSTRAINT [FK_tblChatMessage_tblChatSession] FOREIGN KEY([SessionId])
REFERENCES [dbo].[tblChatSession] ([SessionId])
GO
ALTER TABLE [dbo].[tblChatMessage] CHECK CONSTRAINT [FK_tblChatMessage_tblChatSession]
GO
/****** Object:  ForeignKey [FK_tblComment_tblStatus]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_tblComment_tblStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[tblStatus] ([StatusId])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblStatus]
GO
/****** Object:  ForeignKey [FK_tblComment_tblUser]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblComment]  WITH CHECK ADD  CONSTRAINT [FK_tblComment_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblComment] CHECK CONSTRAINT [FK_tblComment_tblUser]
GO
/****** Object:  ForeignKey [FK_tblCommentLike_tblComment]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblCommentLike]  WITH CHECK ADD  CONSTRAINT [FK_tblCommentLike_tblComment] FOREIGN KEY([CommentId])
REFERENCES [dbo].[tblComment] ([CommentId])
GO
ALTER TABLE [dbo].[tblCommentLike] CHECK CONSTRAINT [FK_tblCommentLike_tblComment]
GO
/****** Object:  ForeignKey [FK_tblCommentLike_tblStatus]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblCommentLike]  WITH CHECK ADD  CONSTRAINT [FK_tblCommentLike_tblStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[tblStatus] ([StatusId])
GO
ALTER TABLE [dbo].[tblCommentLike] CHECK CONSTRAINT [FK_tblCommentLike_tblStatus]
GO
/****** Object:  ForeignKey [FK_tblCommentLike_tblUser]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblCommentLike]  WITH CHECK ADD  CONSTRAINT [FK_tblCommentLike_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblCommentLike] CHECK CONSTRAINT [FK_tblCommentLike_tblUser]
GO
/****** Object:  ForeignKey [FK_tblLike_tblStatus]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblLike]  WITH CHECK ADD  CONSTRAINT [FK_tblLike_tblStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[tblStatus] ([StatusId])
GO
ALTER TABLE [dbo].[tblLike] CHECK CONSTRAINT [FK_tblLike_tblStatus]
GO
/****** Object:  ForeignKey [FK_tblLike_tblUser]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblLike]  WITH CHECK ADD  CONSTRAINT [FK_tblLike_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblLike] CHECK CONSTRAINT [FK_tblLike_tblUser]
GO
/****** Object:  ForeignKey [FK_tblStatus_tblPermissions]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblStatus]  WITH CHECK ADD  CONSTRAINT [FK_tblStatus_tblPermissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[tblPermissions] ([PermissionId])
GO
ALTER TABLE [dbo].[tblStatus] CHECK CONSTRAINT [FK_tblStatus_tblPermissions]
GO
/****** Object:  ForeignKey [FK_tblStatus_tblUser]    Script Date: 09/04/2014 22:07:33 ******/
ALTER TABLE [dbo].[tblStatus]  WITH CHECK ADD  CONSTRAINT [FK_tblStatus_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblStatus] CHECK CONSTRAINT [FK_tblStatus_tblUser]
GO
