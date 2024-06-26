<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

 <style>
 
html, body {
    height: 100%;
    margin: 0;
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
    /* background: white; */
    padding: 30px;
   /*  border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); */
}

h2 {
    margin-bottom: 20px;
}

input[type="email"] {
     width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 15px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
   /*  margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */ */
	background-color: #ffffff; /* 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    /* cursor: pointer; */
}

input[type="email"]:focus,
input[type="password"]:focus {
    border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
    outline: none; /* 기본 포커스 효과 제거 */
    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */
}

input[type="password"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 15px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */
	/* background-color: #00aaff; */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    /* cursor: pointer; */
}

button {
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

button:hover {
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
    color:  #999999; /* 회색*/
}


.sns-icon {
    width: 50px; /* 모든 이미지의 너비를 동일하게 설정 */
    margin: 0 20px; /* 이미지 간 여백 설정 */
    cursor: pointer;
}

.logo-and-text {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .logo-and-text img {
            width: 100px;
            margin-right: 10px;
        }
           
</style>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

	<header>
	
	</header>
	
<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->
	
	<main>
	
   <div class="logo-and-text">
        <img src="/image/logo.png" alt="Logo"> <!-- 로고 이미지 -->
        <h2>SANTA</h2> <!-- 텍스트 "SANTA" 추가 -->
    </div>
    
    <form action="/user/login" method="post">
    
        <div>
           <!--  <label for="userId"></label> -->
            <!-- <input class="userId" name="email" type="email" position="top" placeholder="이메일" required> -->
             <input type="email" id="userId" name="userId" placeholder="이메일" required>
        </div>
        <div>
             <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required>
         </div>
              
              <button type="submit">로그인</button>
              
            <!-- <input type="text" id="userId" name="userId" placeholder="이메일" required> -->
            <!-- <label for="userPassword"></label> -->
            <!-- <input class="password" name="password" type="password" position="bottom" placeholder="비밀번호" required> -->
            <!-- <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required> -->
       
        
        <div class="links">
            <a href="/user/findUserPassword.jsp">비밀번호 재설정</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            &nbsp&nbsp<a href="/user/addUser.jsp">회원가입</a>
        </div>
        <!-- <a href="/user/addUser.jsp">회원가입</a>  
        <a href="/user/findUserPassword.jsp">비밀번호 찾기</a> -->
        
        <div class="sns-login">
            <p>SNS계정으로 간편 로그인/회원가입</p>
        </div>
        <div class="sns-login">
    		<a href="https://kauth.kakao.com/oauth/authorize?client_id=af43c655326aaa2ca97588ce636e1e29&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code">
        		<img src="/image/kakaotalk_sharing_btn_medium.png" alt="Kakao Login" class="sns-icon">
    		</a>
    		<a href="https://nid.naver.com/oauth2.0/authorize">
        		<img src="/image/btnG_아이콘사각.png" alt="Naver Login" class="sns-icon">
    		</a>
		</div>

        
    </form>
    
    </main>
    
<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->
    
    <footer></footer>
    
</body>
</html>
