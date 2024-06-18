<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QNA 작성</title>
   <!--  <style>
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .readonly {
            background-color: #f0f0f0;
            cursor: not-allowed;
        }
    </style> -->
</head>
<body>
    <h2>QNA 작성</h2>
    <form action="/user/addQnA" method="post">
  
        <p><strong>프로필 사진:</strong> <img src="${user.profileImage}" alt="Profile Image" class="readonly"></p>
    	<p><strong>닉네임:</strong> ${user.nickName}</p>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
        </div>
        <div class="form-group">
    <label for="qnaPostCategory"></label>
    <select id="qnaPostCategory" name="qnaPostCategory" required>
        <option value="" disabled selected>질문 카테고리를 선택하세요</option>
        <option value=0>계정</option>
        <option value=1>일정</option>
        <option value=2>인증</option>
        <option value=3>모임</option>
        <option value=4>등산기록</option>
        <option value=5>산 검색</option>
    </select>
		</div>
       <!--  <div class="form-group">
            <label for="qnaPostCategory">카테고리</label>
            <select id="qnaPostCategory" name="qnaPostCategory" required>
                <option value="">카테고리를 선택하세요</option>
                <option value="0">카테고리 1</option>
                <option value="1">카테고리 2</option>
                <option value="2">카테고리 3</option>
                필요에 따라 추가 카테고리를 추가하세요
            </select>
        </div>-->
        <div class="form-group">
            <button type="submit">작성</button>
            <button type="button" onclick="history.back()">취소</button>
        </div> 
        
    </form>
</body>
</html>
