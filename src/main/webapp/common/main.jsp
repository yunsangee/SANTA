<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
    <c:import url="../common/header.jsp"/>
    <script>
        $(document).ready(function() {
        	$(document).ready(function() {
                var owl1 = $('#carousel1').owlCarousel({
                    loop: true,
                    margin: 10,
                    nav: false,
                    items: 1,
                    slideBy: 1,
                    center: true, // 슬라이드를 가운데 정렬합니다.
                    autoplay: true, // 자동 재생을 활성화합니다.
                    autoplayTimeout: 3000 // 3초마다 슬라이드를 넘깁니다.
  /*                   autoplayHoverPause: true  */// 마우스 호버 시 자동 재생을 일시 중지합니다.
                });

                var owl2 = $('#carousel2').owlCarousel({
                    loop: true,
                    margin: 10,
                    nav: false,
                    items: 1,
                    slideBy: 1,
                    center: true, // 슬라이드를 가운데 정렬합니다.
                    autoplay: true, // 자동 재생을 활성화합니다.
                    autoplayTimeout: 5000// 5초마다 슬라이드를 넘깁니다.
                   /*  autoplayHoverPause: true */ // 마우스 호버 시 자동 재생을 일시 중지합니다.
                });
                
                // Custom navigation
                $(document).on('click', '#customNavLeft1', function() {
                    owl1.trigger('prev.owl.carousel');
                });

                $(document).on('click', '#customNavRight1', function() {
                    owl1.trigger('next.owl.carousel');
                });

                $(document).on('click', '#customNavLeft2', function() {
                    owl2.trigger('prev.owl.carousel');
                });

                $(document).on('click', '#customNavRight2', function() {
                    owl2.trigger('next.owl.carousel');
                });
        	});

        });
        
        $(function(){
        	/* $('#logoName').on('click', function(){
                self.location = '/';
            }); */
            
            $('#search').on('click',function(){
            	window.location.href = 'http://${javaServerIp}/mountain/searchMountain';
            });
            
            $('#searchBox').on('click',function(){
            	window.location.href = 'http://${javaServerIp}/mountain/searchMountain';
            });
            
            $('#mapSearch').on('click',function(){
            	window.location.href = 'http://${javaServerIp}/mountain/mapMountain';
            });

            $('.fa-external-link-alt').on('click',function(){
            	console.log($($(this).parent()).text());
            	var h4Value = $($(this).parent()).text().trim();
            	console.log(h4Value);
            	
            	window.location.href = "http://${javaServerIp}/mountain/mapMountain?searchCondition=0&searchKeyword=" + h4Value;
            });
           

            // Like button toggle
            $(document).on('click', '.like-button', function() {
            	let user = ${sessionScope.user != null ? sessionScope.user : 'null'};
            	
            	if(user != null){
                	$(this).toggleClass('fas far');
                	$(this).toggleClass('text-danger');
            	}
            });
        });
    </script>
    
    <style>
        .testimonial-item {
            position: relative;
        }

        #customNavLeft1, #customNavLeft2 {
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 10;
        }
        #customNavRight1,#customNavRight2 {
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 10;
        }
    </style>
</head>

<body>
    <header><c:import url="./top.jsp"/></header>
    <main>
	


<nav>

			
			<div class="container-fluid testimonial py-5" style="margin-top:20px;">
				 
				
				<div class="container py-5">
					<div class="search-container" style="display: flex; justify-content: center; align-items: center; margin-top: 30px; margin-bottom: 10px;">
                            <input id="searchBox" type="text" placeholder="검색" style="flex: 1; padding: 10px; border: none; outline: none; border: 1px solid #ccc; border-radius: 5px; padding: 10px;">
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                                <i class="fas fa-search text-primary" id="search"></i>
                            </button>
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white" style="background: none; border: none; cursor: pointer; margin-left: 1px;">
                                <i class="fas fa-map text-primary" id="mapSearch"></i>
                            </button>
                       </div>
					
					<div class="testimonial-header text-center">
						<h4 class="text-primary">인기산 목록</h4>
					</div>
					<div id="carousel1" class="owl-carousel testimonial-carousel">
						<c:forEach var="mountain" items="${popularMountainList}">
							<div class="item">
								<div
									class="testimonial-item img-border-radius bg-light rounded p-4">
									<i id="customNavLeft1" class="fas fa-chevron-left"></i> <i
										id="customNavRight1" class="fas fa-chevron-right"></i>
									<div
										class="position-relative d-flex align-items-center flex-nowrap">
										<div class="bg-secondary rounded">
											<img src="${mountain.mountainImage}"
												class="img-fluid rounded"
												style="width: 250px; height: 150px;" alt="">
										</div>
										<div class="ms-3 d-block" style="flex-grow: 1;">
											<div class="d-flex justify-content-between align-items-center">
        										<h4 class="text-dark mb-0">${mountain.mountainName}</h4>
            									<i class="fas fa-external-link-alt"></i>
    										</div>
											<p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
											<p class="m-0 pb-3">${mountain.mountainAltitude}m</p>
											<p class="m-0 pb-3">
												<i class="far fa-heart like-button" style="cursor: pointer;"></i>
												${mountain.likeCount}
											</p>
											<p class="m-0 pb-3">${mountain.mountainViewCount}</p>
											<div class="d-flex pe-5">
												<i class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- Second Carousel -->

			<%--             <c:if test="${not empty sessionScope.user}"> --%>
			<div class="container-fluid testimonial py-5">
				<div class="container py-5">
					<div class="testimonial-header text-center">
						<h4 class="text-primary">사용자 맞춤 산 목록</h4>
					</div>
					<div id="carousel2" class="owl-carousel testimonial-carousel">
						<c:forEach var="mountain" items="${customMountainList}">
							<div class="item">
								<div
									class="testimonial-item img-border-radius bg-light rounded p-4">
									<i id="customNavLeft2" class="fas fa-chevron-left"></i> <i
										id="customNavRight2" class="fas fa-chevron-right"></i>
									<div
										class="position-relative d-flex align-items-center flex-nowrap">
										<div class="bg-secondary rounded">
											<img src="${mountain.mountainImage}"
												class="img-fluid rounded"
												style="width: 250px; height: 150px;" alt="">
										</div>
										<div class="ms-3 d-block" style="flex-grow: 1;">
											<div class="d-flex justify-content-between align-items-center">
        										<h4 class="text-dark mb-0">${mountain.mountainName}</h4>
            									<i class="fas fa-external-link-alt"></i>
    										</div>
											<p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
											<p class="m-0 pb-3">${mountain.mountainAltitude}m</p>
											<p class="m-0 pb-3">
												<i class="far fa-heart like-button" style="cursor: pointer;"></i>
												${mountain.likeCount}
											</p>
											<p class="m-0 pb-3">${mountain.mountainViewCount}</p>
											<div class="d-flex pe-5">
												<i class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star text-primary"></i> <i
													class="fas fa-star"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<%--             </c:if> --%>
		</nav>
	</main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
