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
	        $("#searchForm").attr("action", "/meeting/getMeetingPostList").submit();
	    }
		
		function updateCategory(selectElement) {
	        var form = document.getElementById('searchForm');
	        var currentPageInput = document.getElementById('currentPage');
	        currentPageInput.value = 1; // 카테고리 변경 시 첫 페이지로 이동
	        form.action = 'getMeetingPostList?meetingPostListSearchCondition=' + selectElement.value;
	        form.submit();
	    }
	
	    function goToPage(pageNumber) {
	        var form = document.getElementById('searchForm');
	        var currentPageInput = document.getElementById('currentPage');
	        currentPageInput.value = pageNumber;
	        form.submit();
	    }
    
	    $(function() {
	    	
	        $('.postSearch').click(function() {
	            fncGetList(1); // 검색 버튼 클릭 시 1페이지로 설정
	        });
	
	        $('.postListSearch').change(function() {
	            fncGetList(1); // 카테고리 변경 시 1페이지로 설정
	        });
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
				                    	<p class="mb-4 mt-4">${post.title}</p>
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
	    		</div>
	    	</div>
	    </div>
	
	    <form id="searchForm" action="getMeetingPostList" method="post">
	        <div>
	            <select name="searchCondition">
	                <option value="0" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 0 ? 'selected' : ''}>게시글 제목</option>
	                <option value="1" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 1 ? 'selected' : ''}>게시글 내용</option>
	                <option value="2" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 2 ? 'selected' : ''}>유저 닉네임</option>
	            </select>
	            <input type="text" name="searchKeyword" value="${! empty meetingPostSearch.searchKeyword ? meetingPostSearch.searchKeyword : '' }">
	            <button type="button" class="postSearch">검색</button>
	            <input type="hidden" id="currentPage" name="currentPage" value="${meetingPostSearch.currentPage}">
	        </div>
	
	        <div>
	            <select class="postListSearch" name="meetingPostListSearchCondition" onchange="fncGetList(1);">
	                <option value="0" ${! empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition == 0 ? 'selected' : ''}>모임 게시글 목록</option>
	                <option value="1" ${! empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition == 1 ? 'selected' : ''}>내가 쓴 게시글 목록</option>
	                <option value="2" ${! empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition == 2 ? 'selected' : ''}>신청한 게시글 목록</option>
	                <option value="3" ${! empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition == 3 ? 'selected' : ''}>등록된 게시글 목록</option>
	                <option value="4" ${! empty meetingPostSearch.meetingPostListSearchCondition && meetingPostSearch.meetingPostListSearchCondition == 4 ? 'selected' : ''}>좋아요한 게시글 목록</option>
	                <!-- 다른 옵션들도 추가 -->
	            </select>
	        </div>
	    </form>
	
	    <table border="1">
	        <thead>
	            <tr>
	                <th>순번</th>
	                <th>작성자</th>
	                <th>제목</th>
	                <th>모집상태</th>
	                <th>작성일자</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="post" items="${meetingPosts}">
	                <tr>
	                    <td>${post.postNo}</td>
	                    <td>${post.nickName}</td>
	                    <td>${post.title}</td>
	                    <td>${post.recruitmentStatus}</td>
	                    <td>${post.postDate}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	
	    <div class="pagination">
	        <c:if test="${resultPage.maxPage > 1}">
	            <c:forEach begin="1" end="${resultPage.maxPage}" var="i">
	                <a href="javascript:fncGetList(${i})" class="${resultPage.currentPage == i ? 'active' : ''}">${i}</a>
	            </c:forEach>
	        </c:if>
	    </div>
	
	    <form action="/meeting/addMeetingPost" method="get">
	        <button type="submit">글쓰기</button>
	    </form>
    
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>

</body>
</html>
