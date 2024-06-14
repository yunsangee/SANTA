<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script>
        var socket = io("http://localhost:3000");
        var roomNo = "${roomNo}";
        //var userNickname = "${sessionScope.nickname}";
        var userNickname = "${nickname}";
        //var userNo = "${sessionScope.userNo}";
        var userNo = "${userNo}";

        socket.emit('joinRoom', roomNo);

        // 과거 채팅 기록을 로드하여 표시
        socket.on('loadMessages', function(messages) {
            var chatBox = document.getElementById("chatBox");
            messages.forEach(function(message) {
                chatBox.innerHTML += "<div>" + message.userNickname + ": " + message.contents + "</div>";
            });
        });

        socket.on('message', function(message) {
            var chatBox = document.getElementById("chatBox");
            chatBox.innerHTML += "<div>" + message.userNickname + ": " + message.contents + "</div>";
        });

        function sendMessage() {
            var input = document.getElementById("messageInput");
            var message = {
                userNo: userNo,
                userNickname: userNickname,
                contents: input.value
            };
            socket.emit('chatMessage', { roomNo: roomNo, message: message });
            input.value = "";
        }
    </script>
</head>
<body>
    <h1>Chat Room ${roomNo}</h1>
    <div id="chatBox">
        <!-- 실시간 메시지와 과거 채팅 기록이 표시됩니다 -->
    </div>
    <input type="text" id="messageInput">
    <button onclick="sendMessage()">Send</button>
</body>
</html>