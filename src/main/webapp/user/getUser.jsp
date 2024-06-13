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
    <h2>User Details</h2>
    <p>User ID: ${user.userId}</p>
    <p>User Name: ${user.userName}</p>
<%--     <p>Password: ${user.userPassword}</p>
    <p>Check Password: ${user.checkPassword}</p> --%>
    <p>Nick Name: ${user.nickName}</p>
    <p>Address: ${user.address}</p>
    <p>Detail Address: ${user.detailaddress}</p>
    <p>Birth Date: ${user.birthDate}</p>
    <p>Phone Number: ${user.phoneNumber}</p>
    <p>Gender : 
         <c:choose>
            <c:when test="${user.gender == 0}">
                남자
            </c:when>
            <c:when test="${user.gender == 1}">
                여자
            </c:when></c:choose></p>
    <p>Profile Image: ${user.profileImage}</p>
    <p>Creation Date: ${user.creationDate}</p>
    <p>Badge Image: ${user.badgeImage}</p>

    <p>Certification Count: ${user.certificationCount}</p>
    <p>Meeting Count: ${user.meetingCount}</p>
    <p>Introduce Content: ${user.introduceContent}</p>
    
    <p>Hiking Purpose : 
         <c:choose>
            <c:when test="${user.hikingPurpose == 0}">
                취미
            </c:when>
            <c:when test="${user.hikingPurpose == 1}">
                운동
            </c:when>
			 <c:when test="${user.hikingPurpose == 2}">
                친목
            </c:when>
        </c:choose></p>
        
        <p>Hiking Difficulty : 
         <c:choose>
            <c:when test="${user.hikingDifficulty == 0}">
                어려움
            </c:when>
            <c:when test="${user.hikingDifficulty == 1}">
                보통
            </c:when>
			 <c:when test="${user.hikingDifficulty == 2}">
                쉬움
            </c:when>
        </c:choose></p>
        
         <p>Hiking Level : 
         <c:choose>
            <c:when test="${user.hikingLevel == 0}">
                경험없음
            </c:when>
            <c:when test="${user.hikingLevel == 1}">
                1년에 1~2회 이상
            </c:when>
			 <c:when test="${user.hikingLevel == 2}">
                1년에 5회 이상
            </c:when>
             <c:when test="${user.hikingLevel == 3}">
               한 달에 1~2회 이상
            </c:when>
             <c:when test="${user.hikingLevel == 4}">
                한 달에 5회 이상
            </c:when>
        </c:choose></p>
   
    <c:if test="${admin != null}">
        <p>creationDate: ${user.creationDate}</p>
        <p>withdrawDate: ${user.withdrawDate}</p>  
        <p>withdrawReason : 
         <c:choose>
            <c:when test="${user.withdrawReason == 0}">
                서비스 만족도 낮음
            </c:when>
            <c:when test="${user.withdrawReason == 1}">
                사용 빈도 감소
            </c:when>
			 <c:when test="${user.withdrawReason == 2}">
                고객 지원 불만
            </c:when>
             <c:when test="${user.withdrawReason == 3}">
               유사한 다른 서비스 존재
            </c:when>
             <c:when test="${user.withdrawReason == 4}">
                기타
            </c:when>
        </c:choose></p>
        
   		 </c:if>
   		 
   		 <a href="/user/updateUser.jsp">회원정보 수정하기</a> 
   		  <a href="/user/deleteUser.jsp">탈퇴하기</a>   
   		    <button type="button" onclick="history.back()">뒤로</button>

</body>
</html>