<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
	<link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
<!--     <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script> -->

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

    <style>
        body {
            display: flex;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        header {
            width: 100%;
        }

        main {
            flex: 1;
            margin-top: 280px; /* Adjust this value as needed to avoid overlap */
            padding: 20px;
            text-align: center;
            justify-content: center;
            align-items: center;
        }

        .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 30px;
        }

        .container p {
            color: #999999;
            font-size: 13px;
            margin-bottom: 30px;
        }

       .passwordNew  {
            width: 100%; 
           /*  width: 21.8% */;
            padding: 10px;
            margin-bottom: -20px;
           /*  margin-top: 30px; */
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            margin-top:-70px;
            /* margin-right: 77px; */
        }
        
        .checkPassword {
            width: 100%; 
           /*  width: 21.8% */;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            margin-top:-70px;
            /* margin-right: 77px; */
        }

        .passwordNew:focus,
        .checkPassword:focus {
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

        @media (max-width: 768px) {
            .passwordNew, .checkPassword, .submit {
                width: 100%;
            }
        }

        footer {
            width: 100%;
            margin-bottom: -249px;
        }

        .form-group {
            position: relative;
            width: 30%;
            margin: 0 auto;
            text-align: left;
        }

        .form-group span {
            display: block;
            font-size: 13px;
            margin-top: -1px;
            margin-bottom: 10px;
            color: red;
            text-align: left; /* Add this line to align text to the left */
            width: 100%;
        }

        #passwordLengthMessage {
            color: red;
        }

        #passwordMatchMessage {
            color: green;
        }
    </style>

    <c:import url="../common/header.jsp"/>

<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showSuccessAlert(message) {
            Swal.fire({
                icon: 'success',
                text: message,
                confirmButtonText: 'OK'
            });
        }

        function showErrorAlert(message) {
            Swal.fire({
                icon: 'error',
                text: message,
                confirmButtonText: 'Retry'
            });
        }
    </script>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(function() {
            $("input[name='passwordNew']").on("input", function() {
                var password = $(this).val();
                console.log(password.length);
                if (password.length < 7) {
                    $("#passwordLengthMessage").text("비밀번호를 7자 이상 입력해주세요.").show();
                    $("#passwordMatchMessage").text("").hide();
                } else if (password.length > 15) {
                    $("#passwordLengthMessage").text("비밀번호를 15자 이하 입력해주세요.").show();
                    $("#passwordMatchMessage").text("").hide();
                } else {
                    var hasLetter = /[a-zA-Z]/.test(password);
                    var hasNumber = /[0-9]/.test(password);
                    var hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

                    if (!hasLetter || !hasNumber || !hasSpecialChar) {
                        $("#passwordLengthMessage").text("비밀번호에는 영문, 숫자, 특수문자가 포함되어야 합니다.").show();
                        $("#passwordMatchMessage").text("").hide();
                    } else {
                        $("#passwordLengthMessage").text("").hide();
                        checkPasswordMatch();
                    }
                }
            });

            $("input[name='checkPassword']").on("input", function() {
                checkPasswordMatch();
            });

            function checkPasswordMatch() {
                var password = $("input[name='passwordNew']").val();
                var confirmPassword = $("input[name='checkPassword']").val();

                if (password.length >= 7 && password.length <= 15) {
                    var hasLetter = /[a-zA-Z]/.test(password);
                    var hasNumber = /[0-9]/.test(password);
                    var hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

                    if (hasLetter && hasNumber && hasSpecialChar) {
                        if (password !== confirmPassword) {
                            $("#passwordMatchMessage").text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.").css("color", "red").show();
                        } else {
                            $("#passwordMatchMessage").text("비밀번호가 일치합니다.").css("color", "green").show();
                        }
                    } else {
                        $("#passwordMatchMessage").text("").hide();
                    }
                } else {
                    $("#passwordMatchMessage").text("").hide();
                }
            }
        });

        function submitForm(event) {
            event.preventDefault();

            const passwordNew = document.getElementById("passwordNew").value;
            const checkPassword = document.getElementById("checkPassword").value;
            const userPassword = document.getElementById("userPassword").value;
            const userId = document.getElementById("userId").value;

            if (passwordNew !== checkPassword) {
            	showErrorAlert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
                return;
            }

            if (passwordNew === userPassword) {
            	showErrorAlert("기존 비밀번호와 같은 비밀번호입니다.");
                return;
            }
            
            if(userPassword == "kakao"){
            	showErrorAlert("카카오 로그인 산타님은 비밀번호를 변경하실 수 없습니다.");
                return;
            }

            fetch('rest/setUserPassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    userId: userId,
                    userPassword: userPassword,
                    passwordNew: passwordNew,
                    checkPassword: checkPassword
                })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text) });
                }
                return response.text();
            })
            .then(data => {
            	showSuccessAlert("비밀번호가 변경되었습니다.");
                window.location.href = "/user/login.jsp"; // 비밀번호 변경 후 로그인 페이지로 리디렉션
            })
            .catch(error => {
            	showErrorAlert(error.message);
            });
        }
    </script>
</head>

<body>

<header>
    <c:import url="../common/top.jsp"/>
</header>

<main class="container">
    <h2>비밀번호 재설정</h2>
    <p>비밀번호는 영문, 숫자, 특수문자를 포함하여 7자~15자 사이의 비밀번호를 입력하셔야 변경 가능합니다.</p>
    <form onsubmit="submitForm(event)">
        
        <div class="form-group">
            <label for="passwordNew"></label>
            <input type="password" class="passwordNew" id="passwordNew" name="passwordNew" placeholder="비밀번호 입력" required>
            
        </div>
       
        <div class="form-group">
            <label for="checkPassword"></label>
            <input type="password" class="checkPassword" id="checkPassword" name="checkPassword" placeholder="비밀번호 확인" required>
            <span id="passwordLengthMessage"></span>
            <span id="passwordMatchMessage"></span>
        </div>
        
        <input type="hidden" id="userPassword" name="userPassword" value="<c:out value='${sessionScope.userPassword}'/>">
        <input type="hidden" id="userId" name="userId" value="<c:out value='${sessionScope.userId}'/>">
        
        <button type="submit" class="submit">비밀번호 변경</button>
    </form>
</main>

<footer>
    <c:import url="../common/footer.jsp"/>
</footer>

</body>

</html>
