<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ����</title>
</head>
<body>
    <h2>ȸ�� ����</h2>
    <form action="/user/updateUser" method="post">
        <div>
            <label for="userId">���̵�:</label>
            <input type="text" id="userId" name="userId" value="${user.userId}" readonly>
        </div>
        <div>
            <label for="userName">�̸�:</label>
            <input type="text" id="userName" name="userName" value="${user.userName}" required>
        </div>
        <div>
            <label for="userPassword">��й�ȣ:</label>
            <input type="password" id="userPassword" name="userPassword" value="${user.userPassword}" required>
        </div>
        <div>
            <label for="checkPassword">��й�ȣ Ȯ��:</label>
            <input type="password" id="checkPassword" name="checkPassword" value="${user.checkPassword}" required>
        </div>
        <div>
            <label for="nickName">�г���:</label>
            <input type="text" id="nickName" name="nickName" value="${user.nickName}" required>
        </div>
        <div>
            <label for="address">�ּ�:</label>
            <input type="text" id="address" name="address" value="${user.address}" required>
        </div>
        <div>
            <label for="detailaddress">���ּ�:</label>
            <input type="text" id="detailaddress" name="detailaddress" value="${user.detailaddress}" required>
        </div>
        <div>
            <label for="birthDate">�������:</label>
            <input type="text" id="birthDate" name="birthDate" value="${user.birthDate}" required>
        </div>
        <div>
            <label for="phoneNumber">�޴�����ȣ:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" pattern="01[0-9]{8,9}" required>
        </div>
        <div>
            <label for="gender">����:</label>
            <input type="radio" id="genderMale" name="gender" value="1" <c:if test="${user.gender == 1}">checked</c:if>> ����
            <input type="radio" id="genderFemale" name="gender" value="2" <c:if test="${user.gender == 2}">checked</c:if>> ����
        </div>
        <div>
            <label for="profileImage">������ �̹���:</label>
            <img src="${user.profileImage}" alt="Profile Image">
            <input type="file" id="profileImage" name="profileImage">
        </div>
        <div>
            <label for="creationDate">������:</label>
            <input type="text" id="creationDate" name="creationDate" value="${user.creationDate}" readonly>
        </div>
        <div>
            <label for="hikingPurpose">����ŷ ����:</label>
            <input type="text" id="hikingPurpose" name="hikingPurpose" value="${user.hikingPurpose}">
        </div>
        <div>
            <label for="hikingDifficulty">����ŷ ���̵�:</label>
            <input type="text" id="hikingDifficulty" name="hikingDifficulty" value="${user.hikingDifficulty}">
        </div>
        <div>
            <label for="hikingLevel">����ŷ ����:</label>
            <input type="text" id="hikingLevel" name="hikingLevel" value="${user.hikingLevel}">
        </div>
        <div>
            <label for="badgeImage">���� �̹���:</label>
            <img src="${user.badgeImage}" alt="Badge Image">
            <input type="file" id="badgeImage" name="badgeImage">
        </div>
        <div>
            <label for="certificationCount">���� Ƚ��:</label>
            <input type="number" id="certificationCount" name="certificationCount" value="${user.certificationCount}">
        </div>
        <div>
            <label for="meetingCount">���� Ƚ��:</label>
            <input type="number" id="meetingCount" name="meetingCount" value="${user.meetingCount}">
        </div>
        <div>
            <label for="introduceContent">�Ұ� ����:</label>
            <textarea id="introduceContent" name="introduceContent">${user.introduceContent}</textarea>
        </div>
        <div>
            <button type="submit">ȸ�� ���� ����</button>
        </div>
    </form>
</body>
</html>
