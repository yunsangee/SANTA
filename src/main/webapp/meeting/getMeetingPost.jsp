<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Meeting Post Details</title>
</head>
<body>
    <h1>Meeting Post Details</h1>

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

    <h2>Meeting Participations</h2>
    <c:forEach var="participation" items="${meetingParticipations}">
        <p>User No: ${participation.userNo}</p>
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

    <h2>Post Images</h2>
    <c:forEach var="image" items="${meetingPostImages}">
        <img src="data:image/jpeg;base64,${image.bytes}" alt="Image" />
        <hr/>
    </c:forEach>
</body>
</html>