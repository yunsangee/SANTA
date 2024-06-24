<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Form</title>
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 --></head>
<body>
    <div class="container">
        <h1 class="mt-5">Update Schedule</h1>
        <form action="/user/updateSchedule" method="post">
            
            <div class="form-group">
                <label for="title"></label>
                <input type="text" class="form-control" id="title" name="title" value="${schedule.title}"  required>
            </div>
            <div class="form-group">
                <label for="mountainName"></label>
                <input type="text" class="form-control" id="mountainName" name="mountainName" value="${schedule.mountainName}"  required>
            </div>

            <div class="form-group">
                <label for="hikingTotalTime"></label>
                <input type="text" class="form-control" id="hikingTotalTime" name="hikingTotalTime" value="${schedule.hikingTotalTime}" required>
            </div>
            <div class="form-group">
                <label for="hikingAscentTime"></label>
                <input type="text" class="form-control" id="hikingAscentTime" name="hikingAscentTime" value="${schedule.hikingAscentTime}"  required>
            </div>
            <div class="form-group">
                <label for="hikingDescentTime"></label>
                <input type="text" class="form-control" id="hikingDescentTime" name="hikingDescentTime" value="${schedule.hikingDescentTime}" required>
            </div>
            
            <input type="hidden" id="userNo" name="userNo" value="${schedule.userNo}">
      		 <input type="hidden" id="postNo" name="postNo" value="${schedule.postNo}">
            
            <c:choose>
        <c:when test="${not empty schedule}">
           <%--  <input type="hidden" name="scheduleId" value="${schedule.scheduleId}"> --%>
            <tr>
                <td>등산 난이도</td>
                <br>
                <td>
                    <input type="radio" name="hikingDifficulty" value="0" <c:if test="${schedule.hikingDifficulty == 0}">checked</c:if>> 어려움
                    <input type="radio" name="hikingDifficulty" value="1" <c:if test="${schedule.hikingDifficulty == 1}">checked</c:if>> 보통
                    <input type="radio" name="hikingDifficulty" value="2" <c:if test="${schedule.hikingDifficulty == 2}">checked</c:if>> 쉬움
                </td>
            </tr>
            <br>
            <tr>
                <td>교통수단</td>
                <br>
                <td>
                    <input type="radio" name="transportation" value="0" <c:if test="${schedule.transportation == 0}">checked</c:if>> 도보
                    <input type="radio" name="transportation" value="1" <c:if test="${schedule.transportation == 1}">checked</c:if>> 자전거
                    <input type="radio" name="transportation" value="2" <c:if test="${schedule.transportation == 2}">checked</c:if>> 버스
                    <input type="radio" name="transportation" value="3" <c:if test="${schedule.transportation == 3}">checked</c:if>> 자동차
                    <input type="radio" name="transportation" value="4" <c:if test="${schedule.transportation == 4}">checked</c:if>> 지하철
                    <input type="radio" name="transportation" value="5" <c:if test="${schedule.transportation == 5}">checked</c:if>> 기차
                </td>
            </tr>
            
        </c:when>
    </c:choose>
    
   <button type="submit" class="btn">Update</button>  
</form>
    </div>
</body>
</html>
