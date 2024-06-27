<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>내가 작성한 게시글 목록조회</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    
    <script>
        $(document).ready(function() {
            var userNo = "${sessionScope.user.userNo}";

            $("tbody tr").click(function() {
                var postNo = $(this).data("postno");
                window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
            });

            // 삭제 버튼 클릭 이벤트 핸들러
            $(".delete-btn").click(function(event) {
                event.stopPropagation();
                var postNo = $(this).data("postno");
                if(confirm("정말로 삭제하시겠습니까?")) {
                    $.ajax({
                        url: 'rest/updateCertificationPostDeleteFlag',
                        type: 'GET',
                        data: { postNo: postNo, userNo: userNo },
                        success: function(response) {
                            alert('게시글이 삭제되었습니다.');
                            window.location.reload();
                        },
                        error: function(xhr, status, error) {
                            alert('게시글 삭제에 실패했습니다.');
                        }
                    });
                }
            });

            // 수정 버튼 클릭 이벤트 핸들러
            $(".edit-btn").click(function(event) {
                event.stopPropagation();
                var postNo = $(this).data("postno");
                window.location.href = "/certificationPost/updateCertificationPost?postNo=" + postNo;
            });
        });
    </script>
    
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn-action {
            font-size: 18px;
            border: none;
            background: none;
            cursor: pointer;
        }
        .btn-action:hover {
            color: #007bff;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">산명칭</th>
                                <th scope="col">글제목</th>
                                <th scope="col">작성일자</th>
                                <th scope="col">액션</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <c:forEach var="certificationPost" items="${myCertificationPost}" varStatus="status">
                                        <tr data-postno="${certificationPost.postNo}">
                                            <th scope="row">${status.index + 1}</th>
                                            <td>${certificationPost.certificationPostMountainName}</td>
                                            <td>${certificationPost.title}</td>
                                            <td>${certificationPost.postDate}</td>
                                            <td>
                                                <button type="button" class="btn btn-primary btn-sm edit-btn" data-postno="${certificationPost.postNo}" title="수정">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button type="button" class="btn btn-danger btn-sm delete-btn" data-postno="${certificationPost.postNo}" title="삭제">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center">
                                            <p class="mb-0 mt-4">로그인 후 이용부탁드립니다.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <!-- 페이징 네비게이션 추가 -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?userNo=${sessionScope.user.userNo}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
