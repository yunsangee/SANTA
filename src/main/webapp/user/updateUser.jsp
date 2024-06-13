<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Details</title>
<!-- <style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"],
    input[type="number"],
    input[type="date"],
    input[type="password"] {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .readonly {
        background-color: #f9f9f9;
    }
    .btn {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #45a049;
    }
</style> -->
</head>
<body>
    <div class="container">
        <h2>User Details</h2>
        <form action="/user/updateUser" method="post">
       <!-- <div class="form-group">  -->
    <p><strong>User ID:</strong> ${user.userId}</p>
    <p><strong>User Name:</strong> ${user.userName}</p>
   <%--  <p><strong>Password:</strong> ${user.userPassword}</p>
    <p><strong>Check Password:</strong> ${user.checkPassword}</p> --%>
    <%-- <p><strong>Nick Name:</strong> ${user.nickName}</p> --%>
    <%-- <p><strong>Address:</strong> ${user.address}</p>
    <p><strong>Detail Address:</strong> ${user.detailaddress}</p> --%>
    <p><strong>Birth Date:</strong> ${user.birthDate}</p>
    <%-- <p><strong>Phone Number:</strong> ${user.phoneNumber}</p> --%>
    <p><strong>Gender:</strong> ${user.gender}</p>
    <p><strong>Profile Image:</strong> ${user.profileImage}</p>
    <p><strong>Creation Date:</strong> ${user.creationDate}</p>
    <%-- <p><strong>Hiking Purpose:</strong> ${user.hikingPurpose}</p>
    <p><strong>Hiking Difficulty:</strong> ${user.hikingDifficulty}</p>
    <p><strong>Hiking Level:</strong> ${user.hikingLevel}</p> --%>
    <p><strong>Badge Image:</strong> ${user.badgeImage}</p>
    <p><strong>Certification Count:</strong> ${user.certificationCount}</p>
    <p><strong>Meeting Count:</strong> ${user.meetingCount}</p>
    <p><strong>Introduce Content:</strong> ${user.introduceContent}</p>
            
                
            <div class="form-group">
                <label for="nickName">Nick Name</label>
                <input type="text" id="nickName" name="nickName" value="${user.nickName}" >
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="${user.address}">
            </div>
            <%-- <div class="form-group">
                <label for="detailaddress">Detail Address</label>
                <input type="text" id="detailaddress" name="detailaddress" value="${user.detailaddress}" readonly class="readonly">
            </div> --%>
          
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
            </div>
            
            <div class="form-group">
                <label for="profileImage">Profile Image</label>
                <input type="text" id="profileImage" name="profileImage" value="${user.profileImage}" >
            </div>
            
            <div class="form-group">
                <label for="hikingPurpose">Hiking Purpose</label>
                <input type="text" id="hikingPurpose" name="hikingPurpose" value="${user.hikingPurpose}">
            </div>
            <div class="form-group">
                <label for="hikingDifficulty">Hiking Difficulty</label>
                <input type="text" id="hikingDifficulty" name="hikingDifficulty" value="${user.hikingDifficulty}">
            </div>
            <div class="form-group">
                <label for="hikingLevel">Hiking Level</label>
                <input type="text" id="hikingLevel" name="hikingLevel" value="${user.hikingLevel}">
            </div>
            
            <div class="form-group">
                <label for="introduceContent">Introduce Content</label>
                <input type="text" id="introduceContent" name="introduceContent" value="${user.introduceContent}" >
            </div>
            <button type="submit" class="btn">Update</button>
        </form>
    </div>
</body>
</html>
