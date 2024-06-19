<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
<c:import url="../common/header.jsp"/>
<meta charset="UTF-8">
<title>Certification Post List</title>
<style>
    .certification-post-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }
    .certification-post {
        border: 1px solid #ccc;
        border-radius: 10px;
        overflow: hidden;
        width: 300px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: transform 0.2s;
        cursor: pointer;
    }
    .certification-post:hover {
        transform: scale(1.05);
    }
    .certification-post img {
        width: 100%;
        height: auto;
    }
    .certification-post .details {
        padding: 15px;
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
        height: 50px;
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
        font-size: 24px;
    }
</style>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
    $(document).ready(function() {
        // Certification post click event
        $(".certification-post").click(function() {
            var postNo = $(this).data("postno");
            var certificationPostType = $(this).data("certificationPostType"); // 게시물에 대한 선택 정보
            window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
        });

        // Scroll to top button click event
        $(".top-button").click(function() {
            $('html, body').animate({scrollTop: 0}, 'slow');
        });

        // Certify meeting button click event
        $(".btn-certify-hiking").click(function() {
            alert('인증하기');
            var userNo = 1; // userNo 값을 2로 설정
            window.location.href = "/certificationPost/addCertificationPost?userNo=" + userNo;
        });

        // Certify hiking button click event
    
    });
</script>
</head>
</head>
<body>
    <header><c:import url="../common/top.jsp"/></header>
   <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="position-relative mx-auto mb-5" style="max-width: 600px;">
                    <form id="searchForm" class="d-flex align-items-center" action="/certificationPost/listCertificationPost" method="get">
  <!--   <select name="searchCondition" class="form-control border-2 border-secondary rounded-pill me-2" style="width: 150px; height: 45px;">
        <option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>글제목</option>
        <option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>닉네임</option>
        <option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>산명칭</option>
    </select>--> 
      <input type="text" id="searchInput" name="searchKeyword" value="" placeholder="Search" class="form-control border-2 border-secondary rounded-pill me-2"  style="width: 300px; height: 45px;">
     <button type="submit" class="btn btn-primary border-2 border-secondary rounded-pill text-white search-button" style="height: 45px;">검색</button>
   
 </form>

                </div>

                <div class="certification-post-container">
                    <c:forEach var="certificationPost" items="${certificationPost}" varStatus="status">
                        <div class="certification-post" data-postno="${certificationPost.postNo}">
                            <div class="fruite-img">
                      <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">

                            </div>
                            <div class="details">
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
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
    
    <div class="fixed-buttons">
    
        <button class="btn-cp btn-certify-hiking"><i class="fa fa-mountain"></i></button>
        <button class="btn-cp top-button"><i class="fa fa-arrow-up"></i></button>
    </div>

    <footer></footer>
</body>
</html>
