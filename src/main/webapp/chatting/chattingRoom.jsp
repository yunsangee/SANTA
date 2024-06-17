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
        var socket = io("http://192.168.0.52:3000");
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
            
            console.log(message);
            appendMessage(chatBox, message);
        });

        socket.on('deleteMessage', function(data) {
            var messageElement = document.getElementById(data.messageId);
            
            if (messageElement) {
                messageElement.innerHTML = data.userNickname + ": 삭제된 메시지입니다.";
                messageElement.style.backgroundColor = 'lightgrey';
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
            
            if (message.isDeleted) {
                messageElement.innerHTML = message.userNickname + ": 삭제된 메시지입니다.";
                messageElement.style.backgroundColor = 'lightgrey';
            } else {
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
            }

            chatBox.appendChild(messageElement);
        }
        
        // Enter 키 눌러 전송
        document.addEventListener('DOMContentLoaded', (event) => {
            var input = document.getElementById("messageInput");
            input.addEventListener("keydown", function(event) {
                if (event.key === "Enter") {
                    event.preventDefault();
                    sendMessage();
                }
            });
        });
        
    </script>
</head>
<body>
    <h1>Chat Room ${roomNo}</h1>
    <div id="chatBox">
        <!-- 실시간 메시지와 과거 채팅 기록이 표시됩니다 -->
    </div>
    <input type="text" id="messageInput">
    <button onclick="sendMessage()">Send</button>
    <input type="file" id="imageInput">
    <button onclick="uploadImage()">Upload Image</button>
</body>
</html>
