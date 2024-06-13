<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>탈퇴 사유 선택</title>
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
            if (withdrawReason.value == "4" && withdrawContent.value.trim() === "") {
                alert("기타 사유를 적어주세요.");
                withdrawContent.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form action="/user/deleteUser" method="post" onsubmit="return validateForm()">
        <h2>회원 탈퇴</h2>
        <div>
            <label for="withdrawReason">탈퇴사유</label>
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
            <label for="withdrawContent">기타 사유</label>
            <textarea id="withdrawContent" name="withdrawContent" placeholder="기타 사유를 적어주세요"></textarea>
        </div>
        <div>
            <button type="submit" class="btn">탈퇴하기</button>
            <button type="button" onclick="history.back()">취소</button>
        </div>
    </form>
</body>
</html>
