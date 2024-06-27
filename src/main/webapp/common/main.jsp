<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
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
                
                
                var swiper2 = new Swiper('.swiper2-container', {
                    slidesPerView: 3,  // 한 슬라이드에 보여줄 카드 수
                    spaceBetween: 20,
                    navigation: {
                        nextEl: '.certification-button-next-cp',
                        prevEl: '.certification-button-prev-cp',
                    },
                    pagination: {
                        el: '.swiper-pagination-cp',
                        clickable: true,
                    },
                });
                
                
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
                    	
                    	let likeCount= 0;
                    	
                    	if(clickedElement.hasClass('popular')){
                   		 isPop = 1;
                   		 }
                    	
                    	if(clickedElement.hasClass('fas')){
                    	 
                    		
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
                    			likeCount = response;
                    			if(isPop == 1){
                            		$('.custom.post-'+mountainLike.postNo).text(likeCount);
                            		$('.custom.post-'+mountainLike.postNo).toggleClass('fas far');
                            	}else{
                            		$('.popular.post-'+mountainLike.postNo).text(likeCount);
                            		$('.popular.post-'+mountainLike.postNo).toggleClass('fas far');
                            	}
                    			
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
                         			likeCount = response;
                         			if(isPop == 1){
                                		$('.custom.post-'+mountainLike.postNo).text(likeCount);
                                		$('.custom.post-'+mountainLike.postNo).toggleClass('fas far');
                                	}else{
                                		$('.popular.post-'+mountainLike.postNo).text(likeCount);
                                		$('.popular.post-'+mountainLike.postNo).toggleClass('fas far');
                                	}
                         		},
                         	}); 
                    	}
                    	
                    	
                    	
                    	
                	}
                });

        });
        
        $(function(){
        	/* $('#logoName').on('click', function(){
                self.location = '/';
            }); */
            
            $('#search').on('click',function(event){
            	event.preventDefault();
            	window.location.href = '/mountain/searchMountain';
            });
            
            $('#searchBox').on('click',function(event){
            	event.preventDefault();
            	window.location.href = '/mountain/searchMountain';
            });
            
            $('#mapSearch').on('click',function(event){
            	event.preventDefault();
            	window.location.href = '/mountain/mapMountain';
            });

            $('.fa-external-link-alt , .mountainName').on('click',function(){
            	console.log($($(this).parent()).text());
            	var h4Value = $($(this).parent()).text().trim();
            	console.log(h4Value);
            	
            	window.location.href = "/mountain/mapMountain?searchCondition=0&searchKeyword=" + h4Value;
            });
            
            $('.mountainImage').on('click', function(){
            	let mountainName = $(this).parent().parent().children().find('h4').text().trim();
            	console.log(mountainName);
            	window.location.href = "/mountain/mapMountain?searchCondition=0&searchKeyword=" + mountainName;
            });
            
            $(".top-button").click(function() {
                $('html, body').animate({scrollTop: 0}, 'slow');
            });
            
            $(".moreMeetingPost").on('click',function(event){
            	event.preventDefault();
				window.location.href = '/meeting/getMeetingPostList';
            });
            
            
			$(".moreCertificationPost").on('click',function(event){
				event.preventDefault();
				window.location.href = '/certificationPost/listCertificationPost';
            });
			
			 $(document).on('click', '.certification-post', function() {
			        var postNo = $(this).children().find('.certificationPostNo').text().trim();
			        console.log(postNo);
			        window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
			 });
			 
			 $(".postNickName").on("click", function(){
				let userNo = $(this).parent().find('input[name="userNo"]').val();
				console.log(userNo);
				window.location.href="/certificationPost/getProfile?userNo="+userNo;
			 });
           

            // Like button toggle
           
        });
    </script>
    
    <style>
        .testimonial-item {
        	width:100%;
            position: relative;
        }

         .swiper-container {
            position: relative;
        }
        
        .swiper2-container {
            margin:0px;
            position: relative;
        }
        .swiper-pagination {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
        }
        .swiper-pagination-cp {
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
        
        .swiper-button-next-cp,
        .swiper-button-prev-cp {
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
            margin:5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 150px;
            height:300px;
            flex: 1;
            display:flex;
            position:relative;
        
        }
        
        .custom-testimonial-item{
        	text-align: left;
            padding: 10px;
            margin:5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            min-width: 150px;
            height:300px;
            
            flex: 1;
            display:flex;
            position:relative;
        }
        
        
        .table-responsive{
        	text-align: left;
            border: 1px solid #ddd;
            border-radius: 5px;
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
    .swiper2-container {
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 15px;
    width: 100%; /* 전체 너비로 설정 */
    height: 500px;

    overflow: hidden; /* 내용이 넘치는 경우를 대비하여 오버플로우를 숨김 */
    }


.fixed-buttons {
    position: fixed;
    bottom: 20px;
    right: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.btn-cp {
    border: 2px solid orange;
    background-color: white;
    color: limegreen;
    width: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(0,0,0,0.3);
    transition: transform 0.2s;
}
.btn-cp:hover {
    transform: scale(1.1);
}
.btn-cp .fa {
    font-size: 0.75em;
}

.certification-post img {
    width: 100%;
    height: 200px;
}
.certification-post .details {
}

.certification-post-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}
.certification-post {
	margin-buttom:5px;
    border: 1px solid #ccc;
    border-radius: 10px;
    overflow: hidden;
    width: 200px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
    cursor: pointer;
}

.table-header{
	display: flex; 
	justify-content: space-between; 
	align-items: center;
}

.container-fluid .meetingPost{
	padding: 0 !important;

}

.section-container {
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left:12px;
    padding-right:12px;
    margin-top: 20px;
    margin-bottom: 20px;
}


.py-5 {
    padding-top: 20px !important;
    padding-bottom: 20px !important;
}

.first-container{
	margin-top:90px;

}

    </style>
</head>

<body>
    <header><c:import url="./top.jsp"/></header>
    
    
    <main>

<nav>

<div class="container-fluid testimonial first-container" >
    <div class="container py-5">
    <div class="row g-4 mb-5">
        <div class="search-container" style="display: flex; justify-content: center; align-items: center; margin-top: 30px; margin-bottom: 20px;">
            <input id="searchBox" type="text" placeholder="검색" style="flex: 1; padding: 10px; border: none; outline: none; border: 1px solid #ccc; border-radius: 5px; padding: 10px;">
            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                <i class="fas fa-search text-primary" id="search"></i>
            </button>
            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white" style="background: none; border: none; cursor: pointer; margin-left: 1px;">
                <i class="fas fa-map text-primary" id="mapSearch"></i>
            </button>
        </div>
        <div class="testimonial-header text-left" style="margin-top:10px;">
            <h4 class="text-primary">인기산 목록</h4>
        </div>
        <div class="swiper-container popular-swiper-container">
            <div class="swiper-wrapper">
                <c:forEach var="mountain" items="${popularMountainList}" varStatus="index">
                    <div class="swiper-slide">
                        <div class="popular-testimonial-item img-border-radius rounded p-4">
                            <div class=" rounded">
                                <img src="${mountain.mountainImage}" class="img-fluid rounded mountainImage" style="width: 250px; height: 150px;" alt="">
                            </div>
                            <div class="ms-3 d-block" style="flex-grow: 1;">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-dark mb-0 mountainName">${mountain.mountainName}</h4>
                                    <i class="fas fa-external-link-alt"></i>
                                </div>
                                <p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
                                <p class="m-0 pb-3">${mountain.mountainAltitude}</p>
                                <p class="m-0 pb-3">
                                    <i class="${mountain.isLiked == 1 ? 'fas' : 'far'} fa-heart popular like-button post-${mountain.mountainNo}" style="cursor: pointer;">${mountain.likeCount}</i>
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
</div>

<!-- Second Carousel -->
			<div class="container-fluid testimonial section-container">
    <div class="container py-5">

        <div class="testimonial-header text-left">
            <h4 class="text-primary">사용자 맞춤 산 목록</h4>
        </div>
        <div style="height:20px;"></div>
        <div class="row g-4 mb-5" >
        <div class="swiper-container custom-swiper-container">
            <div class="swiper-wrapper">
                <c:forEach var="mountain" items="${customMountainList}" varStatus="index">
                    <div class="swiper-slide">
                        <div class="custom-testimonial-item img-border-radius rounded p-4">
                            <div class="rounded">
                                <img src="${mountain.mountainImage}" class="img-fluid rounded mountainImage" style="width: 250px; height: 150px;" alt="">
                            </div>
                            <div class="ms-3 d-block" style="flex-grow: 1;">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-dark mb-0 mountainName">${mountain.mountainName}</h4>
                                    <i class="fas fa-external-link-alt"></i>
                                </div>
                                <p class="m-0 pb-3" style="font-size: 0.75em;">${mountain.mountainLocation}</p>
                                <p class="m-0 pb-3">${mountain.mountainAltitude}m</p>
                                <p class="m-0 pb-3">
                                    <i class="${mountain.isLiked == 1 ? 'fas' : 'far'} fa-heart custom like-button post-${mountain.mountainNo}" style="cursor: pointer;">${mountain.likeCount}</i>
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
        </div>
	</div></div>

			<div class="container-fluid testimonial section-container">
	<div class="container-fluid py-5 meetingPostr">
    		<div class="container py-5">
    			<div class="table-header text-center">
            			<h4 class="text-primary">모임 모집  목록</h4>
            			
            			<div class="moreMeetingPost">
            			더보기
            			<i class="fas fa-chevron-right"></i>
            			</div>
       				</div>
    			<div class="row g-4 ms-1 mb-5">
    				
       				
		    		<div class="table-responsive">
		    			<table class="table">
		    				<thead>
		    					<tr>
		    						<th scope="col">순번</th>
		    						<th scope="col">작성자</th>
		    						<th scope="col">제목</th>
		    						<th scope="col">모집상태</th>
		    						<th scope="col">작성일자</th>
		    					</tr>
		    				</thead>
		    				<tbody>
		    					<c:forEach var="post" items="${meetingPostList}" varStatus="status">
    <c:if test="${status.index < 10}">
        <tr>
            <td>
                <p class="mb-4 mt-4">${post.postNo}</p>
            </td>
            <td>
                <p class="mb-4 mt-4 postNickName"> <a href="#">${post.nickName}</a>
                	<input type="hidden" name="userNo" value="${post.userNo}"/>
                </p>
                
            </td>
            <td>
                <p class="mb-4 mt-4">
                    <a href="/meeting/getMeetingPost?postNo=${post.postNo}">${post.title}</a>
                </p>
            </td>
            <td>
                <p class="mb-4 mt-4 link">
                    <c:choose>
                        <c:when test="${post.recruitmentStatus == 0}">
                            모집중
                        </c:when>
                        <c:when test="${post.recruitmentStatus == 1}">
                            모집종료
                        </c:when>
                        <c:when test="${post.recruitmentStatus == 2}">
                            모임종료
                        </c:when>
                    </c:choose>
                </p>
            </td>
            <td>
                <p class="mb-4 mt-4">${post.postDate}</p>
            </td>
        </tr>
    </c:if>
</c:forEach>

		    				</tbody>
		    			</table>
		    		</div> <!-- table-responsive -->
		    	
		    	</div> <!-- row g-4 mb-5 -->
	    	</div> <!-- container py-5 -->
	    </div> <!-- container-fluid py-5 -->
	</div>

	   <div class="container-fluid py-5 certificationPost section-container">
    <div class="container py-5">
    	<div class="row g-4 mb-5">
    		<div class="table-header text-center">
            	<h4 class="text-primary">인증 게시글 목록</h4>
            	<div class="moreCertificationPost">
            			더보기
            			<i class="fas fa-chevron-right"></i>
            		</div>
       		</div>
   
            <div class="swiper2-container certification-swiper py-3">
                <div class="swiper-wrapper">
                    <c:forEach var="certificationPost" items="${certificationPostList}" varStatus="status">
                        <c:if test="${status.index < 10}">
                            <div class="swiper-slide certification-post" data-postno="${certificationPost.postNo}">
                                <div class="fruite-img">
                                    <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
                                </div>
                                <div class="details">
                                    <h4 class='certificationPostNo'>${certificationPost.postNo}</h4>
                                    <h4>${certificationPost.title}</h4>
                                    <p>산명칭 : ${certificationPost.certificationPostMountainName}</p>
                                    <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
                                    <p>좋아요수: ${certificationPost.certificationPostLikeCount}</p>
                                    <p>등산난이도 :
                                        <c:choose>
                                            <c:when test="${certificationPost.certificationPostHikingDifficulty == 0}">
                                                어려움
                                            </c:when>
                                            <c:when test="${certificationPost.certificationPostHikingDifficulty == 1}">
                                                중간
                                            </c:when>
                                            <c:when test="${certificationPost.certificationPostHikingDifficulty == 2}">
                                                쉬움
                                            </c:when>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination-cp custom-swiper-pagination"></div>
            <!-- Add Navigation -->
            <div class="swiper-button-next custom-swiper-button-next certification-button-next-cp"></div>
            <div class="swiper-button-prev custom-swiper-button-prev certification-button-prev-cp"></div>
            </div>
        </div>
        </div>
    </div>
	</nav>
	</main>
	<div class="fixed-buttons">
        <button class="btn-cp top-button"><i class="fa fa-arrow-up"></i></button>
    </div>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
