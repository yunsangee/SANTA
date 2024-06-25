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
            font-size: 30px;
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

        .password {
            width: 30%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
        }
        
        .password:focus {
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
    
    <script>
        $(document).ready(function() {
            // 현재 비밀번호 입력 칸에서 포커스 아웃될 때
            $("input[name='currentPassword']").on("blur", function() {
                var currentPassword = $(this).val();

                $.ajax({
                    url: '/user/rest/changePassword',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ currentPassword: currentPassword, action: 'checkCurrentPassword' }),
                    success: function(response) {
                        if (response.status === "incorrect") {
                            $("#currentPasswordMessage").text(response.message).css("color", "red").show();
                        } else if (response.status === "correct") {
                            $("#currentPasswordMessage").text(response.message).css("color", "green").show();
                        }
                    },
                    error: function(xhr, status, error) {
                        $("#currentPasswordMessage").text("오류가 발생했습니다. 다시 시도해주세요.").css("color", "red").show();
                    }
                });
            });

            // 비밀번호 입력 칸에서 포커스 아웃될 때
            $("input[name='userPassword']").on("blur", function() {
                var password = $(this).val();

                if (password.length < 10) {
                    $("#passwordLengthMessage").text("비밀번호를 10자 이상 입력해주세요.").css("color", "red").show();
                } else {
                    $("#passwordLengthMessage").text("").hide();
                }
            });

            // 비밀번호 확인 입력 칸에서 포커스 아웃될 때
            $("input[name='checkPassword']").on("blur", function() {
                var password = $("input[name='userPassword']").val();
                var confirmPassword = $(this).val();

                $.ajax({
                    url: '/user/rest/changePassword',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        userPassword: password,
                        checkPassword: confirmPassword,
                        action: 'checkPasswordMatch'
                    }),
                    success: function(response) {
                        if (response.status === "equals") {
                            $("#passwordMessage").text(response.message).css("color", "green").show();
                        } else if (response.status === "notequals") {
                            $("#passwordMessage").text(response.message).css("color", "red").show();
                        }
                    },
                    error: function(xhr, status, error) {
                        $("#passwordMessage").text("오류가 발생했습니다. 다시 시도해주세요.").css("color", "red").show();
                    }
                });
            });

            // 폼 제출 시 비밀번호 변경 요청
            $("#changePasswordForm").on("submit", function(e) {
                e.preventDefault();
                var currentPassword = $("input[name='currentPassword']").val();
                var userPassword = $("input[name='userPassword']").val();
                var checkPassword = $("input[name='checkPassword']").val();
                var userNo = $("#userNo").val(); // userNo 값을 가져옴

                $.ajax({
                    url: '/user/rest/changePassword',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        currentPassword: currentPassword,
                        userPassword: userPassword,
                        checkPassword: checkPassword,
                        action: 'changePassword'
                    }),
                    success: function(response) {
                        if (response.status === "equals") {
                            alert(response.message);
                            window.location.href = "/user/updateUser?userNo=" + userNo;
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
        });
    </script>
</head>

<body>
<header>
</header>

<main class="container">
    <h2>비밀번호 변경</h2>
    <form id="changePasswordForm" action="/user/changePassword" method="post">
        <div class="password-section">
            <label></label>
            <input type="password" class="password" name="currentPassword" placeholder="현재 비밀번호" required>
            <div id="currentPasswordMessage" class="error-message"></div>
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
      
    <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
    <input type="hidden" id="userId" name="userId" value="${user.userId}">
        
        <button type="submit" class="submit">비밀번호 변경하기</button>
        
    </form>
</main>

<footer>
</footer>

</body>
</html>
