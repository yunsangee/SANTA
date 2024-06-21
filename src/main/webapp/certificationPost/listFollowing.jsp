<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>팔로잉목록</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
    $(document).ready(function(){
        const followerUserNo =1; // followerUserNo을 3으로 고정

        $("button.delete-follow").on('click', function(){
            const followingUserNo = $(this).data("following-id");

            console.log("Follower User No:", followerUserNo);
            console.log("Following User No:", followingUserNo);

            if (!followerUserNo || !followingUserNo) {
                alert('Invalid user information.');
                return;
            }

            $.ajax({
                url: "http://127.0.0.1:8001/userEtc/rest/deleteFollow",
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
                url: "http://127.0.0.1:8001/userEtc/rest/getFollowingList",
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
            const tbody = $("table tbody");
            tbody.empty();

            followingList.forEach(following => {
                const row = `
                    <tr id="row-${following.userNo}">
                        <td style="vertical-align: middle; padding-right: 10px;">
                            <img src="${following.profileImage}" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
                        </td>
                        <td style="vertical-align: middle; padding-right: 10px;">
                            <p class="mb-0">${following.userName}</p>
                        </td>
                        <td style="vertical-align: middle; padding-right: 10px;">
                            <img src="${following.badgeImage}" alt="Badge Image" style="width: 24px; height: 24px;">
                        </td>
                        <td style="vertical-align: middle;">
                            <button 
                                class="delete-follow btn btn-secondary" 
                                data-following-id="${following.userNo}">
                                팔로잉취소
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <hr/>
                        </td>
                    </tr>
                `;
                tbody.append(row);
            });

            // 이벤트 핸들러 다시 설정
            $("button.delete-follow").on('click', function(){
                const followingUserNo = $(this).data("following-id");
                const followerUserNo = 1;

                $.ajax({
                    url: "http://127.0.0.1:8001/userEtc/rest/deleteFollow",
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
        }
    });
    </script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5">
                <h2>Following List</h2>
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <c:forEach var="following" items="${followingList}">
                                <tr id="row-${following.userNo}">
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <img src="${following.profileImage}" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
                                    </td>
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <p class="mb-0">${following.nickName}</p>
                                    </td>
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <img src="${following.badgeImage}" alt="Badge Image" style="width: 24px; height: 24px;">
                                    </td>
                                    <td style="vertical-align: middle;">
                                        <button 
                                            class="delete-follow btn btn-secondary" 
                                            data-following-id="${following.userNo}">
                                            팔로잉취소
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <hr/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <footer></footer>
</body>
</html>
