<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
   	<c:import url="../common/header.jsp"/>
    <script>
    	$(function(){

    		$('#logoName').on('click',function(){
    			window.location.href ='http://${javaServerIp}/';
    		});
    		
			$('#mountain').on('click',function(){
				window.location.href = 'http://${javaServerIp}/mountain/searchMountain';
			});
			
			$('#certificationPost').on('click',function(){
				window.location.href = 'http://${javaServerIp}/certificationPost/listCertificationPost';
			});
			
			$('#meetingPost').on('click',function(){
				window.location.href = 'http://${javaServerIp}/meetingPost/getMeetingPostList';
			});
			
			$('#hikingGuide').on('click',function(){
				window.location.href = 'http://${reactServerIp}';
			});
			
			$('#loginButton').on('click',function(){
				window.location.href = 'http://${javaServerIp}/user/login';
			});
			
			$('#userProfile').on('click',function(){
				window.location.href = 'http://${javaServerIp}/mountain/searchMountain';
			});  // need to fix to popup
			
			$('#getUserList').on('click',function(){
				window.location.href = 'http://${javaServerIp}/user/getUserList';
			});  // need to fix to popup
			
			$('#statistics').on('click',function(){
				window.location.href = 'http://${javaServerIp}/mountain/getStatistics';
			});  // need to fix to popup
			
			$('#correctionPost').on('click',function(){
				window.location.href = 'http://${javaServerIp}/correctionPost/getCorrectionPostList';
			});  // need to fix to popup
    	});
    </script>

</head>

<body>

<div class="container-fluid fixed-top">
    <div class="container px-0">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <h1 id="logoName" class="text-primary display-6">SANTA</h1>
            <button class="navbar-toggler py-2 px-3" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                	<c:if test="${empty sessionScope.user or sessionScope.user.role == 0 }">
                	
                    	<a href="#" id="Home" class="nav-item nav-link active">홈</a>
                    	<a href="#" id="mountain" class="nav-item nav-link">산</a>
                    	<a href="#" id="certificationPost" class="nav-item nav-link">인증게시판</a>
                    	<a href="#" id="meetingPost" class="nav-item nav-link">모임게시판</a>
                    	<a href="#" id="hikingGuide" class="nav-item nav-link">등산안내</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.role == 1 }">
                    	<a href="#" id="Home" class="nav-item nav-link active">홈</a>
                    	<a href="#" id="getUserList" class="nav-item nav-link">회원목록조회</a>
                    	<a href="#" id="statistics" class="nav-item nav-link">통계</a>
                    	<a href="#" id="correctionPost" class="nav-item nav-link">정정제보</a>
                    </c:if>
                </div>
                <div class="d-flex m-3 me-0">
                    <c:if test="${not empty sessionScope.user}">
                        <a href="#" class="my-auto"><i id="userProfile" class="fas fa-user fa-2x"></i></a>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <a href="#" class="my-auto"><i id="loginButton" class="fas fa-sign-in-alt fa-1x"> 로그인</i></a>
                    </c:if>
                </div>
            </div>
        </nav>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('.navbar-toggler').on('click', function() {
            var target = $(this).attr('data-target');
            $(target).collapse('toggle');
        });

        $('.nav-link').on('click', function() {
            $('#navbarCollapse').collapse('hide');
        });
    });
</script>
</body>
</html>