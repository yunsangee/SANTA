<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>

<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->
<head>

<meta charset="UTF-8">
<title>회원가입</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<script>
$(function() {
    $("#birthDate").datepicker({
        dateFormat: "yy-mm-dd"
    });

    $(".gender-button").click(function() {
        $(".gender-button").removeClass("selected");
        $(this).addClass("selected");
        $("#" + $(this).data("target")).prop("checked", true);
    });
});
</script>

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

<style>
html, body {
    /* height: 100%; */
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: white; /* 배경색 설정 */
}

h2 {
    margin-bottom: 20px;
    font-size: 17px;
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

.email-verify-btn {   
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

.email-verify-btn:hover {
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
    width: 320px; /* 고정된 너비 설정 */
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
    width: 50px; /* 모든 이미지의 너비를 동일하게 설정 */
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
    display: none;
}

</style>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

    <header>
    
    </header>
    
<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

    <main class="container">

    <h2>회원가입</h2>
    
    <div class="sns-login">
            <!-- <p>SNS계정으로 간편 로그인/회원가입</p> -->
        </div>
        
        <p class="social-text">
            SNS계정으로 간편하게 회원가입</p>
        
        <div class="sns-login">
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=af43c655326aaa2ca97588ce636e1e29&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code">
                <img src="/image/kakaotalk_sharing_btn_medium.png" alt="Kakao Login" class="sns-icon">
            </a>
            <a href="https://nid.naver.com/oauth2.0/authorize">
                <img src="/image/btnG_아이콘사각.png" alt="Naver Login" class="sns-icon">
            </a>
        </div>
        
        <div class="line"></div>
    
    <form action="/user/addUser" method="post">
        
        <div class="profile-section">
            <input type="file" name="profileImage" accept="image/*">
        </div>
        
        <div class="name-section">
            <label>이름</label>
            <input type="text" name="userName" placeholder="이름" required>
        </div>
        
        <div class="email-section">
            <label>이메일</label>
           <div class="email-input">
                <input type="text" name="userId" placeholder="이메일" required>
            </div>
              <button type="button" class="email-verify-btn">이메일 인증하기</button>
        </div>
       
         <div class="password-section">
            <label>비밀번호</label> 
            <p class="description">영문, 숫자를 포함한 10자 이상의 비밀번호를 입력해주세요.</p>
            <input type="password" name="userPassword" placeholder="비밀번호" required>
         </div>
         <div class="password-section">
            <label>비밀번호 확인</label>
            <input type="password" name="checkPassword" placeholder="비밀번호 확인" required>
        </div>
        
        <div class="nickname-section">
            <label>닉네임</label>
            <input type="text" name="nickName" placeholder="닉네임 (최대 10자)" required>
        </div>
        
        <div class="birthday-section">
            <label>생년월일</label>
            <input type="text" id="birthDate" name="birthDate" placeholder="생년월일" required>
        </div>
        
        <div class="phone-section">
            <label>휴대폰 번호</label>
            <input type="text" name="phoneNumber" placeholder="휴대폰번호" pattern="01[0-9]{8,9}" required>
        </div>
        
        <div class="address-section">
            <label>주소</label>
            <input type="text" name="address" placeholder="주소" required>
   
        <div class=" detailAddress-section">
            <input type="text" name="detailAddress" placeholder="상세주소" required>
        </div>
       </div>
             
        <div class="gender-section">
            <label>성별</label>
        </div>
        <div class="gender-section">
            <div class="gender-button" data-target="genderFemale">여자</div>
            <div class="gender-button" data-target="genderMale">남자</div>
            <input type="radio" id="genderFemale" name="gender" value="0" class="hidden-radio">
            <input type="radio" id="genderMale" name="gender" value="1" class="hidden-radio">
        </div>
        
        <div class="line"></div>
        
        <div class="survey-section">
            <label>설문조사</label>
            <select name="hikingPurpose">
                <option value="" disabled selected>등산 목적을 선택하세요</option>
                <option value="0">취미</option>
                <option value="1">운동</option>
                <option value="2">친목</option>
            </select>
            <select name="hikingDifficulty">
                <option value="" disabled selected>선호 난이도를 선택하세요</option>
                <option value="0">어려움</option>
                <option value="1">보통</option>
                <option value="2">쉬움</option>
            </select>
            <select name="hikingLevel">
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
