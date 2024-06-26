<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>

<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
<meta charset="UTF-8">
<title>회원가입</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<!--  ////////////////////////////////////////////// script  ///////////////////////////////////////////////// -->

<script>
//////////////////////////////// 생년월일 달력 ////////////////////
$(function() {
    $("#birthDate").datepicker({
    	changeMonth: true,
        changeYear: true,
        yearRange: "1945:+0"
    });

//////////////////////////////// 성별 ////////////////////
    $(".gender-button").click(function() {
        $(".gender-button").removeClass("selected");
        $(this).addClass("selected");
        $("#" + $(this).data("target")).prop("checked", true);
    });

//////////////////////////////// 이메일 중복 체크 ////////////////////
    $("input[name='userId']").on("blur", function() {
        var email = $(this).val();
        if (email) {
            $.ajax({
                url: '/user/rest/checkDuplicationId',
                type: 'GET',
                data: { userId: email },
                success: function(response) {
                    var message = response.message;
                    var status = response.status;
                    if (status === "duplicated") {
                        $("#emailMessage").text("중복된 아이디입니다.").css("color", "red");
                        $(".email-verify-btn").prop("disabled", true);
                    } else if (status === "available") {
                        $("#emailMessage").text("사용 가능한 아이디입니다.").css("color", "green");
                        $(".email-verify-btn").prop("disabled", false);
                    }
                },
                error: function(xhr, status, error) {
                    $("#emailMessage").text("오류가 발생했습니다.").css("color", "red");
                    $(".email-verify-btn").prop("disabled", true);
                }
            });
        }
    });
    
//////////////////////////////// 닉네임 중복 체크 ////////////////////
       $("input[name='nickName']").on("blur", function() {
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
                    } else if (status === "available") {
                        $("#nickMessage").text("사용 가능한 닉네임입니다.").css("color", "green");
                    }
                },
                error: function(xhr, status, error) {
                    $("#nickMessage").text("오류가 발생했습니다.").css("color", "red");
                }
            });
                	
        }
    });
    
