<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>회원 목록 조회</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
    <style>
        .tab-menu {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            border-bottom: 2px solid #ccc;
        }

        .tab-menu a {
            text-decoration: none;
            color: black;
            font-weight: bold;
            padding: 10px;
            transition: color 0.3s, border-bottom 0.3s;
        }

        .tab-menu a.active {
            border-bottom: 3px solid #81c408;
            color: #81c408;
        }

        .pagination {
            display: flex;
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

        .table-responsive {
            margin-bottom: 60px; /* Ensure there's space for the fixed pagination */
        }

     footer {
   /*  background-color: #f1f1f1; */
    padding: 10px 0;
    text-align: left;
    position: absolute;
    bottom: 0;
    width: 100%;
    margin-bottom:-200px;
}

        
        .tab-menu, .search-container, .table-responsive {
        	margin-top:20px;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
        $(document).ready(function() {
            // AJAX로 검색 요청을 처리

            // Enter key를 눌렀을 때 검색 요청을 처리
            $('.search-input').keypress(function(event) {
                if (event.which == 13) { // Enter key code
                    $('#curretPage').val(1);
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
        });
    </script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>

    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="tabs-container">
                    <div class="tab-menu">
                        <c:choose>
                            <c:when test="${sessionScope.whichUserList == 0}">
                                <a href="/user/getUserList" class="active">회원목록</a>
                                <a href="/user/withdrawUserList">탈퇴회원 목록</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/user/getUserList">회원목록</a>
                                <a href="/user/withdrawUserList" class="active">탈퇴회원 목록</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="search-container">
                        <form id="searchForm" action="${sessionScope.whichUserList == 0 ? '/user/getUserList' : '/user/withdrawUserList'}" method="get" style="display: flex; align-items: center;">
                            <select name="searchCondition" class="dropdown-custom">
                                <option value="0" ${search.searchCondition == 0 ? 'selected' : ''}>아이디</option>
                                <option value="1" ${search.searchCondition == 1 ? 'selected' : ''}>닉네임</option>
                                <option value="2" ${search.searchCondition == 2 ? 'selected' : ''}>이름</option>
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
                                <th scope="col">이름</th>
                                <th scope="col">아이디</th>
                                <th scope="col">닉네임</th>
                                <th scope="col">가입 일자</th>
                                <th scope="col">탈퇴 일자</th>
                            </tr>
                        </thead>
                        <tbody id="userTable">
                            <c:forEach var="user" items="${userList}" varStatus="status">
                                <tr data-userid="${user.userId}">
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0 mt-4">${(currentPage-1)*pageSize +status.index + 1}</p>
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
                    <div class="pagination-container">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="javascript:void(0);" data-page="${currentPage - 1}" class="btn-custom">&lt;</a>
                            </c:if>

                            <c:choose>
                                <c:when test="${totalPages <= 5}">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <a href="javascript:void(0);" data-page="${i}" class="btn-custom ${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach begin="0" end="4" varStatus="status">
                                        <c:set var="pageNum" value="${currentPage <= 3 ? status.index + 1 : currentPage >= totalPages - 2 ? totalPages - 4 + status.index : currentPage - 2 + status.index}"/>
                                        <a href="javascript:void(0);" data-page="${pageNum}" class="btn-custom ${pageNum == currentPage ? 'active' : ''}">${pageNum}</a>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${currentPage < totalPages}">
                                <a href="javascript:void(0);" data-page="${currentPage + 1}" class="btn-custom">&gt;</a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
    
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
