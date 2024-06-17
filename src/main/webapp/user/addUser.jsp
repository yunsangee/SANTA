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
});
</script>

<style>
html, body {
    height: 100%;
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

input[type="text"], input[type="password"], input[type="date"], input[type="email"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
}

input[type="email"]:focus,
input[type="password"]:focus,
input[type="date"]:focus, 
input[type="text"]:focus {
    border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
    outline: none; /* 기본 포커스 효과 제거 */
    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */
}

button {
    width: 300px;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    background-color: white;
    color: #81C408;
    border: 1px solid #81C408;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #DEFBA7; 
}

.container {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
}

label {
    display: block;
    margin-bottom: 5px;
}

.email-section, .password-section, .nickname-section {
    margin-bottom: 20px;
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

</style>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

	<header>
	
	</header>
	
<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

	<main class = "container">

    <h2>회원가입</h2>
    
    <div class="sns-login">
            <!-- <p>SNS계정으로 간편 로그인/회원가입</p> -->
        </div>
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
    
        <div class="email-section">
            <label>이메일</label>
           <div class="email-input">
                <input type="text" name="userId" placeholder="이메일" required>
                <!-- <span>@</span>
                <select name="emailDomain">
                    <option value="gmail.com">gmail.com</option>
                    <option value="naver.com">naver.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="daum.net">daum.net</option>
                </select> -->
            </div>
            <button type="button" style="width: 100%; margin-top: 10px;">이메일 인증하기</button>
        </div>
       
         <div class="password-section">
            <label>비밀번호</label>
            <input type="password" name="password" placeholder="비밀번호" required>
            
            <label>비밀번호 확인</label>
            <input type="password" name="confirmPassword" placeholder="비밀번호 확인" required>
        </div>
        
        <div class="nickname-section">
            <label>닉네임</label>
            <input type="text" name="nickname" placeholder="닉네임 (2~20자)" required>
        </div>
        
        <button type="submit">회원가입</button>
               
    </form>
    
    </main>
    
<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->    
    
    <footer></footer>
    
</body>
</html>
