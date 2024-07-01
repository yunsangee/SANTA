<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>

<html>
<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->
<head>

<meta charset="UTF-8">
<title>로그인</title>
<c:import url="../common/header.jsp"/>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>


<style>
html, body {
    height: 95%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f7f7f7; /* 배경색 설정 */
}

main {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    text-align: center;
}

form {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 30px;
}

h2 {
    margin-bottom: 20px;
}

input[type="email"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 15px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    margin-top: -10px;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */
}

input[type="password"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 15px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    margin-top: -10px;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */
}

input[type="email"]:focus,
input[type="password"]:focus {
    border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
    outline: none; /* 기본 포커스 효과 제거 */
    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */
}

.button {
    width: 340px;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    background-color: #81C408;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer; 
}

.button:hover {
    background-color: #578906; 
} 

.links {
    margin-top: 15px;
    margin-bottom: 10px; /* 아래쪽 마진 추가 */
    display: flex;
    font-size: 13px;
    justify-content: center; /* 가운데 정렬 */
    width: 100%;
}

.links a {
    color: black;
    text-decoration: none;
}

.sns-login {
    margin-top: 10px;
    display: flex;
    font-size: 12px;
    justify-content: center;
    color: #999999; /* 회색*/
}

.sns-icon {
    width: 100%; /* 모든 이미지의 너비를 동일하게 설정 */
    margin: 0 20px; /* 이미지 간 여백 설정 */
    cursor: pointer;
}

.logo-and-text {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.logo-and-text img {
    width: 100px;
    margin-right: 10px;
}

.logo-and-text h2 {
	margin-left: -20px;
}

.error-message {
    color: red;
    font-size: 12px;
    margin-top: -1px;
    margin-left: 70px;
    margin-bottom: 10px;
    text-align: left;
    width: 400px;
    align-items: center;
    justify-content: center;
}

</style>

<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->

<script>
    $(document).ready(function() {
        // 탈퇴한 회원 경고 메시지 표시
        <c:if test="${not empty withdrawError}">
            alert("${withdrawError}");
        </c:if>
        
        $('#userPassword').keypress(function(event){
        	
        	if(event.which ==13){
        		event.preventDefault();
  /*       		alert('enter'); */
        		$('form').submit();
        	}
        });
    });
    
    
    

    function logoutAndRedirect() {
        $.ajax({
            url: '/oauth/logout/kakao',
            type: 'GET',
            success: function() {
                  window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code";  
           		/*  window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=https://www.dearmysanta.site/oauth/kakao&response_type=code";   */
            },
            error: function(xhr, status, error) {
                console.error("Logout failed:", error);
               /*  window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=https://www.dearmysanta.site/oauth/kakao&response_type=code";  */
                window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code";  
            }
        });
    }
</script>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main>

<div class="logo-and-text">
    <img src="/image/산타 로고.png" alt="Logo"> <!-- 로고 이미지 -->
    <h2>SANTA</h2> <!-- 텍스트 "SANTA" 추가 -->
</div>

<form action="/user/login" method="post">
    <div>
        <input type="email" id="userId" name="userId" placeholder="이메일" required>
        <c:if test="${not empty loginError}">
        	<%-- <div class = "error-message">${loginError}</div> --%>
        </c:if>
    </div>
    <div>
        <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required>
        <c:if test="${not empty loginError}">
            <div class="error-message">${loginError}</div>
        </c:if>
    </div>
    
    <div>
    <button type="submit" class="button">로그인</button>
    </div>
    
    <div class="links">
    	<a href="/user/findUserId.jsp">아이디 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp
        <a href="/user/findUserPassword.jsp">비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp
        &nbsp&nbsp<a href="/user/addUser.jsp">회원가입</a>
    </div>
    <div class="sns-login">
        <p>SNS계정으로 간편 로그인/회원가입</p>
    </div>
    <div class="sns-login">
        <img src="/image/kakao_login_medium_wide.png" alt="Kakao Login" class="sns-icon" onclick="logoutAndRedirect()">
    </div>
</form>

</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer></footer>

</body>
</html>
