<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>내가 작성한 게시글 목록조회</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $("tbody tr").click(function() {
                var postNo = $(this).data("postno");
                window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
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
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">산명칭</th>
                                <th scope="col">글제목</th>
                                <th scope="col">등산일자</th>
                                <th scope="col">작성일자</th>
                  
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="certificationPost" items="${myCertificationPost}" varStatus="status">
                                <tr data-postno="${certificationPost.postNo}">
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0 mt-4">${status.index + 1}</p>
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">${certificationPost.certificationPostMountainName}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${certificationPost.title}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${certificationPost.certificationPostHikingDate}</p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">${certificationPost.postDate}</p>
                                    </td>
                                   
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
   <footer>
    <c:import url="../common/footer.jsp"/>
</footer>
</body>
</html>
