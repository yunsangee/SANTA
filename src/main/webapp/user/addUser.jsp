<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script>
$(function() {
    $("#birthDate").datepicker({
        dateFormat: "yy-mm-dd"
    });
});
</script>
<style>
input[type="text"], input[type="password"], input[type="date"], input[type="email"] {
    width: 300px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    margin-bottom: 10px; /* 입력 필드 간의 간격(margin)을 추가합니다. */
}
button {
    padding: 10px 20px;
    font-size: 16px;
}
</style>
</head>
<body>
    <h2>회원가입</h2>
    <form action="/user/addUser" method="post">
        <div>
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" placeholder="아이디" required>
        </div>
        <div>
            <label for="userName">이름</label>
            <input type="text" id="userName" name="userName" placeholder="이름" required>
        </div>
        <div>
            <label for="userPassword">비밀번호</label>
            <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" required>
        </div>
        <div>
            <label for="checkPassword">비밀번호 확인</label>
            <input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 확인" required>
        </div>
        <div>
            <label for="nickName">닉네임</label>
            <input type="text" id="nickName" name="nickName" placeholder="닉네임" required>
        </div>
        <div>
            <label for="address">주소</label>
            <input type="text" id="address" name="address" placeholder="주소" required>
        </div>
        <div>
            <label for="detailaddress">상세주소</label>
            <input type="text" id="detailaddress" name="detailaddress" placeholder="상세주소" required>
        </div>
        <div>
            <label for="birthDate">생년월일</label>
            <input type="text" id="birthDate" name="birthDate" placeholder="생년월일" required>
        </div>
        <div>
            <label for="phoneNumber">휴대폰 번호</label>
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="휴대폰번호" pattern="01[0-9]{8,9}" required>
        </div>
        <div>
            <label>성별</label>
            <label for="genderMale">남자</label>
            <input type="radio" id="genderMale" name="gender" value="1" required>
            <label for="genderFemale">여자</label>
            <input type="radio" id="genderFemale" name="gender" value="2" required>
        </div>
        <div>
            <label for="profileImage">프로필 이미지</label>
            <input type="file" id="profileImage" name="profileImage" accept="image/*">
        </div>
        <div>
            <label for="hikingPurpose">등산 목적</label>
            <input type="number" id="hikingPurpose" name="hikingPurpose" placeholder="등산 목적" required>
        </div>
        <div>
            <label for="hikingDifficulty">등산 난이도</label>
            <input type="number" id="hikingDifficulty" name="hikingDifficulty" placeholder="등산 난이도" required>
        </div>
        <div>
            <label for="hikingLevel">등산 레벨</label>
            <input type="number" id="hikingLevel" name="hikingLevel" placeholder="등산 레벨" required>
        </div>
        <div>
            <button type="submit">회원가입</button>
        </div>
    </form>
</body>
</html>
