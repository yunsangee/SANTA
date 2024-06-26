<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>휴대폰 번호를 변경하시나요?!</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"></script>

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
            margin-top: 21px;
        }

        .container h2 {
            color: #333;
            margin-top: 40px;
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

       /*  .phone-container {
            width: 30%;
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        } */

        .phone {
            width: 21%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            box-sizing: border-box;
            align-items: center;
            margin-bottom: 10px;
        }

        .send {
            width: 9%;
            padding: 10px;
            font-size: 13px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

        .send:hover {
            background-color: #578906;
        }

        .code {
            width: 30%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            align-items: center;
            margin-bottom: 10px;
        }

        .verify-check-btn {
            width: 30%;
            padding: 10px;
            font-size: 16px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .verify-check-btn:hover {
            background-color: #578906;
        }

        .phone:focus, .code:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); 
        }

        .submit {
            width: 30%;
            padding: 15px;
            font-size: 16px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .submit:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .submit:hover:enabled {
            background-color: #578906;
        }

        .error-message {
            color: red;
            text-align: left;
            margin-bottom: 10px;
            font-size: 13px;
        }

        @media (max-width: 768px) {
            .code, .verify-check-btn, .submit {
                width: 100%;
                margin: 5px 0;
            }
          }
            
            @media (max-width: 768px) {
             .send {
                width: 20%;
                margin: 5px 0;
            }
        }
        
        @media (max-width: 768px) {
            .phone {
                width: 78%;
                margin: 5px 0;
           }
        }

    </style>
    
    <script>
        $(document).ready(function() {
            $(".send").click(function() {
                sendVerificationCode();
            });

            // 인증번호 확인 버튼 클릭 이벤트
            $(document).on("click", ".verify-check-btn", function() {
                var phoneNumber = $("#phoneNumber").val();
                var verifyCode = $("#verifyCode").val();
                verifyCodeFunction(phoneNumber, verifyCode);
            });

            $("#changePhoneNumberForm").on("submit", function(e) {
                e.preventDefault();
                var isPhoneVerified = $("#isPhoneVerified").val() === "true";

                if (!isPhoneVerified) {
                    alert("휴대폰 인증을 완료해주세요.");
                    return;
                }
            });
        });
    /*             var phoneNumber = $("#phoneNumber").val();

                $.ajax({
                    url: "/user/changePhoneNumber",
                    type: "POST",
                    contentType: "application/json",
                    data: { phoneNumber: phoneNumber },
                    success: function(response) {
                        alert("휴대폰 번호가 성공적으로 변경되었습니다.");
                        window.location.href = "/user/updateUser?userNo="+userNo;
                    },
                    error: function(xhr, status, error) {
                        alert("오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
        }); */

        function sendVerificationCode() {
            const phoneNumber = $("#phoneNumber").val();

            $.ajax({
                url: "/message/send-one",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    phoneNumber: phoneNumber,
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

        function verifyCodeFunction(phoneNumber, verifyCode) {
            $.ajax({
                url: "/message/check-one",
                type: "GET",
                data: { phoneNumber: phoneNumber, validationNumber: verifyCode },
                success: function(response) {
                    if (response != -1) {
                        alert("휴대폰 인증이 완료되었습니다.");
                        $("#isPhoneVerified").val("true");
                        $(".submit").prop("disabled", false); // 인증 완료 시 변경하기 버튼 활성화
                    } else {
                        alert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                }
            });
        }
        
        function closePopup() {
            alert("휴대폰 번호가 성공적으로 변경되었습니다.");
            window.opener.location.reload(); // 부모 창 새로고침
            window.close(); // 팝업 창 닫기
        }
    </script>
</head>

<body>
<header>
</header>

<main class="container">
    <h2>휴대폰 번호 변경</h2>
    <form id="changePhoneNumberForm" action="/user/changePhoneNumber" method="post" onsubmit="closePopup(); return false;">
        <div class="form-group phone-container">
            <label for="phoneNumber"></label>
            <input type="text" class="phone" id="phoneNumber" name="phoneNumber" placeholder="휴대폰 번호" required>
            <button type="button" class="send">인증번호</button>
        </div>
        
        <div>
            <input type="hidden" id="isPhoneVerified" value="false">
        </div>
        
        <button type="submit" class="submit" disabled>변경하기</button>
        
    </form>
</main>


<footer>
</footer>

</body>
</html>
