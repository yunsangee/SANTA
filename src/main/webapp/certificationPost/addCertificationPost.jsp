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

<p>Hello addCertificationPost.jsp</p>
<form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data" onsubmit="handleFormSubmit(event)">
    <table>      
 <c:if test="${not empty unCertifiedMeetingPosts}">
        <table>
            <c:forEach var="post" items="${unCertifiedMeetingPosts}">
                <tr>
                    <td>
                        <input type="radio" name="selectedPost" value="${post.meetingName}" required>
                        meetingPost meetingName: ${post.meetingName}
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
        <tr>
            <td>userNo:</td>
            <td><input type="text" name="userNo" maxLength="20" required></td>
        </tr>
        
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Contents:</td>
            <td><input type="text" name="contents" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Mountain Name:</td>
            <td><input type="text" name="certificationPostMountainName" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Hiking Trail:</td>
            <td><input type="text" name="certificationPostHikingTrail" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Total Time:</td>
            <td><input type="text" name="certificationPostTotalTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Ascent Time:</td>
            <td><input type="text" name="certificationPostAscentTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Descent Time:</td>
            <td><input type="text" name="certificationPostDescentTime" maxLength="20" required></td>
        </tr>
        <tr>
            <td>Hiking Date:</td>
            <td><input type="date" name="certificationPostHikingDate" required></td>
        </tr>
        <tr>
            <td>Transportation:</td>
            <td>
                <input type="radio" name="certificationPostTransportation" value="0"> 도보
                <input type="radio" name="certificationPostTransportation" value="1"> 자전거
                <input type="radio" name="certificationPostTransportation" value="2"> 버스
                <input type="radio" name="certificationPostTransportation" value="3"> 자동차
                <input type="radio" name="certificationPostTransportation" value="4"> 지하철
                <input type="radio" name="certificationPostTransportation" value="5"> 기차
            </td>
        </tr>
        <tr>
            <td>Hiking Difficulty:</td>
            <td>
                <input type="radio" name="certificationPostHikingDifficulty" value="0"> 어려움
                <input type="radio" name="certificationPostHikingDifficulty" value="1"> 중간
                <input type="radio" name="certificationPostHikingDifficulty" value="2"> 쉬움
            </td>
        </tr>
        <tr>
            <td>HASHTAG:</td>
            <td><input type="text" name="certificationPostHashtagContents" maxLength="20"></td>
        </tr>
        
        <tr>
            <td colspan="2">
                <input type="submit" value="Submit">
            </td>
        </tr>
    </table>
</form>


</body>
</html>
