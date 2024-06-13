<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="user-details">
    <h2>User Details</h2>
    <p><strong>User ID:</strong> ${user.userId}</p>
    <p><strong>User Name:</strong> ${user.userName}</p>
    <p><strong>Password:</strong> ${user.userPassword}</p>
    <p><strong>Check Password:</strong> ${user.checkPassword}</p>
    <p><strong>Nick Name:</strong> ${user.nickName}</p>
    <p><strong>Address:</strong> ${user.address}</p>
    <p><strong>Detail Address:</strong> ${user.detailaddress}</p>
    <p><strong>Birth Date:</strong> ${user.birthDate}</p>
    <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
    <p><strong>Gender:</strong> ${user.gender}</p>
    <p><strong>Profile Image:</strong> ${user.profileImage}</p>
    <p><strong>Creation Date:</strong> ${user.creationDate}</p>
    <p><strong>Hiking Purpose:</strong> ${user.hikingPurpose}</p>
    <p><strong>Hiking Difficulty:</strong> ${user.hikingDifficulty}</p>
    <p><strong>Hiking Level:</strong> ${user.hikingLevel}</p>
    <p><strong>Badge Image:</strong> ${user.badgeImage}</p>
    <p><strong>Certification Count:</strong> ${user.certificationCount}</p>
    <p><strong>Meeting Count:</strong> ${user.meetingCount}</p>
    <p><strong>Introduce Content:</strong> ${user.introduceContent}</p>
</div>
	

</body>
</html>