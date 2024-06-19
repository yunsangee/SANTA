<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Keywords</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function(){
    	$('.btn-search-keyword').on('click',function(){
    		console.log($(this).text());
    		//console.log($($(this).parent()).find('button').val());
    		
    		//buttonValue = $($(this).parent()).find('button');
    		buttonValue = $($(this).parent());
    		
    		//console.log($(this).data);
    		
    		 const mountainSearch = {
    		                userNo: buttonValue.data('user-no'),
    		                searchCondition: buttonValue.data('search-condition'),
    		                searchKeyword: buttonValue.data('search-keyword'),
    		            locationNo: buttonValue.data('location-no'),
    		            altitudeNo: buttonValue.data('altitude-no'),
    		            difficultyNo: buttonValue.data('difficulty-no')
    		        };
    		 
    		 const form = $('<form>', {
    	            action: '/mountain/mapMountain',
    	            method: 'POST'
    	        });

    	        // mountainSearch 객체의 각 데이터를 폼의 hidden input 필드로 추가
    	        $.each(mountainSearch, function(key, value) {
    	            $('<input>').attr({
    	                type: 'hidden',
    	                name: key,
    	                value: value
    	            }).appendTo(form);
    	        });

    	        // 폼을 body에 추가하고 제출
    	        form.appendTo('body').submit();
    	});
    	
    	
    	$('.btn-popular-keyword').on('click',function(){
    		console.log('??');
    		console.log($(this).text());
    		
    		const form = $('<form>', {
	            action: '/mountain/mapMountain',
	            method: 'POST'
	        });

	        // mountainSearch 객체의 각 데이터를 폼의 hidden input 필드로 추가
	    
	            $('<input>').attr({
	                type: 'hidden',
	                name: 'searchKeyword',
	                value: $(this).text().trim()
	            }).appendTo(form);

	        // 폼을 body에 추가하고 제출
	        form.appendTo('body').submit();
    		
    	});
    	$('#mapSearch').on('click',function(){
        	window.location.href = 'http://${javaServerIp}/mountain/mapMountain';
        });
    	
    	$('#search').on('click',function(){
    		const form = $('<form>', {
	            action: '/mountain/mapMountain',
	            method: 'POST'
	        });

	        // mountainSearch 객체의 각 데이터를 폼의 hidden input 필드로 추가
	    
	            $('<input>').attr({
	                type: 'hidden',
	                name: 'searchKeyword',
	                value: $('#searchBox').val().trim()
	            }).appendTo(form);

	        // 폼을 body에 추가하고 제출
	        form.appendTo('body').submit();
    	});
    	
    	
    	$('.deleteSearchKeyword').on('click', function(){
    		
    		console.log($(this).html());
    		
    		let buttonValue = $(this).parent();
    		let clickedElement = $(this);
    		
    		const mountainSearch = {
		                userNo: buttonValue.data('user-no'),
		                searchKeyword: buttonValue.data('search-keyword'),
		            	searchDate : buttonValue.data('search-date')
		        };
    		 
    		 console.log(mountainSearch);
		 
    		$.ajax({
          		url: "/mountain/rest/deleteSearchKeyword",
          		type:"POST",
          		contentType: "application/json",
  	            dataType: "json",
          		data : JSON.stringify(mountainSearch),
          		success: function(response,status){
          			clickedElement.parent().remove();
          			
          		},
          	});  
		});
    });
    </script>
     <style>
        .styled-line {
            border-top: 2px solid #77C043; /* Add to cart 버튼과 동일한 색상 */
        }
        
        .title-style{
        	color: #77C043;
        
        }

        .btn-grid {
            margin-bottom: 5px;
        }
        
        .btn-keyword {
        margin-right: 15px; /* 각 버튼 간격 추가 */
    	}
    	
    	 .header {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>

	<header>
    	<c:import url="../common/top.jsp"/>
    </header>
	
	
	<main>

		<div class="container-fluid testimonial py-5" style="margin-top:20px;">
				<div class="container py-3">
					<div class="search-container" style="display: flex; justify-content: center; align-items: center; margin-top: 30px; margin-bottom: 10px;">
                            <input id="searchBox" type="text" placeholder="검색" style="flex: 1; padding: 10px; border: none; outline: none; border: 1px solid #ccc; border-radius: 5px; padding: 10px;">
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                                <i class="fas fa-search text-primary" id="search"></i>
                            </button>
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white" style="background: none; border: none; cursor: pointer; margin-left: 1px;">
                                <i class="fas fa-map text-primary" id="mapSearch"></i>
                            </button>
                       </div>
				
				</div>
				
				<div class="container py-1">
       				 <hr class="styled-line">
    			</div>
				
			<div id="searchReord" class="container py-3">
				<div class="header">
        			<h3 class="title-style">검색 기록</h3>
            			<!-- <input type="checkbox" id="toggleButton" data-toggle="toggle"> -->
    			</div>
    
            		<c:forEach var="searchKeyword" items="${mountainSearchKeywords}" varStatus="status">
                    		<button 
            class="btn border border-secondary rounded-pill px-2 text-primary" 
            data-user-no="${searchKeyword.userNo}" 
            data-search-condition="${searchKeyword.searchCondition}"
            data-search-keyword="${searchKeyword.searchKeyword}"
            data-search-date="${searchKeyword.searchDate}"
            data-current-page="${searchKeyword.currentPage}"
            data-page-unit="${searchKeyword.pageUnit}"
            data-page-size="${searchKeyword.pageSize}"
            data-location-no="${searchKeyword.locationNo}"
            data-altitude-no="${searchKeyword.altitudeNo}"
            data-difficulty-no="${searchKeyword.difficultyNo}">
            <i class="fa fa-mountain me-2 text-primary btn-search-keyword">${searchKeyword.searchKeyword}</i>
            <i class="fas fa-times close-icon deleteSearchKeyword"></i>
        </button>
        

                		<c:if test="${status.index == 9}">
                    		<div class="row" style="margin-bottom: 5px;"></div>
                		</c:if>
            		</c:forEach>

    		</div>
    		
    		<div class="container py-1">
       				 <hr class="styled-line">
    			</div>
				
			<div class="container py-3">
    			<h3 class="title-style">인기 검색어</h3>
            		<c:forEach var="searchKeyword" items="${popularSearchKeywords}" varStatus="status">
                    		<button class="btn border border-secondary rounded-pill px-2 text-primary btn-popular-keyword">
                        		<i class="fa fa-mountain me-2 text-primary">${searchKeyword}</i>
                    		</button>

                		<c:if test="${status.index == 9}">
                    		<div class="row" style="margin-bottom: 5px;"></div>
                		</c:if>
            		</c:forEach>

    		</div>

		</div>
		
		
	</main>
	
	
	
	<footer><c:import url="../common/footer.jsp"/></footer>

</body>