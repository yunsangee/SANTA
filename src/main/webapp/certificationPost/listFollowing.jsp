<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>팔로잉목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.7.2/font/bootstrap-icons.min.css">
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
    
        .table-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .table th {
            background-color: #ffcc00;
            color: white;
            border: none;
        }

        .table tbody tr {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table tbody tr td {
            border-top: none;
            border-bottom: none;
            padding: 10px;
        }

        .profile-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .badge-img {
            width: 24px;
            height: 24px;
        }
		/* 닉네임 스타일 */
		.clickable {
		    color: #81C408; /* 연두색 */
		    text-decoration: none; /* 밑줄 제거 */
		}
		
		.clickable:hover {
		    color: #ffcc00; /* 호버 시에도 같은 연두색 */
		    text-decoration: none; /* 밑줄 제거 */
		}

        /* 팔로우 버튼 기본 스타일 */
        .follow-button {
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

        .follow-button.following {
            background-color: white; /* 팔로잉 상태 배경색 */
            color: #ffcc00; /* 팔로잉 상태 글자색 */
            border: 2px solid #ffcc00; /* 팔로잉 상태 테두리 */
        }

        /* 아이콘 스타일 */
        .follow-button .bi {
            font-size: 1.0em; /* 아이콘 크기 조정 */
        }
        
   .main-container {
    min-height: 80vh; /* 화면 높이의 80%를 최소 높이로 설정 */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

   .no-followings {
            text-align: center;
            padding: 50px;
            font-size: 1.2em;
            color: #666;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
}
        
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
    $(document).ready(function() {
        const followerUserNo = ${sessionScope.user.userNo}; // 세션에서 로그인된 사용자 번호를 가져옴

        $(document).on('click', 'p.clickable', function() {
            var userNo = $(this).closest('tr').attr('id').replace('row-', ''); // 클릭된 닉네임의 부모 tr의 id에서 userNo 추출

            // 클릭된 유저 번호를 콘솔에 출력
            console.log('Clicked user number:', userNo);

            // 페이지 이동
            window.location.href = "/certificationPost/getProfile?userNo=" + userNo;
        });

        $(document).on('click', 'button.delete-follow', function() {
            const followingUserNo = $(this).data("following-id");

            // 디버깅 로그 추가
            console.log("Follower User No:", followerUserNo);
            console.log("Following User No:", followingUserNo);

            if (!followerUserNo || !followingUserNo) {
                alert('Invalid user information.');
                return;
            }

            $.ajax({
                url: "/userEtc/rest/deleteFollow",
                method: "GET",
                data: {
                    followerUserNo: followerUserNo,
                    followingUserNo: followingUserNo
                },
                success: function(response) {
                    alert('Unfollowed successfully');
                    getFollowingList(followerUserNo);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Error:', textStatus, errorThrown);
                    alert('Failed to unfollow');
                }
            });
        });

        function getFollowingList(userNo) {
            $.ajax({
                url: "/userEtc/rest/getFollowingList",
                method: "GET",
                data: { userNo: userNo },
                success: function(followingList) {
                    updateFollowingTable(followingList);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Error:', textStatus, errorThrown);
                    alert('Failed to get following list');
                }
            });
        }

        function updateFollowingTable(followingList) {
            const tbody = $('table tbody');
            tbody.empty();

            if (followingList.length === 0) {
                tbody.append('<tr><td colspan="4"><div class="no-followings">팔로잉중인 회원이 없습니다!</div></td></tr>');
            } else {
                followingList.forEach(following => {
                    const row = 
                        '<tr id="row-' + following.userNo + '">' +
                            '<td style="vertical-align: middle; padding-right: 10px;">' +
                                '<img src="' + following.profileImage + '" alt="Profile Image" class="profile-img">' +
                            '</td>' +
                            '<td style="vertical-align: middle; padding-right: 10px;">' +
                                '<p class="mb-0 clickable">' + following.nickName + '</p>' +
                            '</td>' +
                            '<td style="vertical-align: middle; padding-right: 10px;">' +
                                '<img src="' + following.badgeImage + '" alt="Badge Image" class="badge-img">' +
                            '</td>' +
                            '<td style="vertical-align: middle;">' +
                                '<button ' +
                                    'class="delete-follow follow-button btn btn-secondary" ' +
                                    'data-following-id="' + following.userNo + '">' +
                                    '<i class="bi bi-person-dash"></i> 팔로잉취소' +
                                '</button>' +
                            '</td>' +
                        '</tr>' +
                      
                        '</tr>';
                    tbody.append(row);
                });
            }
        }

        // 초기 팔로잉 목록 로드
        getFollowingList(followerUserNo);
    });

    </script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main class="main-container">
    <div class="container-fluid py-5">
        <div class="container py-5 table-container">
         <h2>Following List</h2>
<div class="table-responsive">
    <table class="table">
        <tbody>
            <c:choose>
                <c:when test="${not empty followingList}">
                    <c:forEach var="following" items="${followingList}">
                        <tr id="row-${following.userNo}">
                            <td style="vertical-align: middle; padding-right: 10px;">
                                <img src="${sessionScope.user.profileImage}" alt="Profile Image" class="profile-img">
                            </td>
                            <td style="vertical-align: middle; padding-right: 10px;">
                                <p class="mb-0 clickable" data-userNo="${following.userNo}">${following.nickName}</p>
                            </td>
                            <td style="vertical-align: middle; padding-right: 10px;">
                                <p>배지이미지들어와야함</p>
                                <!-- <img src="${following.badgeImage}" alt="Badge Image" class="badge-img"> -->
                            </td>
                            <td style="vertical-align: middle;">
                                <button class="delete-follow follow-button btn btn-secondary" data-following-id="${following.userNo}">
                                    <i class="bi bi-person-dash"></i> 팔로잉취소
                                </button>
                            </td>
                        </tr>
                      
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4">
                            <div class="no-followings">팔로잉중인 회원이 없습니다!</div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
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
