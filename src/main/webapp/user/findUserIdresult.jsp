<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디 찾기 결과</title>
</head>
<body>
    <h2>아이디 찾기 결과</h2>
    <%
        String userId = (String) request.getAttribute("userId");
    %>
    <div>
        <% if (userId != null) { %>
            <p>회원님의 아이디는: <strong><%= userId %></strong> 입니다.</p>
        <% } else { %>
            <p>입력하신 정보와 일치하는 아이디가 없습니다.</p>
        <% } %>
    </div>
    <div>
        <a href="/user/login.jsp">로그인 페이지로 이동</a>
    </div>
</body>
</html>
