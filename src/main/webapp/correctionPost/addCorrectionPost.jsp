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
					url:"${javaServerIp}/correctionPost/rest/addCorrectionPost",
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
				
				window.close();
				
			});
		});
		

	</script>
	<style>
        .modal {
            display: block; /* Show the modal by default for demonstration */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 10px;
            text-align: center;
            position: relative;
        }
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
        .modal-header,
        .modal-footer {
            padding: 10px;
        }
        .modal-body {
            padding: 10px;
        }
        .modal-body input {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-footer button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal-footer button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
	 <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="window.close()">&times;</span>
            <div class="modal-header">
                <h2>정정제보</h2>
            </div>
            <div class="modal-body">
                <p>&lt;정정에 필요한 내용을 입력해 주세요&gt;</p>
                <textArea id="contents" name="contents" placeholder="내용을 입력해주세요"> </textArea>
            </div>
            <div class="modal-footer">
                <button id="inputButton">제출</button>
            </div>
        </div>
    </div>


	<input type="hidden" id="userNo" name="userNo" value="1" />
	<input type="hidden" id="mountainNo" name="mountainNo" value="1010" />
	<input type="hidden" id="mountainName" name="mountainName" value="관악산" />





</body>
</html>