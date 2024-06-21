<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Chatting Room</title>
    <c:import url="../common/header.jsp"/>
    
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    <script type="text/javascript">
    $(function() {
    	
        var socket = io("http://192.168.0.89:4001");
        
        var userNo = "${userNo}";
        var userNickname = "${nickname}";
        var roomNo = "${roomNo}";

        var initialSpaces = "                           ";
        
        console.log("roomNo:", roomNo);
        console.log("userNo:", userNo);
        console.log("userNickname:", userNickname);
        
         // 공백 15개
        $("#messageInput").val(initialSpaces);
         
        $("#messageInput").on('input', function() {
            var currentVal = $(this).val();
            if (!currentVal.startsWith(initialSpaces)) {
                $(this).val(initialSpaces + currentVal.trimStart());
            }
        });


        function sendMessage() {
            var contents = $("#messageInput").val().trimStart(); // 앞 공백 제거
            
            var message = {
                userNo: userNo,
                userNickname: userNickname,
                contents: contents
            };
            
            console.log("Message:", message);
            
            socket.emit('chatMessage', { roomNo: roomNo, message: message });
            $("#messageInput").val(initialSpaces);
        }

        function deleteMessage(messageId) {
            socket.emit('deleteMessage', { roomNo: roomNo, messageId: messageId });
        }

        function appendMessage(chatBox, message) {
            var messageElement = $("<div></div>").attr("id", message._id);
            
            var userNicknameElement = $("<div></div>").text(message.userNickname);
            var messageContentsElement = $("<div></div>").addClass("p-4 rounded message-contents");

            if (message.userNo == userNo) {
            	
            	messageElement.addClass("my");
            	
            	$('#message._id').attr("class", "my");
            	
                if (message.isDeleted) {
                    messageContentsElement.text("삭제된 메시지입니다.");
                } else {
                    messageContentsElement.text(message.contents);
                    
                    var deleteButton = $("<button class='btn'><i class='bi bi-x' style='font-size: 24px; color: red;'></i></button>")
                        .on("click", function() {
                            deleteMessage(message._id);
                        });
                    
                    messageElement.append(deleteButton);
                                          
                }
                messageContentsElement.addClass("bg-warning col-md-5");
                
                messageElement.append(messageContentsElement);
                
            } else {
                if (message.isDeleted) {
                    messageContentsElement.text("삭제된 메시지입니다.");
                } else {
                    messageContentsElement.text(message.contents);
                }
                messageContentsElement.addClass("bg-lightgrey col-md-5");
                
                messageElement.append(userNicknameElement)
                              .append(messageContentsElement);
            }

            $(chatBox).append(messageElement);
        }
        
        // Enter 키 눌러 전송
        $(document).on('keydown', '#messageInput', function(event) {
            if (event.key === "Enter") {
                event.preventDefault();
                sendMessage();
            }
        });

        // 버튼 클릭 이벤트 처리
        $("button:contains('전송')").on('click', function() {
            sendMessage();
        });
        
        $("button:contains('사진')").on('click', function() {
            $('#imageInput').click();
            
            uploadImage();
        });
        
        socket.emit('joinRoom', roomNo);

        // 과거 채팅 기록을 로드하여 표시
        socket.on('loadMessages', function(messages) {
            var chatBox = $("#chatBox");
            $.each(messages, function(index, message) {
                appendMessage(chatBox, message);
            });
        });

        socket.on('message', function(message) {
            var chatBox = $("#chatBox");
            
            console.log(message);
            appendMessage(chatBox, message);
        });

        socket.on('deleteMessage', function(data) {
            var messageElement = $("#" + data.messageId);
            
            if (messageElement.length) {
            	
                var messageContentsElement = messageElement.find("div.message-contents");
                
                if (messageContentsElement.length) {
                	
                    messageContentsElement.text("삭제된 메시지입니다.");
                    messageElement.find("button").remove(); // 삭제 아이콘 제거
                    
                    
                }
                
                
            }
        });
    });
    </script>
    
    <style>
        .bg-lightgrey {
            background-color: #D9D9D9;
        }
        
        .my {
        	display: flex;
        	align-items: center;
        	justify-content: flex-end;
        }
        
        #send {
        	display: flex;
        	align-items: center;
        }       
        
        /*
        .my .bi-x {
        	margin-right:10px;
        }
        */
    </style>
    
    </head>
    <body>
    <header><c:import url="../common/top.jsp"/></header>
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <h1>${roomName} 채팅방</h1>
                
                <div class="p-5 bg-light rounded">
                    <div class="row g-4" id="chatBox">
                        <!-- 채팅 표시되는 부분 -->
                    </div>
                    <div class="row g-4 mt-5 ms-3" id="send">
                    
                        <div class="col-md-10">
                            <div class="position-relative mx-auto">
                                <button type="button" class="btn btn-primary border-0 py-3 px-5 position-absolute rounded-pill text-white" style="top: 0; left: 0;">사진</button>
                                <input class="form-control border w-100 py-3 px-4 rounded-pill" type="text" id="messageInput">
                                <input type="file" id="imageInput" style="display: none;">
                            </div>
                        </div>
                        
                        <div class="col-md-2">
                            <div class="position-relative mx-auto">
                                <button class="btn btn-primary border-0 rounded text-white ms-2 py-3 px-5">전송</button>
                            </div>
                        </div>
                                     
                    </div>
                </div>
                
            </div>
        </div>
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>




