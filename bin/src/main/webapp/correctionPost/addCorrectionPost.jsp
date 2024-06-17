<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script>
		$(function(){
			$("#inputButton").on("click",function(){
				const data  = {
					userNo : parseInt($("#userNo").val()),
					mountainNo : parseInt($("#mountainNo").val()),
					mountainName : $("#mountainName").val(),
					contents: $("#contents").val()
				}
				
				
				
				$.ajax({
					url:"http://127.0.0.1:8001/correctionPost/rest/addCorrectionPost",
					method: "POST",
					contentType:"application/json",
					//dataType: "json",
					data: JSON.stringify(data),
					success: function(response) {
	                    alert('Mountain updated successfully');
	                    //console.log(response);
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



	<input type="hidden" id="userNo" name="userNo" value="1" />
	<input type="hidden" id="mountainNo" name="mountainNo" value="1010" />
	<input type="hidden" id="mountainName" name="mountainName" value="관악산" />


	<textArea id="contents" name="contents"> </textArea>
	
	<button id="inputButton"></button>




</body>
</html>