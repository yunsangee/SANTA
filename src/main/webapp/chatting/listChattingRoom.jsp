<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chatting Room List</title>
    <c:import url="../common/header.jsp"/>
    
    <script src="https://cdn.socket.io/4.7.5/socket.io.min.js"></script>
    
    <script type="text/javascript">
		
		$(function () {
			
			const socket = io("https://www.dearmysanta.site", {
			    path: '/chattingserver',
			    transports: ['websocket']
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
        
        .table>:not(caption)>*>* {
            padding: .9rem .5rem;
        }
        
        .table {
        	/*border-color: #000000;*/
        }
        
        .table td {
            /*background-color: #B2E457;*/
        }
        
        .row {
        	width: 70%;
        	margin: 0 auto;
        }
    </style>

</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
    <main>
    	
    	<div class="container-fluid py-5">
    		<div class="container py-5">
    			<div class="row g-4 mb-2">
		    		<div class="table-responsive">
		    			<table class="table">
		    				<thead>
		    					<tr>
		    						<th scope="col">순번</th>
		    						<th scope="col">모임 명</th>
		    						<th scope="col">마지막 메시지</th>
		    						
		    						
		    						
		    					</tr>
		    				</thead>
		    				<tbody>

		    				<c:forEach var="chattingRoom" items="${chattingRooms}" varStatus="status">
	                            <tr id="chattingRoom-${chattingRoom.postNo}">		<!-- 아래 userNo, nickname 지워야함. 로컬에서만 지금처럼 쓰는거임 -->
	                            	<td>
				                    	<p class="mb-2 mt-2">${status.index+1}</p>
				                    </td>
	                                <td>
	                                	<p class="mb-2 mt-2">
	                                		<a href="/chatting/getChattingRoom?roomNo=${chattingRoom.postNo}&roomName=${chattingRoom.meetingName}">${chattingRoom.meetingName}</a>
	                                	</p>
	                                </td>
	                                <!-- <input type="hidden" id="roomNo" value="${chattingRoom.postNo }"/> -->
	                                <td class="mb-2 mt-2 last-message">
	                                	No messages yet.
	                                </td>
	                            </tr>
	                        </c:forEach>
	                        </tbody>
		    			</table>
		    		</div>
	    		</div>
    		</div>
    	</div>
    	
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
