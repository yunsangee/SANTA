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
            object-fit: cover;
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
    </style>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main class="main-container">
        <div class="container-fluid py-5">
            <div class="container py-5 table-container">
                <h2>Follower List</h2>
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty followerList}">
                                    <c:forEach var="follower" items="${followerList}">
                                        <tr>
                                            <td style="vertical-align: middle; padding-right: 10px;"> 
                                               <img src="<c:url value='${follower.profileImage}' />" alt="Profile Image" class="profile-img">

                                            </td>
                                            <td style="vertical-align: middle; padding-right: 10px;">
                                                <p class="mb-0 clickable" data-userno="${follower.userNo}">${follower.nickName}</p>
                                            </td>
                                            <td style="vertical-align: middle; padding-right: 10px;">
                                              <img src="<c:url value='${follower.badgeImage}' />" class="badge-img">

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4">
                                            <div class="no-followings">팔로워가 없습니다.</div>
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
