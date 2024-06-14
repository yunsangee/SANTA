<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room List</title>
</head>
<body>
    <h1>Chat Room List</h1>
    <ul>
        <c:forEach var="chattingRoom" items="${chattingRooms}">
            <li><a href="/chatting/getChattingRoom?roomNo=${chattingRoom.postNo}">${chattingRoom.meetingName}</a></li>
        </c:forEach>
    </ul>
</body>
</html>