<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>잃어버린 아이디를 찾았습니다!</title>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
    
<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        main.container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            text-align: center;
        }

        main.container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 20px;
        }

        main.container p {
            color: #333;
            font-size: 17px;
            margin-top:30px;
            margin-bottom: 20px;
        }

        main.container .link {
            display: inline-block;
            font-size: 12px;
            text-align: center;
            margin-top: 10px;
            color: #333;
            text-decoration: none;
        }

        main.container .link:hover {
            text-decoration: underline;
        }
    </style>
  
<c:import url="../common/header.jsp"/>
</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
    <c:import url="../common/top.jsp"/>
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main class="container">
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
    	<button type="submit" class="submit">비밀번호 찾기</button>
    </div>
    
    <div>
        <a href="/user/login.jsp" class="link">로그인 페이지로 이동</a>
    </div>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
</footer>

</body>
</html>
