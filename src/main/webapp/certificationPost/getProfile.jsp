<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>Profile</title>
</head>
<body>




<h2> 인증프로필</h2>

    <p><strong>프로필사진:</strong> ${infouser.profileImage}</p>
    <p><strong>닉네임:</strong> ${infouser.nickName}</p>
    <p><strong>신뢰지표:</strong> ${infouser.badgeImage}</p>
    <p><strong>자기소개:</strong> ${infouser.introduceContent}</p>
      
    <p><strong>Follower Count:</strong> ${followerCount}</p>
    
      <hr/>

<h3> 내가 작성한 게시글 목록조회</h3>
   <c:forEach var="certificationPost" items="${myCertificationPost}">
    <p><strong>산명칭:</strong> ${certificationPost.certificationPostMountainName}</p>
    <p><strong>글제목:</strong> ${certificationPost.title}</p>
    <p><strong>등산일자:</strong> ${certificationPost.certificationPostHikingDate}</p>
    <p><strong>작성일자:</strong> ${certificationPost.postDate}</p>
    <hr/>
</c:forEach>

<hr/><hr/><hr/>좋아요글보기<hr/><hr/><hr/>

<h2>좋아요한 게시글 목록조회</h2>
<c:forEach var="likePost" items="${myLikeCertificationPost}">
    <p><strong>Title:</strong> ${likePost.title}</p>
    <p><strong>Mountain Name:</strong> ${likePost.certificationPostMountainName}</p>
    <p><strong>Hiking Trail:</strong> ${likePost.certificationPostHikingTrail}</p>
    <p><strong>Total Time:</strong> ${likePost.certificationPostTotalTime}</p>
    <p><strong>Ascent Time:</strong> ${likePost.certificationPostAscentTime}</p>
    <p><strong>Descent Time:</strong> ${likePost.certificationPostDescentTime}</p>
    <p><strong>Hiking Date:</strong> ${likePost.certificationPostHikingDate}</p>
    <hr/>
</c:forEach>



</body>
</html>