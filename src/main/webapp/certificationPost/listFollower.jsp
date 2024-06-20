<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
    <c:import url="../common/header.jsp"/>
    <title>팔로워목록</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>

<main>
    <div class="container-fluid py-5">
        <div class="container py-5">
            <h2>Follower List</h2>
            <div class="table-responsive">
                <table class="table">
                    <tbody>
                        <c:forEach var="follower" items="${followerList}">
                            <tr>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <img src="${follower.profileImage}" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
                                </td>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <p class="mb-0">${follower.userName}</p>
                                </td>
                                <td style="vertical-align: middle; padding-right: 10px;">
                                    <img src="${follower.badgeImage}" alt="Badge Image" style="width: 24px; height: 24px;">
                                </td>
                                <td style="vertical-align: middle;">
                                    <button class="btn btn-secondary">삭제</button>
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