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

<div class="mountain-details">
    <img src="https://kr.object.ncloudstorage.com/santabucket/1_2" alt="Mountain Image">
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

<c:forEach var="weather" items="${weatherList}" varStatus="status">
    <div class="weather-forecast">
        <h2>Day ${weather.date}</h2>
        <p><strong>Sky Condition:</strong> ${weather.skyCondition}</p>
        <p><strong>Temperature:</strong> ${weather.temperature}°C</p>
        <p><strong>Min Temperature:</strong> ${weather.minMaxTemperature[0]}°C</p>
        <p><strong>Max Temperature:</strong> ${weather.minMaxTemperature[1]}°C</p>
        <p><strong>Feels Like:</strong> ${weather.minMaxTemperature[2]}°C</p>
        <p><strong>Sunrise Time:</strong> ${weather.sunriseTime}</p>
        <p><strong>Sunset Time:</strong> ${weather.sunsetTime}</p>
        <p><strong>Latitude:</strong> ${weather.latitude}</p>
        <p><strong>Longitude:</strong> ${weather.longitude}</p>
        <c:if test="${not empty weather.precipitation}">
            <p><strong>Precipitation:</strong> ${weather.precipitation}</p>
        </c:if>
        <p><strong>Precipitation Probability:</strong> ${weather.precipitationProbability}%</p>
        <p><strong>Precipitation Type:</strong> ${weather.precipitationType}</p>
        <c:if test="${not empty weather.isHeatWave}">
            <p><strong>Heat Wave:</strong> ${weather.isHeatWave}</p>
        </c:if>
        <c:if test="${not empty weather.isColdWave}">
            <p><strong>Cold Wave:</strong> ${weather.isColdWave}</p>
        </c:if>
    </div>
</c:forEach>

</body>
</html>