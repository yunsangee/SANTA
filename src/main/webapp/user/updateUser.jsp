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
    <p>Gender : 
         <c:choose>
            <c:when test="${user.gender == 0}">
                남자
            </c:when>
            <c:when test="${user.gender == 1}">
                여자
            </c:when></c:choose></p>
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
            
           <div>
            <label for="profileImage">프로필 이미지</label>
            <input type="text" id="profileImage" name="profileImage" value="${user.profileImage}">
        </div> 
        
       <%--  <div>
            <label for="profileImage">프로필 이미지</label>
            <c:if test="${user.profileImage != null}">
                <img src="${pageContext.request.contextPath}/images/${user.profileImage}" alt="Profile Image" style="width:100px;height:100px;">
                <br>
            </c:if>
            <input type="file" id="profileImage" name="profileImage">
        </div> --%>
            
            <div>
    <label for="hikingPurpose">등산 목적</label>
    <select id="hikingPurpose" name="hikingPurpose" >
        <option value="" disabled selected>등산 목적을 선택하세요</option>
        <option value=0>취미</option>
        <option value=1>운동</option>
        <option value=2>친목</option>
    </select>
</div>
	<div>
         <label for="hikingDifficulty">등산 목적</label>
    <select id="hikingDifficulty" name="hikingDifficulty" >
        <option value="" disabled selected>선호 난이도를 선택하세요</option>
        <option value=0>어려움</option>
        <option value=1>보통</option>
        <option value=2>쉬움</option>
    	</select>
	</div>
	<div>
         <label for="hikingLevel">등산 목적</label>
    <select id="hikingLevel" name="hikingLevel" >
        <option value="" disabled selected>등산 경험도를 선택하세요</option>
        <option value=0>경험없음</option>
        <option value=1>1년에 1~2회 이상</option>
        <option value=2>1년에 5회 이상</option>
        <option value=3>한 달에 1~2회 이상</option>
        <option value=4>한 달에 5회 이상</option>
    	</select>
	</div>
            
     <div class="form-group">
    <label for="introduceContent">Introduce Content</label>
    <textarea id="introduceContent" name="introduceContent" rows="10">${user.introduceContent}</textarea>
	</div>
    
            <button type="submit" class="btn">Update</button>
             <button type="button" onclick="history.back()">취소</button>
        </form>
    </div>
</body>
</html>
