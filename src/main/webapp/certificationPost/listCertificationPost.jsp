<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

.radio-container {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-top: 10px; /* 추가된 마진 */
    margin-left: 0; /* 검색 폼과 라디오 버튼의 시작 위치 맞춤 */
}

.radio-container input[type="radio"] {
    display: none;
}

.radio-container label {
    padding: 5px 15px; /* 패딩 크기 조정 */
    border: 2px solid #ccc;
    border-radius: 25px;
    cursor: pointer;
    font-size: 14px; /* 폰트 크기 조정 */
    color: #6c757d; /* 검색 폼과 동일한 색상 */
    transition: all 0.3s ease;
}

.radio-container input[type="radio"]:checked + label {
    background-color: #81c408; /* 검색 버튼과 동일한 배경 색상 */
    color: white;
    border-color: #81c408; /* 검색 버튼과 동일한 테두리 색상 */
}

.radio-container label:hover {
    border-color: #81c408; /* 검색 버튼과 동일한 테두리 색상 */
    color: #81c408; /* 검색 폼과 동일한 색상 */
}

#searchForm {
    display: flex;
    align-items: center;
    margin-bottom: 20px; /* 검색 폼과 라디오 컨테이너 사이의 간격 */
    margin-left: 0; /* 검색 폼과 라디오 버튼의 시작 위치 맞춤 */
    margin-top: 20px; /* 헤더와의 간격 추가 */
}

.header {
    margin-bottom: 20px; /* 헤더와의 간격 추가 */
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
                postElement.innerHTML = 
                    '<div class="fruite-img">' +
                    '<img src="' + imageUrl + '" alt="Certification Post Image">' +
                    '</div>' +
                    '<div class="details">' +
                    '<h4>' + post.postNo + '</h4>' +
                    '<h4>' + post.title + '</h4>' +
                    '<p>산명칭 : ' + post.certificationPostMountainName + '</p>' +
                    '<p>Hiking Date: ' + post.certificationPostHikingDate + '</p>' +
                    '<p>좋아요수: ' + post.certificationPostLikeCount + '</p>' +
                    '<p>등산난이도: ' + 
                        (post.certificationPostHikingDifficulty == 0 ? '어려움' : post.certificationPostHikingDifficulty == 1 ? '중간' : '쉬움') +
                    '</p>' +
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

        $(".btn-certify-hiking").click(function() {
            alert('인증하기');
            var userNo = 2; 
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
                            <div class="details"><h4>${certificationPost.postNo}</h4>
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
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
