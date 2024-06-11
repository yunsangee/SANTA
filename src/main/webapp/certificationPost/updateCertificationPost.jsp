<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Certification Post</title>
</head>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
 <h1>Update Certification Post</h1>
 
 <form action="/certificationPost/updateCertificationPost" method="post" enctype="multipart/form-data">
    <table>
        <tr>
             <input type="hidden" id="postNo" name="postNo" value="45"/>
         </tr>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" maxLength="20" value="${certificationPost.title}"></td>
        </tr>
        <tr>
            <td>Contents:</td>
            <td><input type="text" name="contents" maxLength="20" value="${certificationPost.contents}"></td>
        </tr>
        <tr>
            <td>Mountain Name:</td>
            <td><input type="text" name="certificationPostMountainName" maxLength="20" value="${certificationPost.certificationPostMountainName}"></td>
        </tr>
        <tr>
            <td>Hiking Trail:</td>
            <td><input type="text" name="certificationPostHikingTrail" maxLength="20" value="${certificationPost.certificationPostHikingTrail}"></td>
        </tr>
        <tr>
            <td>Total Time:</td>
            <td><input type="text" name="certificationPostTotalTime" maxLength="20" value="${certificationPost.certificationPostTotalTime}"></td>
        </tr>
        <tr>
            <td>Ascent Time:</td>
            <td><input type="text" name="certificationPostAscentTime" maxLength="20" value="${certificationPost.certificationPostAscentTime}"></td>
        </tr>
        <tr>
            <td>Descent Time:</td>
            <td><input type="text" name="certificationPostDescentTime" maxLength="20" value="${certificationPost.certificationPostDescentTime}"></td>
        </tr>
        <tr>
            <td>Hiking Date:</td>
            <td><input type="date" name="certificationPostHikingDate" value="${certificationPost.certificationPostHikingDate}"></td>
        </tr>
        <tr>
            <td>Transportation:</td>
            <td>
                <input type="radio" name="certificationPostTransportation" value="1" <c:if test="${certificationPost.certificationPostTransportation == 1}">checked</c:if>> Car
                <input type="radio" name="certificationPostTransportation" value="2" <c:if test="${certificationPost.certificationPostTransportation == 2}">checked</c:if>> Bus
                <input type="radio" name="certificationPostTransportation" value="3" <c:if test="${certificationPost.certificationPostTransportation == 3}">checked</c:if>> Train
                <input type="radio" name="certificationPostTransportation" value="4" <c:if test="${certificationPost.certificationPostTransportation == 4}">checked</c:if>> Bicycle
                <input type="radio" name="certificationPostTransportation" value="5" <c:if test="${certificationPost.certificationPostTransportation == 5}">checked</c:if>> Walk
            </td>
        </tr>
        <tr>
            <td>Hiking Difficulty:</td>
            <td>
                <input type="radio" name="certificationPostHikingDifficulty" value="1" <c:if test="${certificationPost.certificationPostHikingDifficulty == 1}">checked</c:if>> Easy
                <input type="radio" name="certificationPostHikingDifficulty" value="2" <c:if test="${certificationPost.certificationPostHikingDifficulty == 2}">checked</c:if>> Moderate
                <input type="radio" name="certificationPostHikingDifficulty" value="3" <c:if test="${certificationPost.certificationPostHikingDifficulty == 3}">checked</c:if>> Hard
            </td>
        </tr>
        <tr>
            <td>HASHTAG:</td>
            <td><input type="text" name="certificationPostHashtagContents" maxLength="20" value="${certificationPost.certificationPostHashtagContents}"></td>
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
 
 
</body>
</html>