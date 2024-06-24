<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QNA 답변</title>
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

        .qna-details {
            margin-bottom: 15px;
        }

        .qna-details p {
            margin: 10px 0;
            font-size: 16px;
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

        .form-group textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            resize: vertical;
        }

        .actions {
            text-align: center;
            margin-top: 20px;
        }

        .actions button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px 0;
        }

        .actions .save-button {
            background-color: #28a745;
            color: white;
        }

        .actions .save-button:hover {
            background-color: #218838;
        }

        .actions .back-button {
            background-color: #6c757d;
            color: white;
        }

        .actions .back-button:hover {
            background-color: #5a6268;
        }

        .list-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 16px;
        }

        .list-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>QNA 답변 작성</h2>
        <div class="profile-header">
            <img src="${qna.profileImage}" alt="Profile Image">
            <p>${qna.nickName}</p>
        </div>
        <div class="qna-details">
            <p><strong>카테고리:</strong>
                <c:choose>
                    <c:when test="${qna.qnaPostCategory == 0}">
                        계정
                    </c:when>
                    <c:when test="${qna.qnaPostCategory == 1}">
                        일정
                    </c:when>
                    <c:when test="${qna.qnaPostCategory == 2}">
                        인증
                    </c:when>
                    <c:when test="${qna.qnaPostCategory == 3}">
                        모임
                    </c:when>
                    <c:when test="${qna.qnaPostCategory == 4}">
                        등산기록
                    </c:when>
                    <c:when test="${qna.qnaPostCategory == 5}">
                        산 검색
                    </c:when>
                </c:choose>
            </p>
            <p><strong>제목:</strong> ${qna.title}</p>
            <p><strong>내용:</strong> ${qna.contents}</p>
        </div>
        <form action="/user/addAdminAnswer" method="post">
            <div class="form-group">
                <label for="adminAnswer">관리자 답변</label>
                <textarea id="adminAnswer" name="adminAnswer" rows="10" placeholder="답변을 입력하세요" required>${qna.adminAnswer}</textarea>
            </div>
            
            <input type="hidden" id="userNo" name="userNo" value="${qna.userNo}">
            <input type="hidden" id="postNo" name="postNo" value="${qna.postNo}">
            
            <div class="actions">
                <button type="submit" class="save-button">답변 저장하기</button>
                <button type="button" class="back-button" onclick="location.href='/user/getQnA?postNo=${qna.postNo}&userNo=${qna.userNo}'">수정 취소하기</button>
            </div>
        </form>
    </div>
</body>
</html>
