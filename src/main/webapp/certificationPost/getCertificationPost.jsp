<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="site.dearmysanta.domain.user.User" %>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>Certification Post Detail Page</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
     .carousel-item img {
    width: 100%;
    height: 500px; /* 원하는 높이로 조정 */
    object-fit: cover; /* 이미지를 잘라서 채움 */
}
.details-container {
    margin-top: 20px;
    position: relative;
}
.details-container p {
    margin-bottom: 10px;
}
.comments-section {
    margin-top: 40px;
}
.comment-item {
    position: relative;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 10px;
}
.comment-item .btn-danger {
    background: none;
    border: none;
    color: #ff5c5c;
    cursor: pointer;
}
.comment-item .btn-danger:hover {
    color: #ff0000;
}
.comment-item p {
    margin: 0;
}
.comment-item .fas {
    margin-right: 5px;
}
.comment-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 15px; /* 작성 날짜의 폰트 크기 줄이기 */
}
.details-header {
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    position: relative;
    margin-bottom: 10px; /* 아래에 여백 추가 */
    gap: 10px; /* 요소 사이 간격 추가 */
}


.details-header .like-container {
    display: flex;
    align-items: center; /* 수직 가운데 정렬 */
    gap: 5px; /* 하트 버튼과 카운트 사이 간격을 살짝 추가 */
}


.details-header p, .details-header .btn, .details-header i {
    margin-left: 0; /* 왼쪽 여백 제거 */
    margin-top: 0; /* 위쪽 여백 제거 */
}

.hashtags {
    display: flex;
    flex-wrap: wrap; /* 여러 줄로 감싸기 */
    gap: 10px; /* 해시태그 간격 */
    margin-bottom: 10px; /* 아래 여백 추가 */
}

.hashtag {
    display: flex;
    align-items: center; /* 수직 정렬 */
    padding: 5px 10px; /* 여백 추가 */
    background-color: #f1f1f1; /* 배경색 추가 */
    border-radius: 5px; /* 모서리 둥글게 */
}

.like-button {
    font-size: 24px; /* 버튼 크기 조정 */
    cursor: pointer;
}
.comment-form {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin-top: 20px;
}
.comment-form textarea {
    flex-grow: 1;
    margin-right: 10px;
}
.inline-info span {
    margin-right: 20px; /* span 사이에 간격을 줍니다 */
}

   .profile-image {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    vertical-align: middle;
}

.author-link {
    display: flex;
    align-items: center;
}

