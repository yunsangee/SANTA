<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>QNA 상세정보</title>

    <script>
        function closeDialog() {
            parent.$('.dialog-overlay.details').removeClass('active');
            parent.dialogVisible = false;
        }
    </script>
</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>
    <div class="container">

        <button class="close-button" onclick="closeDialog()">&times;</button>

        <div class="profile-header">
            <img src="${sessionScope.user.profileImage}" alt="Profile Image">
            <p>${qna.nickName}</p>
            
        </div>

			<div class="line"></div>

        <div class="qna-details">
         <%--    <p><strong>카테고리:</strong>
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
            </p> --%>

           <%--  <p><strong>제목:</strong> ${qna.title}</p> --%>
            <p> ${qna.contents}</p>
        </div>

        <div class="qna-answer">
        	<c:choose>
		        <c:when test="${qna.answerState == 0}">
		            <p>관리자의 답변이 등록되지 않았습니다. 조금만 기다려주세요.</p>
        </c:when>
        <c:otherwise>
            <p>${qna.adminAnswer}</p>
        </c:otherwise>
    </c:choose>
        </div>

        <div class="actions">
            <c:if test="${admin != null}">
                <c:choose>
                    <c:when test="${qna.answerState == 0}">
                        <button type="button" class="edit-button"
                            onclick="location.href='/user/addAdminAnswer?postNo=${qna.postNo}&userNo=${qna.userNo}'">답변 작성하기</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="edit-button"
                            onclick="location.href='/user/addAdminAnswer?postNo=${qna.postNo}&userNo=${qna.userNo}'">답변 수정하기</button>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
</body>

</html>
