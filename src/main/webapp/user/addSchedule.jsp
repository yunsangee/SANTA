<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Form</title>
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

        .form-group .inline-group {
            display: flex;
            justify-content: space-between;
        }

        .form-group .inline-group input {
            width: 30%;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .button-group .button {
            flex: 1;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            margin-right: 5px;
        }

        .button-group .button:last-child {
            margin-right: 0;
        }

        .button-group .button.active {
            background-color: #218838;
        }

        .hidden-radio {
            display: none;
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

    </style>
    <script>
        function toggleButton(target) {
            const group = target.parentElement;
            const buttons = group.querySelectorAll('.button');
            const input = document.getElementById(target.getAttribute('data-target'));

            if (target.classList.contains('active')) {
                target.classList.remove('active');
                input.checked = false;
            } else {
                buttons.forEach(button => {
                    button.classList.remove('active');
                    document.getElementById(button.getAttribute('data-target')).checked = false;
                });
                target.classList.add('active');
                input.checked = true;
            }
        }
    </script>
    
    <script>
        // 일정 등록 버튼 클릭 시 팝업 창 닫기
        function submitForm(event) {
            event.preventDefault(); // 기본 제출 동작 방지
            // 여기서 폼 제출 작업을 수행하고 나서 창을 닫습니다.
            // AJAX 요청을 사용하여 폼 데이터를 서버로 보낼 수도 있습니다.
            window.close();
        }

        // 취소 버튼 클릭 시 팝업 창 닫기
        function cancelForm() {
            window.close();
        }
    </script>
</head>
<body>
    <div class="container" style="margin-top:150px;">
        <h2></h2>
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
            	<label for="hikingTotalTime">총 소요시간</label>
                <input type="text" id="hikingTotalTime" name="hikingTotalTime" placeholder="총 소요시간" >
            </div>
            <div class="form-group inline-group">
            	<label for="hikingTotalTime">상행시간</label>
                <input type="text" id="hikingAscentTime" name="hikingAscentTime" placeholder="상행시간" >

            </div>
            <div class="form-group inline-group">
            	<label for="mountainName">하행시간</label>
                <input type="text" id="hikingDescentTime" name="hikingDescentTime" placeholder="하행시간" >
            </div>
            <div class="form-group">
                <label>등산 난이도</label>
                <div class="button-group">
                    <div class="button" data-target="difficultyHard" onclick="toggleButton(this)">어려움</div>
                    <div class="button" data-target="difficultyNormal" onclick="toggleButton(this)">보통</div>
                    <div class="button" data-target="difficultyEasy" onclick="toggleButton(this)">쉬움</div>
                </div>
                <input type="radio" id="difficultyHard" name="hikingDifficulty" value="0" class="hidden-radio" >
                <input type="radio" id="difficultyNormal" name="hikingDifficulty" value="1" class="hidden-radio" >
                <input type="radio" id="difficultyEasy" name="hikingDifficulty" value="2" class="hidden-radio" >
            </div>
            <div class="form-group">
                <label>교통수단</label>
                <div class="button-group">
                    <div class="button" data-target="transportationWalk" onclick="toggleButton(this)">도보</div>
                    <div class="button" data-target="transportationBike" onclick="toggleButton(this)">자전거</div>
                    <div class="button" data-target="transportationBus" onclick="toggleButton(this)">버스</div>
                    <div class="button" data-target="transportationCar" onclick="toggleButton(this)">자동차</div>
                    <div class="button" data-target="transportationSubway" onclick="toggleButton(this)">지하철</div>
                    <div class="button" data-target="transportationTrain" onclick="toggleButton(this)">기차</div>
                </div>
                <input type="radio" id="transportationWalk" name="Transportation" value="0" class="hidden-radio" >
                <input type="radio" id="transportationBike" name="Transportation" value="1" class="hidden-radio" >
                <input type="radio" id="transportationBus" name="Transportation" value="2" class="hidden-radio" >
                <input type="radio" id="transportationCar" name="Transportation" value="3" class="hidden-radio" >
                <input type="radio" id="transportationSubway" name="Transportation" value="4" class="hidden-radio" >
                <input type="radio" id="transportationTrain" name="Transportation" value="5" class="hidden-radio" >
            </div>
            <div class="form-group">
                <label for="contents">내용</label>
                <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" ></textarea>
            </div>
            <div class="form-group">
                <button type="submit">일정 등록하기</button>
                <button type="button" class="cancel-button" onclick=cancelForm()>취소</button>
            </div>
            <c:set var="clickedDate" value="${param.date}" />
            <input type="hidden" name="stringDate" value="${clickedDate}">
        </form>
    </div>
</body>
</html>
