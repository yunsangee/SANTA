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
    <p><strong>등산 난이도</strong> ${schedule.hikingDifficulty}</p>
    <p><strong>교통수단</strong> ${schedule.transportation}</p>
</div>

</body>
</html>
