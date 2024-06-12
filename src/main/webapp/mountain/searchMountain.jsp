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

<h1>Mountain Search Keywords</h1>
<ul>
    <c:forEach var="searchKeyword" items="${mountainSearchKeywords}">
        <li>${searchKeyword}</li>
    </c:forEach>
</ul>


<h1>Popular Search Keywords</h1>
<ul>
    <c:forEach var="searchKeyword" items="${popularSearchKeywords}">
        <li>${searchKeyword}</li>
    </c:forEach>
</ul>


</body>
</html>