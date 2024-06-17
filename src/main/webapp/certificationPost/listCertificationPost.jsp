<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    
<title>Insert title here</title>
</head>
<body>
	<header></header>
	
		<main>
<h1>Certification Post List</h1>
    <c:forEach var="certificationPost" items="${certificationPost}" varStatus="status">
     <p>Post Number: ${status.count}</p> <!-- 게시글 갯수맞는지 확인하기위한 넘버링 -->
   <p>Mountain Name: ${certificationPost.title}</p>
        <p>Mountain Name: ${certificationPost.certificationPostMountainName}</p>
        <p>Hiking Trail: ${certificationPost.certificationPostHikingTrail}</p>
        <p>Total Time: ${certificationPost.certificationPostTotalTime}</p>
        <p>Ascent Time: ${certificationPost.certificationPostAscentTime}</p>
        <p>Descent Time: ${certificationPost.certificationPostDescentTime}</p>
        <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
        <p>Transportation: 
        
        
         <c:choose>
            <c:when test="${certificationPost.certificationPostTransportation == 0}">
                도보
            </c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 1}">
                자전거
            </c:when>
           <c:when test="${certificationPost.certificationPostTransportation == 2}">
                버스
            </c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 3}">
                자동차
            </c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 4}">
                지하철
            </c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 5}">
                기차
            </c:when>
        </c:choose></p>
        
        
        
        <p>Hiking Difficulty:
        <c:choose>
         <c:when test="${certificationPost.certificationPostHikingDifficulty == 0}">
                어려움
            </c:when>
            <c:when test="${certificationPost.certificationPostHikingDifficulty == 1}">
                중간
            </c:when>
            <c:when test="${certificationPost.certificationPostHikingDifficulty == 2}">
                쉬움
            </c:when>
          </c:choose>
        </p>
        <hr/>
    </c:forEach>
    
    
    </main>
    
    
    
    	<footer></footer>
</body>
</html>