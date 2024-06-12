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

 <h1>Popular Mountains Details</h1>
<%-- <c:set var="count" value="0"/><!--  --> --%>
<c:forEach var="popularMountain" items="${popularMountains}">
    <%-- <c:if test="${count < 5}"><!--  --> --%>
        <div class="popularMountain-details">
            <img src="${popularMountain.mountainImage}" alt="popularMountain Image">
            <h2>${popularMountain.mountainName}</h2>
            <p><strong>Latitude:</strong> ${popularMountain.mountainLatitude}</p>
            <p><strong>Longitude:</strong> ${popularMountain.mountainLongitude}</p>
            <p><strong>Locations:</strong> ${popularMountain.mountainLocation}</p>
            <p><strong>Description:</strong> ${popularMountain.mountainDescription}</p>
            <p><strong>Altitude:</strong> ${popularMountain.mountainAltitude}</p>
            <p><strong>Trails:</strong> ${popularMountain.mountainTrailCount}</p>
            <p><strong>Likes:</strong> ${popularMountain.likeCount}</p>
            <p><strong>Views:</strong> ${popularMountain.mountainViewCount}</p>
            <p><strong>Certified Posts:</strong> ${popularMountain.certifiedPostCount}</p>
            <p><strong>Calendar Registered:</strong> ${popularMountain.calandarRegisteredCount}</p>
            <p><strong>Meeting Posts:</strong> ${popularMountain.meetingPostCount}</p>
            <h3>Trails</h3>
            <ul>
                <c:forEach var="trail" items="${popularMountain.mountainTrail}">
                    <li>${trail}</li>
                </c:forEach>
            </ul>
        </div>
        <%-- <c:set var="count" value="${count + 1}"/> --%>
<%--     </c:if> --%>
</c:forEach>


    <h1>Custom Mountains Details</h1>
    <c:forEach var="customMountain" items="${customMountains}">
        <div class="customMountain-details">
            <img src="${customMountain.mountainImage}" alt="customMountain Image">
            <h2>${customMountain.mountainName}</h2>
            <p><strong>Latitude:</strong> ${customMountain.mountainLatitude}</p>
            <p><strong>Longitude:</strong> ${customMountain.mountainLongitude}</p>
            <p><strong>Locations:</strong> ${customMountain.mountainLocation}</p>
            <p><strong>Description:</strong> ${customMountain.mountainDescription}</p>
            <p><strong>Altitude:</strong> ${customMountain.mountainAltitude} m</p>
            <p><strong>Trails:</strong> ${customMountain.mountainTrailCount}</p>
            <p><strong>Likes:</strong> ${customMountain.likeCount}</p>
            <p><strong>Views:</strong> ${customMountain.mountainViewCount}</p>
            <p><strong>Certified Posts:</strong> ${customMountain.certifiedPostCount}</p>
            <p><strong>Calendar Registered:</strong> ${customMountain.calandarRegisteredCount}</p>
            <p><strong>Meeting Posts:</strong> ${customMountain.meetingPostCount}</p>
            <h3>Trails</h3>
            <ul>
                <c:forEach var="trail" items="${customMountain.mountainTrail}">
                    <li>${trail}</li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>

<h1>Meeting Posts Details</h1>

<%--나중에 리스트 구현 되면 다시 테스트  --%>



<%-- <c:set var="count" value="0"/>
<c:forEach var="meetingPost" items="${meetingPosts}">
    <c:if test="${count < 5}"> --%>
        <div class="meeting-post">
            <h2>Post Information</h2>
            <p>Title: ${meetingPost.title}</p>
            <p>Contents: ${meetingPost.contents}</p>
            <p>Meeting Name: ${meetingPost.meetingName}</p>
            <p>Recruitment Deadline: ${meetingPost.recruitmentDeadline}</p>
            <p>Appointed Departure: ${meetingPost.appointedDeparture}</p>
            <p>Appointed Detail Departure: ${meetingPost.appointedDetailDeparture}</p>
            <p>Appointed Hiking Mountain: ${meetingPost.appointedHikingMountain}</p>
            <p>Appointed Hiking Date: ${meetingPost.appointedHikingDate}</p>
            <p>Participation Age: ${meetingPost.participationAge}</p>
            <p>Maximum Personnel: ${meetingPost.maximumPersonnel}</p>
            <p>Participation Grade: ${meetingPost.participationGrade}</p>
            <p>Participation Gender: ${meetingPost.participationGender}</p>
            <p>Recruitment Status: ${meetingPost.recruitmentStatus}</p>
            <p>Deleted Flag: ${meetingPost.meetingPostDeletedFlag}</p>
            <p>Certified Flag: ${meetingPost.meetingPostCertifiedFlag}</p>
            <p>Like Count: ${meetingPost.meetingPostLikeCount}</p>
            <p>Comment Count: ${meetingPost.meetingPostCommentCount}</p>
            <hr/>
        </div>
  <%--       <c:set var="count" value="${count + 1}"/>
    </c:if>
</c:forEach> --%>

    
    
<h1>Certification Posts Details</h1>
<c:set var="count" value="0"/>
<c:forEach var="certificationPost" items="${certificationPosts}">
    <c:if test="${count < 5}">
        <p>Title: ${certificationPost.title}</p>
        <p>Mountain Name: ${certificationPost.certificationPostMountainName}</p>
        <p>Hiking Trail: ${certificationPost.certificationPostHikingTrail}</p>
        <p>Total Time: ${certificationPost.certificationPostTotalTime}</p>
        <p>Ascent Time: ${certificationPost.certificationPostAscentTime}</p>
        <p>Descent Time: ${certificationPost.certificationPostDescentTime}</p>
        <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
        <p>Transportation: ${certificationPost.certificationPostTransportation}</p>
        <p>Hiking Difficulty: ${certificationPost.certificationPostHikingDifficulty}</p>
        <p>Hashtag Contents: ${certificationPost.certificationPostHashtagContents}</p>
        <hr/>
        <c:set var="count" value="${count + 1}"/>
    </c:if>
</c:forEach>



</body>
</html>