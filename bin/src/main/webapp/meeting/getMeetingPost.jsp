<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Meeting Post Details</title>
</head>
<body>
    <h1>Meeting Post Details</h1>

    <h2>Post Information</h2>
    <p>Title: ${meetingPost.title}</p>
    <p>Contents: ${meetingPost.contents}</p>
    <c:forEach var="image" items="${meetingPostImages}">
        <img src="${image}" alt="Image" />
        <hr/>
    </c:forEach>
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
    <p>Like Status: ${meetingPost.meetingPostLikeCount}</p>
    <p>Like Count: ${meetingPost.meetingPostLikeStatus}</p>
    <p>Comment Count: ${meetingPost.meetingPostCommentCount}</p>

    <h2>Meeting Participations</h2>
    <c:forEach var="participation" items="${meetingParticipations}">
    	<p>UserNo: ${participation.userNo}</p>
        <p>Nickname: ${participation.nickname}</p>
        <p>Participation Status: ${participation.participationStatus}</p>
        <p>Participation Role: ${participation.participationRole}</p>
        <p>Withdraw Flag: ${participation.withdrawFlag}</p>
        <hr/>
    </c:forEach>

    <h2>Comments</h2>
    <c:forEach var="comment" items="${meetingPostComments}">
        <p>User No: ${comment.userNo}</p>
        <p>Nickname: ${comment.nickname}</p>
        <p>Contents: ${comment.meetingPostCommentContents}</p>
        <p>Creation Date: ${comment.meetingPostCommentCreationDate}</p>
        <hr/>
    </c:forEach>
    
    <!-- Update Meeting Post Button -->
    <form action="/meeting/updateMeetingPost" method="get">
        <input type="hidden" name="postNo" value="${meetingPost.postNo}"/>
        <button type="submit">Update Meeting Post</button>
    </form>

    <!-- Delete Meeting Post Button -->
    <form action="/meeting/deleteMeetingPost" method="get" style="margin-top: 20px;">
        <input type="hidden" name="postNo" value="${meetingPost.postNo}"/>
        <button type="submit">Delete Meeting Post</button>
    </form>
    
</body>
</html>