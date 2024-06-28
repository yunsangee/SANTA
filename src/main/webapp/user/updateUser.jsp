<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
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
            top: 55px; /* Adjust as needed */
            left:58px; /* Adjust as needed */
            background-color: #white;
            border-radius: 50%;
            padding: 5px;
            font-size: 30px;
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

        .profile-info a {
            margin: 5px 0;
            color: black;
            font-weight: bold;
            font-size:15px;
        }

        .update, .phone-link, .detail-section p, .detail-section textarea, .detail-section select {
            width: 400px; /* 원하는 크기로 조절합니다. */
            padding: 10px; /* 입력 필드 내부 여백(padding)을 추가합니다. */
            font-size: 16px; /* 폰트 크기를 조정합니다. */
            background-color: #ffffff; /* 배경색 추가 */
            color: black;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px;
            margin-bottom: 5px; /* 입력 필드 간 간격 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        .update:focus, .detail-section textarea:focus,  .detail-section select:focus, .phone-link:focus {
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

        footer {
            width: 100%;
            text-align: center;
            position: absolute;
            bottom: 0;
        }

        .error-message {
            color: red;
            font-size: 13px;
            margin-top: -1px;
            margin-bottom: 10px;
            text-align: left;
            width: 100%;
            align-items: center;
            justify-content: center;
        }

        .success-message {
            color: green;
            font-size: 16px;
            margin-top: -1px;
            margin-bottom: 10px;
            text-align: left;
            width: 100%;
            align-items: center;
            justify-content: center;
        }
        
        .back-section {
        	width: 100%;
		    font-size: 13.5px;
    		text-align: center;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer; 
		    margin-bottom:50px;
		    margin-top:-60px;
        }
        
        .back-section a {
        	color : grey;
        	text-decoration: underline;
        }
        
        .file-input{
        	display:none;
        }

        
    </style>

    <!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->

    <script>
        $(document).ready(function() {
            $(".submit").click(function() { 
                if ($("#profile").val() != "") {
                    $("form").attr("enctype", "multipart/form-data").submit();
                } else {
                    $("#profile").remove();
                    $("form").submit();
                }
            });
            
            $('.pencil').on("click", function(){
            	 console.log("click");
                 
                 $('#profile').click();
                 let intervalId = setInterval(function() {
                     var profileValue = $('#profile').val();
                     if (profileValue) {
                         console.log('Profile value is set:', profileValue);
                         
                         
                         let formData = new FormData();
                         formData.append("image",$('#profile')[0].files[0]);
                         
                         
                         $.ajax({
                        	 url:'/user/rest/updateProfile',
                        	 type: 'POST',
                        	 data: formData,
                        	 processData: false,  // 기본적으로 처리하지 않도록 설정
                             contentType: false,
                        	 success: function(response){
                        		 console.log('success');
                        		 console.log(response);
                        		 
                        		 $('.profile').attr("src",response);
                        		 
                        		 
                        		 clearInterval(intervalId);  // 조건이 만족되면 주기적인 확인 중지
                        	 },
                        	 error:function(jqXHR, textStatus, errorThrown) {
                                 console.error('File upload failed:', textStatus, errorThrown);
                             }
                         });
                         
                         
                        
                     } else {
                         console.log('Profile value is not set');
                     }
                 }, 3000); // 3000 밀리초 = 3초
            });

            // 주소 클릭 시 도로명 주소 창 열기
            $("input[name='address']").click(function() {
                window.open("/user/address.jsp", "pop", "width=570,height=420, scrollbars=yes, resizable=yes"); 
            });

            // 닉네임 중복 체크
            $("input[name='nickName']").on("blur", function() {
                var nick = $(this).val();
                if (nick.length >= 10) {
                    $("#nickMessage").text("10글자 미만의 닉네임을 작성해주세요.").css("color", "red");
                    $(".submit").prop("disabled", true);
                } else if (nick) {
                    $.ajax({
                        url: '/user/rest/checkDuplicationNickName',
                        type: 'GET',
                        data: { nickName: nick },
                        success: function(response) {
                            var message = response.message;
                            var status = response.status;
                            if (status === "duplicated") {
                                $("#nickMessage").text("중복된 닉네임입니다.").css("color", "red");
                                $(".submit").prop("disabled", true);
                            } else if (status === "available") {
                                $("#nickMessage").text("사용 가능한 닉네임입니다.").css("color", "green");
                                $(".submit").prop("disabled", false);
                            }
                        },
                        error: function(xhr, status, error) {
                            $("#nickMessage").text("오류가 발생했습니다.").css("color", "red");
                            $(".submit").prop("disabled", true);
                        }
                    });
                } else {
                    $("#nickMessage").text("");
                    $(".submit").prop("disabled", false);
                }
            });

            // 사용자 ID 클릭 시 비밀번호 변경 팝업 창 열기
            $(".text-link").click(function(event) {
                event.preventDefault(); // 기본 동작 막기
                window.open($(this).attr("href"), "비밀번호 변경", "width=500,height=420,scrollbars=yes,resizable=yes");
            });

            // 전화번호 칸 클릭시 전화번호 변경 팝업 창 열기
            $(".phone-link").click(function(event) {
                window.open("/user/changePhone.jsp", "전화번호 변경", "width=500,height=420,scrollbars=yes,resizable=yes");
            });
        });

        // 도로명 주소 콜백 함수
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            $("input[name='address']").val(roadAddrPart1);
            $("input[name='detailAddress']").val(addrDetail);
        }

        // 팝업 창이 닫힐 때 부모 창을 새로고침
        function closePopupAndReload() {
            window.opener.location.reload();
            window.close();
        }
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
            <div class="profile-container">
                <img src="${sessionScope.user.profileImage}" class="profile">
                <a class="pencil">📷 </a>
                <input type="file" id="profile" class="file-input"/>
                <!-- ✏️ -->
            </div>
            <div class="profile-info">
                <p>${user.badgeImage} 인증 ${user.certificationCount}회, 모임 ${user.meetingCount}회</p>
                <a href="/user/changePassword.jsp" class="text-link">${user.userId}✏️</a> 
                <!--  <button type="button" ><input type="file" id="profile" name="image" value=""></button> -->
            </div>
        </div>

        <div class="detail-section">
            <input type="text" class="update" name="nickName" value="${user.nickName}" required>
            <div id="nickMessage" class="error-message"></div>
            <p>${user.birthDate}</p> <!-- Birth Date는 수정 불가 -->
            <div class="phone-container">
                <input type="text" class="phone-link" name="phoneNumber" value="${user.phoneNumber}" readonly>
            </div>
            <input type="text" class="update" name="address" value="${user.address}" readonly>
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
            <textarea class="update" name="introduceContent" placeholder="자기소개">${user.introduceContent}</textarea>
            
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
        
<%--         <div class="creation-section">
            <a>${user.creationDate}</a>
        </div> --%>
        
        <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
        <input type="hidden" id="userId" name="userId" value="${user.userId}">
        
        <!-- <br> -->
            
        <div class="link-section">
            <button type="button" class="a submit">수정 완료하기</button>
        </div>    

	<div class="back-section">
		<a href="/user/getUser">뒤로</a>
	</div>

    </form>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// --> 

<footer></footer>

</body>
</html>
