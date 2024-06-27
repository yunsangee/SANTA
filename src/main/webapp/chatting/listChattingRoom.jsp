<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chatting Room List</title>
    <c:import url="../common/header.jsp"/>
    
    <script src="https://cdn.socket.io/4.0.0/socket.io.min.js"></script>
    
    <script type="text/javascript">
		
		$(function () {
			
			const socket = io("https://www.dearmysanta.site", {
			    path: '/chattingserver'
			});
			
			socket.on('lastMessage', function(data) {
                var roomElement = $('#chattingRoom-' +data.roomNo);
                if (roomElement.length) {
                    if (data.lastMessage) {
                        roomElement.find('.last-message').text(data.lastMessage.contents);
                    } else {
                        roomElement.find('.last-message').text("No messages yet.");
                    }
                }
            });

            // 모든 채팅방에 대해 마지막 메시지를 요청
			<c:forEach var="chattingRoom" items="${chattingRooms}">
	            socket.emit('getLastMessage', ${chattingRoom.postNo}); // 각 채팅방의 마지막 메시지를 요청
	        </c:forEach>
	            
	        /*
	        $("td.col-md-3").on('click', function() {
                var roomNo = $(this).parent().find("input[id='roomNo']").val(); // roomNo 추출
                self.location = "/chatting/getChattingRoom?roomNo=" + roomNo;
            });
	        */
			
		});
	</script>

	<style>
    	.page-header {
        	margin-top:30px !important;
        }
        
        .table>:not(caption)>*>* {
            padding: .9rem .5rem;
        }
        
        .table {
        	/*border-color: #000000;*/
        }
        
        .table td {
            /*background-color: #B2E457;*/
        }
    </style>

</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
    <main>
    	
    	<div class="container-fluid page-header py-5">
    		<h1 class="text-center text-white display-6">Chatting Room List</h1>
    	</div>
    	
    	<div class="container-fluid py-5">
    		<div class="container py-5">
	    		<div class="table-responsive">
	    			<table class="table">
	    				<thead>

	    				</thead>
	    					<tr>
	    						<td></td>
	    						<td></td>
	    					</tr>
	    				<c:forEach var="chattingRoom" items="${chattingRooms}">
                            <tr id="chattingRoom-${chattingRoom.postNo}">		<!-- 아래 userNo, nickname 지워야함. 로컬에서만 지금처럼 쓰는거임 -->
                                <td class="col-md-3"><a href="/chatting/getChattingRoom?roomNo=${chattingRoom.postNo}&roomName=${chattingRoom.meetingName}">${chattingRoom.meetingName}</a></td>
                                <!-- <input type="hidden" id="roomNo" value="${chattingRoom.postNo }"/> -->
                                <td class="col-md-9 last-message">Loading...</td>
                            </tr>
                        </c:forEach>
	    			</table>
	    		</div>
    		</div>
    	</div>
    	
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
