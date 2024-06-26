<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <meta charset="UTF-8">
    <title>Certification Post List</title>
    
<style>
.certification-post {
    display: flex;
    flex-direction: column;
    gap: 20px;
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
    height: 250px; /* 이미지 높이 고정 */
    object-fit: cover; /* 이미지 비율을 유지하면서 고정된 크기에 맞춤 */
}

.details {
    padding: 15px;
}

.post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.post-title-author {
    display: flex;
    flex-direction: column;
}

.post-title, .post-author, .post-mountain, .post-difficulty, .post-date {
    margin: 0;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트 생략(...) 처리 */
}

.post-title {
    font-size: 18px;
    font-weight: bold;
    max-width: 280px; /* 최대 너비 설정 */
}

.post-author {
    font-size: 14px;
    max-width: 280px; /* 최대 너비 설정 */
}

.post-likes p {
    font-size: 14px;
    color: #ffb524; /* 좋아요수 색상 변경 */
    text-align: right;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트 생략(...) 처리 */
    max-width: 100px; /* 최대 너비 설정 */
}

.certification-post p {
    margin: 5px 0;
}

.certification-post .fa {
    margin-right: 5px;
}

.certification-post-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
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

.radio-container {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-top: 10px;
    margin-left: 0;
}

.radio-container input[type="radio"] {
    display: none;
}

.radio-container label {
    padding: 5px 15px;
    border: 2px solid #ccc;
    border-radius: 25px;
    cursor: pointer;
    font-size: 14px;
    color: #6c757d;
    transition: all 0.3s ease;
}

.radio-container input[type="radio"]:checked + label {
    background-color: #81c408;
    color: white;
    border-color: #81c408;
}

.radio-container label:hover {
    border-color: #81c408;
    color: #81c408;
}

#searchForm {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    margin-left: 0;
    margin-top: 20px;
}

.header {
    margin-bottom: 20px;
}

.post-title-author h4 {
    margin-bottom: 10px; /* 간격 추가 */
}

.fixed-buttons {
    position: fixed;
    bottom: 20px;
    right: 220px; /* 컨테이너에 가깝게 배치 */
    display: flex;
    flex-direction: column;
    gap: 10px;
}

</style>



    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

    <script>
    $(document).ready(function() {
        let page = 0;
        const size = 10;

        function loadMorePosts() {
            console.log('Loading more posts. Page:', page);
            $.ajax({
                url: 'rest/listCertificationPost',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    searchKeyword: $('#searchInput').val(),
                    searchCondition: $('#searchCondition').val(),
                    sortCondition: $('input[name="sortCondition"]:checked').val(),
                    currentPage: page,
                    pageSize: size
                }),
                success: function(data) {
                    console.log('Received data:', data);
                    if (data && data.list && data.list.length > 0) {
                        appendPostsToPage(data.list, data.certificationPostImages);
                        page++;
                    } else {
                        console.log('No more posts to load.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching posts:', error);
                }
            });
        }

        $('#searchForm').submit(function(event) {
            event.preventDefault();
            page = 0;
            $('.certification-post-container').empty();
            loadMorePosts();
        });

        $('input[name="sortCondition"]').change(function() {
            page = 0;
            $('.certification-post-container').empty();
            loadMorePosts();
        });

        window.addEventListener('scroll', () => {
            if (window.innerHeight + window.scrollY >= document.body.offsetHeight) {
                loadMorePosts();
            }
        });

        function appendPostsToPage(posts, images) {
            console.log('Appending posts to page:', posts);
            const postContainer = document.querySelector('.certification-post-container');
            posts.forEach((post, index) => {
                const postElement = document.createElement('div');
                postElement.classList.add('certification-post');
                postElement.dataset.postno = post.postNo;
                const imageUrl = images[index] ? images[index] : 'default-image-url.png';

                // 제목과 작성자 글자 수 제한
                const shortTitle = post.title.length > 5 ? post.title.substring(0, 5) + '...' : post.title;
               // const shortAuthor = post.nickName.length > 5 ? post.nickName.substring(0, 5) + '...' : post.nickName;

                postElement.innerHTML = 
                    '<div class="fruite-img">' +
                        '<img src="' + imageUrl + '" alt="Certification Post Image">' +
                    '</div>' +
                    '<div class="details">' +
                        '<div class="post-header">' +
                            '<div class="post-title-author">' +
                            '<h4 class="post-title"> ' + shortTitle + '</h4>' +
                            '<h4 class="post-author" style="margin-top: 10px;"><i class="fas fa-user"></i> 작성자: ' + post.nickName + '</h4>' +
   								  '</div>' +
                            '<div class="post-likes">' +
                                '<p><i class="fas fa-heart"></i>  ' + post.certificationPostLikeCount + '</p>' +
                            '</div>' +
                        '</div>' +
                        '<p class="post-mountain"><i class="fas fa-mountain"></i> 산명칭: ' + post.certificationPostMountainName + '</p>' +
                        '<p class="post-difficulty"><i class="fas fa-chart-line"></i> 등산난이도: ' + 
                            (post.certificationPostHikingDifficulty == 0 ? '어려움' : post.certificationPostHikingDifficulty == 1 ? '중간' : '쉬움') +
                        '</p>' +
                        '<p class="post-date"><i class="far fa-calendar-alt"></i> 등산일자: ' + post.certificationPostHikingDate + '</p>' +
                    '</div>';
                postContainer.appendChild(postElement);
            });
        }


        loadMorePosts();

        $(document).on('click', '.certification-post', function() {
            var postNo = $(this).data("postno");
            window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
        });

        $(".top-button").click(function() {
            $('html, body').animate({scrollTop: 0}, 'slow');
        });
        
        var userNo = ${user.userNo};
        
        $(".btn-certify-hiking").click(function() {
            alert('인증하기');
       
            window.location.href = "/certificationPost/addCertificationPost?userNo=" + userNo;
        });
    });
    </script>
