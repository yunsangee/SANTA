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
	
	        $('.postListSearch').change(function() {
	            fncGetList(1); // 카테고리 변경 시 1페이지로 설정
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
	        
	        $('#titleOption').click(function() {
	        	event.preventDefault();
                $('#searchCondition').val(0);
                $('#dropdownMenuButton').text('제목');
            });

            $('#contentOption').click(function() {
            	event.preventDefault();
                $('#searchCondition').val(1);
                $('#dropdownMenuButton').text('내용');
            });

            $('#nicknameOption').click(function() {
            	event.preventDefault();
                $('#searchCondition').val(2);
                $('#dropdownMenuButton').text('닉네임');
            });
            
            $('#allPostsOption').click(function() {
                $('#meetingPostListSearchCondition').val(0);
                $('#searchCondition').val(0);
                $('#searchKeyword').val('');
                fncGetList(1);
            });

            $('#myPostsOption').click(function() {
                $('#meetingPostListSearchCondition').val(1);
                $('#searchCondition').val(0);
                $('#searchKeyword').val('');
                fncGetList(1);
            });

            $('#appliedPostsOption').click(function() {
                $('#meetingPostListSearchCondition').val(2);
                $('#searchCondition').val(0);
                $('#searchKeyword').val('');
                fncGetList(1);
            });

            $('#registeredPostsOption').click(function() {
                $('#meetingPostListSearchCondition').val(3);
                $('#searchCondition').val(0);
                $('#searchKeyword').val('');
                fncGetList(1);
            });

            $('#likedPostsOption').click(function() {
                $('#meetingPostListSearchCondition').val(4);
                $('#searchCondition').val(0);
                $('#searchKeyword').val('');
                fncGetList(1);
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
    			<div class="row g-4 mb-2">
    			
	    			<form id="searchForm">
	    			
	    				<div class="input-group w-100 mx-auto d-flex mb-4">
	    				
	    					<div class="nav-item dropdown">
	                            <a href="#" id="dropdownMenuButton" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
	                            	<c:choose>
							            <c:when test="${meetingPostSearch.searchCondition == 0}">
							                제목
							            </c:when>
							            <c:when test="${meetingPostSearch.searchCondition == 1}">
							                내용
							            </c:when>
							            <c:when test="${meetingPostSearch.searchCondition == 2}">
							                닉네임
							            </c:when>
							        </c:choose>
	                            </a>
	                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
	                                <a href="#" class="dropdown-item searchCondition" data-condition="0" id="titleOption">제목</a>
	                                <a href="#" class="dropdown-item searchCondition" data-condition="1" id="contentOption">내용</a>
	                                <a href="#" class="dropdown-item searchCondition" data-condition="2" id="nicknameOption">닉네임</a>
	                            </div>
	                        </div>
	                        
	                        <input type="hidden" id="searchCondition" name="searchCondition" value="${! empty meetingPostSearch.searchCondition ? meetingPostSearch.searchCondition : 0}">
		                    
	    					<input type="text" class="form-control p-3" placeholder="검색어 입력" id="searchKeyword" name="searchKeyword"
	    					 aria-describedby="searchButton" value="${! empty meetingPostSearch.searchKeyword ? meetingPostSearch.searchKeyword : '' }">
	    					 
	    					<span id="searchButton" class="input-group-text p-3">
	    						<i class="fa fa-search"></i>
	    					</span>
	    					
	    					<!-- pagenation -->
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
	    					
	    					<div class="nav-item dropdown">
	                            <a href="#" id="dropdownMenuButton2" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
	                            	<c:choose>
							            <c:when test="${meetingPostSearch.meetingPostListSearchCondition == 0}">
							                전체 게시글
							            </c:when>
							            <c:when test="${meetingPostSearch.meetingPostListSearchCondition == 1}">
							                내가 쓴 게시글
							            </c:when>
							            <c:when test="${meetingPostSearch.meetingPostListSearchCondition == 2}">
							                모임 신청한 게시글
							            </c:when>
							            <c:when test="${meetingPostSearch.meetingPostListSearchCondition == 3}">
							                모임 등록된 게시글
							            </c:when>
							            <c:when test="${meetingPostSearch.meetingPostListSearchCondition == 4}">
							                좋아요 한 게시글
							            </c:when>
							        </c:choose>
	                            </a>
	                            <div class="dropdown-menu m-0 bg-secondary rounded-0">
	                                <a href="#" class="dropdown-item listSearchCondition" data-list-condition="0" id="allPostsOption">전체 게시글</a>
	                                <a href="#" class="dropdown-item listSearchCondition" data-list-condition="1" id="myPostsOption">내가 쓴 게시글</a>
	                                <a href="#" class="dropdown-item listSearchCondition" data-list-condition="2" id="appliedPostsOption">모임 신청한 게시글</a>
	                                <a href="#" class="dropdown-item listSearchCondition" data-list-condition="3" id="registeredPostsOption">모임 등록된 게시글</a>
	                                <a href="#" class="dropdown-item listSearchCondition" data-list-condition="4" id="likedPostsOption">좋아요 한 게시글</a>
	                            </div>
	                        </div>
	                        
	                        <input type="hidden" id="meetingPostListSearchCondition" name="meetingPostListSearchCondition" value="${! empty meetingPostSearch.meetingPostListSearchCondition ? meetingPostSearch.meetingPostListSearchCondition : 0}">
	                        
	    				</div>
	    				
	    			</form>
    				
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
		    					<c:forEach var="post" items="${meetingPosts}">
					                <tr>
					                    <td>
					                    	<p class="mb-4 mt-4">${post.postNo}</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">${post.nickName}</p>
					                    </td>
					                    <td>
					                    	<p class="mb-4 mt-4">
					                    		<a href="/meeting/getMeetingPost?postNo=${post.postNo}">${post.title}</a>
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
