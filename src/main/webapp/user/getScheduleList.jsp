<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Schedule List</h1>
    <c:forEach var="schedule" items="${schedule}" varStatus="status">
    <p>Schedule Number: ${status.count}</p> <!-- 게시글 갯수맞는지 확인하기위한 넘버링 -->
    <p>Schedule title: ${schedule.title}</p>
        <hr/>
    </c:forEach>
</body>
</html>