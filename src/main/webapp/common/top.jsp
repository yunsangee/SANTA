<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script>
    	$(document).ready(function(){
    		
    		var currentUrl = window.location.pathname;
    	    console.log("현재 URL:", currentUrl);

    	    // 현재 URL의 마지막 요소를 가져옴
    	    var pathParts = currentUrl.split('/');
    	    var startPathPart = pathParts[1];
    	    console.log("첫번째 URL 요소:", startPathPart);
    	    
    	    if(startPathPart ==""){
    	    	startPathPart = "home";
    	    }

    	    // 클래스 이름과 ID를 사용하여 요소를 찾고 active 클래스를 추가
    	    $('.nav-link').removeClass('active');
    	    $('.' + startPathPart).addClass('active');

    	    
    	$(function(event){
    		
    		$('#Home').on('click',function(event){
    			event.preventDefault();
    			window.location.href ='/';
    		});

    		$('#logoName').on('click',function(event){
    			event.preventDefault();
    			window.location.href ='/';
    		});
    		
			$('#mountain').on('click',function(event){
				event.preventDefault();
				window.location.href = '/mountain/searchMountain';
			});
			
			$('#certificationPost').on('click',function(event){
				event.preventDefault();
				window.location.href = '/certificationPost/listCertificationPost';
			});
			
			$('#meetingPost').on('click',function(event){
				event.preventDefault();
				window.location.href = '/meeting/getMeetingPostList';
			});
			
			$('#chatting').on('click',function(event){
				event.preventDefault();
				let user = '${sessionScope.user != null ? sessionScope.user : "null"}';
				
				if(user != 'null'){
					window.location.href = '/chatting/getChattingRoomList';
				}
			});
			
			$('#hikingGuide').on('click',function(event){
				event.preventDefault();
				
				
				let user = '${sessionScope.user != null ? sessionScope.user : "null"}';
				
				if(user !='null'){
					window.location.href = '/hikingguide';
				}
			});
			
			$('#loginButton').on('click',function(event){
				event.preventDefault();
				window.location.href = '/user/login';
			});
			
			$('#userProfile').on('click',function(event){
				event.preventDefault();
				window.location.href = '/mountain/searchMountain';
			});  // need to fix to popup
			
			$('#getUserList').on('click',function(event){
				event.preventDefault();
				window.location.href = '/user/getUserList';
			});  // need to fix to popup
			
			$('#statistics').on('click',function(event){
				event.preventDefault();
				window.location.href = '/mountain/getStatistics';
			});  // need to fix to popup
			
			$('#correctionPost').on('click',function(event){
				event.preventDefault();
				window.location.href = '/correctionPost/getCorrectionPostList';
			});  // need to fix to popup
			
			 $('#myInfo').on('click', function(event) {
				 event.preventDefault();
		            window.location.href = '/user/getUser';
		        });
		        $('#myMeetingPost').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/meeting/getMeetingPostList?userNo=${sessionScope.user.userNo}';
		        });
		        $('#myCertificationPost').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/certificationPost/listMyCertificationPost?userNo=${sessionScope.user.userNo}';
		        });
		        $('#myMountainLike').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/mountain/getMountainLikeList?userNo='+'${sessionScope.user.userNo}'; //??
		        });
		        $('#mySchedule').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/user/getScheduleList';
		        });
		        $('#myHikingRecord').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/hikingguide/hikingRecord?userNo=${sessionScope.user.userNo}';
		        });
		        $('#qna').on('click', function(event) {
		        	event.preventDefault();
		            window.location.href = '/user/getQnAList';
		        });
		        $('#logout').on('click', function(event) {
		        	event.preventDefault();
		        	
		        	if('${sessionScope.user.userPassword}' == 'kakao'){
		        		window.location.href = '/oauth/logout/kakao';
		        	}else{
		            	window.location.href = '/user/logout';
		        	}
		        });

             
             
             
    	});
    	});
    </script>
    
    <style>
    	 .user-icon, .user-image {
            width: 24px; /* Set the desired width */
            height: 24px; /* Set the desired height */
            border-radius: 50%;
        }
        
        .d-flex{
        	align-items: center;	
        }
        
        .dropdown-menu {
            width: 200px; /* Reduced size */
            left: -150px !important; /* Adjust the value based on your layout */
        }
        .dropdown-menu .dropdown-header {
            display: flex;
            align-items: center;
            padding: 5px; /* Reduced padding */
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }
        .dropdown-menu .dropdown-header img {
            width: 25px; /* Reduced size */
            height: 25px; /* Reduced size */
            border-radius: 50%;
            margin-right: 5px; /* Reduced margin */
        }
        .dropdown-menu .dropdown-header .info {
            flex: 1;
        }
        .dropdown-menu .dropdown-header .info .name {
            font-weight: bold;
            font-size: 0.7em; /* Reduced font size */
        }
        .dropdown-menu .dropdown-header .info .email {
            font-size: 0.7em; /* Reduced font size */
            color: #6c757d;
        }
        .dropdown-menu .dropdown-item {
            display: flex;
            align-items: center;
            padding: 5px; /* Reduced padding */
        }
        .dropdown-menu .dropdown-item i {
            margin-right: 5px; /* Reduced margin */
            font-size: 0.7em; /* Reduced font size */
        }
        .dropdown-menu .dropdown-item .text {
            font-size: 0.7em; /* Reduced font size */
        }
        
        .alarmMessage {
    		width: 300px;
		}

		.alarm-dropdown-menu .dropdown-item {
    		font-size: 0.6em;
		}

		.alarm-dropdown-menu .dropdown-item .close-icon {
            margin-left: 20px;
            cursor: pointer;
        }
        
        .settings{
        	width:150px;
        	right: 100px;
        	buttom: 50px;
        	font-size: 0.6em;
        }
        
        
        .alarmSettings{
        	width:150px;
        	right: 100px;
        	buttom: 50px;
        	font-size: 0.6em;

        }
        
        .alarmSettings .form-switch{
        	display:flex;
        	align-items: center;	
        
        }
        
        .logo {
            background-color: transparent;
            border: none;
            padding: 0;
            cursor: pointer;
        }
        
        
    </style>

