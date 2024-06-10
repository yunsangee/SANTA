<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Meeting Post</title>
</head>
<body>
    <h1>Update Meeting Post</h1>
    <form action="updateMeetingPost" method="post" enctype="multipart/form-data">
        <input type="hidden" id="postNo" name="postNo" value="${meetingPost.postNo}"/>

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="${meetingPost.title}"/><br/>

        <label for="contents">Contents:</label>
        <textarea id="contents" name="contents">${meetingPost.contents}</textarea><br/>

        <label for="meetingName">Meeting Name:</label>
        <input type="text" id="meetingName" name="meetingName" value="${meetingPost.meetingName}"/><br/>

        <label for="recruitmentDeadline">Recruitment Deadline:</label>
        <input type="date" id="recruitmentDeadline" name="recruitmentDeadline" value="${meetingPost.recruitmentDeadline}"/><br/>

        <label for="appointedDeparture">Appointed Departure:</label>
        <input type="text" id="appointedDeparture" name="appointedDeparture" value="${meetingPost.appointedDeparture}"/><br/>

        <label for="appointedHikingMountain">Appointed Hiking Mountain:</label>
        <input type="text" id="appointedHikingMountain" name="appointedHikingMountain" value="${meetingPost.appointedHikingMountain}"/><br/>

        <label for="appointedHikingDate">Appointed Hiking Date:</label>
        <input type="date" id="appointedHikingDate" name="appointedHikingDate" value="${meetingPost.appointedHikingDate}"/><br/>

        <label for="participationAge">Participation Age:</label>
        <input type="text" id="participationAge" name="participationAge" value="${meetingPost.participationAge}"/><br/>

        <label for="maximumPersonnel">Maximum Personnel:</label>
        <input type="number" id="maximumPersonnel" name="maximumPersonnel" value="${meetingPost.maximumPersonnel}"/><br/>

        <label for="participationGrade">Participation Grade:</label>
        <input type="number" id="participationGrade" name="participationGrade" value="${meetingPost.participationGrade}"/><br/>

        <label for="participationGender">Participation Gender:</label>
        <input type="number" id="participationGender" name="participationGender" value="${meetingPost.participationGender}"/><br/>

        <label for="meetingPostImage">Post Images:</label>
        <input type="file" id="meetingPostImage" name="meetingPostImage" multiple/><br/>

        <button type="submit">Submit</button>
    </form>
</body>
</html>
