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

<p>Hello getAlarmMessage.jsp</p>

<c:forEach var="item" items="${alarmMessageList}" varStatus="status">
	<p> Messages = ${status.index} : ${item}
	<br/>
</c:forEach>

	

</body>
</html>