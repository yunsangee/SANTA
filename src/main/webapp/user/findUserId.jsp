<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
    <h2>아이디 찾기</h2>
    <form action="findUserId" method="get">
        <div>
            <label for="userName">이름:</label>
            <input type="text" id="userName" name="userName" placeholder="이름" required>
        </div>
        <div>
            <label for="phoneNumber">휴대폰 번호:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="휴대폰번호" pattern="01[0-9]{8,9}" required>
        </div>
        <div>
            <label for="verifyCode">인증번호:</label>
            <input type="text" id="verifyCode" name="verifyCode" placeholder="인증번호" >
        </div>
        <div>
            <button type="submit">아이디 찾기</button>
        </div>
    </form>
</body>
</html>
