<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>FollowingList</title>
</head>
<body>
<h1>Following List</h1>

<c:forEach var="following" items="${followingList}">
    <p>이름: ${following.userName}</p>
    <p>배찌?신뢰지표?: ${following.badgeImage}</p>
    
    
    <hr/>
</c:forEach>

</body>
</html>