.author-link img {
    margin-right: 10px;
}
   
    </style>
    <script>
    $(document).ready(function() {
        var postNo = ${certificationPost.postNo};  // JSP에서 postNo 값을 가져옵니다.
        var userNo = ${user.userNo}; // JSP에서 세션의 userNo 값을 가져옵니다.

        // 좋아요 상태 확인 및 초기화
        function initializeLikeButton() {
            var likeStatus = ${certificationPost.certificationPostLikeStatus};
            var likeCount = ${certificationPost.certificationPostLikeCount};
            if (likeStatus > 0) {
                $('.like-button').removeClass('text-secondary').addClass('text-danger');
            } else {
                $('.like-button').removeClass('text-danger').addClass('text-secondary');
            }
            $('.like-button').next('p').text(likeCount);
        }

        initializeLikeButton();

        $('.like-button').on('click', function() {
            var likeButton = $(this);
            var certificationPostLikeStatus = likeButton.hasClass('text-danger');

            if (certificationPostLikeStatus) {
                // 좋아요 취소
                $.ajax({
                    url: 'rest/deleteCertificationPostLike',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ postNo: postNo, userNo: userNo }),
                    success: function(response) {
                        likeButton.removeClass('text-danger').addClass('text-secondary');
                        var certificationPostLikeCount = parseInt(likeButton.next('p').text()) - 1;
                        likeButton.next('p').text(certificationPostLikeCount);
                    },
                    error: function(xhr, status, error) {
                        console.error('좋아요 취소 오류:', error);
                    }
                });
            } else {
                // 좋아요 추가
                $.ajax({
                    url: 'rest/addCertificationPostLike',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ postNo: postNo, userNo: userNo }),
                    success: function(response) {
                        likeButton.removeClass('text-secondary').addClass('text-danger');
                        var certificationPostLikeCount = parseInt(likeButton.next('p').text()) + 1;
                        likeButton.next('p').text(certificationPostLikeCount);
                    },
                    error: function(xhr, status, error) {
                        console.error('좋아요 추가 오류:', error);
                    }
                });
            }
        });

        // 댓글 조회
        function loadComments() {
            $.ajax({
                url: 'rest/getCertificationPostComment',
                type: 'GET',
                data: { postNo: postNo },
                success: function(comments) {
                    var commentsList = $('.comments-list');
                    commentsList.empty(); // 기존 댓글을 비웁니다.
                    $.each(comments, function(index, comment) {
                        var isAuthor = comment.userNo == userNo;
                        var authorLabel = isAuthor ? ' <span class="badge badge-primary">(작성자)</span>' : '';
                        var deleteButton = isAuthor ? '<button class="btn btn-danger btn-sm" data-comment-id="'+comment.certificationPostCommentNo+'"><i class="fa fa-trash"></i></button>' : '';
                        var formattedDate = comment.certificationPostCommentCreationDate.split('T')[0];
                        var commentItem = 
                            '<div class="comment-item" style="margin-bottom: 10px;">' +
                                '<div class="comment-meta">' +
                                    '<p><i class="fas fa-user"></i> 닉네임 : ' + comment.nickname + authorLabel + '</p>' +
                                    '<span>' +
                                        '<span style="font-size: smaller;"><i class="fas fa-clock"></i> 작성 날짜 : ' + formattedDate + '</span>' +
                                        deleteButton +
                                    '</span>' +
                                '</div>' +
                                '<p><i class="fas fa-comment"></i> 댓글 : ' + comment.certificationPostCommentContents + '</p>' +
                            '</div>';
                        commentsList.append(commentItem);
                    });

                    // 댓글 삭제 버튼 클릭 이벤트 바인딩
                    $('.btn-danger[data-comment-id]').on('click', function() {
                        if (confirm('정말로 삭제하시겠습니까?')) {
                            var commentId = $(this).data('comment-id');
                            deleteComment(commentId);
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error('댓글 조회 오류:', xhr, status, error);
                }
            });
        }


        // 댓글 추가
        $('.comment-form').on('submit', function(event) {
            event.preventDefault();
            var newComment = $('#newComment').val().trim();
            if (newComment) {
                $.ajax({
                    url: 'rest/addCertificationPostComment',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ certificationPostNo: postNo, userNo: userNo, certificationPostCommentContents: newComment }),
                    success: function(response) {
                        $('#newComment').val('');
                        loadComments();
                    },
                    error: function(xhr, status, error) {
                        console.error('댓글 추가 오류:', xhr, status, error);
                    }
                });
            } else {
                alert('댓글을 입력해주세요.');
            }
        });

        // 댓글 삭제
        function deleteComment(certificationPostCommentNo) {
            $.ajax({
                url: 'rest/deleteCertificationPostComment',
                type: 'DELETE',
                data: { certificationPostCommentNo: certificationPostCommentNo, userNo: userNo },
                success: function(response) {
                    loadComments();
                },
                error: function(xhr, status, error) {
                    console.error('댓글 삭제 오류:', xhr, status, error);
                }
            });
        }

        // 초기 댓글 로드
        loadComments();

        // 게시글 삭제 버튼 클릭 시
        $('.btn-danger:not([data-comment-id])').on('click', function() {
            if (confirm('정말로 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'rest/updateCertificationPostDeleteFlag',
                    type: 'GET',
                    data: { postNo: postNo, userNo: userNo },
                    success: function(response) {
                        alert('게시글이 삭제되었습니다.');
                        window.location.href = 'listCertificationPost'; // 게시글 목록 페이지로 리디렉션
                    },
                    error: function(xhr, status, error) {
                        console.error('게시글 삭제 오류:', xhr, status, error);
                    }
                });
            }
        });

        // 작성자 클릭 이벤트 설정
        $('.details-container').on('click', 'p.author-link', function() {
            var authorUserNo = $(this).data('user-no'); // 작성자의 userNo 가져오기
            window.location.href = 'getProfile?userNo=' + authorUserNo;
        });
    });
    </script>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
%>
<header>
    <c:import url="../common/top.jsp"/>
