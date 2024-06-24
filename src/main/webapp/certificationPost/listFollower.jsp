<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>팔로워목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.7.2/font/bootstrap-icons.min.css">
    <style>
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
            color: #32CD32; /* 연두색 */
            text-decoration: none; /* 밑줄 제거 */
        }

        .clickable:hover {
            color: #32CD32; /* 호버 시에도 같은 연두색 */
            text-decoration: none; /* 밑줄 제거 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
    $(document).ready(function(){
        $(document).on('click', 'p.clickable', function() {
            var userNo = $(this).data('userno'); // 클릭된 닉네임의 userNo 추출

            // 클릭된 유저 번호를 콘솔에 출력
            console.log('Clicked user number:', userNo);

            // 페이지 이동
            window.location.href = "/certificationPost/getProfile?userNo=" + userNo;
        });
    });
    </script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main>
        <div class="container-fluid py-5">
            <div class="container py-5 table-container">
                <h2>Follower List</h2>
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <c:forEach var="follower" items="${followerList}">
                                <tr>
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <img src="${follower.profileImage}" alt="Profile Image" class="profile-img">
                                    </td>
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <p class="mb-0 clickable" data-userno="${follower.userNo}">${follower.nickName}</p>
                                    </td>
                                    <td style="vertical-align: middle; padding-right: 10px;">
                                        <img src="${follower.badgeImage}" alt="Badge Image" class="badge-img">
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
