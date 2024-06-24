<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
<meta charset="UTF-8">
<title>${user.nickName}님 정보입니다.</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

<style>
main {
    height: 100%; 
    margin: 0;
    display: flex;
    flex-direction: column; 
    justify-content: center;
    align-items: center;
    background-color: white; 
    margin-top:120px;
}

.profile-header {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 25px;
}

.profile-container {
    position: relative;
}

/* .profile {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background-color: #ccc;
    margin-right: 20px;
    margin-left: -40px;
} */

.profile {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background-color: #ccc;
    margin-right: 20px;
    margin-left: -40px;
}

.pencil {
    position: absolute;
    top: 70px; /* Adjust as needed */
    left: 70px; /* Adjust as needed */
    background-color: white;
    border-radius: 50%;
    padding: 5px;
    font-size: 20px;
    cursor: pointer;
    margin-right: 20px;
    margin-left: -40px;
}

.profile-info {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.profile-info p {
    margin: 5px 0;
    color: black;
    font-weight: bold;
}

.update, .detail-section p, .detail-section textarea, .detail-section select {
    width: 400px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 5px; /* 입력 필드 간 간격 */
   /*  margin-top: 10px; */
    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
}

.update:focus, .detail-section textarea:focus,  .detail-section select:focus {
	border: 1px solid #81C408; /* 클릭 시 테두리 두께와 색상 설정 */
    outline: none; /* 기본 포커스 효과 제거 */
    box-shadow: 0 0 5px rgba(129, 196, 8, 0.5); /* 선택적으로 포커스 시 그림자 효과 추가 */	
}

.detail-section p {
 	width: 400px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #f0f0f0; /* 연한 회색 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 5px; /* 입력 필드 간 간격 */
   /*  margin-top: 10px; */
    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
    text-align: left; /* 글씨 왼쪽 정렬 */
}

.gender {
 	width: 400px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #f0f0f0; /* 연한 회색 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 5px; /* 입력 필드 간 간격 */
   /*  margin-top: 10px; */
    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
    text-align: left; /* 글씨 왼쪽 정렬 */
}

button, a.button {
    width: 400px;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    text-align: center;
    text-decoration: none;
    display: block;
    border-radius: 5px;
    cursor: pointer;
    box-sizing: border-box;
}

.a {   
    background-color: white;
    color: #81C408;
    border: 1px solid #81C408;
    border-radius: 5px;
    margin-bottom: 80px;
}

.a:hover {
    background-color: #DEFBA7; 
}

.text-link {
    color: #81C408;
    text-decoration: none;
    font-size: 13px;
    display: block;
    text-align: center;
    margin-top: 20px;
}

.text-link:hover {
    color: #578906;
    text-decoration: underline;
}

.container {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    width: 400px; /* 고정된 너비 설정 */
    justify-content: center;
    align-items: center; /* 가운데 정렬 */
}

.detail-section {
    display: flex; 
    flex-direction: column; /* 세로 정렬을 위해 추가 */
    align-items: center; /* 가운데 정렬 */
    margin-bottom: 20px;
    justify-content: center;
}

.detail-section a {
	 font-size: 12px;
}

.creation-section a {
	 font-size: 12px;
	 align-items: center;
}

.detail-section p {
    margin: 5px 0;
}

.line {
    border-bottom: 1px solid #ccc;
    margin: 20px 0;
    width: 100%; /* 라인을 전체 너비로 확장 */
}

.survey-label {
    width: 400px; /* 설문조사 글씨를 포함할 너비 설정 */
    text-align: left; /* 설문조사 글씨 왼쪽 정렬 */
    font-size: 12px;
    margin-top: 5px;
    margin-bottom: 7px;
}


</style>

<!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->

<script>
$(document).ready(function() {
	$(".submit").click(function() {
		
		console.log("click");
		if($("#profile").val() != ""){
			$("form").attr("enctype", "multipart/form-data").submit();
		} else {
			$("#profile").remove();
			$("form").submit();
		}
	
});
	});

</script>


<c:import url="../common/header.jsp"/>
</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
    <c:import url="../common/top.jsp"/>
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main class="container">
	<form action="/user/updateUser" method="post" >
    	<div class="profile-header">
        	<!-- <div class="profile-image"> -->
        	<div class="profile-container">
          		<img src="${user.profileImage}" class="profile">
          		<a class="pencil">✏️</a>
        </div>
        <div class="profile-info">
            <p>${user.badgeImage} 인증 ${user.certificationCount}회, 모임 ${user.meetingCount}회</p>
            <p>${user.userId}</p> 
              <!--  <button type="button" ><input type="file" id="profile" name="image" value=""></button> -->
        </div>
    </div>

    <div class="detail-section">
        <input type="text" class="update" name="nickName" value="${user.nickName}">
         <p>${user.birthDate}</p> <!-- Birth Date는 수정 불가 -->
        <input type="text" class="update"  name="phoneNumber" value="${user.phoneNumber}" >
        <input type="text" class="update" name="address" value="${user.address}">
        <input type="text" class="update" name="detailAddress" value="${user.detailAddress}" placeholder="상세 주소">
        <p> 
            <c:choose>
                <c:when test="${user.gender == 0}">
                    여자
                </c:when>
                <c:when test="${user.gender == 1}">
                    남자
                </c:when>
            </c:choose>
        </p> <!-- Gender는 수정 불가 -->
        <textarea class="update"  name="introduceContent">${user.introduceContent}</textarea>
        
        <div class="line"></div>
        
        <label class="survey-label">설문조사</label>
        
        <select name="hikingPurpose">
            <option value="0" ${user.hikingPurpose == 0 ? 'selected' : ''}>취미</option>
            <option value="1" ${user.hikingPurpose == 1 ? 'selected' : ''}>운동</option>
            <option value="2" ${user.hikingPurpose == 2 ? 'selected' : ''}>친목</option>
        </select>
        <select name="hikingDifficulty">
            <option value="0" ${user.hikingDifficulty == 0 ? 'selected' : ''}>어려움</option>
            <option value="1" ${user.hikingDifficulty == 1 ? 'selected' : ''}>보통</option>
            <option value="2" ${user.hikingDifficulty == 2 ? 'selected' : ''}>쉬움</option>
        </select>
        <select name="hikingLevel">
            <option value="0" ${user.hikingLevel == 0 ? 'selected' : ''}>경험없음</option>
            <option value="1" ${user.hikingLevel == 1 ? 'selected' : ''}>1년에 1~2회 이상</option>
            <option value="2" ${user.hikingLevel == 2 ? 'selected' : ''}>1년에 5회 이상</option>
            <option value="3" ${user.hikingLevel == 3 ? 'selected' : ''}>한 달에 1~2회 이상</option>
            <option value="4" ${user.hikingLevel == 4 ? 'selected' : ''}>한 달에 5회 이상</option>
        </select>
        
        <c:if test="${admin != null}">
            <input type="text" class="read-only" value="${user.creationDate}" readonly>
            <input type="text" class="read-only" value="${user.withdrawDate}" readonly>
            <input type="text" class="read-only" 
                value="<c:choose>
                        <c:when test='${user.withdrawReason == 0}'>서비스 만족도 낮음</c:when>
                        <c:when test='${user.withdrawReason == 1}'>사용 빈도 감소</c:when>
                        <c:when test='${user.withdrawReason == 2}'>고객 지원 불만</c:when>
                        <c:when test='${user.withdrawReason == 3}'>유사한 다른 서비스 존재</c:when>
                        <c:when test='${user.withdrawReason == 4}'>기타</c:when>
                       </c:choose>" 
                readonly>
        </c:if>     		
    </div>
    
    	<div class="creation-section">
    		<a>${user.creationDate}</a>
    	</div>
    
    <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
    <input type="hidden" id="userId" name="userId" value="${user.userId}">
    
	<br>
		
	<div class="link-section">
            <button type="button" class="a submit" >수정 완료하기</button>
    </div>    
	
	</form>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// --> 

<footer></footer>

</body>
</html>
