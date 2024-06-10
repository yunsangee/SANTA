<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<h1>Certification Post List</h1>
    <c:forEach var="certificationPost" items="${certificationPost}">
    <p>Mountain Name: ${certificationPost.title}</p>
        <p>Mountain Name: ${certificationPost.certificationPostMountainName}</p>
        <p>Hiking Trail: ${certificationPost.certificationPostHikingTrail}</p>
        <p>Total Time: ${certificationPost.certificationPostTotalTime}</p>
        <p>Ascent Time: ${certificationPost.certificationPostAscentTime}</p>
        <p>Descent Time: ${certificationPost.certificationPostDescentTime}</p>
        <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
        <p>Transportation: ${certificationPost.certificationPostTransportation}</p>
        <p>Hiking Difficulty: ${certificationPost.certificationPostHikingDifficulty}</p>
        <p>Hashtag Contents: ${certificationPost.certificationPostHashtagContents}</p>
        <hr/>
    </c:forEach>
</body>
</html>