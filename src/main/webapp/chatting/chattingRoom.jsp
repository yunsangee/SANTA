<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String roomNo = request.getParameter("roomNo");
    String nickname = request.getParameter("nickname");
    String userNo = request.getParameter("userNo");

    request.setAttribute("roomNo", roomNo);
    request.setAttribute("nickname", nickname);
    request.setAttribute("userNo", userNo);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Room</title>
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script>
        var socket = io("http://172.30.1.86:3000");
        var roomNo = "${roomNo}";
        var userNickname = "${nickname}";
        var userNo = "${userNo}";
        
        console.log("roomNo:", roomNo);
        console.log("userNo:", userNo);
        console.log("userNickname:", userNickname);

        socket.emit('joinRoom', roomNo);

        // 과거 채팅 기록을 로드하여 표시
        socket.on('loadMessages', function(messages) {
            var chatBox = document.getElementById("chatBox");
            messages.forEach(function(message) {
                appendMessage(chatBox, message);
            });
        });

        socket.on('message', function(message) {
            var chatBox = document.getElementById("chatBox");
            appendMessage(chatBox, message);
        });

        socket.on('deleteMessage', function(messageId) {
            var messageElement = document.getElementById(messageId);
            if (messageElement) {
                messageElement.remove();
            }
        });

        function sendMessage() {
            var input = document.getElementById("messageInput");
            var message = {
                userNo: userNo,
                userNickname: userNickname,
                contents: input.value
            };
            
            console.log("Message:", message);
            
            socket.emit('chatMessage', { roomNo: roomNo, message: message });
            input.value = "";
        }

        function deleteMessage(messageId) {
            socket.emit('deleteMessage', { roomNo: roomNo, messageId: messageId });
        }

        function appendMessage(chatBox, message) {
            var messageElement = document.createElement("div");
            messageElement.id = message._id;
            messageElement.innerHTML = message.userNickname + ": " + message.contents;

            if (message.userNo == userNo) {
                var deleteButton = document.createElement("button");
                deleteButton.innerHTML = "Delete";
                deleteButton.onclick = function() {
                    deleteMessage(message._id);
                };
                messageElement.appendChild(deleteButton);
                
                messageElement.style.backgroundColor = 'lightgreen';
            }

            chatBox.appendChild(messageElement);
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
