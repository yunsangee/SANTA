<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<c:import url="../common/header.jsp"/>
 <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
    	$(document).ready( function(){
        var swiper = new Swiper('.swiper-container', {
            slidesPerView: 3,  // 한 슬라이드에 보여줄 카드 수
            spaceBetween: 10,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: 1,
                    spaceBetween: 10,
                },
                768: {
                    slidesPerView: 2,
                    spaceBetween: 20,
                },
                1024: {
                    slidesPerView: 3,
                    spaceBetween: 30,
                },
            }
        });
        
        
        $('.meetingPost').on('click', function(event){
        	event.preventDefault();
        	alert('meetingPost link');
        	window.location.href = '/meeting/getMeetingPostList?meetingPostListSearchCondition=5&searchKeyword=${mountain.mountainName}';
        });
        
        $('.certificationPost').on('click',function(event){
        	event.preventDefault();
        	alert('certificationPost link');
        	window.location.href = '/certificationPost/listCertificationPost?searchCondition=2&searchKeyword=${mountain.mountainName}';
        });
        
        $('.schedule').on('click',function(event){
        	event.preventDefault();
        	let user = ${sessionScope.user != null ? true : false};
        	
        	if(user){
        		window.location.href='/user/getScheduleList';
        	}
        });
/*         
        $('.bi-info-circle').on('click', function(){
        	
        	let user  = '${sessionScope.user != null ? sessionScope.user : "null"}';
        	if(user != 'null'){
        	 window.open('../correctionPost/addCorrectionPost.jsp', '정정제보', 'width=400,height=400');
        	}
        });
        
 */

 $('.bi-info-circle').click(function() {
     $('.dialog-overlay.details').addClass('active');
   });

   // 다이얼로그를 닫는 로직
   $('.dialog-overlay.details, .close-dialog').click(function(event) {
     if ($(event.target).is('.dialog-overlay.details') || $(event.target).is('.close-dialog')) {
       $('.dialog-overlay.details').removeClass('active');
     }
   });
        
        $(document).on('click', '.like-button', function() {
        	
        	let user = "${sessionScope.user != null ? sessionScope.user : 'null'}";
        	console.log("mountainNo:" + $(this).parent().parent().find('input:hidden[id="mountainNo"]').val());
        	let clickedElement = $(this)
        	
        	
        	console.log('index:' + $(this).parent().find('input:hidden[id="mountainIndex"]').val());
        	let index =  $(this).parent().find('input:hidden[id="mountainIndex"]').val();
        	
        	let isPop = 0;
        	
        	if(user != 'null'){
            	$(this).toggleClass('fas far');
            	//$(this).toggleClass('text-danger');
            	
            	const mountainLike = {
            			
            			postNo: $('#mountainNo').val(),
						userNo: parseInt(${sessionScope.user.userNo})
            			
            	}
            	
            	if(clickedElement.hasClass('fas')){
            		
            	 $.ajax({
            		url: "/mountain/rest/addMountainLike?index="+'-1'+"&isPop="+0,
            		type:"POST",
            		contentType: "application/json",
    	            dataType: "json",
            		data : JSON.stringify(mountainLike),
            		success: function(response,status){
            			console.log("res:" + response);
            			//$(this).text(response);
            			clickedElement.text(response);
            			console.log(clickedElement.text());
            			
            		},
            	}); 
            	}else{
            		 $.ajax({
                 		url: "/mountain/rest/deleteMountainLike?index="+'-1'+"&isPop="+0,
                 		type:"POST",
                 		contentType: "application/json",
         	            dataType: "json",
                 		data : JSON.stringify(mountainLike),
                 		success: function(response,status){
                 			clickedElement.text(response);
                 			
                 		},
                 	}); 
            	}
        	}
        });
    });
    	
    	$(document).ready(function(){
			$("#inputButton").on("click",function(event){
				event.preventDefault();
				const data  = {
					userNo : parseInt($("#userNo").val()),
					mountainNo : parseInt($("#mountainNo").val()),
					mountainName : $("#mountainName").val(),
					contents: $("#contents").val()
				};

				
			 	alert('/correctionPost/rest/addCorrectionPost');
				let url = '/correctionPost/rest/addCorrectionPost';
				$.ajax({
		            url: url,
		            method: "GET",
		            data: data, // data 객체를 쿼리 파라미터로 전송
		            success: function(response) {
		                alert('Mountain updated successfully');
		                console.log(response);
		                window.close();
		            },
		            error: function(jqXHR, textStatus, errorThrown) {
		                console.error('Error:', textStatus, errorThrown);
		                alert('Error:', textStatus, errorThrown);    
		                alert('Failed to update mountain');
		            }
		        });
			 	
			/* 	window.close();  */
				
			});
		});
		
    	
        function closeDialog() {
            $('.dialog-overlay').removeClass('active');
            dialogVisible = false;
        }
    </script>

 <style>
        .mountain-info {
            margin-top: 30px;
        }
        .mountain-image {
            width: 100%;
            height: auto%;
            max-height: 400px;
            object-fit: cover;
            object-position: top;
            align:center;
        }
        .mountain-description {
            margin-top: 20px;
        }
        .weather-info {
            margin-top: 20px;
        }
        .weather-card {
            text-align: center;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 15px;
            min-width: 150px;
            flex: 1;
        }
        
        .swiper-container {
            padding-bottom: 40px; /* pagination과 nav 버튼을 위한 여백 추가 */
            position: relative;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .swiper-slide{
        	position: relative;
            align-items: center;
            justify-content: center;
        }
        .swiper-pagination {
            position: absolute;
            bottom: 10px; /* pagination 위치 조정 */
            width: 100%;
            text-align: center;
        }
        .swiper-button-next,
        .swiper-button-prev {
            top: 50%; /* nav 버튼 위치 조정 */
            transform: translateY(-50%);
        }
        
        .mountain-image-container{
        	style:flex;
        	justify-content: center;
        }
        .today-mountain-stats {
    background-color: #f9f9f9;
    border-radius: 10px;
    padding: 20px;
    margin-top: 20px;
}

.today-mountain-stats h4 {
    font-size: 1.5em;
    margin-bottom: 20px;
}

.stat-item {
    display: flex;
    align-items: center;
    background-color: #fff;
    border-radius: 5px;
    padding: 15px;
    margin-bottom: 10px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.stat-item i {
    font-size: 1.5em;
    margin-right: 10px;
}

.stat-item span {
    font-size: 1.1em;
}

.fas.fa-heart {
    color: red; /* 좋아요가 눌린 경우의 색상 */
}

.far.fa-heart {
    color: gray; /* 좋아요가 눌리지 않은 경우의 색상 */
}
        .title{
        	display:flex;
			align-items: center;
        }
        
        .etc{
    		padding-left:10px;
        	justify-content: center;
        }
        
        .main{
        	display:flex;
			align-items: center;
        	justify-content: center;
        }
        
        
        
        .weather-card{
        	width:300px;
        	margin:auto;
        }
        
        .container-fluid.py-5{
        	margin-top:30px;
        }
        
        .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding-top:20px;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.dialog-overlay.active {
    display: flex;
}
.dialog-content {
      background: #fff;
      padding: 20px;
      border-radius: 5px;
      margin-top:45px;
      width: 35%;
      height: 80%;
      display: flex;
      flex-direction: column;
      position: relative;
    }

        /* ///////////////////////////////////////////////////////////////////////////////////////////////////////////// */
        
       .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #555;
            background: none;
            border: none;
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .profile-header p {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 13.5px;
            text-align: left; /* 왼쪽 정렬 추가 */
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5);
        }

        .form-group select {
            height: 40px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #218838;
        }
        
        
        .dialog-content h2 {
           font-size:20px;
        }
        
        .line {
          border-bottom: 1px solid #ccc;
          margin-bottom:15px;
          margin-top:-15px;
      }
        
        
        
        
    </style>
</head>
<body>

	<header><c:import url="../common/top.jsp"/></header>
	
	
	<main>
	
		
		<div class="container-fluid py-5">
			<div class="container py-5">
				
				<div class="card mb-3" style="width:auto; height:300px;">
					<div class="row g-0">
   						<div class="col-md-6">
     							<img src="${mountain.mountainImage}" class="img-fluid rounded-start" style="height:325px; width:600px;clip-path: inset(0px 0px 30px 0px);" alt="Mountain Image">
   						</div>
   						<div class="col-md-6">
     							<div class="card-body">
       							<h5 class="card-title">${mountain.mountainName}</h5>
      								<div class="etc">
        									<i class="bi bi-info-circle"></i>
        									<i class="${mountain.isLiked == 1 ? 'fas' : 'far'} fa-heart popular like-button" style="cursor: pointer;">${mountain.likeCount}</i>
      								</div>
      								<input type="hidden" id="mountainNo" value="${mountain.mountainNo}"/>
      								<p class="card-text">위치: ${mountain.mountainLocation}</p>
						        <p class="card-text">높이: ${mountain.mountainAltitude}m</p>
						        <p class="card-text">좋아요: ${mountain.likeCount}</p>
				      		</div>
				    	</div>
				    </div>
				</div>
 					
 				<h4>${mountain.mountainName} 날씨</h4>
  				
  				
  				<div class="row g-4 mb-4">
  					<div class="swiper-container" style="height:500px;">
                		<div class="swiper-wrapper" style="padding-top:20px;">
                
                    		<c:forEach var="weather" items="${weatherList}">
                        		<div class="swiper-slide">
                            	<div class="weather-card">
                                <p>${weather.date}</p>
                                <img src="https://openweathermap.org/img/wn/${weather.icon}@2x.png" alt="${weather.description}">
                                <p>${weather.description}</p>
                                <p>${weather.minMaxTemperature[0]}° / ${weather.minMaxTemperature[1]}°</p>
                                <p>체감 온도: ${weather.minMaxTemperature[2]}°C</p>
                                <p>풍속: ${weather.windSpeed}m/s</p>
                                <c:if test="${not empty weather.precipitation}">
                                    <p>강수량: ${weather.precipitation}</p>
                                </c:if>
                                <c:if test="${empty weather.precipitation}">
                                    <p>강수량: 0mm</p>
                                </c:if>
                                
                                
                                <div>
                                    <i class="bi bi-sunrise"></i> 일출: ${weather.sunriseTime} &nbsp
                                    <i class="bi bi-sunset"></i> 일몰: ${weather.sunsetTime}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                   
                </div>
                <!-- Add Pagination -->
                 	<div class="swiper-pagination"></div>
                 	 <!-- Add Navigation -->
                	<div class="swiper-button-next"></div>
                	<div class="swiper-button-prev"></div>
            </div>
            
               
  				</div>
  				
			</div>
		</div>

       
        
        <div class="today-mountain-stats">
    <h4>산타 통계</h4>
    <div class="stat-item">
        <i class="fas fa-users text-primary"></i>
        <span><strong>${meetingCount}</strong>개의  <strong>${mountain.mountainName}</strong> <strong>모임</strong>이  이루어졌어요!
        	<a href="#" class="small-link meetingPost">보러가기</a>
        </span>
    </div>
    <div class="stat-item">
        <i class="fas fa-pencil-alt text-warning"></i>
        <span><strong>${certificationCount}</strong>개의 <strong>${mountain.mountainName}</strong> <strong>등산 인증</strong> 후기가 있어요!
        	 <a href="#" class="small-link certificationPost">보러가기</a>
        </span>
    </div>
    <div class="stat-item">
        <i class="fas fa-calendar-alt text-danger"></i>
        <span>
        	<strong>${scheduleCount}</strong>명의 <strong>산타</strong>가 <strong>${mountain.mountainName}</strong> 등산일정을 등록했어요!
        	<a href="#" class="small-link schedule">일정 등록하러 가기</a>
        </span>
    </div>
</div>
        
	</main>
	
	<div class="dialog-overlay details">
    <div class="dialog-content details">

            <button class="close-button" onclick="closeDialog()">&times;</button>

            <h2></h2>

            <div class="profile-header">
                <img src="${user.profileImage}" alt="Profile Image">
                <p>${user.nickName}</p>
            </div>

         <div class="line"></div>
      
            <form action="/user/addQnA" method="post">
                <div class="form-group">
                    <label for="title">산 명칭<span>*</span></label>
                    <input type="text" id="title" name="title" value="${mountain.mountainName}" placeholder="산 명칭을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="contents">내용<span>*</span></label>
                    <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
                </div>
                <div class="form-group">
                    <button type="submit" id="inputButton">작성 완료하기</button>
                </div>
            </form>



	<input type="hidden" id="userNo" name="userNo" value="${sessionScope.user.userNo}" />
	<input type="hidden" id="mountainNo" name="mountainNo" value="${mountain.mountainNo}" />
	<input type="hidden" id="mountainName" name="mountainName" value="${mountain.mountainName}" />

    </div>
  </div>
	
	
	
	
	
	<footer><c:import url="../common/footer.jsp"/></footer>

</body>
</html>