<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<h1>Certification Post Detail Page</h1>
<body>

<h2>Like Status</h2>
    <c:choose>
        <c:when test="${certificationPost.certificationPostLikeStatus == 0}">
           <p>좋아요를 누르지 않았습니다.</p> 
        </c:when>
        <c:otherwise>
            <p>!!!좋아요를 눌렀습니다.!!!</p>
        </c:otherwise>
    </c:choose>
    
 <p>Mountain Name: ${certificationPost.title}</p>
        <p>Mountain Name: ${certificationPost.certificationPostMountainName}</p>
        <p>Hiking Trail: ${certificationPost.certificationPostHikingTrail}</p>
        <p>Total Time: ${certificationPost.certificationPostTotalTime}</p>
        <p>Ascent Time: ${certificationPost.certificationPostAscentTime}</p>
        <p>Descent Time: ${certificationPost.certificationPostDescentTime}</p>
        <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
        <p>Transportation: ${certificationPost.certificationPostTransportation}</p>
        <p>Hiking Difficulty: ${certificationPost.certificationPostHikingDifficulty}</p>
		<h2>Hashtags</h2>
<c:forEach var="hashtag" items="${hashtagList}">
    <p>Hashtag: ${hashtag.certificationPostHashtagContents}</p>
</c:forEach>
<h2>Comments</h2>
<c:forEach var="comment" items="${certificationPostComments}">
    <p>User No: ${comment.userNo}</p>
    <p>Nickname: ${comment.nickname}</p>
    <p>Contents: ${comment.certificationPostCommentContents}</p>
    <p>Creation Date: ${comment.certificationPostCommentCreationDate}</p>
    <hr/>
</c:forEach>

</body>
</html>