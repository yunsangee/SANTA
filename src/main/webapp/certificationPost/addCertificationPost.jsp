<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <style>
        .image-preview {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .image-preview img {
            max-width: 100px;
            max-height: 100px;
            margin-right: 10px;
        }
        .image-preview p {
            margin: 0 10px 0 0;
        }
        .image-preview button {
            margin-right: 10px;
        }
    </style>
    <script>
        var selectedFiles = [];

        function displaySelectedFiles() {
            var input = document.getElementById('certificationPostImage');
            var files = input.files;

            // 파일을 배열에 추가
            for (var i = 0; i < files.length; i++) {
                selectedFiles.push(files[i]);
            }

            updateFileList();
        }

        function updateFileList() {
            var output = document.getElementById('fileList');
            output.innerHTML = ''; // 기존 내용을 초기화

            for (var i = 0; i < selectedFiles.length; i++) {
                var listItem = document.createElement('div'); // 리스트 아이템 생성
                listItem.classList.add('image-preview');

                // 파일 이름 설정
                var fileName = document.createElement('p');
                fileName.textContent = selectedFiles[i].name;
                listItem.appendChild(fileName);

                // 이미지 미리보기 생성
                var img = document.createElement('img');
                img.src = URL.createObjectURL(selectedFiles[i]);
                listItem.appendChild(img);

                // 제거 버튼 생성
                var removeButton = document.createElement('button');
                removeButton.textContent = '빼기';
                removeButton.setAttribute('data-index', i);
                removeButton.onclick = function () {
                    removeFile(this.getAttribute('data-index'));
                };
                listItem.appendChild(removeButton);

                output.appendChild(listItem); // 리스트에 추가
            }
        }

        function removeFile(index) {
            selectedFiles.splice(index, 1); // 파일 배열에서 제거
            updateFileList(); // 리스트 갱신
        }

        function handleFormSubmit(event) {
            // 모든 선택된 파일을 새로운 FormData 객체에 추가
            var formData = new FormData();

            for (var i = 0; i < selectedFiles.length; i++) {
                formData.append('certificationPostImage', selectedFiles[i]);
            }

            // 기존의 폼 데이터를 추가
            var formElements = document.getElementById('certificationForm').elements;
            for (var i = 0; i < formElements.length; i++) {
                if (formElements[i].name && formElements[i].type !== 'file') {
                    formData.append(formElements[i].name, formElements[i].value);
                }
            }

            // AJAX를 사용하여 폼 데이터를 서버로 전송 (이 부분은 예시입니다)
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/addCertificationPost', true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    console.log('Success:', xhr.responseText);
                } else {
                    console.log('Error:', xhr.statusText);
                }
            };
            xhr.send(formData);

            // 기본 폼 제출을 막음
            event.preventDefault();
        }
    </script>
</head>
<body>

<p>Hello addCertificationPost.jsp</p>
<form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data" onsubmit="handleFormSubmit(event)">
    <table>
        <tr>
            <td>userNo:</td>
            <td><input type="number" id="userNo" name="userNo" required></td>
        </tr>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Contents:</td>
            <td><input type="text" name="contents" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Mountain Name:</td>
            <td><input type="text" name="certificationPostMountainName" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Hiking Trail:</td>
            <td><input type="text" name="certificationPostHikingTrail" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Total Time:</td>
            <td><input type="text" name="certificationPostTotalTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Ascent Time:</td>
            <td><input type="text" name="certificationPostAscentTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Descent Time:</td>
            <td><input type="text" name="certificationPostDescentTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Hiking Date:</td>
            <td><input type="date" name="certificationPostHikingDate" required></td>
        </tr>
        <tr>
            <td>Transportation:</td>
            <td>
                <input type="radio" name="certificationPostTransportation" value="0"> 도보
                <input type="radio" name="certificationPostTransportation" value="1"> 자전거
                <input type="radio" name="certificationPostTransportation" value="2"> 버스
                <input type="radio" name="certificationPostTransportation" value="3"> 자동차
                <input type="radio" name="certificationPostTransportation" value="4"> 지하철
                <input type="radio" name="certificationPostTransportation" value="5"> 기차
            </td>
        </tr>
        <tr>
            <td>Hiking Difficulty:</td>
            <td>
                <input type="radio" name="certificationPostHikingDifficulty" value="0"> 어려움
                <input type="radio" name="certificationPostHikingDifficulty" value="1"> 중간
                <input type="radio" name="certificationPostHikingDifficulty" value="2"> 쉬움
            </td>
        </tr>
        <tr>
            <td>HASHTAG:</td>
            <td><input type="text" name="certificationPostHashtagContents" maxLength="20"></td>
        </tr>
        <tr>
            <td>이미지:</td>
            <td>
                <input type="file" id="certificationPostImage" name="certificationPostImage" multiple onchange="displaySelectedFiles()">
                <div id="fileList"></div> <!-- 선택한 파일 이름을 표시할 리스트 -->
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Submit">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
