<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QNA 작성</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 500px;
            max-width: 100%;
        }

        h2 {
            margin-top: 0;
            font-size: 24px;
            color: #333;
            text-align: center;
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .profile-header p {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group select {
            height: 40px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #218838;
        }

        .form-group .cancel-button {
            background-color: #dc3545;
            margin-top: 10px;
        }

        .form-group .cancel-button:hover {
            background-color: #c82333;
        }

    </style>
</head>
<body>
    <div class="container">
        <h2>QNA 작성</h2>
        <div class="profile-header">
            <img src="${user.profileImage}" alt="Profile Image">
            <p>${user.nickName}</p>
        </div>
        <form action="/user/addQnA" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="contents">내용</label>
                <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="qnaPostCategory">카테고리</label>
                <select id="qnaPostCategory" name="qnaPostCategory" required>
                    <option value="" disabled selected>질문 카테고리를 선택하세요</option>
                    <option value="0">계정</option>
                    <option value="1">일정</option>
                    <option value="2">인증</option>
                    <option value="3">모임</option>
                    <option value="4">등산기록</option>
                    <option value="5">산 검색</option>
                </select>
            </div>
            
            <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
  		  <input type="hidden" id="userId" name="userId" value="${user.userId}">
            
            <div class="form-group">
                <button type="submit">작성</button>
                <button type="button" class="cancel-button" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
