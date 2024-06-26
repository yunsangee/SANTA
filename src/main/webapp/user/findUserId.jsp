<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>아이디를 잃어버리셨나요?!</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"></script>
    
 <!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->   
    
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
            margin-top:265px;
        }

        .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 40px;
            font-size:33.5px;
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
            width: 22%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            display: inline-block;
            margin-left:0px;
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
        
        .verify-check-btn {
            width: 8%;
            padding: 10px;
            font-size: 16px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 5px;
        }
        
        .name:focus,
        .code:focus,
        .phone:focus {
            border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
            outline: none; /* 기본 포커스 효과 제거 */
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */    
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
        
         @media (max-width: 768px) {
            .name,
            .code,
            .phone,
            .send,
            .submit,
            .verify-check-btn {
                width: 100%;
                margin: 5px 0;
            }

            .form-group {
                flex-direction: column;
                align-items: stretch;
            }
        }
        
        footer {
        	width: 100%;
        	 margin-bottom:-249px;
        }
    </style>
    	
    	<c:import url="../common/header.jsp"/>
<!--  ////////////////////////////////////////////// script  ///////////////////////////////////////////////// -->    
    
    <script>
        $(document).ready(function() {
            $(".send").unbind("click").click(function() {
                sendVerificationCode();
            });

            // 인증번호 버튼 클릭 시 인증번호 입력란 추가
            $(".send").unbind("click").click(function() {
                var userName = $("#userName").val();
                var phoneNumber = $("#phoneNumber").val();
                if (userName && phoneNumber) {
                    sendVerificationCode();
                } else {
                    alert("이름과 휴대폰 번호를 모두 입력해주세요.");
                }
            });

            // 인증번호 확인 버튼 클릭 이벤트
            $(document).on("click", ".verify-check-btn", function() {
                var phoneNumber = $("#phoneNumber").val();
                var verifyCode = $("#verifyCode").val();
                verifyCodeFunction(phoneNumber, verifyCode);
            });

            $("#findUserIdForm").on("submit", function(e) {
                var isPhoneVerified = $("#isPhoneVerified").val() === "true";
                var userName = $("#userName").val();
                var phoneNumber = $("#phoneNumber").val();

                if (!userName || !phoneNumber) {
                    e.preventDefault();
                    alert("이름과 휴대폰 번호를 모두 입력해주세요.");
                } else if (!isPhoneVerified) {
                    e.preventDefault();
                    alert("휴대폰 인증을 완료해주세요.");
                }
            });
        });

        function sendVerificationCode() {
            const userName = $("#userName").val();
            const phoneNumber = $("#phoneNumber").val();

            $.ajax({
                url: "/user/rest/findUserId",
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({
                    userName: userName,
                    phoneNumber: phoneNumber
                }),
                success: function(response) {
                    if (!response.userExists) {
                        alert("회원정보가 일치하지 않습니다. 다시 확인해주세요.");
                    } else {
                        $.ajax({
                            url: "/message/send-one",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify({
                                userName: userName,
                                phoneNumber: phoneNumber
                            }),
                            success: function(response) {
                                if (response) {
                                    alert("인증번호가 전송되었습니다.");
                                    
                                    // 인증번호가 전송된 후 인증번호 입력란을 추가
                                    $(".form-group").after(
                                        '<div id="verificationSection">' +
                                        '<label for="verifyCode"></label>' +
                                        '<input type="text" class="code" id="verifyCode" name="verifyCode" placeholder="인증번호" required>' +
                                        '<button type="button" class="verify-check-btn">확인</button>' +
                                        '<span id="verificationResult" class="error-message"></span>' +
                                        '</div>'
                                    );
                                } else {
                                    alert("인증번호 전송에 실패했습니다. 다시 시도해주세요.");
                                }
                            },
                            error: function(xhr, status, error) {
                                alert('인증번호 전송에 실패했습니다. 다시 시도해주세요.');
                            }
                        });
                    }
                },
                error: function(xhr, status, error) {
                    alert('회원정보가 일치하지 않습니다. 다시 시도해주세요.');
                }
            });
        }

        function verifyCodeFunction(phoneNumber, verifyCode) {
            $.ajax({
                url: "/message/check-one",
                type: "GET",
                data: { phoneNumber: phoneNumber, validationNumber: verifyCode },
                success: function(response) {
                    if (response != -1) {
                        alert("휴대폰 인증이 완료되었습니다.");
                        $("#isPhoneVerified").val("true");
                    } else {
                        alert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                }
            });
        }
    </script>
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
    <form id="findUserIdForm" action="/user/findUserId" method="post">
        <div>
            <label for="name"></label>
            <input type="text" class="name" id="userName" name="userName" placeholder="이름" required>
        </div>
        
        <div class="form-group">
            <label for="phoneNumber"></label>
            <input type="text" class="phone" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호" required>
            <button type="button" class="send">인증번호</button>
        </div>
        
        <div>
            <input type="hidden" id="isPhoneVerified" value="false">
        </div>
        
        <button type="submit" class="submit">아이디 찾기</button>
        
        <br>
        <a href="/user/findUserPassword.jsp" class="link">비밀번호 찾기</a>&emsp;&emsp;&emsp;
        &emsp;<a href="/user/login.jsp" class="link">로그인 페이지로 가기</a>
        
    </form>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
	<c:import url="../common/footer.jsp"/>
</footer>

</body>
</html>
