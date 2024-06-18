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
    	});
    
    </script>
    
    <style>
    	
    
    </style>
</head>

<body>
	<div class="container-fluid fixed-top">
	<nav class="navbar navbar-light bg-white navbar-expand-xl">
		<h1 id="logoName" class="text-primary display-6">SANTA</h1>
		<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="fa fa-bars text-primary"></span>
		</button>
		<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
				<div class="navbar-nav mx-auto">
					<a href="#" id="Home" class="nav-item nav-link active">홈</a> <a
						href="#" id="mountain" class="nav-item nav-link">산</a> <a
						href="#" id="certificationPost" class="nav-item nav-link">인증게시판</a>
					<a href="#" id="meetingPost" class="nav-item nav-link">모임게시판</a>
					<a href="#" id="hikingGuide" class="nav-item nav-link">등산안내</a>
				</div>
				
				
				<div class="d-flex m-3 me-0">
					<c:if test="${ not empty sessionScope.user}">
						<a href="#" class="my-auto"> <i id="userProfile" class="fas fa-user fa-2x"></i>
						</a>
					</c:if>
					
					<c:if test="${ empty sessionScope.user}">
						<a href="#" class="my-auto"> <i id="loginButton" class="fas fa-sign-in-alt fa-1x">로그인</i>
						</a>
					</c:if>
				</div>
			</div>
	</nav>
	</div>
</body>
</html>