</head>

<body>
<div class="container-fluid fixed-top">
    <div class="container px-3">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <button type="button" class="logo"><h1 id="logoName" class="text-primary display-6">SANTA</h1></button>
            <button class="navbar-toggler py-2 px-3" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <c:if test="${empty sessionScope.user or sessionScope.user.role == 0 }">
                        <a href="#" id="Home" class="nav-item nav-link home active">홈</a>
                        <a href="#" id="mountain" class="nav-item nav-link mountain">산</a>
                        <a href="#" id="certificationPost" class="nav-item nav-link certificationPost">인증게시판</a>
                        <a href="#" id="meetingPost" class="nav-item nav-link meeting">모임게시판</a>
                        <a href="#" id="chatting" class="nav-item nav-link chatting">모임 채팅</a>
                        <a href="#" id="hikingGuide" class="nav-item nav-link hikingGuide">등산안내</a>
                        
                    </c:if>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.role == 1 }">
                        <a href="#" id="Home" class="nav-item nav-link home active">홈</a>
                        <a href="#" id="getUserList" class="nav-item nav-link userList">회원목록조회</a>
                        <a href="#" id="statistics" class="nav-item nav-link statistics">통계</a>
                        <a href="#" id="correctionPost" class="nav-item nav-link correctionPost">정정제보</a>
                    </c:if>
                </div>
                <div class="d-flex m-3 me-0" >
                    <c:if test="${not empty sessionScope.user}">
                    	<div class="dropdown">
                            <a class="dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${sessionScope.user.profileImage}" class="user-image" alt="User Image"/>
                            </a>
                            <div class="dropdown-menu dropdown-menu-left profile" aria-labelledby="navbarDropdown">
                                 <div class="dropdown-header">
                                    <img src="${sessionScope.user.profileImage}" alt="User Image"/>
                                    <div class="info">
                                        <div class="name">${sessionScope.user.nickName}</div>
                                        <div class="email">${sessionScope.user.userId}</div>
                                    </div>
                                    <i class="fas fa-cog setting-icon" id="settingsIcon"></i>
                                </div>
                                <a class="dropdown-item" href="#"><i class="fas fa-certificate"></i> 인증 ${sessionScope.user.certificationCount}회, 모임 ${sessionScope.user.meetingCount}회 </a>
                                <a class="dropdown-item" id="myInfo" href="#"><i class="fas fa-user"></i> 내 정보보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="myMeetingPost" href="#"><i class="fas fa-users"></i> 내가 쓴 모임 게시글 보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="myCertificationPost" href="#"><i class="fas fa-check-circle"></i> 내가 쓴 인증 게시글 보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="myMountainLike" href="#"><i class="fas fa-heart"></i> 내가 좋아요 한 산 보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="mySchedule" href="#"><i class="fas fa-calendar-alt"></i> 내 일정 보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="myHikingRecord" href="#"><i class="fas fa-hiking"></i> 등산 기록 보기 <i class="fas fa-chevron-right"></i></a>
                                <a class="dropdown-item" id="qna" href="#"><i class="fas fa-question-circle"></i> Q&A <i class="fas fa-chevron-right"></i></a>
                                <!-- <a class="dropdown-item" id="logout" href="#"><i class="fas fa-sign-out-alt"></i> 로그아웃 <i class="fas fa-chevron-right"></i></a> -->
                                
                            </div>
                        </div>
                        
 