//////////////////////////////// 이메일 인증 요청 ////////////////////
    $(".email-verify-btn").click(function() {
        var email = $("input[name='userId']").val();
        if (email) {
            $.ajax({
                url: '/user/rest/sendVerification',
                type: 'GET',
                data: { email: email },
                success: function(response) {
                    alert("인증번호가 전송되었습니다. 이메일을 확인해주세요.");
                    if ($("#emailVerificationSection").length === 0) {
                        $(".email-section").append(
                            '<div id="emailVerificationSection">' +
                            '<label></label>' +
                            '<input type="text" id="emailVerificationCode" name="emailVerificationCode" placeholder="인증번호를 입력하세요" required>' +
                            '<button type="button" class="email-verify-check-btn">인증번호 확인</button>' +
                            '</div>'
                        );
                    }
                },
                error: function(xhr, status, error) {
                    alert("이메일 전송에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            alert("이메일을 입력해주세요.");
        }
    });

////////////////////////////////이메일 인증 확인 ////////////////////
    $(document).on("click", ".email-verify-check-btn", function() {
        var email = $("input[name='userId']").val();
        var code = $("#emailVerificationCode").val();
        if (code) {
            $.ajax({
                url: '/user/rest/verify',
                type: 'POST',
                data: { email: email, code: code },
                success: function(response) {
                    alert(response);
                    if (response === "인증되었습니다.") {
                        $("#isEmailVerified").val("true");
                    }
                },
                error: function(xhr, status, error) {
                    alert("인증번호 확인에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            alert("인증번호를 입력해주세요.");
        }
    });

////////////////////////////////휴대폰 인증 요청 ////////////////////
    $(".phone-verify-btn").click(function() {
        var phoneNumber = $("input[name='phoneNumber']").val();
        var userName = $("input[name='userName']").val();
        if (phoneNumber && userName) {
            $.ajax({
                url: '/message/send-one',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ phoneNumber: phoneNumber, userName: userName }),
                success: function(response) {
                    alert("휴대폰 인증번호가 전송되었습니다.");
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
                    alert("휴대폰 인증번호 전송에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            alert("이름과 휴대폰 번호를 입력해주세요.");
        }
    });

////////////////////////////////이메일 인증 확인 ////////////////////
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
        } else {
            alert("인증번호를 입력해주세요.");
        }
    });

//////////////////////////////// 주소 ////////////////////
    $("input[name='address']").click(function() {
        window.open("/user/address.jsp", "pop", "width=570,height=420, scrollbars=yes, resizable=yes"); 
    });
});

function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
    $("input[name='address']").val(roadAddrPart1);
    $("input[name='detailAddress']").val(addrDetail);
}


//////////////////////////////// 비밀번호 길이 및 성별 확인 ////////////////////
 $(function() { 
    // 비밀번호 입력 칸에서 포커스 아웃될 때
    $("input[name='userPassword']").on("blur", function() {
        var password = $(this).val();

        if (password.length < 10) {
            $("#passwordLengthMessage").text("비밀번호를 10자 이상 입력해주세요.").css("color", "red").show();
        } else {
            $("#passwordLengthMessage").text("").hide();
        }
    });

//////////////////////////////// 비밀번호 확인 ////////////////////
    $("input[name='checkPassword']").on("blur", function() {
        var password = $("input[name='userPassword']").val();
        var confirmPassword = $(this).val();

        $.ajax({
            url: '/user/rest/addUserPassword',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                userPassword: password,
                checkPassword: confirmPassword
            }),
            success: function(response) {
                var message = response.message;
                var status = response.status;
                if (status === "equals") {
                    $("#passwordMessage").text("비밀번호가 일치합니다.").css("color", "green").show();
                } else if (status === "notequals") {
                    $("#passwordMessage").text("비밀번호가 일치하지 않습니다. 다시 입력해주세요.").css("color", "red").show();
                }
            },
            error: function(xhr, status, error) {
                $("#passwordMessage").text("오류가 발생했습니다. 다시 시도해주세요.").css("color", "red").show();
            }
        });
    });

////////////////////////////////////////// 모든 값 입력 확인

 // 폼 제출 시 모든 필드 검증
    $("#signupForm").on("submit", function(e) {
        var isValid = true;
        var isEmailVerified = $("#isEmailVerified").val() === "true";
        var isPhoneVerified = $("#isPhoneVerified").val() === "true";
        var password = $("input[name='userPassword']").val();
        var isGenderSelected = $("input[name='gender']:checked").length > 0;

     // 모든 필드가 유효한지 확인
        $("#signupForm").find("input[required], select[required]").each(function() {
            if (!$(this).val()) {
                isValid = false;
                return false;
            }
        });

        if (!isValid) {
            e.preventDefault();
            alert("모든 필드를 올바르게 입력해주세요.");
        } else if (!isEmailVerified) {
            e.preventDefault();
            alert("이메일 인증을 완료해주세요.");
        } else if (!isPhoneVerified) {
            e.preventDefault();
            alert("휴대폰 인증을 완료해주세요.");
        } else if (password.length < 10) {
            e.preventDefault();
            alert("비밀번호는 10자 이상이어야 합니다.");
        } else if (!isGenderSelected) {
            e.preventDefault();
            alert("성별을 선택해주세요.");
        } else {
            alert("산타 가입을 환영합니다.");
        }
    });
 });
</script>

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

<style>
html, body {
    /* height: 100%; */
    width: 100%;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: white; /* 배경색 설정 */
    padding-top: 50px; /* 상단 여백 추가 */
    padding-bottom: 50px; /* 하단 여백 추가 */
}

h2 {
    margin-bottom: 20px;
    font-size: 17px;
}

header {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    padding: 10px;
    background-color: white;
    display: flex;
    align-items: center;
   /*  border-bottom: 1px solid #ccc; */
}

input[type="text"], input[type="password"], input[type="date"], input[type="email"], select {
    width: 100%; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 10px; /* 입력 필드 간 간격 */
    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
}

input[type="email"]:focus,
input[type="password"]:focus,
input[type="date"]:focus, 
input[type="text"]:focus,
select:focus {
    border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
    outline: none; /* 기본 포커스 효과 제거 */
    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */
}

.email-verify-btn, .phone-verify-btn {   
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

.email-verify-btn:disabled, .phone-verify-btn:disabled {
    background-color: #f5f5f5;
    color: #cccccc;
    border: 1px solid #cccccc;
    cursor: not-allowed;
}

.email-verify-btn:hover, .phone-verify-btn:hover {
    background-color: #DEFBA7; 
}

.email-verify-check-btn, .phone-verify-check-btn {
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

.email-verify-check-btn:hover, .phone-verify-check-btn:hover {
    background-color: #DEFBA7; 
}

.signup-btn {
    width: 100%;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    background-color: #81C408;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer; 
}

.signup-btn:hover {
    background-color: #578906; 
}

.container {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    width: 340px; /* 고정된 너비 설정 */
}

label {
    display: block;
    margin-bottom: 5px;
}

.center-text {
    font-size: 13px;
    text-align: center;
}

.center-text a {
    color: black;
}

.center-text a:hover {
    color: #BABABA;
}

.social-text {
    font-size: 10px;
    text-align: center;
    color: #999999;
}

.description {
    font-size: 12px;
    color: #999999;
    margin-bottom: 10px;
}

.email-section, .password-section, .center-text,.detailAddress-section, .nickname-section, .name-section,.birthday-section, .phone-section, .profile-section, .survey-section {
    margin-bottom: 20px;
}

.address-section {
    margin-bottom: 0px;
}

.sns-login {
    margin-top: 10px;
    display: flex;
    font-size: 12px;
    justify-content: center;
    color:  #999999; /* 회색*/
}

.sns-icon {
    width: 40%; /* 모든 이미지의 너비를 동일하게 설정 */
    margin: 0 20px; /* 이미지 간 여백 설정 */
    cursor: pointer;
}

.line {
    border-bottom: 1px solid #ccc;
    margin: 20px 0;
}

.gender-section {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.gender-button {
    width: 50%;
    padding: 10px;
    font-size: 16px;
    text-align: center;
    cursor: pointer;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: white;
    color: #666;
}

.gender-button.selected {
    background-color: #81C408;
    color: white;
}

.gender-button + .gender-button {
    margin-left: 10px;
}

.hidden-radio {
    display: block; /* 숨겨진 라디오 버튼을 표시 */
    height: 0;
    width: 0;
    opacity: 0;
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
        
.header-logo {
    display: flex;
    margin-left: 80px;
    margin-top: 50px;
}

.header-logo img {
    height: 40px;
    margin-right: 3px;
    margin-top: -2px;
}

.header-logo span {
    font-size: 24px;
    font-weight: bold;
    color: black;
    margin-top: 0px; 
}

.header-logo a {
    display: flex;
    align-items: center;
    text-decoration: none;
}
</style>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
	<div class="header-logo">      
		<a href="/common/main.jsp">
          <img src="/image/산타 로고.png" alt="Logo">
        <span>SANTA</span>
        </a>
    </div>
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->
    
<main class="container">

<h2>회원가입</h2>

<div class="sns-login">
</div>
    
<p class="social-text">SNS계정으로 간편하게 회원가입</p>

<div class="sns-login">
    <a href="https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code">
        <img src="/image/kakaotalk_sharing_btn_medium.png" alt="Kakao Login" class="sns-icon">
    </a>
</div>

<div class="line"></div>

<form id="signupForm" action="/user/addUser" method="post">
    <div class="name-section">
        <label>이름</label>
        <input type="text" name="userName" placeholder="이름" required>
    </div>

    <div class="email-section">
        <label>이메일</label>
        <div class="email-input">
            <input type="text" name="userId" placeholder="이메일" required>
            <div id="emailMessage" class="error-message"></div>
        </div>
        <button type="button" class="email-verify-btn">이메일 인증하기</button>
        <input type="hidden" id="isEmailVerified" value="false">
    </div>

    <div class="password-section">
        <label>비밀번호</label> 
        <p class="description">영문, 숫자를 포함한 10자 이상의 비밀번호를 입력해주세요.</p>
        <input type="password" name="userPassword" placeholder="비밀번호 입력" autocomplete="new-password" required>
         <div id="passwordLengthMessage"></div> 
    </div>
    <div class="password-section">
        <label>비밀번호 확인</label>
        <input type="password" name="checkPassword" placeholder="비밀번호 확인" autocomplete="new-password" required>
       <div id="passwordMessage" class="error-message"></div>
    </div>
    
    <div class="nickname-section">
        <label>닉네임</label>
        <input type="text" name="nickName" placeholder="닉네임 (최대 10자)" required>
       	<div id="nickMessage" class="error-message"></div>
    </div>
    
    <div class="birthday-section">
        <label>생년월일</label>
        <input type="text" id="birthDate" name="birthDate" placeholder="생년월일" required>
    </div>
    
    <div class="phone-section">
        <label>휴대폰 번호</label>
        <div class="phone-input">
            <input type="text" name="phoneNumber" placeholder="휴대폰번호" pattern="01[0-9]{8,9}" required>
        </div>
        <button type="button" class="phone-verify-btn">휴대폰 번호 인증하기</button>
        <input type="hidden" id="isPhoneVerified" value="false">
    </div>
    
    <div class="address-section">
        <label>주소</label>
        <input type="text" name="address" placeholder="주소" required>
        <div class="detailAddress-section">
            <input type="text" name="detailAddress" placeholder="상세주소" required>
        </div>
    </div>
    
    <div class="gender-section">
        <label>성별</label>
    </div>
    <div class="gender-section" >
        <div class="gender-button" data-target="genderFemale">여자</div>
        <div class="gender-button" data-target="genderMale">남자</div>
        <input type="radio" id="genderFemale" name="gender" value="0" class="hidden-radio" required>
        <input type="radio" id="genderMale" name="gender" value="1" class="hidden-radio" required>
    </div>
    
    <div class="line"></div>
    
    <div class="survey-section">
        <label>설문조사</label>
        <select name="hikingPurpose" required>
            <option value="" disabled selected>등산 목적을 선택하세요</option>
            <option value="0">취미</option>
            <option value="1">운동</option>
            <option value="2">친목</option>
        </select>
        <select name="hikingDifficulty" required>
            <option value="" disabled selected>선호 난이도를 선택하세요</option>
            <option value="0">어려움</option>
            <option value="1">보통</option>
            <option value="2">쉬움</option>
        </select>
        <select name="hikingLevel" required>
            <option value="" disabled selected>등산 경험도를 선택하세요</option>
            <option value="0">경험없음</option>
            <option value="1">1년에 1~2회 이상</option>
            <option value="2">1년에 5회 이상</option>
            <option value="3">한 달에 1~2회 이상</option>
            <option value="4">한 달에 5회 이상</option>
        </select>
    </div>
    
    <button type="submit" class="signup-btn">회원가입하기</button>
    
    <p class="center-text">
        이미 산타 회원이신가요?
        <a href="/user/login.jsp">로그인</a>
    </p>
</form>

</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer></footer>

</body>
</html>
