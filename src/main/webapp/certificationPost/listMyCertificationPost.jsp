<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<h1> 내가 작성한 게시글 목록조회</h1>
<body>
   <c:forEach var="certificationPost" items="${myCertificationPost}">
    <p><strong>산명칭:</strong> ${certificationPost.certificationPostMountainName}</p>
    <p><strong>글제목:</strong> ${certificationPost.title}</p>
    <p><strong>등산일자:</strong> ${certificationPost.certificationPostHikingDate}</p>
    <p><strong>작성일자:</strong> ${certificationPost.postDate}</p>
    <hr/>
</c:forEach>
</body>
</html>