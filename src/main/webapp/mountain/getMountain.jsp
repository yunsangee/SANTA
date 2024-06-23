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
        
        
        $('#meetingPost').on('click', function(){
        	window.location.href = '/meetingPost/getMeetingPostList';
        });
        
        $('#certificationPost').on('click',function(){
        	window.location.href = '/certificationPost/listCertificationPost';
        });
        
        $('.bi-info-circle').on('click', function(){
        	
        	let user  = '${sessionScope.user != null ? sessionScope.user : "null"}';
        	if(user != 'null'){
        	 window.open('../correctionPost/addCorrectionPost.jsp', '정정제보', 'width=400,height=400');
        	}
        });
    });
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
        
    </style>
</head>
<body>

	<header><c:import url="../common/top.jsp"/></header>
	
	
	

	<main>
		<div class="container mountain-info">
        <div class="row mountain-image-container">
            <div class="col-md-10">
                <img src="${mountain.mountainImage}" alt="Mountain Image" class="mountain-image">
            </div>
        </div>
           </div>
        <div class="row mountain-description">
            <div class="col-md-12">
                 <div class="title"><h2>${mountain.mountainName} </h2>
                 					<i class="bi bi-info-circle"></i>
                 </div>
    			 <div>위치: ${mountain.mountainLocation}</div>
    			 <div>높이: ${mountain.mountainAltitude}m</div>
    			 <div>좋아요: ${mountain.likeCount}</div>
            </div>
        </div>
       <div class="row weather-info">
            <h4>${mountain.mountainName} 날씨</h4>
            <div class="swiper-container">
                <div class="swiper-wrapper">
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
        
        <div class="today-mountain-stats">
    <h4>오늘등산 통계</h4>
    <div class="stat-item">
        <i class="fas fa-users text-primary"></i>
        <span><strong>${meetingCount}</strong>개의  <strong>${mountain.mountainName}</strong> <strong>모임</strong>이  이루어졌어요!
        	<a href="/meetingPost/getMeetingPostList?searchKeyword=${mountain.mountainName}" class="small-link" id="meetingPost">보러가기</a>
        </span>
    </div>
    <div class="stat-item">
        <i class="fas fa-pencil-alt text-warning"></i>
        <span><strong>${certificationCount}</strong>개의 <strong>${mountain.mountainName}</strong> <strong>등산 인증</strong> 후기가 있어요!
        	 <a href="/certificationPost/listCertificationPost?searchKeyword=${mountain.mountainName}" class="small-link" id="certificationPost">보러가기</a>
        </span>
    </div>
    <div class="stat-item">
        <i class="fas fa-calendar-alt text-danger"></i>
        <span><strong>${scheduleCount}</strong>명의 <strong>산타</strong>가 <strong>${mountain.mountainName}</strong> 등산일정을 등록했어요!</span>
    </div>
</div>
        
	</main>
	
	
	
	
	
	<footer><c:import url="../common/footer.jsp"/></footer>

</body>
</html>