<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 정보</title>
</head>
<body>
    <h2>회원 정보</h2>
    <form action="/user/updateUser" method="post">
        <div>
            <label for="userId">아이디:</label>
            <input type="text" id="userId" name="userId" value="${user.userId}" readonly>
        </div>
        <div>
            <label for="userName">이름:</label>
            <input type="text" id="userName" name="userName" value="${user.userName}" required>
        </div>
        <div>
            <label for="userPassword">비밀번호:</label>
            <input type="password" id="userPassword" name="userPassword" value="${user.userPassword}" required>
        </div>
        <div>
            <label for="checkPassword">비밀번호 확인:</label>
            <input type="password" id="checkPassword" name="checkPassword" value="${user.checkPassword}" required>
        </div>
        <div>
            <label for="nickName">닉네임:</label>
            <input type="text" id="nickName" name="nickName" value="${user.nickName}" required>
        </div>
        <div>
            <label for="address">주소:</label>
            <input type="text" id="address" name="address" value="${user.address}" required>
        </div>
        <div>
            <label for="detailaddress">상세주소:</label>
            <input type="text" id="detailaddress" name="detailaddress" value="${user.detailaddress}" required>
        </div>
        <div>
            <label for="birthDate">생년월일:</label>
            <input type="text" id="birthDate" name="birthDate" value="${user.birthDate}" required>
        </div>
        <div>
            <label for="phoneNumber">휴대폰번호:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" pattern="01[0-9]{8,9}" required>
        </div>
        <div>
            <label for="gender">성별:</label>
            <input type="radio" id="genderMale" name="gender" value="1" <c:if test="${user.gender == 1}">checked</c:if>> 남자
            <input type="radio" id="genderFemale" name="gender" value="2" <c:if test="${user.gender == 2}">checked</c:if>> 여자
        </div>
        <div>
            <label for="profileImage">프로필 이미지:</label>
            <img src="${user.profileImage}" alt="Profile Image">
            <input type="file" id="profileImage" name="profileImage">
        </div>
        <div>
            <label for="creationDate">가입일:</label>
            <input type="text" id="creationDate" name="creationDate" value="${user.creationDate}" readonly>
        </div>
        <div>
            <label for="hikingPurpose">하이킹 목적:</label>
            <input type="text" id="hikingPurpose" name="hikingPurpose" value="${user.hikingPurpose}">
        </div>
        <div>
            <label for="hikingDifficulty">하이킹 난이도:</label>
            <input type="text" id="hikingDifficulty" name="hikingDifficulty" value="${user.hikingDifficulty}">
        </div>
        <div>
            <label for="hikingLevel">하이킹 레벨:</label>
            <input type="text" id="hikingLevel" name="hikingLevel" value="${user.hikingLevel}">
        </div>
        <div>
            <label for="badgeImage">배지 이미지:</label>
            <img src="${user.badgeImage}" alt="Badge Image">
            <input type="file" id="badgeImage" name="badgeImage">
        </div>
        <div>
            <label for="certificationCount">인증 횟수:</label>
            <input type="number" id="certificationCount" name="certificationCount" value="${user.certificationCount}">
        </div>
        <div>
            <label for="meetingCount">모임 횟수:</label>
            <input type="number" id="meetingCount" name="meetingCount" value="${user.meetingCount}">
        </div>
        <div>
            <label for="introduceContent">소개 내용:</label>
            <textarea id="introduceContent" name="introduceContent">${user.introduceContent}</textarea>
        </div>
        <div>
            <button type="submit">회원 정보 수정</button>
        </div>
    </form>
</body>
</html>
