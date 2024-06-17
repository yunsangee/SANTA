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

<c:forEach var="mountain" items="${mountainList}">
	<div class="mountain-details">
	
    	<img src="${mountain.mountainImage}" alt="Mountain Image">
    	<h2>${mountain.mountainName}</h2>
    	<p><strong>Latitude:</strong> ${mountain.mountainLatitude}</p>
    	<p><strong>Longitude:</strong> ${mountain.mountainLongitude}</p>
    	<p><strong>Locations:</strong> ${mountain.mountainLocation}</p>
    	<p><strong>Description:</strong> ${mountain.mountainDescription}</p>
    	<p><strong>Altitude:</strong> ${mountain.mountainAltitude} m</p>
    	<p><strong>Trails:</strong> ${mountain.mountainTrailCount}</p>
    	<p><strong>Likes:</strong> ${mountain.likeCount}</p>
    	<p><strong>Views:</strong> ${mountain.mountainViewCount}</p>
    	<p><strong>Certified Posts:</strong> ${mountain.certifiedPostCount}</p>
    	<p><strong>Calendar Registered:</strong> ${mountain.calandarRegisteredCount}</p>
    	<p><strong>Meeting Posts:</strong> ${mountain.meetingPostCount}</p>
    	<h3>Trails</h3>
    	<ul>
        	<c:forEach var="trail" items="${mountain.mountainTrail}">
            	<li>${trail}</li>
        	</c:forEach>
    	</ul>
	</div>
</c:forEach>

</body>
</html>