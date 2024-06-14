<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script>
        var socket = io("http://localhost:3000");
        var roomId = "${roomNo}";
        var userNickname = "${sessionScope.userNickname}";
        var userId = "${sessionScope.userId}";

        socket.emit('joinRoom', roomId);

        // 과거 채팅 기록을 로드하여 표시
        socket.on('loadMessages', function(messages) {
            var chatBox = document.getElementById("chatBox");
            messages.forEach(function(message) {
                chatBox.innerHTML += "<div>" + message.userNickname + ": " + message.text + "</div>";
            });
        });

        socket.on('message', function(message) {
            var chatBox = document.getElementById("chatBox");
            chatBox.innerHTML += "<div>" + message.userNickname + ": " + message.text + "</div>";
        });

        function sendMessage() {
            var input = document.getElementById("messageInput");
            var message = {
                userId: userId,
                userNickname: userNickname,
                text: input.value
            };
            socket.emit('chatMessage', { roomId: roomId, message: message });
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