<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
   
    <title>User List</title>
 <!--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

<style>
    .tabs {
        display: flex;
        border-bottom: 2px solid #eee;
        align-items: center;
        margin-bottom: -15px; /* 탭 아래 선이 목록 맨 위 선과 겹치도록 */
    }

    .tab {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        text-align: center;
        color: #81C408;
        border-bottom: 2px solid transparent;
        margin-right: 10px;
    }

    .tab.active {
        border-bottom: 2px solid #FFA500;
        color: #FFA500;
    }

    .tab:hover {
        color: #DEFBA7;
    }

    .pagination {
        justify-content: center;
        margin-top: 20px;
    }

    .pagination a {
        margin: 0 5px;
        padding: 10px;
        border: 1px solid #81C408;
        border-radius: 5px;
        text-decoration: none;
        color: #81C408;
        width: 30px;
        height: 30px;
        align-items: center;
        justify-content: center;
        /* display: flex; */
    }

    .pagination a:hover {
        background-color: #DEFBA7;
    }

    .pagination .active {
        background-color: #81C408;
        color: white;
    }

    .dropdown-custom {
        padding: 7px;
        font-size: 13px;
        background-color: white;
        border: 1px solid #D4D4D4;
        border-radius: 5px;
        cursor: pointer;
        box-sizing: border-box;
        color: black;
        width: auto;
        margin-left: 10px;
    } 

    .search-input {
        padding: 7px;
        font-size: 13px;
        background-color: white;
        border: 1px solid #D4D4D4;
        border-radius: 5px;
        cursor: pointer;
        box-sizing: border-box;
        color: black;
        width: auto;
        margin-right: 10px;
        width: 200px;
    }

    .search-container {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
        flex-grow: 1;
    }

    .tabs-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

</style>

 <c:import url="../common/header.jsp"/>

<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->

<script>
    $(document).ready(function() {
        // AJAX로 검색 요청을 처리
        $('#searchForm').submit(function(event) {
            event.preventDefault(); // 폼 제출 기본 동작 방지
            var url = $(this).attr('action');
            $.ajax({
                url: url,
                type: 'GET',
                data: $(this).serialize(),
                success: function(data) {
                    var tableSelector = url.includes('withdrawUserList') ? '#withdrawUserTable' : '#userTable';
                    updateTable(data, tableSelector);
                }
            });
        });

        // Enter key를 눌렀을 때 검색 요청을 처리
        $('.search-input').keypress(function(event) {
            if (event.which == 13) { // Enter key code
                $(this).closest('form').submit();
                event.preventDefault(); // 기본 Enter key 동작 방지
            }
        });

        // 페이지 이동을 처리
        $(document).on('click', '.pagination a', function(event) {
            event.preventDefault(); // 링크 기본 동작 방지
            var page = $(this).attr('data-page');
            $('#currentPage').val(page);
            $('#searchForm').submit();
        });

        function updateTable(data, tableSelector) {
            var userTable = $(tableSelector);
            userTable.empty();
            var users = data.userList;
            $.each(users, function(index, user) {
                userTable.append(
                    '<tr data-userid="' + user.userId + '">' +
                        '<th scope="row"><div class="d-flex align-items-center"><p class="mb-0 mt-4">' + (index + 1) + '</p></div></th>' +
                        '<td><p class="mb-0 mt-4"><a href="/user/getUser?userNo=' + user.userNo + '" style="text-decoration: none; color: inherit;">' + user.userName + '</a></p></td>' +
                        '<td><p class="mb-0 mt-4"><a href="/user/getUser?userNo=' + user.userNo + '" style="text-decoration: none; color: inherit;">' + user.userId + '</a></p></td>' +
                        '<td><p class="mb-0 mt-4">' + user.nickName + '</p></td>' +
                        '<td><p class="mb-0 mt-4">' + user.creationDate + '</p></td>' +
                        '<td><p class="mb-0 mt-4">' + (user.withdrawDate ? user.withdrawDate : '') + '</p></td>' +
                    '</tr>'
                );
            });

            var pagination = $('.pagination');
            pagination.empty();
            for (var i = 1; i <= data.totalPages; i++) {
                pagination.append(
                    '<a href="javascript:void(0);" data-page="' + i + '" class="btn-custom ' + (i == data.currentPage ? 'active' : '') + '">' + i + '</a>'
                );
            }

            $('#totalUsers').text('Total Users: ' + data.totalCount + ', Users on This Page: ' + data.currentPageCount);
        }
    });
</script>

</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

    <header>
        <c:import url="../common/top.jsp"/>
    </header>
   
<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->
   
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="tabs-container">
                    <div class="tabs">
                        <c:choose>
                            <c:when test="${fn:contains(pageContext.request.requestURI, '/getUserList')}">
                                <div class="tab active" onclick="window.location.href='/user/getUserList'">회원목록</div>
                                <div class="tab" onclick="window.location.href='/user/withdrawUserList'">탈퇴회원 목록</div>
                            </c:when>
                            <c:otherwise>
                                <div class="tab" onclick="window.location.href='/user/getUserList'">회원목록</div>
                                <div class="tab active" onclick="window.location.href='/user/withdrawUserList'">탈퇴회원 목록</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="search-container">
                        <form id="searchForm" action="${fn:contains(pageContext.request.requestURI, '/getUserList') ? '/user/rest/getUserList' : '/user/rest/withdrawUserList'}" method="get" style="display: flex; align-items: center;">
                            <select name="searchCondition" class="dropdown-custom">
                                <option value="0" ${search.searchCondition == 0 ? 'selected' : ''}>User ID</option>
                                <option value="1" ${search.searchCondition == 1 ? 'selected' : ''}>Nickname</option>
                                <option value="2" ${search.searchCondition == 2 ? 'selected' : ''}>Name</option>
                            </select>
                            <input type="text" name="searchKeyword" class="form-control search-input" placeholder="Search by keyword" value="${search.searchKeyword}">
                            <input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
                        </form>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">User Name</th>
                                <th scope="col">User ID</th>
                                <th scope="col">Nick Name</th>
                                <th scope="col">Creation Date</th>
                                <th scope="col">Withdraw Date</th>
                            </tr>
                        </thead>
                        <tbody id="userTable">
                            <c:forEach var="user" items="${userList}" varStatus="status">
                                <tr data-userid="${user.userId}">
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0 mt-4">${status.index + 1}</p>
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="/user/getUser?userNo=${user.userNo}" style="text-decoration: none; color: inherit;">${user.userName}</a>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="/user/getUser?userNo=${user.userNo}" style="text-decoration: none; color: inherit;">${user.userId}</a>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.nickName}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.creationDate}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.withdrawDate != null ? user.withdrawDate : ''}</p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tbody id="withdrawUserTable">
                            <c:forEach var="user" items="${withdrawUserList}" varStatus="status">
                                <tr data-userid="${user.userId}">
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0 mt-4">${status.index + 1}</p>
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="/user/getUser?userNo=${user.userNo}" style="text-decoration: none; color: inherit;">${user.userName}</a>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="/user/getUser?userNo=${user.userNo}" style="text-decoration: none; color: inherit;">${user.userId}</a>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.nickName}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.creationDate}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${user.withdrawDate != null ? user.withdrawDate : ''}</p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${totalCount > search.pageSize}">
                    <div class="pagination">
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <a href="javascript:void(0);" data-page="${page}" class="btn-custom ${page == currentPage ? 'active' : ''}">${page}</a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->
    
    <footer>
    	<c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
