<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script>
		$(document).ready(function(){
			$("#inputButton").on("click",function(event){
				event.preventDefault();
				const data  = {
					userNo : parseInt($("#userNo").val()),
					mountainNo : parseInt($("#mountainNo").val()),
					mountainName : $("#mountainName").val(),
					contents: $("#contents").val()
				};

				
			 	alert('/correctionPost/rest/addCorrectionPost');
				let url = '/correctionPost/rest/addCorrectionPost';
				$.ajax({
		            url: url,
		            method: "GET",
		            data: data, // data 객체를 쿼리 파라미터로 전송
		            success: function(response) {
		                alert('Mountain updated successfully');
		                console.log(response);
		                window.close();
		            },
		            error: function(jqXHR, textStatus, errorThrown) {
		                console.error('Error:', textStatus, errorThrown);
		                alert('Error:', textStatus, errorThrown);    
		                alert('Failed to update mountain');
		            }
		        });
			 	
			/* 	window.close();  */
				
			});
		});
		

	</script>
	
</head>
<body>

    <div class="dialog-overlay write">
        <div class="dialog-content">
            <button class="close-button" onclick="closeDialog()">&times;</button>

            <h2></h2>

            <div class="profile-header">
                <img src="${user.profileImage}" alt="Profile Image">
                <p>${user.nickName}</p>
            </div>

         <div class="line"></div>
      
            <form action="/user/addQnA" method="post">
                <div class="form-group">
                    <label for="title">산 명칭<span>*</span></label>
                    <input type="text" id="title" name="title" value="${mountain.mountainName}" placeholder="산 명칭을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="contents">내용<span>*</span></label>
                    <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
                </div>
                <div class="form-group">
                    <button type="submit" id="inputButton">작성 완료하기</button>
                </div>
            </form>
        </div>
    </div>
    


	<input type="hidden" id="userNo" name="userNo" value="${sessionScope.user.userNo}" />
	<input type="hidden" id="mountainNo" name="mountainNo" value="${mountain.mountainNo}" />
	<input type="hidden" id="mountainName" name="mountainName" value="${mountain.mountainName}" />





</body>
</html>