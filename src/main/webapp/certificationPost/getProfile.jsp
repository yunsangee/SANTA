<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>Profile</title>
    <style>
    html, body {
        height: 100%;
        margin: 0;
        font-family: Arial, sans-serif;
    }

    .wrapper {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    header, footer {
        flex-shrink: 0;
    }

      .main-container {
            min-height: 80vh; /* 화면 높이의 80%를 최소 높이로 설정 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

    main {
        flex-grow: 1;
        margin-top: 160px;
        padding: 0 20px;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
        margin-bottom: 30px;
    }

    footer {
        background-color: #f1f1f1;
        padding: 10px 0;
        text-align: center;
        margin-top: 50px;
    }

    .profile-container {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        padding: 20px;
        border-bottom: 1px solid #ccc;
        font-size: 1em;
        background-color: #f9f9f9;
        border-radius: 10px;
    }

    .profile-image {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        margin-right: 20px;
        border: 2px solid #ddd;
    }

    .profile-details {
        flex-grow: 1;
    }
    .profile-details .badge-img {
    width: 30px; /* 이미지 크기를 닉네임 크기와 유사하게 조정 */
    height: 30px;
    margin-left: 10px; /* 닉네임과의 간격 조정 */
    vertical-align: middle; /* 닉네임과 수직으로 맞춤 */
}
    

    .profile-details p {
        margin: 5px 0;
    }

    .follow-info {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-top: 10px;
    }

    .follow-button {
        margin-left: 20px;
        font-size: 0.9em;
        cursor: pointer;
        background-color: #ffcc00;
        color: black;
        border: 2px solid #ffcc00;
        padding: 10px 20px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: background-color 0.3s, color 0.3s, border 0.3s;
    }

    .follow-button.following {
        background-color: white;
        color: #ffcc00;
        border: 2px solid #ffcc00;
    }

    .follow-button .bi {
        font-size: 1.2em;
    }

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
        border-bottom: 3px solid  #81c408;
        color: #81c408;
    }

    .posts-container-wrapper {
        position: relative;
    }

    .posts-container {
        display: flex;
        overflow-x: auto;
        white-space: nowrap;
        gap: 20px;
        padding: 10px 0;
        scrollbar-width: none;
    }

    .post-preview {
        flex: 0 0 auto;
        width: 250px;
        height: 250px;
        border: 1px solid #ccc;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        font-size: 1em;
        background-color: #fff;
        border-radius: 10px;
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
    }

    .post-preview img {
        max-width: 100%;
        max-height: 100%;
        object-fit: cover;
        transition: transform 0.3s;
    }

    .post-preview:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .post-preview:hover img {
        transform: scale(1.1);
    }

    .posts-container::-webkit-scrollbar {
        display: none;
    }

    .scroll-overlay {
        position: absolute;
        top: 0;
        bottom: 0;
        width: 50px;
        background: rgba(255, 255, 255, 0.7);
        z-index: 1;
        cursor: pointer;
        transition: background 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
    }

    .posts-container-wrapper:hover .scroll-overlay {
        opacity: 1;
    }

    .scroll-overlay.left {
        left: 0;
    }

    .scroll-overlay.right {
        right: 0;
    }

    .scroll-arrow {
        font-size: 2em;
        color: #888;
        transition: color 0.3s;
    }

    .scroll-overlay:hover .scroll-arrow {
        color: #555;
    }
    
.no-posts-message {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 250px; /* Adjust this value if your container height is different */
    text-align: center;
    color: #666;
    font-size: 1.2em;
    width: 100%;
}

