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
        main {
            padding: 20px;
            padding-top: 80px;
        }

        header {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .main-image {
            width: 100%;
            height: 500px;
            object-fit: contain;
            margin-bottom: 20px;
        }

        .thumbnail-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .thumbnail {
            cursor: pointer;
            width: 100px;
            height: auto;
            border: 2px solid transparent;
            transition: border-color 0.3s;
        }

        .thumbnail.active {
            border-color: #007bff;
        }

        .details-container {
            margin-top: 20px;
            position: relative;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .details-container p {
            margin-bottom: 10px;
        }

        .btn-icon {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 22px;
            color: #81c408;
            transition: color 0.3s;
        }

        .btn-icon:hover {
            color: #ffb524;
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

        .comment-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 15px;
        }

        .details-header {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            position: relative;
            margin-bottom: 10px;
            gap: 10px;
        }

        .details-header .like-container {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .details-header p, .details-header .btn, .details-header i {
            margin-left: 0;
            margin-top: 0;
        }

        .details-container h4.fw-bold {
            font-size: 24px;
            color: #2c3e50;
            margin-top: 20px;
            margin-bottom: 20px;
            border-bottom: 2px solid #81C408;
            padding-bottom: 10px;
        }

        .hashtags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
            margin-top: 20px;
        }

        .hashtag {
            display: flex;
            align-items: center;
            padding: 5px 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        .post-content-wrapper {
            margin-top: 10px; /* 줄이기 위해 감소 */
            margin-bottom: 20px; /* 줄이기 위해 감소 */
            padding: 10px; /* 줄이기 위해 감소 */
            background: #f9f9f9;
            border-radius: 10px;
            overflow: hidden; /* 스크롤을 숨기기 위해 변경 */
            word-wrap: break-word; /* 긴 문자열을 줄 바꿈 */
            white-space: pre-wrap; /* 연속된 공백도 줄 바꿈 */
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 위쪽으로 내용을 정렬 */
        }

        .post-content {
            margin: 0;
            padding: 0;
        }

        .like-button {
            font-size: 24px;
            cursor: pointer;
        }

        .text-yellow {
            color: #ffb524;
        }

        .text-yellow-outline {
            color: #ffb524;
            -webkit-text-stroke: 2px #ffb524;
            color: transparent;
        }

        .comment-form {
            display: flex;
            align-items: center;
        }

        .comment-form textarea {
            flex-grow: 1;
            margin-right: 10px;
        }

        .comment-form button {
            background-color: #81C408;
            border: none;
            color: white;
            padding: 10px;
            border-radius: 50%;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .comment-form button:hover {
            background-color: #ffb524;
        }

        .comment-form i {
            font-size: 16px;
        }

        .inline-info {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 10px;
        }

        .inline-info span {
            display: flex;
            align-items: center;
            margin-right: 20px;
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

        .badge-img {
            width: 24px; /* 배지 크기를 닉네임과 비슷하게 맞춤 */
            height: 24px; /* 배지 크기를 닉네임과 비슷하게 맞춤 */
            vertical-align: middle; /* 배지를 텍스트 중간에 정렬 */
            margin-left: 5px; /* 배지와 닉네임 사이에 간격 추가 */
        }

        .info-block {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .info-block .inline-info span {
            display: block;
            margin-bottom: 5px;
        }

        .info-block .inline-info span i {
            color: #81C408;
        }

        .details-container .post-content {
            font-size: 18px;
            line-height: 1.6;
            color: #333;
            margin-top: 20px;
        }
    </style>
    <script>
    $(document).ready(function() {
        var postNo = ${certificationPost.postNo};
        var userNo = ${user.userNo};

        $('.thumbnail').on('click', function() {
            var mainImage = $('#mainImage');
            var clickedImage = $(this).attr('src');
            mainImage.attr('src', clickedImage);
            $('.thumbnail').removeClass('active');
            $(this).addClass('active');
        });

        // 좋아요 상태 초기화 및 설정
        function initializeLikeButton() {
            var likeStatus = ${certificationPost.certificationPostLikeStatus};
            var likeCount = ${certificationPost.certificationPostLikeCount};
            if (likeStatus > 0) {
                $('.like-button').removeClass('text-yellow-outline').addClass('text-yellow');
            } else {
                $('.like-button').removeClass('text-yellow').addClass('text-yellow-outline');
            }
            $('.like-button').next('p').text(likeCount);
        }

        initializeLikeButton();

        $('.like-button').on('click', function() {
            var likeButton = $(this);
            var certificationPostLikeStatus = likeButton.hasClass('text-yellow');

            if (certificationPostLikeStatus) {
                // 좋아요 취소
                $.ajax({
                    url: 'rest/deleteCertificationPostLike',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ postNo: postNo, userNo: userNo }),
                    success: function(response) {
                        likeButton.removeClass('text-yellow').addClass('text-yellow-outline');
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
                        likeButton.removeClass('text-yellow-outline').addClass('text-yellow');
                        var certificationPostLikeCount = parseInt(likeButton.next('p').text()) + 1;
                        likeButton.next('p').text(certificationPostLikeCount);
                    },
                    error: function(xhr, status, error) {
                        console.error('좋아요 추가 오류:', xhr, status, error);
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
                    commentsList.empty();
                    $.each(comments, function(index, comment) {
                        var isAuthor = comment.userNo == userNo;
                        var authorLabel = isAuthor ? ' <span class="badge badge-primary">(작성자)</span>' : '';
                        var deleteButton = isAuthor ? '<button class="btn btn-danger btn-sm" data-comment-id="'+comment.certificationPostCommentNo+'"><i class="fa fa-trash"></i></button>' : '';
                        var formattedDate = comment.certificationPostCommentCreationDate.split('T')[0];
                        var commentItem = 
                            '<div class="comment-item" style="margin-bottom: 10px;">' +
                                '<div class="comment-meta">' +
                                    '<p><a href="getProfile?userNo=' + comment.userNo + '" class="author-link"><i class="fas fa-user"></i> 닉네임 : ' + comment.nickname + authorLabel + '</a></p>' +
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
            submitComment();
        });

        $('#newComment').on('keydown', function(event) {
            if (event.key === 'Enter' && !event.shiftKey) {
                event.preventDefault();
                submitComment();
            }
        });

        function submitComment() {
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
        }

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
  $('.btn-icon.btntrash').on('click', function() {
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
<header>
    <c:import url="../common/top.jsp"/>
</header>
<main class="container my-5">
    <div class="container py-5">
        <div class="row justify-content-center g-4 mb-5 main-container">
            <div class="col-lg-8 col-xl-9">
                <img id="mainImage" src="${certificationPostImages[0]}" class="main-image" alt="Main Image">
                <div class="thumbnail-container">
                    <c:forEach var="image" items="${certificationPostImages}" varStatus="status">
                        <img src="${image}" class="thumbnail ${status.index == 0 ? 'active' : ''}" data-index="${status.index}" alt="Thumbnail">
                    </c:forEach>
                </div>
                <div class="details-container">
                    <div class="details-header">
                        <a href="getProfile?userNo=${certificationPost.userNo}" class="author-link">
                            <img class="profile-image" src="${certificationPost.profileImage}" alt="Profile Image"/> ${certificationPost.nickName} <img src="${certificationPost.badgeImage}" class="badge-img">
                        </a>
                        <p><i class="fas fa-calendar-alt"></i> 작성 일자: ${certificationPost.postDate}</p>
                        <div class="like-container">
                            <i class="fa fa-heart like-button ${certificationPost.certificationPostLikeStatus == 0 ? 'text-yellow-outline' : 'text-yellow'}"></i>
                            <p class="mb-0 ml-2">${certificationPost.certificationPostLikeCount}</p>
                        </div>
                      <c:if test="${user != null && user.userNo == certificationPost.userNo}">
    <form action="/certificationPost/updateCertificationPost" method="get" style="display: inline;">
        <input type="hidden" name="postNo" value="${certificationPost.postNo}"/>
        <button type="submit" class="btn-icon"><i class="fas fa-pencil-alt"></i></button>
    </form>
    <button class="btn-icon btntrash"><i class="fas fa-trash-alt"></i></button>
</c:if>

                    </div>

                    <div class="hashtags mb-3">
                        <c:forEach var="hashtag" items="${hashtagList}">
                            <span class="hashtag"><i class="fas fa-hashtag"></i> ${hashtag.certificationPostHashtagContents}</span>
                        </c:forEach>
                    </div>
                    <div class="post-content-wrapper">
                        <h4 class="fw-bold mb-3">${certificationPost.title}</h4>
                        <p class="post-content"><i class="fas fa-lightbulb"></i><strong> 이렇게 다녀왔어요!</strong></p>
                        <p class="post-content">${certificationPost.contents}</p>
                    </div>

                    <hr>
                    <div class="info-block">
                        <div class="inline-info mb-3">
                            <span><i class="fas fa-mountain"></i> 산 이름 : &ensp; ${certificationPost.certificationPostMountainName}</span>
                            <span><i class="fas fa-route"></i> 등산 경로 : &ensp; ${certificationPost.certificationPostHikingTrail}</span>
                        </div>
                        <div class="inline-info mb-3">
                            <span><i class="fas fa-hourglass-start"></i> 총 소요시간 : &ensp; ${certificationPost.certificationPostTotalTime}</span>
                            <span><i class="fas fa-arrow-up"></i> 상행 시간 : &ensp;${certificationPost.certificationPostAscentTime}</span>
                            <span><i class="fas fa-arrow-down"></i> 하행 시간 : &ensp; ${certificationPost.certificationPostDescentTime}</span>
                        </div>
                        <p class="mb-3"><i class="fas fa-calendar-day"></i> 등산 일자 : &ensp;${certificationPost.certificationPostHikingDate}</p>
                        <p class="mb-3"><i class="fas fa-car"></i> 교통수단 : &ensp;
                            <c:choose>
                                <c:when test="${certificationPost.certificationPostTransportation == 0}">도보</c:when>
                                <c:when test="${certificationPost.certificationPostTransportation == 1}">자전거</c:when>
                                <c:when test="${certificationPost.certificationPostTransportation == 2}">버스</c:when>
                                <c:when test="${certificationPost.certificationPostTransportation == 3}">자동차</c:when>
                                <c:when test="${certificationPost.certificationPostTransportation == 4}">지하철</c:when>
                                <c:when test="${certificationPost.certificationPostTransportation == 5}">기차</c:when>
                            </c:choose>
                        </p>
                        <p class="mb-3"><i class="fas fa-chart-line"></i> 등산 난이도 : &ensp;
                            <c:choose>
                                <c:when test="${certificationPost.certificationPostHikingDifficulty == 0}">어려움</c:when>
                                <c:when test="${certificationPost.certificationPostHikingDifficulty == 1}">중간</c:when>
                                <c:when test="${certificationPost.certificationPostHikingDifficulty == 2}">쉬움</c:when>
                            </c:choose>
                        </p>
                    </div>
                </div>
                <br><hr>
                <div class="comments-section">
                    <h3><i class="fas fa-comments"></i> 댓글 작성하기</h3>
                    <form class="comment-form">
                        <textarea class="form-control" id="newComment" rows="3" placeholder="댓글을 입력해 주세요. (최대 100자)" maxlength="100"></textarea>
                        <button type="submit" class="btn btn-custom"><i class="fas fa-pencil-alt"></i></button>
                    </form>
                    <br><hr><br>
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
