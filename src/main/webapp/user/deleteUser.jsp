<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<!-- <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"] {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .btn {
        width: 100%;
        padding: 10px;
        background-color: #ff4d4d;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #ff1a1a;
    }
</style> -->
</head>
<body>
    <div class="container">
        <h2>회원 탈퇴</h2>
        <form action="/user/deleteUser" method="post">
            <div class="form-group">
                <label for="withdrawReason">탈퇴 사유</label>
                <input type="text" id="withdrawReason" name="withdrawReason" placeholder="탈퇴 사유를 입력하세요" required>
            </div>
            <button type="submit" class="btn">회원탈퇴하기</button>
        </form>
    </div>
</body>
</html>
