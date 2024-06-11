<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>Follower List</h1>
<c:forEach var="follower" items="${followerList}">
    <p>이름: ${follower.userName}</p>
    <p>배찌?신뢰지표?: ${follower.badgeImage}</p>


    <hr/>
</c:forEach>
</body>
</html>