</header>
<main class="container my-5">
    <div class="container py-5">
        <div class="row justify-content-center g-4 mb-5">
            <div class="col-lg-8 col-xl-9">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <c:forEach var="image" items="${certificationPostImages}" varStatus="status">
                            <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
                        </c:forEach>
                    </ol>
                    <div class="carousel-inner">
                        <c:forEach var="image" items="${certificationPostImages}" varStatus="status">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <img src="${image}" class="d-block w-100" alt="Image">
                            </div>
                        </c:forEach>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
        <div class="details-container">
    <div class="details-header">
        <p class="author-link" data-user-no="${certificationPost.userNo}">
            <img class="profile-image" src="${sessionScope.user.profileImage}" alt="Profile Image"/> ${certificationPost.nickName}
        </p>
        <p><i class="fas fa-calendar-alt"></i> 작성 일자: ${certificationPost.postDate}</p>
        <div class="like-container">
            <i class="fa fa-heart like-button ${certificationPost.certificationPostLikeStatus == 0 ? 'text-secondary' : 'text-danger'}"></i>
            <p class="mb-0 ml-2">${certificationPost.certificationPostLikeCount}</p>
        </div>
        <c:if test="${user != null && user.userNo == certificationPost.userNo}">
            <form action="/certificationPost/updateCertificationPost" method="get">
                <input type="hidden" name="postNo" value="${certificationPost.postNo}"/>
                <button type="submit" class="btn btn-secondary"><i class="fa fa-edit"></i></button>
            </form>
            <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
        </c:if>
    </div>
    <div class="hashtags mb-3">
        <c:forEach var="hashtag" items="${hashtagList}">
            <span class="hashtag"><i class="fas fa-hashtag"></i> ${hashtag.certificationPostHashtagContents}</span>
        </c:forEach>
    </div>
    <h4 class="fw-bold mb-3">${certificationPost.title}</h4>
    <hr>
    <div class="inline-info mb-3">
        <span><i class="fas fa-mountain"></i> 산이름:&ensp; ${certificationPost.certificationPostMountainName}</span>
        <span><i class="fas fa-route"></i> 등산경로:&ensp; ${certificationPost.certificationPostHikingTrail}</span>
    </div>
    <div class="inline-info mb-3">
        <span><i class="fas fa-hourglass-start"></i> 총소요시간:&ensp; ${certificationPost.certificationPostTotalTime}</span>
        <span><i class="fas fa-arrow-up"></i> 상행시간: &ensp;${certificationPost.certificationPostAscentTime}</span>
        <span><i class="fas fa-arrow-down"></i> 하행시간: &ensp; ${certificationPost.certificationPostDescentTime}</span>
    </div>
    <p class="mb-3"><i class="fas fa-calendar-day"></i> 등산 일자: &ensp;${certificationPost.certificationPostHikingDate}</p>
    <p class="mb-3"><i class="fas fa-car"></i> 교통수단: &ensp;
        <c:choose>
            <c:when test="${certificationPost.certificationPostTransportation == 0}">도보</c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 1}">자전거</c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 2}">버스</c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 3}">자동차</c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 4}">지하철</c:when>
            <c:when test="${certificationPost.certificationPostTransportation == 5}">기차</c:when>
            <c:otherwise>Unknown</c:otherwise>
        </c:choose>
    </p>
    <p class="mb-3"><i class="fas fa-chart-line"></i> 등산 난이도: &ensp;
        <c:choose>
            <c:when test="${certificationPost.certificationPostHikingDifficulty == 0}">어려움</c:when>
            <c:when test="${certificationPost.certificationPostHikingDifficulty == 1}">중간</c:when>
            <c:when test="${certificationPost.certificationPostHikingDifficulty == 2}">쉬움</c:when>
            <c:otherwise>Unknown</c:otherwise>
        </c:choose>
    </p>
</div>

          
                <p class="mb-3"><i class="fas fa-calendar-day"></i> 글내용 : &ensp;${certificationPost.contents}</p>     <hr><br>
                
                <div class="comments-section"> 
                    <h3><i class="fas fa-comments"></i> 댓글작성하기</h3>
                    <form class="comment-form">
                        <textarea class="form-control" id="newComment" rows="3" placeholder="댓글을 입력해주세요. (최대 100자)" maxlength="100"></textarea>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </form>
                    <div class="comments-list" style="margin-top: 20px;">
                        <!-- 댓글 내용이 여기에 쌓입니다 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<footer>
    <c:import url="../common/footer.jsp"/>
</footer>
</body>
</html>
