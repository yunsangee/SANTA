<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호를 변경하시나요?!</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        main {
            flex: 1;
            padding: 20px;
            text-align: center;
            justify-content: center;
            align-items: center;
            margin-top: 100px;
        }

        .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 40px;
            font-size: 33.5px;
        }

        .container p {
            color: #999999;
            font-size: 13px;
            margin-bottom: 30px;
        }

        .container label {
            display: block;
            font-weight: bold;
            align-items: center;
        }

        .password, .email, .code, .phone {
            width: 30%;
            padding: 10px;
         /*    margin-bottom: 10px;
            margin-top: 30px; */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
        }
        
        .password:focus, .email:focus, .code:focus, .phone:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); 
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
            .password, .email, .code, .phone, .submit {
                width: 100%;
                margin: 5px 0;
            }
        }

        footer {
            width: 100%;
            text-align: center;
            position: absolute;
            bottom: 0;
        }
    </style>
    
    <c:import url="../common/header.jsp"/>
    
    <script>
        $(document).ready(function() {
            $("#changePasswordForm").on("submit", function(e) {
                var password = $("input[name='userPassword']").val();
                var confirmPassword = $("input[name='checkPassword']").val();

                if (password.length < 10) {
                    e.preventDefault();
                    $("#passwordLengthMessage").text("비밀번호는 10자 이상이어야 합니다.").css("color", "red");
                } else if (password !== confirmPassword) {
                    e.preventDefault();
                    $("#passwordMessage").text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.").css("color", "red");
                }
            });
        });
    </script>
</head>

<body>
<header>
    <c:import url="../common/top.jsp"/>
</header>

<main class="container">
    <h2>비밀번호 변경</h2> 
    <p class="description">영문, 숫자를 포함한 10자 이상의 비밀번호를 입력해주세요.</p>
    <form id="changePasswordForm" action="/user/changePassword" method="post">
        <div class="password-section">
            <label></label>
            <input type="password" class="password" name="currentPassword" placeholder="현재 비밀번호" required>
        </div>
        <div class="password-section">
            <label></label>
            <input type="password" class="password" name="userPassword" placeholder="비밀번호 입력" autocomplete="new-password" required>
            <div id="passwordLengthMessage" class="error-message"></div>
        </div>
        <div class="password-section">
            <label></label>
            <input type="password" class="password" name="checkPassword" placeholder="비밀번호 확인" autocomplete="new-password" required>
            <div id="passwordMessage" class="error-message"></div>
        </div>
        
        <button type="submit" class="submit">비밀번호 변경하기</button>
        
    </form>
</main>

<footer>
    <c:import url="../common/footer.jsp"/>
</footer>

</body>
</html>
