<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>비밀번호를 잃어버리셨나요?!</title>
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

        main {
            margin-top: 10px;
            padding: 20px;
            text-align: center;
            justify-content: center;
            align-items: center;
            width: 90%;
            max-width: 500px;
        }

        .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 20px;
        }

        .container p {
            color: #999999;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .container label {
            display: block;
            font-weight: bold;
            align-items: center;
        }

        .email,
        .code {
            width: 30%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        /* .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        } */

        .phone {
            width: 21.8%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            margin-right: 77px;
        }
        
        .email:focus,
        .code:focus,
        .phone:focus {
        	border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
		    outline: none; /* 기본 포커스 효과 제거 */
		    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */	
        }

        .send {
            width: 8%;
            padding: 10px;
            font-size: 16px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: -77px;
        }

        .send:hover {
            background-color: #578906;
        }

        .submit {
            width: 30%;
            padding: 15px;
            font-size: 16px;
            background-color: #81C408;
            margin-top: 10px;
            margin-bottom: 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .submit:hover {
            background-color: #578906;
        }

        .container .link {
            display: inline-block;
            font-size: 12px;
            text-align: center;
            margin-top: 10px;
            color: #333;
            justify-content: center;
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

        @media (max-width: 768px) {
            .email,
            .code,
            .phone,
            .send,
            .submit {
                width: 100%;
                margin: 5px 0;
            }

            .form-group {
                flex-direction: column;
                align-items: stretch;
            }

            /* .send {
                margin-left: 0;
            } */
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
    <form action="/user/findUserPassword" method="post">
        <div>
            <label for="email"></label>
            <input type="text" class="email" id="userId" name="userId" placeholder="email" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber"></label>
            <input type="text" class="phone" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호" required>
            <button type="button" class="send" onclick="sendVerificationCode()">인증번호</button>
        </div>
        <div>
            <label for="verifyCode"></label>
            <input type="text" class="code" id="verifyCode" name="verifyCode" placeholder="인증번호">
        </div>
        <button type="submit" class="submit">비밀번호 찾기</button>
        <br>
        <a href="/user/findUserId.jsp" class="link">아이디 찾기</a>&emsp;&emsp;&emsp;
        &emsp;<a href="/user/login.jsp" class="link">로그인 페이지로 가기</a>
    </form>
</main>

<script>
    function sendVerificationCode() {
        // 인증번호 전송 로직 구현
        alert('인증번호가 전송되었습니다.');
    }
</script>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
</footer>

</body>

</html>
