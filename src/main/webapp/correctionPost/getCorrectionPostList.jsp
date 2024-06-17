<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	$(function(){
		$("button:contains('update')").on('click',function(){
			
			console.log("#form"+ ($(this).parent()).find("input:hidden[id='crpNo']").val());
			
			/* let formId = "#form" + ($(this).parent()).find("input:hidden[id='crp']").val(); */
			
			var crpValue = $(this).parent().find("input:hidden[id='crpNo']").val();

	        // 해당 값을 사용하여 폼의 id를 찾아서 속성 설정 후 제출
	        $("#form" + crpValue).attr("action","/mountain/updateMountain").attr("method","GET").submit(); 
			/* console.log($( $(this).parent()).html());
			console.log($( $(this).parent()).find("input:hidden[id='crpNo']").val() );  */
		});
		
		
		$("#delete").on('click',function(){
				const data  = {
					crpNo : parseInt(($(this).parent()).find("input:hidden[id='crpNo']").val()),
					userNo : parseInt(($(this).parent()).find("input:hidden[id='userNo']").val())
				}
				
				
				
				$.ajax({
					url:"http://127.0.0.1:8001/correctionPost/rest/deleteCorrectionPost",
					method: "GET",
					contentType:"application/json",
					//dataType: "json",
					data: JSON.stringify(data),
					success: function(response) {
	                    alert('Mountain updated successfully');
	                    //console.log(response);
	                    $("div.correction-post"+data.crpNo).remove();
	                    
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    console.error('Error:', textStatus, errorThrown);
	                    alert('Failed to update mountain');
	                }
						
				});
		});
	});


</script>
       


</head>
<body>

	<c:forEach var="correctionPost" items="${correctionPostList}">
		<form id="form${correctionPost.postNo}">
		 <div class="correction-post${correctionPost.postNo}">
            <h2>${correctionPost.mountainName}</h2>
            <p><strong>Nickname:</strong> ${correctionPost.nickName}</p>
            <p><strong>Profile Image:</strong> ${correctionPost.profileImage}</p>
            <p><strong>Contents:</strong> ${correctionPost.contents}</p>
            <p><strong>Post Date:</strong> ${correctionPost.postDate}</p>
            
            <hr/>
        
        	<input type="hidden" id="userNo" name="userNo" value="${correctionPost.userNo}"/>
        	<input type="hidden" id="crpNo" name="crpNo" value="${correctionPost.postNo}"/>
        	<input type="hidden" id="mountainNo" name="mountainNo" value="${correctionPost.mountainNo}"/>
        	<button id="update" type="button">update</button>
        	<button id="delete" type="button">delete</button>
        </div>
       </form>
	
	</c:forEach>
	


</body>
</html>