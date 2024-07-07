<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>스케줄 상세</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
    <style>
        .schedule {
            margin-top: 30px;
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

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5);
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .button-group .button, .hard, .soso, .easy {
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

        .button-group .hard.active {
            background-color: #851600;
        }

        .button-group .soso.active {
            background-color: #8F4F00;
        }

        .button-group .easy.active {
            background-color: #003EB3;
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

        .readonly {
            background-color: #e9ecef;
            pointer-events: none;
        }

        .edit-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #007bff;
            border: none;
            background: none;
            margin-right: 15px;
            font-size: 20px;
            margin-top: 35px;
        }

        .edit-button:hover {
            color: #0056b3;
        }

        .check-button {
            display: none;
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #28a745;
            border: none;
            background: none;
            margin-right: 15px;
            font-size: 20px;
            margin-top: 35px;
        }

        .check-button:hover {
            color: #218838;
        }

        .list-button {
            display: block;
            width: 100%;
            text-align: center;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 10px;
        }

        .list-button:hover {
            background-color: #0056b3;
        }

        .delete-button {
            display: block;
            width: 100%;
            text-align: center;
            padding: 10px;
            background-color: #dc3545; /* 빨강색 */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 10px;
        }

        .delete-button:hover {
            background-color: #c82333; /* 진한 빨강색 */
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showSuccessAlert(message) {
            Swal.fire({
                icon: 'success',
                text: message,
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "/user/getScheduleList"; // 조회 화면으로 리디렉션
                }
            });
        }

        function showErrorAlert(message) {
            Swal.fire({
                icon: 'error',
                text: message,
                confirmButtonText: 'Retry'
            });
        }
    </script>
    
    <script>
        function toggleButton(target) {
            const group = target.parentElement;
            const buttons = group.querySelectorAll('.button, .hard, .soso, .easy');
            const input = document.getElementById(target.getAttribute('data-target'));

            buttons.forEach(button => {
                button.classList.remove('active');
            });

            target.classList.add('active');
            input.checked = true;
        }

        function switchToEditMode() {
            document.querySelectorAll('.readonly').forEach(function(element) {
                element.classList.remove('readonly');
                element.removeAttribute('readonly');
                element.style.backgroundColor = '#fff';
            });

            document.getElementById('editIcon').style.display = 'none';
            document.getElementById('checkIcon').style.display = 'inline-block';
        }

        function updateSchedule() {
            var updatedSchedule = {
                postNo: document.getElementById('postNo').value || '',
                userNo: document.getElementById('userNo').value || '',
                title: document.getElementById('title').value || '',
                mountainName: document.getElementById('mountainName').value || '',
                hikingTotalTime: document.getElementById('hikingTotalTime').value || '',
                hikingAscentTime: document.getElementById('hikingAscentTime').value || '',
                hikingDescentTime: document.getElementById('hikingDescentTime').value || '',
                hikingDifficulty: document.querySelector('input[name="hikingDifficulty"]:checked') ? document.querySelector('input[name="hikingDifficulty"]:checked').value : '',
                transportation: document.querySelector('input[name="transportation"]:checked') ? document.querySelector('input[name="transportation"]:checked').value : '',
                contents: document.getElementById('contents').value || ''
            };

            fetch('/user/rest/updateSchedule', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(updatedSchedule)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.error) {
                    //alert('업데이트 실패: ' + data.message);
                } else {
                	showSuccessAlert('일정이 업데이트되었습니다.');

                   // window.location.href = "/user/getScheduleList";  // 조회 화면으로 리디렉션
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                showErrorAlert('업데이트 중 오류가 발생했습니다.');
            });
        }

        function deleteSchedule() {
            var postNo = document.getElementById('postNo').value || '';
            var userNo = document.getElementById('userNo').value || '';

            if (!postNo || !userNo) {
            	showErrorAlert('삭제할 일정을 찾을 수 없습니다.');
                return;
            }


            fetch(`/user/rest/deleteSchedule`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ postNo: postNo, userNo: userNo })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // 응답 본문이 비어 있을 수 있으므로 조건 추가
                return response.text().then(text => text ? JSON.parse(text) : {});
            })
            .then(data => {
                if (data.error) {
                   // alert('삭제 실패: ' + data.message);
                } else {
                	showSuccessAlert('일정이 삭제되었습니다.');
                    //window.location.href = "/user/getScheduleList";  // 조회 화면으로 리디렉션
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                showErrorAlert('삭제 중 오류가 발생했습니다.');
            });
        }


        document.addEventListener('DOMContentLoaded', function() {
            var difficulty = '${schedule.hikingDifficulty}';
            var transportation = '${schedule.transportation}';

            if (difficulty === '0') {
                document.querySelector('.hard[data-target="difficultyHard"]').classList.add('active');
                document.getElementById('difficultyHard').checked = true;
            } else if (difficulty === '1') {
                document.querySelector('.soso[data-target="difficultyNormal"]').classList.add('active');
                document.getElementById('difficultyNormal').checked = true;
            } else if (difficulty === '2') {
                document.querySelector('.easy[data-target="difficultyEasy"]').classList.add('active');
                document.getElementById('difficultyEasy').checked = true;
            }

            var transportButtons = {
                '0': 'transportationWalk',
                '1': 'transportationBike',
                '2': 'transportationBus',
                '3': 'transportationCar',
                '4': 'transportationSubway',
                '5': 'transportationTrain'
            };

            if (transportation in transportButtons) {
                document.querySelector('.button[data-target="' + transportButtons[transportation] + '"]').classList.add('active');
                document.getElementById(transportButtons[transportation]).checked = true;
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <form id="scheduleForm" class="schedule" method="post">
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
                <label for="contents">내용</label>
                <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" readonly class="readonly">${schedule.contents}</textarea>
            </div>
            
            <input type="hidden" id="postNo" name="postNo" value="${schedule.postNo}">
            <input type="hidden" id="userNo" name="userNo" value="${schedule.userNo}">
            
            <button type="button" id="editIcon" class="edit-button" onclick="switchToEditMode()">✏️</button>
            <button type="button" id="checkIcon" class="check-button" onclick="updateSchedule()">✔️</button>
            
            <button type="button" class="delete-button" onclick="deleteSchedule()">삭제하기</button>
        </form>
    </div>
</body>
</html>
