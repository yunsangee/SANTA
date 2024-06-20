<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
    <c:import url="../common/header.jsp"/>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

<!-- JavaScript 파일 -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        $(document).ready(function() {
                var swiper1 = new Swiper('.swiper-container', {
                    slidesPerView: 2,  // 한 슬라이드에 보여줄 카드 수
                    spaceBetween: 20,
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                    },
                });

        });
        
        $(function(){
        	/* $('#logoName').on('click', function(){
                self.location = '/';
            }); */
            
            $('#search').on('click',function(){
            	window.location.href = '/mountain/searchMountain';
            });
            
            $('#searchBox').on('click',function(){
            	window.location.href = '/mountain/searchMountain';
            });
            
            $('#mapSearch').on('click',function(){
            	window.location.href = '${javaServerIp}/mountain/mapMountain';
            });

            $('.fa-external-link-alt').on('click',function(){
            	console.log($($(this).parent()).text());
            	var h4Value = $($(this).parent()).text().trim();
            	console.log(h4Value);
            	
            	window.location.href = "${javaServerIp}/mountain/mapMountain?searchCondition=0&searchKeyword=" + h4Value;
            });
           

            // Like button toggle
            $(document).on('click', '.like-button', function() {
            	
            	let user = "${sessionScope.user != null ? sessionScope.user : 'null'}";
            	console.log("mountainNo:" + $(this).parent().find('input:hidden[id="mountainNo"]').val());
            	let clickedElement = $(this)
            	
            	
            	console.log('index:' + $(this).parent().find('input:hidden[id="mountainIndex"]').val());
            	let index =  $(this).parent().find('input:hidden[id="mountainIndex"]').val();
            	
            	let isPop = 0;
            	
            	if(user != 'null'){
                	$(this).toggleClass('fas far');
                	//$(this).toggleClass('text-danger');
                	
                	const mountainLike = {
                			userNo: parseInt(${sessionScope.user.userNo}),
                			postNo: $(this).parent().find('input:hidden').val().trim(),
                			postLikeType:2
                			
                	}
                	
                	if(clickedElement.hasClass('fas')){
                	 if(clickedElement.hasClass('popular')){
                		 isPop = 1;
                	 }
                		
                	 $.ajax({
                		url: "/mountain/rest/addMountainLike?index="+index+"&isPop="+isPop,
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
                     		url: "/mountain/rest/deleteMountainLike?index="+index+"&isPop="+isPop,
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
    </script>
    
    <style>
        .testimonial-item {
            position: relative;
        }

         .swiper-container {
            padding-bottom: 40px;
            position: relative;
        }
        .swiper-pagination {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
        }
        .swiper-button-next,
        .swiper-button-prev {
            top: 50%;
            transform: translateY(-50%);
        }
        
        .fas.fa-heart {
    color: red; /* 좋아요가 눌린 경우의 색상 */
}

.far.fa-heart {
    color: gray; /* 좋아요가 눌리지 않은 경우의 색상 */
}
        
        .popular-testimonial-item{
        	text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 15px;
            min-width: 150px;
            flex: 1;
            display:flex;
            position:relative;
        
        }
        
        .custom-testimonial-item{
        	text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 15px;
            min-width: 150px;
            flex: 1;
            display:flex;
            position:relative;
        }
        
        .swiper-container {
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 15px;
    width: 100%; /* 전체 너비로 설정 */
    overflow: hidden; /* 내용이 넘치는 경우를 대비하여 오버플로우를 숨김 */
    }
    
   .container-fluid {
}
    </style>
</head>

<body>
    <header><c:import url="./top.jsp"/></header>
    
    
    <main style="margin-top:30px;">

<nav>

<div class="container-fluid testimonial">
    <div class="container py-5">
        <div class="search-container" style="display: flex; justify-content: center; align-items: center; margin-top: 30px; margin-bottom: 20px;">
            <input id="searchBox" type="text" placeholder="검색" style="flex: 1; padding: 10px; border: none; outline: none; border: 1px solid #ccc; border-radius: 5px; padding: 10px;">
            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                <i class="fas fa-search text-primary" id="search"></i>
            </button>
            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white" style="background: none; border: none; cursor: pointer; margin-left: 1px;">
                <i class="fas fa-map text-primary" id="mapSearch"></i>
            </button>
        </div>
        <div class="testimonial-header text-center" style="margin-top:10px;">
            <h4 class="text-primary">인기산 목록</h4>
        </div>
        <div class="swiper-container popular-swiper-container">
            <div class="swiper-wrapper">
                <c:forEach var="mountain" items="${popularMountainList}" varStatus="index">
                    <div class="swiper-slide">
                        <div class="popular-testimonial-item img-border-radius rounded p-4">
                            <div class=" rounded">
                                <img src="${mountain.mountainImage}" class="img-fluid rounded" style="width: 250px; height: 150px;" alt="">
                            </div>
                            <div class="ms-3 d-block" style="flex-grow: 1;">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-dark mb-0">${mountain.mountainName}</h4>
                                    <i class="fas fa-external-link-alt"></i>
                                </div>
                                <p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
                                <p class="m-0 pb-3">${mountain.mountainAltitude}</p>
                                <p class="m-0 pb-3">
                                    <i class="${mountain.isLiked == 1 ? 'fas' : 'far'} fa-heart popular like-button" style="cursor: pointer;">${mountain.likeCount}</i>
                                    <input type="hidden" id="mountainNo" value="${mountain.mountainNo}"/>
                                    <input type="hidden" id="mountainIndex" value="${index.index}"/>
                                </p>
                                <p class="m-0 pb-3">${mountain.mountainViewCount}</p>
                                <div class="d-flex pe-5">
                                    <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination popular-swiper-pagination"></div>
            <!-- Add Navigation -->
            <div class="swiper-button-next popular-swiper-button-next"></div>
            <div class="swiper-button-prev popular-swiper-button-prev"></div>
        </div>
    </div>
</div>

<!-- Second Carousel -->
			<div class="container-fluid testimonial" style="margin-top:10px;">
    <div class="container py-5">

        <div class="testimonial-header text-center">
            <h4 class="text-primary">사용자 맞춤 산 목록</h4>
        </div>
        <div class="swiper-container custom-swiper-container">
            <div class="swiper-wrapper">
                <c:forEach var="mountain" items="${customMountainList}" varStatus="index">
                    <div class="swiper-slide">
                        <div class="custom-testimonial-item img-border-radius rounded p-4">
                            <div class="rounded">
                                <img src="${mountain.mountainImage}" class="img-fluid rounded" style="width: 250px; height: 150px;" alt="">
                            </div>
                            <div class="ms-3 d-block" style="flex-grow: 1;">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-dark mb-0">${mountain.mountainName}</h4>
                                    <i class="fas fa-external-link-alt"></i>
                                </div>
                                <p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
                                <p class="m-0 pb-3">${mountain.mountainAltitude}m</p>
                                <p class="m-0 pb-3">
                                    <i class="${mountain.isLiked == 1 ? 'fas' : 'far'} fa-heart custom like-button" style="cursor: pointer;">${mountain.likeCount}</i>
                                    <input type="hidden" id="mountainNo" value="${mountain.mountainNo}"/>
                                    <input type="hidden" id="mountainIndex" value="${index.index}"/>
                                </p>
                                <p class="m-0 pb-3">${mountain.mountainViewCount}</p>
                                <div class="d-flex pe-5">
                                    <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star text-primary"></i> <i class="fas fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination custom-swiper-pagination"></div>
            <!-- Add Navigation -->
            <div class="swiper-button-next custom-swiper-button-next"></div>
            <div class="swiper-button-prev custom-swiper-button-prev"></div>
        </div>
	</div></div>
	</nav>
	</main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
