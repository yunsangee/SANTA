<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
<meta charset="UTF-8">
<title>${user.nickName}님 정보입니다.</title>

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

<style>
/* html, body {
    height: 100%;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: white;
}

h2 {
    margin-bottom: 20px;
    font-size: 24px;
} */

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
    align-items: center;
    margin-top: 20px;
    margin-bottom: 20px;
}

.profile {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background-color: #ccc;
    margin-right: 20px;
    margin-left: -40px; /* 왼쪽으로 이동할 거리 설정 */
}

.profile-info {
 	justify-content: center;
    align-items: center;
    display: flex;
    flex-direction: column;
}

.profile-info p {
 	justify-content: center;
    align-items: center;
    margin: 5px 0;
    color : black;
    font-weight: bold; /* 글씨 두께 설정 (bold 대신 700 같은 숫자도 사용 가능) */
}

form {
    width: 100%;
}

.detail-section p {
	justify-content: center;
    align-items: center;
    width: 400px; /* 원하는 크기로 조절합니다. */
    padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
    font-size: 16px; /* 폰트 크기를 조정합니다. */
    background-color: #ffffff; /* 배경색 추가 */
    color: black;
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 5px;
    margin-bottom: 10px; /* 입력 필드 간 간격 */
    margin-top: 20px;
    box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
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

/* button:hover, a.button:hover {
    background-color: #DEFBA7;
} */

.a {   
    width: 400px;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    background-color: white;
    color: #81C408;
    border: 1px solid #81C408;
    border-radius: 5px;
    cursor: pointer;
    box-sizing: border-box;
}


.a:hover {
    background-color: #DEFBA7; 
}

.text-link {
    color: #81C408;
    text-decoration: none;
    font-size: 13px;
    justify-content: center;
    margin-top: 20px;
    display: block;
    justify-content: center;
	text-align: center;
	margin-bottom: 40px;
}

.text-link:hover {
    color: #578906;
    text-decoration: underline;
}

.container {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    width: 320px; /* 고정된 너비 설정 */
}

.detail-section {
    margin-bottom: 20px;
}

.detail-section a, .creation-section a {
	margin-top: 20px;
	font-size: 12px;
}

.detail-section p {
    margin: 5px 0;
}

.line {
    border-bottom: 1px solid #ccc;
    margin: 20px 0;
}
        .default-value {
            color: lightgray;
        }
        
        .badgeImage{
        	width:24px;
        	height:24px;
        }

</style>

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
    <div class="profile-header">
        <div class="profile-image">
            <!-- 프로필 이미지가 들어갈 자리 -->
            <img src="${sessionScope.user.profileImage}" class="profile">
        </div>
        <div class="profile-info">
            <p><img src="${user.badgeImage}" class="badgeImage"> 인증 ${user.certificationCount}회, 모임 ${user.meetingCount}회</p>
            <p>${user.userId}</p>
        </div>
    </div>
    
    <div class="detail-section">
        <%-- <p>User ID: ${user.userId}</p> --%>
        <%-- <p>User Name: ${user.userName}</p> --%>
        <p>${user.nickName}</p>
        <p>${user.birthDate}</p>
        <p>${user.phoneNumber}</p>
        <p>${user.address}</p>
         <p class="detailAddress">
        	${user.detailAddress == null || user.detailAddress == "" ? '<span class="default-value">상세주소</span>' : user.detailAddress}
    	</p>
        <p> 
            <c:choose>
                <c:when test="${user.gender == 0}">
                    여자
                </c:when>
                <c:when test="${user.gender == 1}">
                    남자
                </c:when>
            </c:choose>
        </p>
        <p class="introduceContent">
        	${user.introduceContent == null || user.introduceContent == "" ? '<span class="default-value">자기소개 글</span>' : user.introduceContent}
    	</p>
        
        <div class="line"></div>
        
        <a>설문조사</a>
        
        <p>
            <c:choose>
                <c:when test="${user.hikingPurpose == 0}">
                    취미
                </c:when>
                <c:when test="${user.hikingPurpose == 1}">
                    운동
                </c:when>
                <c:when test="${user.hikingPurpose == 2}">
                    친목
                </c:when>
            </c:choose>
        </p>
        <p>
            <c:choose>
                <c:when test="${user.hikingDifficulty == 0}">
                    어려움
                </c:when>
                <c:when test="${user.hikingDifficulty == 1}">
                    보통
                </c:when>
                <c:when test="${user.hikingDifficulty == 2}">
                    쉬움
                </c:when>
            </c:choose>
        </p>
        <p>
            <c:choose>
                <c:when test="${user.hikingLevel == 0}">
                    경험없음
                </c:when>
                <c:when test="${user.hikingLevel == 1}">
                    1년에 1~2회 이상
                </c:when>
                <c:when test="${user.hikingLevel == 2}">
                    1년에 5회 이상
                </c:when>
                <c:when test="${user.hikingLevel == 3}">
                    한 달에 1~2회 이상
                </c:when>
                <c:when test="${user.hikingLevel == 4}">
                    한 달에 5회 이상
                </c:when>
            </c:choose>
        </p>
        
        
        <c:if test="${admin != null}">
           <%--  <p>Creation Date: ${user.creationDate}</p> --%>
            <p>Withdraw Date: ${user.withdrawDate}</p>
            <p>Withdraw Reason: 
                <c:choose>
                    <c:when test="${user.withdrawReason == 0}">
                        서비스 만족도 낮음
                    </c:when>
                    <c:when test="${user.withdrawReason == 1}">
                        사용 빈도 감소
                    </c:when>
                    <c:when test="${user.withdrawReason == 2}">
                        고객 지원 불만
                    </c:when>
                    <c:when test="${user.withdrawReason == 3}">
                        유사한 다른 서비스 존재
                    </c:when>
                    <c:when test="${user.withdrawReason == 4}">
                        기타
                    </c:when>
                </c:choose>
            </p>
        </c:if>     		
    </div>
    	
    <div class="creation-section">
    	<a>${user.creationDate}</a>
    </div>
    
    <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
    <input type="hidden" id="userId" name="userId" value="${user.userId}">
    
	<br>
		
	<div class="link-section">
		<%--  <button type="button" class="a" onclick="location.href='/user/updateUser?userNo=${user.userNo}' ">회원정보 수정하기</button> --%>
		 <form action="/user/updateUser" method="get">
            <input type="hidden" name="userNo" value="${user.userNo}">
            <button type="submit" class="a">회원정보 수정하기</button>
        </form>
	    <%-- <a href="/user/updateUser?userNo=${user.userNo}" class="button">회원정보 수정하기</a> --%>
    	 <a href="/user/deleteUser?userNo=${user.userNo}" class="text-link">탈퇴하기</a>
	</div>
    <!-- <button type="button" class="signup-btn" onclick="history.back()">뒤로</button> -->
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// --> 

<footer>
</footer>

</body>
</html>
