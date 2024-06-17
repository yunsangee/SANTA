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


</head>
<body>

        <label for="mountainNo">Mountain No:</label>
        <input type="text" id="mountainNo" name="mountainNo" value=20><br><br>
        
        <label for="mountainLocation">Mountain Location:</label>
        <input type="text" id="mountainLocation" name="mountainLocation"><br><br>
        
        <label for="mountainDescription">Mountain Description:</label>
        <input type="text" id="mountainDescription" name="mountainDescription"><br><br>
        
        <label for="mountainAltitude">Mountain Altitude:</label>
        <input type="text" id="mountainAltitude" name="mountainAltitude"><br><br>
        
        <label for="mountainTrailCount">Mountain Trail Count:</label>
        <input type="number" id="mountainTrailCount" name="mountainTrailCount"><br><br>
        
        <button id="submit">Update Mountain</button>

</body>
</html>