<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


<script>
	$(function(){
		$("#submit").on('click', function(){
			const data = {
	                mountainNo: parseInt($('#mountainNo').val()),
	                mountainLocation: $('#mountainLocation').val(),
	                mountainDescription: $('#mountainDescription').val(),
	                mountainAltitude: parseFloat($('#mountainAltitude').val()),
	                mountainTrailCount: parseInt($('#mountainTrailCount').val())
	            };
			
				console.log("data:");
				console.log(data);

	            $.ajax({
	                url: "http://127.0.0.1:8001/mountain/rest/updateMountain?crpNo=${crpNo}",
	                method: "POST",
	                contentType: "application/json",
	                dataType: "json",
	                data: JSON.stringify(data),
	                success: function(response) {
	                    alert('Mountain updated successfully');
	                    console.log(response);
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    console.error('Error:', textStatus, errorThrown);
	                    alert('Failed to update mountain');
	                }
	            });
		});
	});
	

</script>

<script>
    $(document).ready(function() {
        $(".search-button").click(function() {
            var keyword = $(this).val();
            $("#searchInput").val(keyword);
            $("#searchForm").submit();
        });
    });
</script>



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
<body>



	<header></header>
	
	
	

	<main></main>
	
	
	
	
	
	<footer></footer>
	
	
	
	
	
</body>
</html>