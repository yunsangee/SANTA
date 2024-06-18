<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

    <!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->
  <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
        }

        main {
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        p {
            color: #999999;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .container label {
            display: block;
            font-weight: bold;
            align-items: center;
        }

       .email, .code {
            width: 40%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
        }
        
        .phone {
        	width: 30%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            margin-left : -140px;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

       /*  .form-group input[type="text"] {
            width: 40%;
            margin-right: 10px;
        } */

        .button {
            width: 40%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: -100px;
        }

        .form-group button:hover {
            background-color: #45a049;
        }

        button {
            width: 40%;
            padding: 10px;
            background-color: #4CAF50;
            margin-bottom: 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .container .link {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #333;
            text-decoration: none;
        }

        .container .link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
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
    <h2>비밀번호 찾기</h2>
    <p>회원정보에 등록한 휴대폰 번호와 입력한 휴대폰 번호가 동일해야 인증번호를 받을 수 있습니다.</p>
    <form action="findUserPassword" method="post">
        <div>
            <label for="email"></label>
            <input type="text" class ="email" id="email" name="email" placeholder="email" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber"></label>
            <input type="text" class ="phone" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호" pattern="01[0-9]{8,9}" required>
            <button type="button" class="button" onclick="sendVerificationCode()">인증번호</button>
        </div>
        <div>
            <label for="verifyCode"></label>
            <input type="text" class ="code" id="verifyCode" name="verifyCode" placeholder="인증번호" required>
        </div>
        <button type="submit">비밀번호 찾기</button>
        <a href="/user/findUserId.jsp" class="link">아이디 찾기</a>
        <a href="/user/login.jsp" class="link">로그인 페이지로 가기</a>
    </form>
</main> 

<script>
    function sendVerificationCode() {
        // 인증번호 전송 로직 구현
        alert('인증번호가 전송되었습니다.');
    }
</script>

</body>
</html>
