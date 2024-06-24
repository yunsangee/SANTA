<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>${user.nickName}님 산타 탈퇴</title>
    
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
   
 <!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->  
  
<style>
main {
    /* font-family: Arial, sans-serif; */
    padding: 20px;
}
        
h2 {
    font-family: Arial, sans-serif;
    font-size: 24px;
    color: #333;
    margin-left: 50px;
}

li {
    font-family: Arial, sans-serif;
    margin-left: 40px;
}

.container {
    max-width: 500px;
    margin: 0 auto;
    margin-top: 30px;
    padding: 20px;
}

.container label {
    font-weight: bold;
    display: block;
}

.container select {
    width: 500px;
    padding: 10px;
    margin-top: 10px;
    /* margin-bottom: 10px; */
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-left: 50px;
}

.container textarea {
    width: 500px;
    padding: 10px;
   /*  margin-top: 5px; */
    /* margin-bottom: 10px; */
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-left: 50px;
}

.container input[type="checkbox"] {
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-left: 50px;
}

button, a.button {
    width: 400px;
    padding: 15px;
    font-size: 16px;
    margin-top: 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    border-radius: 5px;
    cursor: pointer;
    box-sizing: border-box;
}

.a {  
	margin-top : 40px; 
    background-color: white;
    color: #81C408;
    border: 1px solid #81C408;
}

.a:hover {
    background-color: #DEFBA7; 
}

/* .cancel {
    background-color: #5bc0de;
    color: white;        
}

.cancel:hover {
    background-color: #31b0d5;
} */

.checkbox-label {
	margin-top: 30px;
    display: flex;
    align-items: center;
}

.checkbox-label2 {
	 display: flex;
    align-items: center;
}

.checkbox-label input, .checkbox-label2 input {
    margin-right: 10px;
}

.link-section {
    text-align: center;
    margin-top: 40px;
}

span {
    color: #EB001F;
    font-weight: bold;
}
</style>
  
 <!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// --> 
 
<script>
function toggleWithdrawContent() {
    var withdrawReason = document.getElementById("withdrawReason");
    var withdrawContentDiv = document.getElementById("withdrawContentDiv");
    var withdrawContent = document.getElementById("withdrawContent");
    if (withdrawReason.value == "4") {
        withdrawContentDiv.style.display = "block";
        withdrawContent.required = true;
    } else {
        withdrawContentDiv.style.display = "none";
        withdrawContent.required = false;
        withdrawContent.value = ""; // reset the value
    }
}

function validateForm() {
    var withdrawReason = document.getElementById("withdrawReason");
    var withdrawContent = document.getElementById("withdrawContent");
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            alert("모든 확인 사항에 동의해주세요.");
            checkboxes[i].focus();
            return false;
        }
    }
    if (withdrawReason.value == "4" && withdrawContent.value.trim() === "") {
        alert("기타 사유를 적어주세요.");
        withdrawContent.focus();
        return false;
    }
    return true;
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
    <h2>산타를 떠나시나요? <br>탈퇴하기 전에 꼭 확인해주세요.</h2>
    <br>
    <ul>
        <li>프로필, 모임 커뮤니티, 인증 커뮤니티, 등산 일정, 그 외 회원이 이용한 <span>모든 정보(기록)이 삭제</span>됩니다.</li>
        <li>탈퇴시 회원 정보(기록)은 복구되지 않으며, 탈퇴 취소 불가능 합니다. 유의해서 진행해주세요.</li>
        <li>탈퇴시 <span>7일간 재가입 불가능</span> 합니다.</li>
    </ul>

    <form action="/user/deleteUser" method="post" onsubmit="return validateForm()">
        <div class="Reason-section">
            <label for="withdrawReason"></label>
            <select id="withdrawReason" name="withdrawReason" onchange="toggleWithdrawContent()" required>
                <option value="" disabled selected>탈퇴사유를 선택하세요</option>
                <option value="0">서비스 만족도 낮음</option>
                <option value="1">사용 빈도 감소</option>
                <option value="2">고객 지원 불만</option>
                <option value="3">유사한 다른 서비스 존재</option>
                <option value="4">기타</option>
            </select>
        </div>
        <div id="withdrawContentDiv" style="display:none;">
            <label for="withdrawContent"></label>
            <textarea id="withdrawContent" name="withdrawContent" placeholder="기타 사유를 적어주세요"></textarea>
        </div>
        <div class="checkbox-label">
            <input type="checkbox" id="agreeDelete" required>
            <label for="agreeDelete">탈퇴시 회원 정보(기록) 삭제에 동의합니다.
                <span>*</span>
            </label>
        </div>
        <div class="checkbox-label2">
            <input type="checkbox" id="agreeWarning" required>
            <label for="agreeWarning">회원 탈퇴 주의사항을 확인했습니다.
                <span>*</span>
            </label>
        </div>
        
        <div class="link-section">
            <button type="submit" class="a">탈퇴하기</button>
       </div>
       <!-- <div class="link-section">
            <button type="button" class="cancel" onclick="history.back()">취소</button>
        </div> -->
    </form>
</main>
    
 <!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->
 
<footer></footer> 
 
</body>
</html>
