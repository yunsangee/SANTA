<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Detail</title>
  <!--   <style>
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

<div class="schedule-details">
    <h2>Schedule Detail</h2>
    <p><strong>일정명</strong> ${schedule.title}</p>
    <p><strong>산 명칭</strong> ${schedule.mountainName}</p>
    <p><strong>총 소요시간</strong> ${schedule.hikingTotalTime}</p>
    <p><strong>상행시간</strong> ${schedule.hikingAscentTime}</p>
    <p><strong>하행시간</strong> ${schedule.hikingDescentTime}</p>
    <p><strong>등산 난이도</strong>
    <c:choose>
            <c:when test="${schedule.hikingDifficulty == 0}">
                어려움
            </c:when>
            <c:when test="${schedule.hikingDifficulty == 1}">
                보통
            </c:when>
			 <c:when test="${schedule.hikingDifficulty == 2}">
                쉬움
            </c:when>
    </c:choose></p>
    
    <p><strong>교통수단</strong>
    <c:choose>
            <c:when test="${schedule.transportation == 0}">
                도보
            </c:when>
            <c:when test="${schedule.transportation == 1}">
                자전거
            </c:when>
			 <c:when test="${schedule.transportation == 2}">
                버스
            </c:when>
            <c:when test="${schedule.transportation == 3}">
                자동차
            </c:when>
            <c:when test="${schedule.transportation == 4}">
                지하철
            </c:when>
            <c:when test="${schedule.transportation == 5}">
                기차
            </c:when>
    </c:choose></p>
    	<button type="button" onclick="location.href='/user/updateSchedule?postNo=${schedule.postNo}&userNo=${schedule.userNo}'">수정하기</button>
    	 <!-- <a href="/user/updateSchedule.jsp">일정 수정하기</a> -->
    	 <button type="button" onclick="history.back()">뒤로</button>
    
</div>

</body>
</html>
