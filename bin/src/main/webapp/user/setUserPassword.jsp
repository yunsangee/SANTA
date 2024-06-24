<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<!-- <style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="password"] {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .btn {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #45a049;
    }
</style> -->
</head>
<body>
    <div class="container">
        <h2>비밀번호 재설정</h2>
        <form action="/user/setUserPassword" method="post">
            <div class="form-group">
                <label for="passwordNew">새 비밀번호</label>
                <input type="password" id="passwordNew" name="passwordNew" placeholder="새 비밀번호" required>
            </div>
            <div class="form-group">
                <label for="checkPassword">비밀번호 확인</label>
                <input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 확인" required>
            </div>
           
            <input type="hidden" id="userPassword" name="userPassword" value="${userPassword}">
            <input type="hidden" id="userId" name="userId" value="${userId}">
        
            <button type="submit" class="btn">비밀번호 재설정</button>
        </form>
    </div>
</body>
</html>
