<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QNA Details</title>
<!--     <style>
        .qna-details {
            margin-bottom: 15px;
        }
        .qna-details label {
            display: block;
            margin-bottom: 5px;
        }
        .qna-details input, .qna-details select, .qna-details textarea {
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

<div class="qna-details">
    <h2>QNA Details</h2>
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
    <p><strong>관리자 답변:</strong> ${qna.adminAnswer}</p>
</div>
	<c:if test="${user.role == 1}">
    <c:choose>
        <c:when test="${qna.answerState == 0}">
            <button type="button" onclick="location.href='/user/addAdminAnswer?postNo=${qna.postNo}&userNo=${qna.userNo}'">답변 작성하기</button>
        </c:when>
        <c:otherwise>
            <button type="button" onclick="location.href='/user/addAdminAnswer?postNo=${qna.postNo}&userNo=${qna.userNo}'">수정하기</button>
        </c:otherwise>
    </c:choose>
</c:if>
	<button type="button" onclick="history.back()">뒤로</button>

</body>
</html>
