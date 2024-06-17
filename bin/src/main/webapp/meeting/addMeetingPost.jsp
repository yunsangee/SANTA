<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Meeting Post</title>
</head>
<body>
    <h1>Add Meeting Post</h1>
    <form action="/meeting/addMeetingPost" method="post" enctype="multipart/form-data">
    
    	<label for="userNo">userNo:</label>
        <input type="number" id="userNo" name="userNo"/><br/>
    
        <label for="title">Title:</label>
        <input type="text" id="title" name="title"/><br/>

        <label for="contents">Contents:</label>
        <textarea id="contents" name="contents"></textarea><br/>

        <label for="meetingName">Meeting Name:</label>
        <input type="text" id="meetingName" name="meetingName"/><br/>

        <label for="recruitmentDeadline">Recruitment Deadline:</label>
        <input type="date" id="recruitmentDeadline" name="recruitmentDeadline"/><br/>

        <label for="appointedDeparture">Appointed Departure:</label>
        <input type="text" id="appointedDeparture" name="appointedDeparture"/><br/>
        
        <label for="appointedDetailDeparture">Appointed Detail Departure:</label>
        <input type="text" id="appointedDetailDeparture" name="appointedDetailDeparture"/><br/>

        <label for="appointedHikingMountain">Appointed Hiking Mountain:</label>
        <input type="text" id="appointedHikingMountain" name="appointedHikingMountain"/><br/>

        <label for="appointedHikingDate">Appointed Hiking Date:</label>
        <input type="date" id="appointedHikingDate" name="appointedHikingDate"/><br/>

        <label for="participationAge">Participation Age:</label>
        <input type="text" id="participationAge" name="participationAge"/><br/>

        <label for="maximumPersonnel">Maximum Personnel:</label>
        <input type="number" id="maximumPersonnel" name="maximumPersonnel"/><br/>

        <label for="participationGrade">Participation Grade:</label>
        <input type="number" id="participationGrade" name="participationGrade"/><br/>

        <label for="participationGender">Participation Gender:</label>
        <input type="number" id="participationGender" name="participationGender"/><br/>

        <label for="meetingPostImage">Post Images:</label>
        <input type="file" id="meetingPostImage" name="meetingPostImage" multiple/><br/>

        <button type="submit">Submit</button>
    </form>
</body>
</html>
