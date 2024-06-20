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
	                url: "http://127.0.0.1:8001/mountain/rest/updateMountain?postNo=${crpNo}",
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

<style>
		.close {
            color: #aaa;
            position: absolute;
            right: 10px;
            top: 10px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

</style>


</head>
<body>
		<span class="close" onclick="window.close()">&times;</span>
        <label for="mountainNo">Mountain No:</label>
        <input type="text" id="mountainNo" name="mountainNo" value="${mountain.mountainNo}"><br><br>
        
        <label for="mountainLocation">Mountain Location:</label>
        <input type="text" id="mountainLocation" name="mountainLocation" value="${mountain.mountainLocation}"><br><br>
        
        
        <label for="mountainAltitude">Mountain Altitude:</label>
        <input type="text" id="mountainAltitude" name="mountainAltitude" value="${mountain.mountainAltitude}"><br><br>
        
        
        <button id="submit">Update Mountain</button>

</body>
</html>