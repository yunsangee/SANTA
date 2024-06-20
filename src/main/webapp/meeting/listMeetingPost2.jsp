<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <title>모임 게시글 목록</title>
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
    
    <script type = "text/javascript">
    
	    $(document).ready(function() {
	        $('.search1').click(function() {
	            fncGetList(1); // 검색 버튼 클릭 시 1페이지로 설정
	        });
	
	        $('.search2').change(function() {
	            fncGetList(1); // 카테고리 변경 시 1페이지로 설정
	        });
	    });
    
    	function fncGetList(currentPage) {
            $("#currentPage").val(currentPage);
            $("#searchForm").attr("action", "/meeting/getMeetingPostList/").submit();
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
    
    </script>
</head>
<body>
    <form id="searchForm" action="getMeetingPostList" method="post">
        <div>
            <select name="searchCondition">
                <option value="0" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 0 ? 'selected' : ''}>게시글 제목</option>
                <option value="1" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 1 ? 'selected' : ''}>게시글 내용</option>
                <option value="2" ${! empty meetingPostSearch.searchCondition && meetingPostSearch.searchCondition == 2 ? 'selected' : ''}>유저 닉네임</option>
            </select>
            <input type="text" name="searchKeyword" value="${! empty meetingPostSearch.searchKeyword ? meetingPostSearch.searchKeyword : '' }">
            <button type="button" class="search1">검색</button>
            <input type="hidden" id="currentPage" name="currentPage" value="${meetingPostSearch.currentPage}">
        </div>

        <div>
            <select class="search2" name="meetingPostListSearchCondition" onchange="fncGetList(1);">
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

</body>
</html>
