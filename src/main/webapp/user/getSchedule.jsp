<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Detail</title>
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
        <h2></h2>
        <form action="/user/updateSchedule" method="post">
            <div class="form-group">
                <label for="title">일정명</label>
                <input type="text" id="title" name="title" value="${schedule.title}" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="mountainName">산 명칭</label>
                <input type="text" id="mountainName" name="mountainName" value="${schedule.mountainName}" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="hikingTotalTime">총 소요시간</label>
                <input type="text" id="hikingTotalTime" name="hikingTotalTime" value="${schedule.hikingTotalTime}" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="hikingAscentTime">상행시간</label>
                <input type="text" id="hikingAscentTime" name="hikingAscentTime" value="${schedule.hikingAscentTime}" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="hikingDescentTime">하행시간</label>
                <input type="text" id="hikingDescentTime" name="hikingDescentTime" value="${schedule.hikingDescentTime}" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="hikingDifficulty">등산 난이도</label>
                <input type="text" id="hikingDifficulty" name="hikingDifficulty" value="<c:choose>
                	<c:when test='${schedule.hikingDifficulty == 0}'>어려움</c:when>
                	<c:when test='${schedule.hikingDifficulty == 1}'>보통</c:when>
                	<c:when test='${schedule.hikingDifficulty == 2}'>쉬움</c:when>
                	</c:choose>" readonly class="readonly">
            </div>
            <div class="form-group">
                <label for="transportation">교통수단</label>
                <input type="text" id="transportation" name="transportation" value="<c:choose>
                <c:when test='${schedule.transportation == 0}'>도보</c:when>
                <c:when test='${schedule.transportation == 1}'>자전거</c:when>
                <c:when test='${schedule.transportation == 2}'>버스</c:when>
                <c:when test='${schedule.transportation == 3}'>자동차</c:when>
                <c:when test='${schedule.transportation == 4}'>지하철</c:when>
                <c:when test='${schedule.transportation == 5}'>기차</c:when>
                </c:choose>" readonly class="readonly">
            </div>
            
             <div class="form-group">
                <label for="contents">내용</label>
                <textarea id="contents" name="contents" rows="10"  value="${schedule.contents}" placeholder="내용을 입력하세요" required>${schedule.contents}</textarea>
            </div>
            
            <input type="hidden" id="userNo" name="userNo" value="${schedule.userNo}">
            <input type="hidden" id="postNo" name="postNo" value="${schedule.postNo}">
            
            <div class="form-group">
                <button type="button" onclick="location.href='/user/updateSchedule?postNo=${schedule.postNo}&userNo=${schedule.userNo}'">수정하기</button>
               <!--  <button type="button" class="cancel-button" onclick="history.back()">뒤로</button> -->
                <a href="/user/getScheduleList" class="list-button">목록으로</a>
            </div>
        </form>
    </div>
</body>
</html>
