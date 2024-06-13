<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
</head>
<body>
    <div class="user-details">
        <h2>아이디 찾기 결과</h2>
        <c:choose>
            <c:when test="${not empty userId}">
                <p>회원님의 아이디는: <strong>${userId}</strong> 입니다.</p>
            </c:when>
            <c:otherwise>
                <p>입력하신 정보와 일치하는 아이디가 없습니다.</p>
            </c:otherwise>
        </c:choose>
        <div>
            <a href="/user/login.jsp">로그인 페이지로 이동</a>
        </div>
    </div>
</body>
</html>