</head>
<body>
    <header><c:import url="../common/top.jsp"/></header>
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="position-relative mx-auto mb-5" style="max-width: 600px;">
                    <form id="searchForm" class="d-flex align-items-center">
                        <select id="searchCondition" name="searchCondition" class="form-control border-2 border-secondary rounded-pill me-2" style="width: 150px; height: 45px;">
                            <option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>글제목</option>
                            <option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>닉네임</option>
                            <option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>산명칭</option>
                        </select> 
                        
                        <input type="text" id="searchInput" name="searchKeyword" value="" placeholder="Search" class="form-control border-2 border-secondary rounded-pill me-2" style="width: 300px; height: 45px;">
                        <button type="submit" class="btn btn-primary border-2 border-secondary rounded-pill text-white search-button" style="height: 45px;">검색</button>
                    </form>
                    <div class="radio-container">
                        <input type="radio" id="likeDesc" name="sortCondition" value="3" ${ !empty search.sortCondition && search.sortCondition==3 ? "checked" : "" }>
                        <label for="likeDesc">좋아요 많은 순</label>
                        <input type="radio" id="likeAsc" name="sortCondition" value="4" ${ !empty search.sortCondition && search.sortCondition==4 ? "checked" : "" }>
                        <label for="likeAsc">좋아요 적은 순</label>
                        <input type="radio" id="difficultyDesc" name="sortCondition" value="5" ${ !empty search.sortCondition && search.sortCondition==5 ? "checked" : "" }>
                        <label for="difficultyDesc">난이도 높은 순</label>
                        <input type="radio" id="difficultyAsc" name="sortCondition" value="6" ${ !empty search.sortCondition && search.sortCondition==6 ? "checked" : "" }>
                        <label for="difficultyAsc">난이도 낮은 순</label>
                    </div>
                </div>

             <div class="certification-post-container">
    <c:forEach var="certificationPost" items="${certificationPost}" varStatus="status">
        <div class="certification-post" data-postno="${certificationPost.postNo}">
            <div class="fruite-img">
                <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
            </div>
            <div class="details">
                <div class="post-header">
                    <div class="post-title-author">
                        <h4 class="post-title"> 
                            <i class="fas fa-heading"></i> 
                            <c:choose>
                                <c:when test="${fn:length(certificationPost.title) > 5}">
                                    ${fn:substring(certificationPost.title, 0, 5)}...
                                </c:when>
                                <c:otherwise>
                                    ${certificationPost.title}
                                </c:otherwise>
                            </c:choose>
                        </h4>
                        <h4 class="post-author" style="margin-top: 10px;">
                            <i class="fas fa-user"></i> 
                            작성자: 
                            <c:choose>
                                <c:when test="${fn:length(certificationPost.nickName) > 5}">
                                    ${fn:substring(certificationPost.nickName, 0, 5)}...
                                </c:when>
                                <c:otherwise>
                                    ${certificationPost.nickName}
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="post-likes">
                        <p><i class="fas fa-heart"></i> 좋아요수: ${certificationPost.certificationPostLikeCount}</p>
                    </div>
                </div>
                <p class="post-mountain"><i class="fas fa-mountain"></i> 산명칭: ${certificationPost.certificationPostMountainName}</p>
                <p class="post-difficulty"><i class="fas fa-chart-line"></i> 등산난이도: 
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
                <p class="post-date"><i class="far fa-calendar-alt"></i> 등산일자: ${certificationPost.certificationPostHikingDate}</p>
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