</style>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function() {
    var userNo = "${infouser.userNo}"; // JSP에서 userNo 값을 가져옴
    var loggedInUserNo = "${sessionScope.user.userNo}"; // JSP에서 로그인된 사용자 번호를 가져옴
    var isFollowing = ${isFollowing == 1}; // 서버에서 받은 isFollowing 값을 boolean으로 변환
    var followerUserNo = loggedInUserNo; // 팔로워 사용자 번호는 로그인된 사용자 번호와 동일

    console.log("User No: " + userNo);
    console.log("Logged In User No: " + loggedInUserNo);
    console.log("Is Following: " + isFollowing);

    // 팔로우 버튼 텍스트 설정
    updateFollowButtonText(isFollowing);

    // 팔로우 버튼 클릭 이벤트 핸들러
    $('.follow-button').click(function() {
        var url = isFollowing ? '/userEtc/rest/deleteFollow' : '/userEtc/rest/addFollow';
        $.ajax({
            url: url,
            method: 'GET',
            data: { followerUserNo: followerUserNo, followingUserNo: userNo },
            success: function(response) {
                console.log("Follow/unfollow success:", response);
                isFollowing = !isFollowing;
                updateFollowButtonText(isFollowing);
                updateFollowerCount(response);
            },
            error: function(xhr, status, error) {
                console.error("팔로우 중 에러 발생:", xhr, status, error);
            }
        });
    });

    // 팔로우 버튼 텍스트 및 스타일 업데이트 함수
    function updateFollowButtonText(isFollowing) {
        var button = $('.follow-button');
        if (isFollowing) {
            button.html('<i class="bi bi-person-dash-fill"></i> 팔로잉 취소').addClass('following');
        } else {
            button.html('<i class="bi bi-person-plus-fill"></i> 팔로우하기').removeClass('following');
        }
    }

    // 팔로워 수 업데이트 함수
    function updateFollowerCount(followerCount) {
        $('#followerCount').html('<i class="fas fa-user"></i>&ensp;<strong>팔로워 :</strong> ' + followerCount);
    }

    // 클릭 시 Follower Count의 경로로 이동하는 이벤트 핸들러
    $('#followerCount').click(function() {
        if (userNo === loggedInUserNo) {
            window.location.href = "/certificationPost/listFollower?userNo=" + userNo;
        }
    });
    $('#followingCount').click(function() {
        if (userNo === loggedInUserNo) {
            window.location.href = "/certificationPost/listFollowing?userNo=" + userNo;
        }
    });

    // 내 인증 탭을 클릭했을 때 호출되는 함수
    $('#my-certifications-tab').click(function(e) {
        e.preventDefault();
        $(this).addClass('active');
        $('#liked-posts-tab').removeClass('active');
        $('#my-posts-container').show();
        $('#like-posts-container').hide();
        loadMyCertifications(); // 내 인증 게시물 로드 함수 호출
    });

    // 좋아요한 게시글 탭을 클릭했을 때 호출되는 함수
    $('#liked-posts-tab').click(function(e) {
        e.preventDefault();
        $(this).addClass('active');
        $('#my-certifications-tab').removeClass('active');
        $('#my-posts-container').hide();
        $('#like-posts-container').show();
        loadLikedPosts(); // 좋아요한 게시물 로드 함수 호출
    });

    // 게시물 클릭 시 상세 페이지로 이동하는 이벤트 핸들러 (이벤트 위임 방식)
    $(document).on('click', '.post-preview', function() {
        var postNo = $(this).data("postno");
        window.location.href = "/certificationPost/getCertificationPost?postNo=" + postNo;
    });

    function loadMyCertifications() {
        $.ajax({
            url: '/certificationPost/rest/listMyCertificationPost',
            method: 'GET',
            data: { userNo: userNo },
            success: function(response) {
                $('#my-posts-container').empty();
                if (response.certificationPostList && response.certificationPostList.length) {
                    response.certificationPostList.forEach(function(certificationPost, index) {
                        var imageUrl = response.certificationPostImages[index];
                        $('#my-posts-container').append(
                            '<div class="post-preview" data-postno="' + certificationPost.postNo + '">' +
                                '<img src="' + imageUrl + '" alt="Certification Post Image">' +
                            '</div>'
                        );
                    });
                } else {
                    $('#my-posts-container').append('<div class="no-posts-message">${infouser.nickName} 산타가 작성한 인증 게시글이 아직 없습니다.</div>');
                }
            },
            error: function(xhr, status, error) {
                console.error("내 인증 게시물 로드 중 에러 발생:", xhr, status, error);
            }
        });
    }

    // AJAX를 통해 좋아요한 게시글을 로드하는 함수
    function loadLikedPosts() {
        $.ajax({
            url: '/certificationPost/rest/getCertificationPostLikeList',
            method: 'POST',
            data: { userNo: userNo },
            success: function(response) {
                $('#like-posts-container').empty();
                if (response.certificationPostList && response.certificationPostList.length) {
                    response.certificationPostList.forEach(function(certificationPost, index) {
                        var imageURL = response.certificationPostImages[index];
                        $('#like-posts-container').append(
                            '<div class="post-preview" data-postno="' + certificationPost.postNo + '">' +
                                '<img src="' + imageURL + '" alt="Certification Post Image">' +
                            '</div>'
                        );
                    });
                } else {
                    $('#like-posts-container').append('<div class="no-posts-message">좋아요한 게시글이 없습니다.<br>더 많은 게시글을 찾아보세요.</div>');
                }
            },
            error: function(xhr, status, error) {
                console.error("좋아요한 게시글 로드 중 에러 발생:", xhr, status, error);
            }
        });
    }


    // 마우스 오버 시 스크롤 이동
    var scrollAmount = 10; // 스크롤 이동량 설정 (값을 조정하여 속도 변경 가능)
    var scrollInterval;

    function startScrolling(container, direction) {
        scrollInterval = setInterval(function() {
            container.scrollLeft(container.scrollLeft() + (direction * scrollAmount));
        }, 10); // 10ms마다 스크롤 이동
    }

    $('.posts-container-wrapper').on('mousemove', function(e) {
        var container = $(this).find('.posts-container');
        var containerOffset = container.offset();
        var mouseX = e.pageX - containerOffset.left;

        clearInterval(scrollInterval); // 기존 스크롤 인터벌 정지

        if (mouseX < container.width() / 3) {
            startScrolling(container, -1); // 왼쪽으로 스크롤
            $(this).find('.scroll-overlay.left').css('opacity', '1'); // 왼쪽 오버레이 표시
            $(this).find('.scroll-overlay.right').css('opacity', '0'); // 오른쪽 오버레이 숨김
        } else if (mouseX > container.width() * 2 / 3) {
            startScrolling(container, 1); // 오른쪽으로 스크롤
            $(this).find('.scroll-overlay.right').css('opacity', '1'); // 오른쪽 오버레이 표시
            $(this).find('.scroll-overlay.left').css('opacity', '0'); // 왼쪽 오버레이 숨김
        } else {
            clearInterval(scrollInterval); // 중앙에 있으면 스크롤 정지
            $(this).find('.scroll-overlay').css('opacity', '0'); // 양쪽 오버레이 숨김
        }
    });

    $('.posts-container-wrapper').on('mouseleave', function() {
        clearInterval(scrollInterval); // 마우스가 떠나면 스크롤 정지
        $(this).find('.scroll-overlay').css('opacity', '0'); // 양쪽 오버레이 숨김
    });
});
</script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main>
        <div class="container">
            <div class="profile-container">
                <img class="profile-image" src="${sessionScope.user.profileImage}" alt="Profile Image"/> <!-- 프로필사진 -->
                <div class="profile-details">
                    <p><strong>닉네임:</strong> ${infouser.nickName} <img src="${user.badgeImage}" class="badge-img"> </p><!-- 뱃지이미지 들어가야함 -->
                    <p><strong>한줄소개:</strong>${infouser.introduceContent}</p>      
                    <div class="follow-info">
                        <p id="followingCount" class="${sessionScope.user.userNo != infouser.userNo ? 'disabled' : ''}"><i class="fas fa-user"></i>&ensp;<strong>팔로잉 :</strong> ${followingCount}</p>
                        <span class="separator">•</span>
                        <p id="followerCount" class="${sessionScope.user.userNo != infouser.userNo ? 'disabled' : ''}"><i class="fas fa-user"></i>&ensp;<strong>팔로워 :</strong> ${followerCount}</p>
                        <c:if test="${sessionScope.user.userNo != infouser.userNo}">
                            <button class="follow-button btn btn-secondary">팔로우하기</button>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="tab-menu">
                <a href="#" id="my-certifications-tab" class="active"><strong>${infouser.nickName}</strong> 산타의 인증</a>
                <a href="#" id="liked-posts-tab"><strong>${infouser.nickName}</strong> 산타의 좋아요</a>
            </div>
            <div class="posts-container-wrapper">
                <div class="scroll-overlay left"><span class="scroll-arrow">&lt;</span></div>
                <div id="my-posts-container" class="posts-container">
                    <c:choose>
            <c:when test="${not empty myCertificationPost}">
                <c:forEach var="certificationPost" items="${myCertificationPost}" varStatus="status">
                    <div class="post-preview" data-postNo="${certificationPost.postNo}">
                        <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-posts-message">${infouser.nickName} 산타가 작성한 인증 게시글이 아직 없습니다.</div>
            </c:otherwise>
        </c:choose>
                </div>
                <div class="scroll-overlay right"><span class="scroll-arrow">&gt;</span></div>
            </div>
            <div class="posts-container-wrapper">
                <div class="scroll-overlay left"><span class="scroll-arrow">&lt;</span></div>
                <div id="like-posts-container" class="posts-container" style="display: none;">
                    <c:forEach var="certificationPost" items="${myLikeCertificationPost}" varStatus="status">
                        <div class="post-preview" data-postNo="${certificationPost.postNo}">
                            <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
                        </div>
                    </c:forEach>
                </div>
                <div class="scroll-overlay right"><span class="scroll-arrow">&gt;</span></div>
            </div>
        </div>
    </main>
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
