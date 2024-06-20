<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Certification Post Detail Page</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    .carousel-item img {
        width: 100%;
        height: 500px; /* 원하는 높이로 조정 */
        object-fit: cover; /* 이미지를 잘라서 채움 */
    }
    .carousel-item {
        transition: transform 0.5s ease-in-out;
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
        margin-bottom: 20px;
    }
    .comment-item p {
        margin-bottom: 5px;
    }
    .details-header {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        position: absolute;
        top: 0;
        right: 0;
    }
    .details-header p, .details-header .btn, .details-header i {
        margin-left: 10px;
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
    .hashtag {
        display: inline-block;
        margin-right: 10px;
    }
</style>

<script>
$(document).ready(function() {
    var postNo = ${certificationPost.postNo};  // JSP에서 postNo 값을 가져옵니다.
    var userNo = 2; // JSP에서 userNo 값을 가져옵니다.

    // 댓글 목록 불러오기
    function loadComments() {
        $.ajax({
            url: 'rest/getCertificationPostComment',
            type: 'GET',
            data: { postNo: postNo },
            success: function(response) {
                console.log("댓글 목록 불러오기 성공:", response);
                var commentsHtml = '';
                response.forEach(function(comment) {
                    commentsHtml += `
                        <div class="comment-item">
                            <p>Nickname: ${comment.nickname}</p>
                            <p>Contents: ${comment.certificationPostCommentContents}</p>
                            <p>Creation Date: ${comment.certificationPostCommentCreationDate}</p>
                            <button class="btn btn-danger btn-sm delete-comment-button" data-comment-no="${comment.certificationPostCommentNo}"><i class="fa fa-trash"></i></button>
                            <hr/>
                        </div>
                    `;
                });
                $('.comment-list').html(commentsHtml);
            },
            error: function(xhr, status, error) {
                console.error("댓글 목록 불러오기 오류:", error);
            }
        });
    }

    // 초기 댓글 목록 불러오기
    loadComments();

    // 댓글 등록
    $('#commentForm').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 방식을 막음

        var newComment = $('#newComment').val().trim();

        if (newComment) {
            var commentData = {
                postNo: postNo,
                userNo: userNo,
                certificationPostCommentContents: newComment
            };

            $.ajax({
                url: 'rest/addCertificationPostComment',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(commentData),
                success: function(response) {
                    console.log("댓글 작성 성공:", response);
                    $('#newComment').val(''); // 입력 필드 비우기
                    loadComments(); // 댓글 목록 새로고침
                },
                error: function(xhr, status, error) {
                    console.error("댓글 작성 오류:", error);
                }
            });
        } else {
            alert("댓글 내용을 입력해주세요.");
        }
    });

    // 댓글 삭제
    $(document).on('click', '.delete-comment-button', function() {
        var commentNo = $(this).data('comment-no');

        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: 'rest/deleteCertificationPostComment',
                type: 'DELETE',
                data: JSON.stringify({ certificationPostCommentNo: commentNo, userNo: userNo }),
                contentType: 'application/json',
                success: function(response) {
                    console.log("댓글 삭제 성공:", response);
                    loadComments(); // 댓글 목록 새로고침
                },
                error: function(xhr, status, error) {
                    console.error("댓글 삭제 오류:", error);
                }
            });
        }
    });
});
</script>
<script>
$(document).ready(function() {
    var postNo = ${certificationPost.postNo};  // JSP에서 postNo 값을 가져옵니다.
    var userNo =2; // JSP에서 userNo 값을 가져옵니다.

    $('.like-button').on('click', function() {
        var likeButton = $(this);
        var certificationPostLikeStatus = likeButton.hasClass('text-danger'); // 현재 좋아요 상태를 확인합니다.

        console.log('postNo:', postNo);
        console.log('userNo:', userNo);
        console.log('certificationPostLikeStatus:', certificationPostLikeStatus);

        if (certificationPostLikeStatus) {
            // 이미 좋아요 상태인 경우, 좋아요를 취소합니다.
            $.ajax({
                url: 'rest/deleteCertificationPostLike',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ postNo: postNo, userNo: userNo }),
                success: function(response) {
                    console.log('좋아요 취소 성공:', response);
                    likeButton.removeClass('text-danger').addClass('text-secondary');
                    var certificationPostLikeCount = parseInt(likeButton.next('p').text()) - 1;
                    likeButton.next('p').text(certificationPostLikeCount);
                },
                error: function(xhr, status, error) {
                    console.error('좋아요 취소 오류:', error);
                    console.log('xhr:', xhr);
                    console.log('status:', status);
                }
            });
        } else {
            // 좋아요 상태가 아닌 경우, 좋아요를 추가합니다.
            $.ajax({
                url: 'rest/addCertificationPostLike',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ postNo: postNo, userNo: userNo }),
                success: function(response) {
                    console.log('좋아요 추가 성공:', response);
                    likeButton.removeClass('text-secondary').addClass('text-danger');
                    var certificationPostLikeCount = parseInt(likeButton.next('p').text()) + 1;
                    likeButton.next('p').text(certificationPostLikeCount);
                },
                error: function(xhr, status, error) {
                    console.error('좋아요 추가 오류:', error);
                    console.log('xhr:', xhr);
                    console.log('status:', status);
                }
            });
        }
    });
    
 // 삭제 버튼 클릭 시
    $('.btn-danger').on('click', function() {
        if (confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: 'rest/updateCertificationPostDeleteFlag',
                type: 'GET',
                data: { postNo: postNo, userNo: userNo },
                success: function(response) {
                    console.log('게시글 삭제 성공:', response);
                    alert('게시글이 삭제되었습니다.');
                    window.location.href = 'listCertificationPost'; // 게시글 목록 페이지로 리디렉션
                },
                error: function(xhr, status, error) {
                    console.error('게시글 삭제 오류:', error);
                }
            });
        }
    });
});

</script>
</head>
<body>
<header>
    <c:import url="../common/top.jsp"/>
</header>
<main class="container my-5">
    <div class="container-fluid py-5 mt-5">
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
                            <p><i class="fas fa-calendar-alt"></i> 작성 일자: ${certificationPost.postDate}</p>
                            <div class="d-flex align-items-center">
                                <i class="fa fa-heart like-button ${certificationPost.certificationPostLikeStatus == 0 ? 'text-secondary' : 'text-danger'}"></i>
                                <p class="mb-0 ml-2">${certificationPost.certificationPostLikeCount}</p>
                            </div>
                              
                                <form action="/certificationPost/updateCertificationPost" method="get">
                                    <input type="hidden" name="postNo" value="${certificationPost.postNo}"/>
                                    <button type="submit" class="btn btn-secondary"><i class="fa fa-edit"></i></button>
                                </form>
                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                           
                            
                            
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
                    <hr><br>
                 <div class="comments-section">
                        <h3><i class="fas fa-comments"></i> 댓글작성하기</h3>
                        
                        <form id="commentForm" class="comment-form">
                            <textarea class="form-control" id="newComment" rows="3" placeholder="댓글을 입력해주세요. (최대 100자)" maxlength="100"></textarea>
                            <button type="submit" class="btn btn-primary">등록</button>
                        </form>
                        <hr><br>
                        <div class="comment-list">
                            <!-- 댓글 목록이 여기에 로드됩니다 -->
                        </div>
                    </div>
                    <hr>
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