<div class="container alarmSettings" id="settingsModal" style="display:none; position:absolute; top: 65%; margin-left:5px; right: 0; background: white; border: 1px solid #ccc; padding: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <h6>알림 설정</h6>
    <div class="form-group">
        <label class="d-flex align-items-center">
            전체알림
            <div class="form-check form-switch ml-auto">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchAllAlert"
                       ${sessionScope.user.allAlertSetting == 1 ? "checked" : ""}>
                <label class="form-check-label" for="flexSwitchAllAlert"></label>
            </div>
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            인증 게시글 알림
            <div class="form-check form-switch ml-auto">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCertificationPostAlert"
                       ${sessionScope.user.certificationPostAlertSetting == 1 ? "checked" : ""}>
                <label class="form-check-label" for="flexSwitchCertificationPostAlert"></label>
            </div>
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            모임 게시글 알림
            <div class="form-check form-switch ml-auto">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchMeetingPostAlert"
                       ${sessionScope.user.meetingPostAlertSetting == 1 ? "checked" : ""}>
                <label class="form-check-label" for="flexSwitchMeetingPostAlert"></label>
            </div>
        </label>
    </div>
    <div class="form-group">
        <label class="d-flex align-items-center">
            등산 안내 알림
            <div class="form-check form-switch ml-auto">
                <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchHikingGuideAlert"
                       ${sessionScope.user.hikingGuideAlertSetting == 1 ? "checked" : ""}>
                <label class="form-check-label" for="flexSwitchHikingGuideAlert"></label>
            </div>
        </label>
    </div>
</div>
                    	
                    	<div class="dropdown" style="margin-left:30px;">
                            <a class="dropdown-toggle" href="#" id="alarmDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell"></i>
                            </a>
                            <div class="dropdown-menu alarm-dropdown-menu alarmMessage" aria-labelledby="alarmDropdown">
                                <h6 class="dropdown-header">알림 메시지</h6>
                                <c:forEach var="alarmMessage" items="${alarmMessageList}">
                                    <a class="dropdown-item message" href="${alarmMessage.postTypeNo == 0 ? '/meetingPost/getMeetingPost?postNo=alarmMessage.postNo' : '/certificationPost/getCertificationPost?postNo=alarmMessage.postNo' }">
                                    ${alarmMessage.message} 
                                    <i class="fas fa-times close-icon"></i> 
                                    <input type="hidden" id="alarmNo" value="${alarmMessage.alarmNo}"/>
                                    </a>
                                    
                                </c:forEach>
                            </div>
                        </div>
                        
                    <a href="#" class="my-auto nav-link" id='logout'><i id="loginButton" class="fas fa-sign-in-alt fa-1x"> 로그아웃</i></a>
                        
                    </c:if>
                    
                    
                    
                    
                    <c:if test="${empty sessionScope.user}">
                        <a href="#" class="my-auto nav-link"><i id="loginButton" class="fas fa-sign-in-alt fa-1x"> 로그인</i></a>
                    </c:if>
                </div><!-- /* d-flex */ -->
            </div>
        </nav>
    </div>
</div>


