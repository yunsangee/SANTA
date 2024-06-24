<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<h1>User List</h1>
    <c:forEach var="user" items="${user}" varStatus="status">
    <p>User Number: ${status.count}</p> <!-- 게시글 갯수맞는지 확인하기위한 넘버링 -->
    <p>userName : ${user.userName}</p>
    <p>userId: ${user.userId}</p>
        <p>NickName: ${user.nickName}</p>
        <p>creationDate: ${user.creationDate}</p>
        <p>withdrawDate: ${user.withdrawDate}</p>
        <hr/>
    </c:forEach>
</body>
</html>