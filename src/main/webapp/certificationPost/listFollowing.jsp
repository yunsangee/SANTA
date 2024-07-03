<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
  <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png">
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
            padding: 10px;
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
            display: flex; /* Add flex display for table rows */
            align-items: center; /* Align items vertically centered */
            justify-content: space-between; /* Distribute space between items */
        }

        .table tbody tr td {
            border-top: none;
            border-bottom: none;
            padding: 10px;
            flex: 1; /* Make all columns take equal space */
            text-align: center; /* Center-align text in cells */
            white-space: nowrap; /* Prevent text from breaking into multiple lines */
        }

        .profile-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px; /* Add margin for spacing */
        }

        .badge-img {
            width: 24px;
            height: 24px;
            object-fit: cover;
            margin-left: 10px; /* Add margin for spacing */
        }

        /* 닉네임 스타일 */
        .clickable {
            color: #81C408; /* 연두색 */
            text-decoration: none; /* 밑줄 제거 */
            font-size: 16px; /* Increase font size */
        }

        .clickable:hover {
            color: #ffcc00; /* 호버 시에도 같은 연두색 */
            text-decoration: none; /* 밑줄 제거 */
        }

      
    .follow-button {
        font-size: 0.8em; /* 글자 크기 감소 */
        cursor: pointer; /* 커서 모양 변경 */
        background-color: #ffffff; /* 배경색: 흰색 */
        color: black; /* 글자색 */
        border: 2px solid #ffcc00; /* 테두리 색상: 노랑색 */
        padding: 8px 16px; /* 패딩 감소 */
        border-radius: 20px; /* 둥근 테두리 */
        display: flex;
        align-items: center;
        gap: 8px;
        transition: background-color 0.3s, color 0.3s, border 0.3s; /* 애니메이션 */
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
           .swal2-icon.swal2-success [class^='swal2-success-line'] {
        background-color:  #81C408 !important; /* 성공 아이콘의 체크표시 색상 변경 */
    }


.custom-swal-popup .swal2-icon.swal2-success .swal2-success-ring {
    border-color: #81C408; /* 성공 아이콘 색상 변경 */
}

.custom-swal-popup .swal2-icon.swal2-success .swal2-success-fix,
.custom-swal-popup .swal2-icon.swal2-success .swal2-success-circular-line-right {
    background-color: #81C408; /* 성공 아이콘 내부 색상 변경 */
}
        
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <script>
    $(document).ready(function() {
        const followerUserNo = ${sessionScope.user.userNo}; // 세션에서 로그인된 사용자 번호를 가져옴

        $(document).on('click', 'p.clickable', function() {
            var userNo = $(this).data('userno'); // 클릭된 닉네임의 userNo 추출

            // 클릭된 유저 번호를 콘솔에 출력
            console.log('Clicked user number:', userNo);

            // 페이지 이동
            window.location.href = "/certificationPost/getProfile?userNo=" + userNo;
        });

        $(document).on('click', 'button.delete-follow', function() {
            const followingUserNo = $(this).data("following-id");
            const button = $(this); // 클릭된 버튼을 참조

            // 디버깅 로그 추가
            console.log("Follower User No:", followerUserNo);
            console.log("Following User No:", followingUserNo);

            if (!followerUserNo || !followingUserNo) {
                alert('Invalid user information.');
                return;
            }

            Swal.fire({
                title: '팔로잉을 취소하시겠습니까?',
                text: "이 작업은 되돌릴 수 없습니다.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#81C408',
                cancelButtonColor: '#45595b',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "/userEtc/rest/deleteFollow",
                        method: "GET",
                        data: {
                            followerUserNo: followerUserNo,
                            followingUserNo: followingUserNo
                        },
                        success: function(response) {
                            Swal.fire({
                                title: '언팔로우 성공!',
                                text: '성공적으로 언팔로우 되었습니다.',
                                icon: 'success',
                                confirmButtonColor: '#81C408',
                                customClass: {
                                    popup: 'custom-swal-popup'
                                }
                            })
                            button.removeClass('btn-secondary').addClass('btn-success').text('팔로우');
                            getFollowingList(followerUserNo);
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error('Error:', textStatus, errorThrown);
                            Swal.fire(
                                '언팔로우에 실패했습니다.',
                                '',
                                'error'
                            );
                        }
                    });
                }
            })
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
                    Swal.fire(
                        '팔로잉 목록을 불러오는데 실패했습니다.',
                        '',
                        'error'
                    );
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
                        '<p class="mb-0 clickable" data-userno="' + following.userNo + '">' + following.nickName + '</p>' +
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
                                    <img src="${following.profileImage}" alt="Profile Image" class="profile-img">
                                </td>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <p class="mb-0 clickable" data-userno="${following.userNo}">${following.nickName}</p>
                                </td>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <img src="${following.badgeImage}" alt="Badge Image" class="badge-img">
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
