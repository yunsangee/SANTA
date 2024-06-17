<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QNA 답변</title>
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
    <h2>QNA 답변 작성</h2>
    <form action="/user/addAdminAnswer" method="post">
  		<p><strong>카테고리 : </strong>
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
        </c:choose></p>
        <p><strong>프로필 사진:</strong> <img src="${qna.profileImage}" alt="Profile Image" class="readonly"></p>
    	<p><strong>닉네임:</strong> ${qna.nickName}</p>
    	<p><strong>제목:</strong> ${qna.title}</p>
    	<p><strong>내용:</strong> ${qna.contents}</p>
        <div class="form-group">
            <label for="adminAnswer">관리자 답변</label>
            <textarea id="adminAnswer" name="adminAnswer" rows="10" placeholder="답변을 입력하세요" required>${qna.answerState != 1 ? qna.adminAnswer : ''}</textarea>
        </div>
        
       <input type="hidden" id="userNo" name="userNo" value="${qna.userNo}">
       <input type="hidden" id="postNo" name="postNo" value="${qna.postNo}">
     
        
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
            <button type="button" onclick="location.href='/user/getQnA?postNo=${qna.postNo}&userNo=${qna.userNo}'">수정하기</button>
        </div> 
        
    </form>
</body>
</html>
