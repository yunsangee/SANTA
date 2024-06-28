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
}

.wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

header, footer {
    flex-shrink: 0;
}

main {
    flex-grow: 1;
    margin-top: 160px;
    padding: 0 20px;
    max-width: 1200px;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 30px; /* MAIN 아래에 공백 추가 */
}

footer {
    background-color: #f1f1f1;
    padding: 10px 0;
    text-align: center;
    margin-top: 50px; /* FOOTER 위에 공백 추가 */
}

body {
    font-family: Arial, sans-serif;
}

.profile-container {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding: 20px;
    border-bottom: 1px solid #ccc;
    font-size: 0.9em;
}

.profile-image {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    margin-right: 20px;
}

.profile-details {
    flex-grow: 1;
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

/* 팔로우 버튼 기본 스타일 */
.follow-button {
    margin-left: 20px;
    font-size: 0.8em; /* 글자 크기 감소 */
    cursor: pointer; /* 커서 모양 변경 */
    background-color: #ffcc00; /* 기본 배경색 */
    color: black; /* 글자색 */
    border: 2px solid #ffcc00; /* 테두리 색상 */
    padding: 8px 16px; /* 패딩 감소 */
    border-radius: 20px; /* 둥근 테두리 */
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background-color 0.3s, color 0.3s, border 0.3s; /* 애니메이션 */
}

/* 팔로잉 상태 스타일 */
.follow-button.following {
    background-color: white; /* 팔로잉 상태 배경색 */
    color: #ffcc00; /* 팔로잉 상태 글자색 */
    border: 2px solid #ffcc00; /* 팔로잉 상태 테두리 */
}

/* 아이콘 스타일 */
.follow-button .bi {
    font-size: 1.0em; /* 아이콘 크기 조정 */
}

.tab-menu {
    display: flex;
    justify-content: space-around;
    margin: 20px 0;
    border-bottom: 1px solid #ccc;
}

.tab-menu a {
    text-decoration: none;
    color: black;
    font-weight: bold;
    padding: 10px;
}

.tab-menu a.active {
    border-bottom: 2px solid black;
}

.posts-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.post-preview {
    flex: 0 1 calc(33.333% - 20px); /* 3 columns with 20px gap */
    box-sizing: border-box;
    height: 250px; /* Adjust height */
    border: 1px solid #ccc;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    font-size: 0.9em;
}

.post-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: cover;
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

    // AJAX를 통해 내 인증 게시물을 로드하는 함수
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
                    $('#my-posts-container').append('<p>인증 게시물이 없습니다.</p>');
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
                    $('#like-posts-container').append('<p>좋아요한 게시물이 없습니다.<br>더 많은 게시물을 찾아보세요.</p>');
                }
            },
            error: function(xhr, status, error) {
                console.error("좋아요한 게시물 로드 중 에러 발생:", xhr, status, error);
            }
        });
    }
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
                    <p><strong>닉네임:</strong> ${infouser.nickName} <i class="fas fa-flag"></i></p><!-- 뱃지이미지 들어가야함 -->
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
                <a href="#" id="liked-posts-tab"><strong>${infouser.nickName}</strong> 산타가 좋아요한 게시글</a>
            </div>
            <div id="my-posts-container" class="posts-container">
                <c:forEach var="certificationPost" items="${myCertificationPost}" varStatus="status">
                    <div class="post-preview" data-postNo="${certificationPost.postNo}">
                        <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
                    </div>
                </c:forEach>
            </div>
            <div id="like-posts-container" class="posts-container" style="display: none;">
                <c:forEach var="certificationPost" items="${myLikeCertificationPost}" varStatus="status">
                    <div class="post-preview" data-postNo="${certificationPost.postNo}">
                        <img src="${certificationPostImages[status.index]}" alt="Certification Post Image">
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