<script>
$(document).ready(function(event) {
    $('.navbar-toggler').on('click', function(event) {
        var target = $(this).attr('data-target');
        $(target).collapse('toggle');
    });

    $('.nav-link').on('click', function(event) {
    	event.stopPropagation();
        $('#navbarCollapse').collapse('hide');
    });
    
    $('.dropdown-toggle').on('click', function(event) {
        event.stopPropagation();
       /*  $('.dropdown-menu').removeClass('show');
        $(this).next('.dropdown-menu').toggleClass('show'); */
        
       	let dropdownMenu = $(this).next('.dropdown-menu');
        
        if (dropdownMenu.hasClass('show')) {
            dropdownMenu.removeClass('show');
        } else {
            $('.dropdown-menu').removeClass('show'); // 다른 모든 드롭다운 메뉴 숨기기
            dropdownMenu.addClass('show'); // 현재 드롭다운 메뉴 보이기
        }
        
        
        var modal = document.getElementById('settingsModal');
        
        if(modal.style.display == 'block'){
        	modal.style.display = 'none';
        }
    });

    // Close dropdown when clicking outside
    $(document).on('click', function(event) {
    	event.stopPropagation();
        if (!$(event.target).closest('.dropdown').length) {
        	
            $('.dropdown-menu').removeClass('show');
            
            if(!$('.dropdown-menu').hasClass('show')){
            	var modal = document.getElementById('settingsModal');
            	modal.style.display='none';
              }
            
        }
    });
    

        $(document).on('click', '.close-icon', function(event) {
            event.preventDefault();
            event.stopPropagation(); // Prevents the click event from bubbling up
            
            
            
            $(this).closest('.dropdown-item').remove();
            
            console.log($(this).parent().find('#alarmNo').val());
            
            let alarmNo = $(this).parent().find('#alarmNo').val();
            $.ajax({
                url: '/userEtc/rest/deleteAlarmMessage?alarmNo=' + alarmNo,
                method: "GET",
                success: function(response) {
                    // On success, remove the message item from the dropdown
                    clickedElement.closest('.dropdown-item').remove();
                },
                error: function(xhr, status, error) {
                    // Handle error
                    console.error("Error deleting alarm message:", error);
                }
            });
        });
        
      /*   document.getElementsByClassName('setting-icon').addEventListener('click', function () {
            closeAlarmSetting();
        }); */
        
        $('.setting-icon').on('click',function(event){
			event.preventDefault();
            
            /* var modal = $("#settingsModal");
            var icon = $(this);
            
            // 아이콘의 위치와 크기를 가져와서 모달의 위치를 설정
            var iconOffset = icon.offset();
            var iconHeight = icon.outerHeight();
            
            modal.css({
                top: iconOffset.top + iconHeight + "px",
                left: iconOffset.left + "px"
            }); */
            
            closeAlarmSetting();
        });
        
        $('.form-switch').on('click', function(event){
        	event.stopPropagation();
        });
        
        
        function closeAlarmSetting() {
        	var modal = document.getElementById('settingsModal');
            if (modal.style.display === 'none' || modal.style.display === '') {
                modal.style.display = 'block';
            } else {
                modal.style.display = 'none';
            }
        } 
        
        
        $('#flexSwitchAllAlert').on('click', function(event) {
            var isChecked = $(this).is(':checked');
            console.log('전체알림:', isChecked);
            // AJAX 요청을 통해 서버에 업데이트
            
            let userNo = ${sessionScope.user.userNo != null ? sessionScope.user.userNo : 'null' };
            let alarmSettingType = 0;
            
            console.log('userNo:' + userNo);
            
            if(userNo != 'null'){
            
            $.ajax({
            	url:'userEtc/rest/updateAlarmSetting?userNo=' + userNo +'&alarmSettingType='+alarmSettingType,
        		method:"GET",
        		success:function(response){
        			console.log('all alarm setting clear');
        			location.reload();
        		}
            });
            }
        });

        $('#flexSwitchCertificationPostAlert').on('click', function(event) {
            var isChecked = $(this).is(':checked');
            console.log('인증 게시글 알림:', isChecked);
            // AJAX 요청을 통해 서버에 업데이트
            
            let userNo = ${sessionScope.user.userNo != null ? sessionScope.user.userNo : 'null' };
            let alarmSettingType = 1;
            
            $.ajax({
            	url:'userEtc/rest/updateAlarmSetting?userNo=' + userNo +'&alarmSettingType='+alarmSettingType,
        		method:"GET",
        		success:function(response){
        			console.log('all alarm setting clear');
        			location.reload();
        		}
            });
        });

        $('#flexSwitchMeetingPostAlert').on('click', function(event) {
            var isChecked = $(this).is(':checked');
            console.log('모임 게시글 알림:', isChecked);
            // AJAX 요청을 통해 서버에 업데이트
            
            let userNo = ${sessionScope.user.userNo != null ? sessionScope.user.userNo : 'null' };
            let alarmSettingType = 2;
            
            $.ajax({
            	url:'userEtc/rest/updateAlarmSetting?userNo=' + userNo +'&alarmSettingType='+alarmSettingType,
        		method:"GET",
        		success:function(response){
        			console.log('all alarm setting clear');
        			location.reload();
        		}
            });
        });

        $('#flexSwitchHikingGuideAlert').on('click', function(event) {
            var isChecked = $(this).is(':checked');
            console.log('등산 안내 알림:', isChecked);
            // AJAX 요청을 통해 서버에 업데이트
            
            let userNo = ${sessionScope.user.userNo != null ? sessionScope.user.userNo : 'null' };
            let alarmSettingType = 3;
            
            $.ajax({
            	url:'userEtc/rest/updateAlarmSetting?userNo=' + userNo +'&alarmSettingType='+alarmSettingType,
        		method:"GET",
        		success:function(response){
        			console.log('all alarm setting clear');
        			location.reload();
        		}
            });
        });

});
</script>
</body>
</html>