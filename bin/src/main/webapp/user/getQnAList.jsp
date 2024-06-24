<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>QNA Post List</h1>
    <c:forEach var="qna" items="${qna}" varStatus="status">
    <p>Post Number: ${status.count}</p> <!-- 게시글 갯수맞는지 확인하기위한 넘버링 -->
    <p>카테고리 :
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
    <p>Mountain Name: ${qna.title}</p>
        <p>NickName: ${qna.nickName}</p>
        <p>postDate: ${qna.postDate}</p>
         
         <c:if test="${user != null and user.role == 1}">
         답변 상태 : ${qna.answerState == 0 ? '답변 대기' : '답변 완료' }
   		 </c:if>
   		 
        <hr/>
    </c:forEach>
</body>
</html>