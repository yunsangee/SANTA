<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<style>
input[type="text"], input[type="password"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */
}
button {
    padding: 10px 20px;
    font-size: 16px;
}
</style>
</head>
<body>
    <h2>로그인</h2>
    <form action="/user/login" method="post">
        <div>
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" placeholder="아이디" required>
        </div>
        <div>
            <label for="userPassword">비밀번호</label>
            <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required>
        </div>
        <div>
            <button type="submit">로그인</button>
        </div>
    </form>
</body>
</html>
