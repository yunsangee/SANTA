<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>아이디를 잃어버리셨나요?!</title>
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

        .name {
            width: 30%;
            padding: 10px;
            margin-bottom: 10px;
            margin-top: 30px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
        }

        .code {
            width: 30%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
        }

        .phone {
            width: 21.8%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            margin-right: 77px;
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

        .form-group button:hover {
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
    </style>
    
<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->    
    
 <script>
    function sendVerificationCode() {
        const userName = document.getElementById("userName").value;
        const phoneNumber = document.getElementById("phoneNumber").value;

        $.ajax({
            url: "/message/send-one",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                userName: userName,
                phoneNumber: phoneNumber
            }),
            success: function(response) {
                alert('인증번호가 전송되었습니다.');
            },
            error: function(xhr, status, error) {
                alert('인증번호 전송에 실패하였습니다.');
            }
        });
    }

    document.getElementById("verifyCode").addEventListener("input", function() {
        const phoneNumber = document.getElementById("phoneNumber").value;
        const verifyCode = this.value;

        $.ajax({
            url: "/message/check-one",
            type: "GET",
            data: {
                phoneNumber: phoneNumber,
                validationNumber: verifyCode
            },
            success: function(response) {
                const verificationResult = document.getElementById("verificationResult");
                if (response === -1) {
                    verificationResult.textContent = "인증번호가 일치하지 않습니다.";
                } else {
                    verificationResult.textContent = "인증번호가 확인되었습니다.";
                    verificationResult.style.color = "green";
                }
            },
            error: function(xhr, status, error) {
                alert('인증번호 확인에 실패하였습니다.');
            }
        });
    });
</script>

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
    <h2>아이디 찾기</h2>
    <p>회원정보에 등록한 휴대폰 번호와 입력한 휴대폰 번호가 동일해야 인증번호를 받을 수 있습니다.</p>
    <form id="findUserIdForm" action="findUserId" method="post">
        <div>
            <label for="name"></label>
            <input type="text" class="name" id="userName" name="userName" placeholder="이름" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber"></label>
            <input type="text" class="phone" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호" required>
            <button type="button" class="send" onclick="sendVerificationCode()">인증번호</button>
        </div>
        <div>
            <label for="verifyCode"></label>
            <input type="text" class="code" id="verifyCode" name="verifyCode" placeholder="인증번호">
            <span id="verificationResult" class="error-message"></span>
        </div>
        <button type="submit" class="submit">아이디 찾기</button>
        <br>
        <a href="/user/findUserPassword.jsp" class="link">비밀번호 찾기</a>&emsp;&emsp;&emsp;
        &emsp;<a href="/user/login.jsp" class="link">로그인 페이지로 가기</a>
    </form>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
</footer>

</body>
</html>
