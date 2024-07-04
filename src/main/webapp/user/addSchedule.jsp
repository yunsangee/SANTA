<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>일정 등록</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
    <style>
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
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5);
        }

        .form-group select {
            height: 40px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group .inline-group {
            display: flex;
            justify-content: space-between;
        }

        .form-group .inline-group input {
            width: 48%; /* 48%로 변경하여 두 개의 필드가 한 줄에 잘 맞도록 함 */
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
    </style>
</head>
<body>
    <div class="container">
        <form action="/user/addSchedule" method="post">
            <div class="form-group">
                <label for="title">일정명</label>
                <input type="text" id="title" name="title" placeholder="일정명을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="mountainName">산 명칭</label>
                <input type="text" id="mountainName" name="mountainName" placeholder="산 명칭" required>
            </div>
            <div class="form-group inline-group">
                <label for="hikingTotalTime">총 소요시간(00:00 형식)</label>
                <input type="text" id="hikingTotalTime" name="hikingTotalTime" placeholder="00:00" value="00:00" pattern="([01][0-9]|2[0-3]):[0-5][0-9]" required title="시간 형식은 HH:MM 입니다.">
            </div>
            <div class="form-group inline-group">
                <label for="hikingAscentTime">상행시간(00:00 형식)</label>
                <input type="text" id="hikingAscentTime" name="hikingAscentTime" placeholder="00:00" value="00:00" pattern="([01][0-9]|2[0-3]):[0-5][0-9]" required title="시간 형식은 HH:MM 입니다.">
            </div>
            <div class="form-group inline-group">
                <label for="hikingDescentTime">하행시간(00:00 형식)</label>
                <input type="text" id="hikingDescentTime" name="hikingDescentTime" placeholder="00:00" value="00:00" pattern="([01][0-9]|2[0-3]):[0-5][0-9]" required title="시간 형식은 HH:MM 입니다.">
            </div>
            <div class="form-group">
                <label for="contents">내용</label>
                <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요"></textarea>
            </div>
            <div class="form-group">
                <button type="submit">일정 등록하기</button>
            </div>
            <c:set var="clickedDate" value="${param.date}" />
            <input type="hidden" name="stringDate" value="${clickedDate}">
        </form>
    </div>
</body>
</html>
