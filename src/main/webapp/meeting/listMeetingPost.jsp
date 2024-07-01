<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>모임 게시글 목록</title>
    <c:import url="../common/header.jsp"/>
    
    <script type = "text/javascript">
    
	    function fncGetList(currentPage) {
	        $("#currentPage").val(currentPage);
	        $("#searchForm").attr("method" , "POST").attr("action", "/meeting/getMeetingPostList").submit();
	    }
		
	    function goToPage(pageNumber) {
	        var form = document.getElementById('searchForm');
	        var currentPageInput = document.getElementById('currentPage');
	        currentPageInput.value = pageNumber;
	        form.submit();
	    }
	    
    
	    $(function() {
	
	    	$('#meetingPostListSearchCondition').change(function() {
	    		
	            $('#searchCondition').val(0);
	            $('#searchKeyword').val('');
	            fncGetList(1);
	        });
	        
	        $('#searchButton').click(function() {
	        	
                fncGetList(1); // 아이콘 클릭 시 fncGetList(1) 호출
            });
	        
	        $('#searchKeyword').keydown(function(event) {
	        	
	            if (event.key === "Enter") {
	                event.preventDefault();
	                $('#searchButton').click(); // 엔터 키를 누르면 searchButton 클릭
	            }
	        });
	        
            
            $('#writePostButton').click(function() {
            	self.location = "/meeting/addMeetingPost";
            })
            
            $("div.previous").on("click", function() {
				
				if ($(this).attr("class") == "previous disabled") {
					return;
				} else {
					fncGetList(${ resultPage.beginUnitPage-1});
				}
			})
			
			$("div.next").on("click", function() {
				
				if ($(this).attr("class") == "next disabled") {
					return;
				} else {
					fncGetList(${resultPage.endUnitPage+1})
				}
			})
            
            
	    });
	    
    
    </script>
    
    <style>
        /* 스타일링을 여기에 추가하세요 */
        .pagination a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
        }
        .pagination a.active {
            background-color: dodgerblue;
            color: white;
        }
        .pagination a:hover:not(.active) {background-color: #ddd;}
        
        .active> a {
        	background-color: #81c408 !important;
        }
        
        .disabled {
		    pointer-events: none;
		    cursor: not-allowed;
		    opacity: 0.5;
		}
		
    </style>
    
</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
	<main>
	
		<div class="container-fluid page-header py-5">
    		<h1 class="text-center text-white display-6">Meeting Post List</h1>
    	</div>
    	
    	<div class="container-fluid py-5">
    		<div class="container py-5">
	    		<form id="searchForm" class="col-md-12">
	    		
	    			<div class="row g-4 mb-5 align-items-center">
	    			
	    				<div class="col-md-2 offset-md-1">
	    					<select class="form-control border-2 border-secondary rounded-pill py-2" id="searchCondition" name="searchCondition">
	    						<option value="0" ${ !empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition==0 ? "selected" : "" }>제목</option>
	                           	<option value="1" ${ !empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition==1 ? "selected" : "" }>내용</option>
	                           	<option value="2" ${ !empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition==2 ? "selected" : "" }>닉네임</option>
	    					</select>
	    				</div>
	    				
	    				<div class="col-md-5">
	    					<input type="text" id="searchKeyword" name="searchKeyword" value="${! empty meetingPostSearch.searchKeyword ? meetingPostSearch.searchKeyword : '' }" placeholder="검색어 입력" class="form-control border-2 border-secondary rounded-pill py-2">
	    				</div>
	    				
	    				<div class="col-md-1">
	    					<button id="searchButton" class="btn btn-primary border-2 border-secondary rounded-pill text-white" style="height: 45px;">
						    	<i class="fas fa-search"></i>
							</button>
	    				</div>
	    				
	    				<div class="col-md-2">
	    					<select class="form-control border-2 border-secondary rounded-pill py-2" id="meetingPostListSearchCondition" name="meetingPostListSearchCondition">
	    						<option value="0" ${ !empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition==0 ? "selected" : "" }>전체 게시글</option>
	                           	<option value="1" ${ !empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition==1 ? "selected" : "" }>내가 쓴 게시글</option>
	                           	<option value="2" ${ !empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition==2 ? "selected" : "" }>모임 신청한 게시글</option>
	                           	<option value="3" ${ !empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition==3 ? "selected" : "" }>모임 등록된 게시글</option>
	                           	<option value="4" ${ !empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition==4 ? "selected" : "" }>좋아요 한 게시글</option>
	    					</select>
	    				</div>
	
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
	    			</div>
	    			
	    		</form>
	    		
	    		<div class="row g-4 mb-2">
    				
		    		<div class="table-responsive">
		    			<table class="table">
		    				<thead>
		    					<tr>
		    						<th scope="col">순번</th>
		    						<th scope="col">작성자</th>
		    						<th scope="col">제목</th>
		    						<th scope="col">등산 예정 산</th>
		    						<th scope="col">모집상태</th>
		    						<th scope="col">작성일자</th>
		    					</tr>
		    				</thead>
		    				<tbody>
		    				
		    				<c:set var="itemsPerPage" value="${resultPage.pageSize}"/>
							<c:set var="currentPage" value="${resultPage.currentPage}"/>
		    				
		    					<c:forEach var="post" items="${meetingPosts}" varStatus="status">
					                <tr>
					                    <td>
					                    	<p class="mb-4 mt-4">${status.index + 1 + (currentPage - 1) * itemsPerPage}</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">
					                    		<a href="/certificationPost/getProfile?userNo=${post.userNo}">${post.nickName}</a>
					                    	</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">
					                    		<a href="/meeting/getMeetingPost?postNo=${post.postNo}">${post.title}</a>
					                    	</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">
					                    		<p class="mb-4 mt-4">${post.appointedHikingMountain}</p>
					                    	</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">
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
					            </c:forEach>
		    				</tbody>
		    			</table>
		    		</div> <!-- table-responsive -->
		    		
		    	</div> <!-- row g-4 mb-5 -->
		    	
		    	<div class="row g-4 mb-5">
		    		<div class="d-flex justify-content-end">
		    			<button class="btn btn-primary py-2 px-4 text-white" id="writePostButton">글쓰기</button>
		    		</div>
		    	</div> <!-- row g-4 mb-5 -->
		    	
		    	<div class="row g-4">
		    		<div class="pagination d-flex justify-content-center">
		    		
		    			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
					 		<div class="previous disabled">
						</c:if>
						<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
							<div class="previous">
						</c:if>
								<a href="#" aria-label="Previous" class="rounded">
							        <span aria-hidden="true">
							        	&laquo;
							        </span>
							    </a>
						    </div>
		    			
		    			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
							<c:if test="${ resultPage.currentPage == i }">
								<!--  현재 page 가르킬경우 : active -->
							    <div class="active">
							    	<a href="javascript:fncGetList('${ i }');" class="rounded">
							    		${ i }
							    		<span class="sr-only">
							    			(current)
							    		</span>
							    	</a>
							    </div>
							</c:if>	
							
							<c:if test="${ resultPage.currentPage != i}">	
								<div>
									<a href="javascript:fncGetList('${ i }');" class="rounded">
										${ i }
									</a>
								</div>
							</c:if>
							
						</c:forEach>
						
						<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
					  		<div class="next disabled">
						</c:if>
						<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
							<div class ="next">
						</c:if>
					    		<a href="#" aria-label="Next" class="rounded">
					        		<span aria-hidden="true">
					        			&raquo;
					        		</span>
					    		</a>
					    	</div>
						</div>
		    			
		    		</div>
		    	</div>
		    	
	    	</div> <!-- container py-5 -->
	    </div> <!-- container-fluid py-5 -->
    
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>

</body>
</html>
