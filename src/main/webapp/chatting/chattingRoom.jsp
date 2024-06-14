<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script>
        var socket = io("http://localhost:3000");
        var roomId = "${roomId}";

        socket.emit('joinRoom', roomId);

        socket.on('message', function(message) {
            var chatBox = document.getElementById("chatBox");
            chatBox.innerHTML += "<div>" + message.user + ": " + message.text + "</div>";
        });

        function sendMessage() {
            var input = document.getElementById("messageInput");
            var message = {
                user: "User",  // 실제 사용자 정보를 여기에 추가해야 합니다
                text: input.value
            };
            socket.emit('chatMessage', { roomId: roomId, message: message });
            input.value = "";
        }
    </script>
</head>
<body>
    <h1>Chat Room ${roomId}</h1>
    <div id="chatBox"></div>
    <input type="text" id="messageInput">
    <button onclick="sendMessage()">Send</button>
</body>
</html>