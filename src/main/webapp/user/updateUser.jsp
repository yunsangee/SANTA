<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
	  
    <meta charset="UTF-8">
    <title>${user.nickName}님 정보입니다.</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
    <c:import url="../common/header.jsp"/>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<!--    <script src="https://code.jquery.com/jquery-3.7.1.js"></script> -->
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script> 

    <!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->
    <style>
        main {
            height: 100%; 
            margin: 0;
            display: flex;
            flex-direction: column; 
            justify-content: center;
            align-items: center;
            background-color: white; 
            margin-top:120px;
        }

        .profile-header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            margin-bottom: 25px;
        }

        .profile-container {
            position: relative;
        }

        .profile {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #ccc;
            margin-right: 20px;
            margin-left: -40px;
        }

        .pencil {
            position: absolute;
            top: 55px; /* Adjust as needed */
            left:58px; /* Adjust as needed */
            background-color: #white;
            border-radius: 50%;
            padding: 5px;
            font-size: 30px;
            cursor: pointer;
            margin-right: 20px;
            margin-left: -40px;
        }

        .profile-info {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-info p {
            margin: 5px 0;
            color: black;
            font-weight: bold;
        }

        .profile-info a {
            margin: 5px 0;
            color: black;
            font-weight: bold;
            font-size:15px;
        }

        .update, .phone-link, .detail-section p, .detail-section textarea, .detail-section select {
            width: 400px; /* 원하는 크기로 조절합니다. */
            padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
            font-size: 16px; /* 폰트 크기를 조정합니다. */
            background-color: #ffffff; /* 배경색 추가 */
            color: black;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px;
            margin-bottom: 5px; /* 입력 필드 간 간격 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }
        
        #phoneVerificationCode {
            width: 290px; /* 원하는 크기로 조절합니다. */
            padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
            font-size: 16px; /* 폰트 크기를 조정합니다. */
            background-color: #ffffff; /* 배경색 추가 */
            color: black;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px;
            margin-bottom: 5px; /* 입력 필드 간 간격 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }  

        .update:focus, .detail-section textarea:focus,  .detail-section select:focus, .phone-link:focus, #phoneVerificationCode:focus {
            border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
            outline: none; /* 기본 포커스 효과 제거 */
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */	
        }

        .detail-section p {
            width: 400px; /* 원하는 크기로 조절합니다. */
            padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
            font-size: 16px; /* 폰트 크기를 조정합니다. */
            background-color: #f0f0f0; /* 연한 회색 배경색 추가 */
            color: black;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px;
            margin-bottom: 5px; /* 입력 필드 간 간격 */
            text-align: left; /* 글씨 왼쪽 정렬 */
        }

        .gender {
            width: 400px; /* 원하는 크기로 조절합니다. */
            padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
            font-size: 16px; /* 폰트 크기를 조정합니다. */
            background-color: #f0f0f0; /* 연한 회색 배경색 추가 */
            color: black;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px;
            margin-bottom: 5px; /* 입력 필드 간 간격 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
            text-align: left; /* 글씨 왼쪽 정렬 */
        }

        .submit-button{
            width: 400px;
            padding: 15px;
            font-size: 16px;
            margin-top: 10px;
            text-align: center;
            text-decoration: none;
            display: block;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
        } 

        .a {   
            background-color: white;
            color: #81C408;
            border: 1px solid #81C408;
            border-radius: 5px;
            margin-bottom: 80px;
        }

        .a:hover {
            background-color: #DEFBA7; 
        }

        .text-link {
            color: #81C408;
            text-decoration: none;
            font-size: 13px;
            display: block;
            text-align: center;
            margin-top: 20px;
        }

        .text-link:hover {
            color: #578906;
            text-decoration: underline;
        }

       /*  .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px; 
            justify-content: center;
            align-items: center; 
        }  */

        .detail-section {
            display: flex; 
            flex-direction: column; 
            align-items: center;
            margin-bottom: 20px;
            justify-content: center;
        }

        .detail-section a {
            font-size: 12px;
        }

        .creation-section a {
            font-size: 12px;
            align-items: center;
        }

        .detail-section p {
            margin: 5px 0;
        }

        .line {
            border-bottom: 1px solid #ccc;
            margin: 20px 0;
            width: 100%; /* 라인을 전체 너비로 확장 */
        }

        .survey-label {
            width: 400px; /* 설문조사 글씨를 포함할 너비 설정 */
            text-align: left; /* 설문조사 글씨 왼쪽 정렬 */
            font-size: 12px;
            margin-top: 5px;
            margin-bottom: 7px;
        }

        footer {
            width: 100%;
            text-align: center;
            position: absolute;
            bottom: 0;
        }

        .error-message {
            color: red;
            font-size: 13px;
            margin-top: -1px;
            margin-bottom: 10px;
            text-align: left;
            width: 100%;
            align-items: center;
            justify-content: center;
        }

        .success-message {
            color: green;
            font-size: 16px;
            margin-top: -1px;
            margin-bottom: 10px;
            text-align: left;
            width: 100%;
            align-items: center;
            justify-content: center;
        }
        
        .back-section {
        	width: 100%;
		    font-size: 13.5px;
    		text-align: center;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer; 
		    margin-bottom:50px;
		    margin-top:-60px;
        }
        
        .back-section a {
        	color : grey;
        	text-decoration: underline;
        }
        
        .file-input{
        	display:none;
        }
        
        
        .badgeImage{
        	width:24px;
        	height:24px;
        }
        
         .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding-top:20px;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.dialog-overlay.active {
    display: flex;
}
.dialog-content {
      background: #fff;
      padding: 20px;
      border-radius: 5px;
      margin-top:45px;
      width: 35%;
      height: 50%;
      display: flex;
      flex-direction: column;
      position: relative;
    }

        /* ///////////////////////////////////////////////////////////////////////////////////////////////////////////// */
        
       .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #555;
            background: none;
            border: none;
        }
         .container h2 {
            color: #333;
            margin-top: 5px;
            margin-bottom: 40px;
            font-size: 30px;
            text-align:center;
             align-items: center;
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
             width: 100%; /* 원하는 크기로 조절합니다. */
		    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
		    font-size: 16px; /* 폰트 크기를 조정합니다. */
		    background-color: #ffffff; /* 배경색 추가 */
		    color: black;
		    border: 1px solid #ccc; /* 테두리 추가 */
		    border-radius: 5px;
		    margin-bottom: 3px; /* 입력 필드 간 간격 */
		    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }
        
        .password:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); 
        }
         .submit-password {
            width: 100%;
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

        .submit-password:hover {
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
            text-align: left;
            margin-bottom: 10px;
            font-size: 13px;
        }

        @media (max-width: 768px) {
            .password, .email, .code, .phone, .submit {
                width: 100%;
                margin: 5px 0;
            }
        }
        
        .phone-verify-btn {   
          width: 100%;
	    padding: 15px;
	    font-size: 16px;
	    margin-top: 10px;
	    background-color: white;
	    color: #81C408;
	    border: 1px solid #81C408;
	    border-radius: 5px;
	    cursor: pointer;
	    box-sizing: border-box;
	}
	
	phone-verify-btn:disabled {
    background-color: #f5f5f5;
    color: #cccccc;
    border: 1px solid #cccccc;
    cursor: not-allowed;
}

.phone-verify-btn:hover {
    background-color: #DEFBA7; 
}

.phone-verify-check-btn {
    width: auto;
    padding: 10px;
    font-size: 14px;
    background-color: white;
    color: #81C408;
    border: 1px solid #81C408;
    border-radius: 5px;
    cursor: pointer;
    box-sizing: border-box;
    margin-left: 0px;
    margin-top:-3px;
}

.phone-verify-check-btn:hover {
    background-color: #DEFBA7; 
}
        
    </style>
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
    <script>
    function closeDialog() {
        $('.dialog-overlay').removeClass('active');
        dialogVisible = false;
    }


    	let profileImage = '';
        $(document).ready(function() {
            $(".submit-button").click(function() { 
                if ($("#profile").val() != "") {
                    $("#mainForm").attr("enctype", "multipart/form-data").submit();
                } else {
                    $("#profile").remove();
                    $("#mainForm").submit();
                }
            });
            
            $('.pencil').on("click", function(){
            	 console.log("click");
                 
                 $('#profile').click();
                 let intervalId = setInterval(function() {
                     var profileValue = $('#profile').val();
                     
                     if (profileValue != profileImage) {
                         console.log('Profile value is set:', profileValue);
                         
                         
                         let formData = new FormData();
                         formData.append("image",$('#profile')[0].files[0]);
                         
                         
                         $.ajax({
                        	 url:'/user/rest/updateProfile',
                        	 type: 'POST',
                        	 data: formData,
                        	 processData: false,  // 기본적으로 처리하지 않도록 설정
                             contentType: false,
                        	 success: function(response){
                        		 console.log('success');
                        		 console.log(response);
                        		 
                        		 $('.profile').attr("src",response);
                        		 profileImage = profileValue;

                        		 clearInterval(intervalId);  // 조건이 만족되면 주기적인 확인 중지
                        	 },
                        	 error:function(jqXHR, textStatus, errorThrown) {
                                 console.error('File upload failed:', textStatus, errorThrown);
                             }
                         });
                         
                         
                        
                     } else {
                         console.log('Profile value is not set');
                     }
                 }, 1000); // 3000 밀리초 = 3초
                 //example();
            });

            // 주소 클릭 시 도로명 주소 창 열기
            $("input[name='address']").click(function() {
                window.open("/user/address.jsp", "pop", "width=570,height=420, scrollbars=yes, resizable=yes"); 
            });

            // 닉네임 중복 체크
            $("input[name='nickName']").on("input", function() {
                var nick = $(this).val();
                if (nick.length >= 10) {
                    $("#nickMessage").text("10글자 미만의 닉네임을 작성해주세요.").css("color", "red");
                    $(".submit").prop("disabled", true);
                } else if (nick) {
                    $.ajax({
                        url: '/user/rest/checkDuplicationNickName',
                        type: 'GET',
                        data: { nickName: nick },
                        success: function(response) {
                            var message = response.message;
                            var status = response.status;
                            if (status === "duplicated") {
                                $("#nickMessage").text("중복된 닉네임입니다.").css("color", "red");
                                $(".submit").prop("disabled", true);
                            } else if (status === "available") {
                                $("#nickMessage").text("사용 가능한 닉네임입니다.").css("color", "green");
                                $(".submit").prop("disabled", false);
                            }
                        },
                        error: function(xhr, status, error) {
                            $("#nickMessage").text("오류가 발생했습니다.").css("color", "red");
                            $(".submit").prop("disabled", true);
                        }
                    });
                } else {
                    $("#nickMessage").text("");
                    $(".submit-button").prop("disabled", false);
                }
            });

            // 사용자 ID 클릭 시 비밀번호 변경 팝업 창 열기
      		/* $(".text-link").click(function(event) {
                event.preventDefault(); // 기본 동작 막기
                window.open($(this).attr("href"), "비밀번호 변경", "width=500,height=420,scrollbars=yes,resizable=yes");
            });  */
            
            $('.text-link').click(function() {
           	 let user = "${sessionScope.user != null ? sessionScope.user : 'null'}";
           	 
           	 if(user != 'null'){
                	$('.dialog-overlay.details').addClass('active');
           	 }
              });

              // 다이얼로그를 닫는 로직
              $('.dialog-overlay.details, .close-dialog').click(function(event) {
                if ($(event.target).is('.dialog-overlay.details') || $(event.target).is('.close-dialog')) {
                  $('.dialog-overlay.details').removeClass('active');
                }
              });
           
            
////////////////////////////////휴대폰 인증 요청 ////////////////////

              function validatePhoneNumber(phoneNumber) {
                  var phoneRegex = /^010/; // 정규 표현식을 사용하여 010으로 시작하는지 확인
                  return phoneRegex.test(phoneNumber);
              }

              $("input[name='phoneNumber']").on("input", function() {
                  var phoneNumber = $(this).val();
                  
                  if (validatePhoneNumber(phoneNumber)) {
                      $("#phoneMessage").text("").removeClass("error-message").addClass("valid-message");
                  } else {
                      $("#phoneMessage").text("010으로 시작하는 휴대폰번호를 입력해주세요.").removeClass("valid-message").addClass("error-message");
                  }
              });

              $(".phone-verify-btn").click(function() {
                  var phoneNumber = $("input[name='phoneNumber']").val();
                 var userId = $("input[name='userId']").val(); // Assuming userName is available as an input field

                  if (phoneNumber && userId) {
                      $.ajax({
                          url: '/message/send-one',
                          type: 'POST',
                          contentType: 'application/json',
                          data: JSON.stringify({ phoneNumber: phoneNumber, userId: userId }),
                          success: function(response) {
                              showSuccessAlert("휴대폰 인증번호가 전송되었습니다.");
                              if ($("#phoneVerificationSection").length === 0) {
                                  $(".phone-section").append(
                                      '<div id="phoneVerificationSection">' +
                                      '<label></label>' +
                                      '<input type="text" id="phoneVerificationCode" name="phoneVerificationCode" placeholder="휴대폰 인증번호를 입력하세요" required>' +
                                      '<button type="button" class="phone-verify-check-btn">인증번호 확인</button>' +
                                      '</div>'
                                  );
                              }
                          },
                          error: function(xhr, status, error) {
                            showErrorAlert("휴대폰 인증번호 전송에 실패했습니다. 다시 시도해주세요.");
                          }
                      });
                  } else {
                      showErrorAlert("이름과 휴대폰 번호를 입력해주세요.");
                  }
              });

              /////////////////////////////////////////phone 인증 확인 ////////////////////
              $(document).on("click", ".phone-verify-check-btn", function() {
                  var phoneNumber = $("input[name='phoneNumber']").val();
                  var validationNumber = $("#phoneVerificationCode").val();
                  if (validationNumber) {
                      $.ajax({
                          url: '/message/check-one',
                          type: 'GET',
                          data: { phoneNumber: phoneNumber, validationNumber: validationNumber },
                          success: function(response) {
                              if (response != -1) {
                                 showSuccessAlert("휴대폰 인증이 완료되었습니다.");
                                  $("#isPhoneVerified").val("true");
                              } else {
                                 showErrorAlert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                              }
                          },
                          error: function(xhr, status, error) {
                              showErrorAlert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                          }
                      });
                  } else {
                      showErrorAlert("인증번호를 입력해주세요.");
                  }
              });
              ///////////////////////////////////////////

          

        // 도로명 주소 콜백 함수
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            $("input[name='address']").val(roadAddrPart1);
            $("input[name='detailAddress']").val(addrDetail);
        }
    });

        
        
    </script>
    
    
    <script>
        $(document).ready(function() {
            $("input[name='currentPassword']").on("input", function() {
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

            $("input[name='userPassword']").on("input", function() {
                var password = $(this).val();

                if (password.length < 7) {
                    $("#passwordLengthMessage").text("비밀번호를 7자 이상 입력해주세요.").css("color", "red").show();
                } else {
                    $("#passwordLengthMessage").text("").hide();
                }
            });

            $("input[name='checkPassword']").on("input", function() {
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

            $(".submit-password").on("click", function(e) {
                e.preventDefault();
                var currentPassword = $("input[name='currentPassword']").val();
                var userPassword = $("input[name='userPassword']").val();
                var checkPassword = $("input[name='checkPassword']").val();
                var userNo = $("#userNo").val();

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
                            showSuccessAlert(response.message);
                            
                            closeDialog();
                            
                        } else {
                            showErrorAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                    	showErrorAlert("오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
        });
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
    <form id="mainForm" action="/user/updateUser" method="post" >
        <div class="profile-header">
            <div class="profile-container">
                <img src="${sessionScope.user.profileImage}" class="profile">
                <a class="pencil">📷 </a>
                <input type="file" id="profile" class="file-input"/>
                <!-- ✏️ -->
            </div>
            <div class="profile-info">
                <p><img src="${user.badgeImage}" class="badgeImage"> 인증 ${user.certificationCount}회, 모임 ${user.meetingCount}회</p>
                <a href="#" class="text-link change-password" >${user.userId}✏️</a> 
                <!--  <button type="button" ><input type="file" id="profile" name="image" value=""></button> -->
            </div>
        </div>

        <div class="detail-section">
            <input type="text" class="update" name="nickName" value="${user.nickName}" required>
            <div id="nickMessage" class="error-message"></div>
            <p>${user.birthDate}</p> <!-- Birth Date는 수정 불가 -->
            
            
           <%--  <div class="phone-container">
                <input type="text" class="phone-link" name="phoneNumber" value="${user.phoneNumber}" readonly>
            </div> --%>
            
            <div class="phone-section">
        <label></label>
        <div class="phone-input">
             <input type="text" class="phone-link" name="phoneNumber" value="${user.phoneNumber}" >
           <div id="phoneMessage" class="error-message"></div>
        </div>
        <button type="button" class="phone-verify-btn">휴대폰 번호 인증하기</button>
        </div>
            
            
            <input type="text" class="update" name="address" value="${user.address}" readonly>
            <input type="text" class="update" name="detailAddress" value="${user.detailAddress}" placeholder="상세 주소">
            <p> 
                <c:choose>
                    <c:when test="${user.gender == 0}">
                        여자
                    </c:when>
                    <c:when test="${user.gender == 1}">
                        남자
                    </c:when>
                </c:choose>
            </p> <!-- Gender는 수정 불가 -->
            <textarea class="update" name="introduceContent" placeholder="자기소개">${user.introduceContent}</textarea>
            
            <div class="line"></div>
            
            <label class="survey-label">설문조사</label>
            
            <select name="hikingPurpose">
                <option value="0" ${user.hikingPurpose == 0 ? 'selected' : ''}>취미</option>
                <option value="1" ${user.hikingPurpose == 1 ? 'selected' : ''}>운동</option>
                <option value="2" ${user.hikingPurpose == 2 ? 'selected' : ''}>친목</option>
            </select>
            <select name="hikingDifficulty">
                <option value="0" ${user.hikingDifficulty == 0 ? 'selected' : ''}>어려움</option>
                <option value="1" ${user.hikingDifficulty == 1 ? 'selected' : ''}>보통</option>
                <option value="2" ${user.hikingDifficulty == 2 ? 'selected' : ''}>쉬움</option>
            </select>
            <select name="hikingLevel">
                <option value="0" ${user.hikingLevel == 0 ? 'selected' : ''}>경험없음</option>
                <option value="1" ${user.hikingLevel == 1 ? 'selected' : ''}>1년에 1~2회 이상</option>
                <option value="2" ${user.hikingLevel == 2 ? 'selected' : ''}>1년에 5회 이상</option>
                <option value="3" ${user.hikingLevel == 3 ? 'selected' : ''}>한 달에 1~2회 이상</option>
                <option value="4" ${user.hikingLevel == 4 ? 'selected' : ''}>한 달에 5회 이상</option>
            </select>
            
            <c:if test="${admin != null}">
                <input type="text" class="read-only" value="${user.creationDate}" readonly>
                <input type="text" class="read-only" value="${user.withdrawDate}" readonly>
                <input type="text" class="read-only" 
                    value="<c:choose>
                            <c:when test='${user.withdrawReason == 0}'>서비스 만족도 낮음</c:when>
                            <c:when test='${user.withdrawReason == 1}'>사용 빈도 감소</c:when>
                            <c:when test='${user.withdrawReason == 2}'>고객 지원 불만</c:when>
                            <c:when test='${user.withdrawReason == 3}'>유사한 다른 서비스 존재</c:when>
                            <c:when test='${user.withdrawReason == 4}'>기타</c:when>
                        </c:choose>" 
                    readonly>
            </c:if>     		
        </div>
        
<%--         <div class="creation-section">
            <a>${user.creationDate}</a>
        </div> --%>
        
        <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
        <input type="hidden" id="userId" name="userId" value="${user.userId}">
        
        <!-- <br> -->
            
        <div class="link-section">
            <button type="button" class="a submit-button">수정 완료하기</button>
        </div>    

	<div class="back-section">
		<a href="/user/getUser">뒤로</a>
	</div>

    </form>
</main>




<div class="dialog-overlay details">
    <div class="dialog-content details">

            <button class="close-button" onclick="closeDialog()">&times;</button>
            <h2 style="text-align:center">비밀번호 변경</h2>
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
      
       <%--  <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
        <input type="hidden" id="userId" name="userId" value="${user.userId}"> --%>
        
        <button type="button" class="submit-password">비밀번호 변경하기</button>
        
    </form>
	</div>
</div>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// --> 

<footer></footer>

</body>
</html>
