<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:import url="../common/header.jsp"/>
<script>
	$(document).ready(function(){
		$("button:contains('update')").on('click',function(){
			
			console.log("#form"+ ($(this).parent()).find("input:hidden[id='crpNo']").val());
			
			/* let formId = "#form" + ($(this).parent()).find("input:hidden[id='crp']").val(); */
			
			var crpValue = $(this).parent().find("input:hidden[id='crpNo']").val();

	        // 해당 값을 사용하여 폼의 id를 찾아서 속성 설정 후 제출
	        $("#form" + crpValue).attr("action","/mountain/updateMountain").attr("method","GET").submit(); 
			/* console.log($( $(this).parent()).html());
			console.log($( $(this).parent()).find("input:hidden[id='crpNo']").val() );  */
		});
		
		 $(document).on('click', '.pagination a', function(event) {
	            event.preventDefault(); // 링크 기본 동작 방지
	            var page = $(this).attr('data-page');
	            
	            console.log('page:' + page);
	            
	            const form = $('<form>', {
    	            action: '/correctionPost/getCorrectionPostList',
    	            method: 'GET'
    	        });

    	        // mountainSearch 객체의 각 데이터를 폼의 hidden input 필드로 추가

    	            $('<input>').attr({
    	                type: 'hidden',
    	                name: "currentPage",
    	                value: page
    	            }).appendTo(form);

    	        // 폼을 body에 추가하고 제출
    	        form.appendTo('body').submit();
	            
	        });
		
		 $('#search').on('click',function(event) {
	            event.preventDefault(); // 링크 기본 동작 방지
	            const searchCondition = $('select[name="searchCondition"]').val();
	            const searchKeyword = $('input[name="searchKeyword"]').val();
	            const currentPage = $('input[name="currentPage"]').val();
	            
	            const form = $('<form>', {
	                action: '/correctionPost/getCorrectionPostList',
	                method: 'GET'
	            });
	            
	            // 검색 조건 추가
	            $('<input>').attr({
	                type: 'hidden',
	                name: "searchCondition",
	                value: searchCondition
	            }).appendTo(form);

	            // 검색 키워드 추가
	            $('<input>').attr({
	                type: 'hidden',
	                name: "searchKeyword",
	                value: searchKeyword
	            }).appendTo(form);

	            // 현재 페이지 추가
	            $('<input>').attr({
	                type: 'hidden',
	                name: "currentPage",
	                value: 1
	            }).appendTo(form);
	            
	            // 폼을 body에 추가하고 제출
	            form.appendTo('body').submit();
	        });
		
		
		$(".delete").on('click',function(){
			
				const data  = {
					postNo : parseInt(($(this).parent()).find("input:hidden[id='crpNo']").val()),
					userNo : parseInt(($(this).parent()).find("input:hidden[id='userNo']").val())
				}
				
				console.log(data.postNo);
				console.log(data.userNo);
				
				$.ajax({
					url:"/correctionPost/rest/deleteCorrectionPost",
					method: "POST",
					contentType:"application/json",
					//dataType: "json",
					data: JSON.stringify(data),
					success: function(response) {
	                    //alert('Mountain updated successfully');
	                    //console.log(response);
	                    $("#"+data.postNo).remove();
	                    
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    console.error('Error:', textStatus, errorThrown);
	                    //alert('Failed to update mountain');
	                }
						
				});
		});
		
		$(".update").on('click',function(event){
					//event.preventDefault();
					let mountainNo = $(this).closest("form").find("#mountainNo").val();
					let crpNo = $(this).closest("form").find("#crpNo").val();
					let user = {
			                profileImage: "${user.profileImage}",  // Replace with actual user profile image path
			                nickName: "${user.badgeImage}",             // Replace with actual user nickname
			                badgeImage: "${user.nickName}",      // Replace with actual user badge image path
			                userNo:"${user.userNo}"
			            };
					
					
		            $.ajax({
		                url: '/mountain/rest/getMountain',
		                method: 'GET',
		                data: { userNo: user.userNo, mountainNo: mountainNo },
		                success: function(response) {
							let mountain = response.mountain;
							let user = response.user;

		                    var content = '<button class="close-button" onclick="closeDialog()">&times;</button>' +
		                    '<h2></h2>' +
		                    '<div class="profile-header">' +
		                    '<img src="' + user.profileImage + '" alt="Profile Image">' +
		                    '<p>' + user.nickName + '<img src="' + user.badgeImage + '" style="width:24px; height:24px;"></p>' +
		                    '</div>' +
		                    '<div class="line"></div>' +
		                    '<div class="form-group">' +
		                    '<label for="title">산 명칭<span>*</span></label>' +
		                    '<input type="text" id="title" name="title" value="' + mountain.mountainName + '" placeholder="산 명칭을 입력하세요" required>' +
		                    '</div>' +
		                    '<div class="form-group">' +
		                    '<label for="mountainLocation">산 위치</label>' +
		                    '<input type="text" id="mountainLocation" name="mountainLocation" value="' + mountain.mountainLocation + '"><br><br>' +
		                    '</div>' +
		                    '<div class="form-group">' +
		                    '<label for="mountainAltitude">산 높이</label>' +
		                    '<input type="text" id="mountainAltitude" name="mountainAltitude" value="' + mountain.mountainAltitude + '"><br><br>' +
		                    '</div>' +
		                    '<div class="form-group">' +
		                    '<label for="mountainDescription">100대 산 선정사유 및 등산 코스</label>' +
		                    '<textarea id="mountainDescription" name="mountainDescription" rows="10" placeholder="내용을 입력하세요" required>' + mountain.mountainDescription + '</textarea>' +
		                    '</div>' +
		                    '<div class="form-group">' +
		                    '<button type="submit" id="inputButton">작성 완료하기</button>' +
		                    '<tr>'+
		                    '<input type="hidden" id="userNo" name="userNo" value="' + user.userNo + '" />' +
		                    '<input type="hidden" id="mountainNo" name="mountainNo" value="' + mountain.mountainNo + '" />' +
		                    '<input type="hidden" id="crpNo" name="crpNo" value="' + crpNo + '" />';
		                    '</tr>'+
		                    '</div>' +
		                    
		                    $('.dialog-content').html(content);
		                    $('.dialog-overlay.details').addClass('active');
		                    dialogVisible = true;
		                   
		                },
		                error: function() {
		                }
		            });
		        });
	});

	$(document).ready(function(){
		$("#dialog").on('submit', function(){
			const data = {
					mountainNo:$(this).closest("form").find("#mountainNo").val(),
	                mountainName:$(this).closest("form").find("#title").val(),
	                mountainLocation: $(this).closest("form").find('#mountainLocation').val(),
	                mountainDescription: $(this).closest("form").find('#mountainDescription').val(),
	                mountainAltitude: parseFloat($(this).closest("form").find('#mountainAltitude').val()),
	            };
			
				console.log("data:");
				console.log(data);
				
				
				let crpNo = $(this).closest("form").find('#crpNo').val();
				
				alert('crpNo:' + crpNo);
	            $.ajax({
	                url: "/mountain/rest/updateMountain?crpNo=" + crpNo,
	                method: "POST",
	                contentType: "application/json",
	                dataType: "json",
	                data: JSON.stringify(data),
	                success: function(response) {
	                    //alert('Mountain updated successfully');
	                    console.log(response);
	                    closeDialog();
	                    window.location.reload();
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    console.error('Error:', textStatus, errorThrown);
	                    //alert('Failed to update mountain');
	                }
	            });
		});
	});
	
	function closeDialog() {
        $('.dialog-overlay').removeClass('active');
        dialogVisible = false;
    }
</script>
 <style>
        .tabs {
            display: flex;
            border-bottom: 2px solid #eee;
            align-items: center;
            margin-bottom: -15px; /* 탭 아래 선이 목록 맨 위 선과 겹치도록 */
        }

        .tab {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            color: #81C408;
            border-bottom: 2px solid transparent;
            margin-right: 10px;
        }

        .tab.active {
            border-bottom: 2px solid #FFA500;
            color: #FFA500;
        }

        .tab:hover {
            color: #DEFBA7;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px;
            border: 1px solid #81C408;
            border-radius: 5px;
            text-decoration: none;
            color: #81C408;
            width: 30px;
            height: 30px;
            align-items: center;
            justify-content: center;
            display: flex;
        }

        .pagination a:hover {
            background-color: #DEFBA7;
        }

        .pagination .active {
            background-color: #81C408;
            color: white;
        }

        .dropdown-custom {
            padding: 7px;
            font-size: 13px;
            background-color: white;
            border: 1px solid #D4D4D4;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
            color: black;
            margin-left: 10px;
        }

        .search-input {
            padding: 7px;
            font-size: 13px;
            background-color: white;
            border: 1px solid #D4D4D4;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
            color: black;
            width: 250px;
            margin-right: 10px;
        }

        .search-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            flex-grow: 1;
        }
        
        .searchBox {
	flex: 1; 
	padding: 10px; 
	border: none; 
	outline: none; 
	border: 1px solid #ccc; 
	border-radius: 35px; 
	padding: 10px;
	margin-left:20px;
}

.search {
	background: none; 
	border: none; 
	cursor: pointer;
	margin-left: -50px;
}

		.search i {
            font-size: 18px;
        }

        .search:hover {
           /*  background-color: #006400; */
        }

        .tabs-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .border{
        	border:#90EE90;
        }
         .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding-top:20px;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.dialog-overlay.active {
    display: flex;
}
.dialog-content {
      background: #fff;
      padding: 20px;
      border-radius: 5px;
      margin-top:45px;
      width: 35%;
      height: 80%;
      display: flex;
      flex-direction: column;
      position: relative;
    }

        /* ///////////////////////////////////////////////////////////////////////////////////////////////////////////// */
        
       .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #555;
            background: none;
            border: none;
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .profile-header p {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .form-group {
            margin-bottom: 5px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 13.5px;
            text-align: left; /* 왼쪽 정렬 추가 */
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border: 1px solid #81C408;
            outline: none;
            box-shadow: 0 0 5px rgba(129, 196, 8, 0.5);
        }

        .form-group select {
            height: 40px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #218838;
        }
        
        
        .dialog-content h2 {
           font-size:20px;
        }
        
        .line {
          border-bottom: 1px solid #ccc;
          margin-bottom:15px;
          margin-top:-15px;
      }
      
      .td{
      	align-items:center;
      
      }
    </style>


</head>
<body>
<header>
        <c:import url="../common/top.jsp"/>
    </header>
   
    <main style="margin-top:30px;">
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="tabs-container">
                    <div class="tabs">
                       <div class="tab">정정 제보 목록</div>
                    </div>
                    <div class="search-container">
                            <select name="searchCondition" class="dropdown-custom">
                                <option value="0" ${search.searchCondition == 0 ? 'selected' : ''}>산 이름</option>
                            </select>
                            <input type="text" name="searchKeyword" class="form-control search-input" placeholder="검색어를 입력해주세요!" value="${search.searchKeyword}">
                             <button class="search" >
                				<i class="fas fa-search text-primary" id="search"></i>
           					 </button>
                            <input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Mountain Name.</th>
                                <th scope="col">User NickName.</th>
                                <th scope="col">Contents</th>
                                <th scope="col">Claim Date</th>
                               	<th scope="col">Is Checked</th>
                            </tr>
                        </thead>
                        <tbody>
    <c:forEach var="correctionPost" items="${correctionPostList}">
        <tr id="${correctionPost.postNo}">
            <th scope="row">
                <div class="d-flex align-items-center">
                    <p class="mb-0 mt-4">${correctionPost.postNo}</p>
                </div>
            </th>
            <td>
                <p class="mb-0 mt-4">
                    <a href="/mountain/getMountain?mountainNo=${correctionPost.mountainNo}" style="text-decoration: none; color: inherit;">${correctionPost.mountainName}</a>
                </p>
            </td>
            <td>
                <p class="mb-0 mt-4">
                    <a href="/user/getUser?userNo=${correctionPost.userNo}" style="text-decoration: none; color: inherit;">${correctionPost.nickName}</a>
                </p>
            </td>
            <td>
                <p class="mb-0 mt-4">${correctionPost.contents}</p>
            </td>
            <td>
                <p class="mb-0 mt-4">${correctionPost.postDate}</p>
            </td>
            <td>
                <form id="form${correctionPost.postNo}">
                    <input type="hidden" id="userNo" name="userNo" value="${correctionPost.userNo}"/>
                    <input type="hidden" id="crpNo" name="crpNo" value="${correctionPost.postNo}"/>
                    <input type="hidden" id="mountainNo" name="mountainNo" value="${correctionPost.mountainNo}"/>
                    <c:if test="${correctionPost.status == 0}">
                   	 	<button id="update" class="update btn border border-secondary px-2 text-primary" type="button">수정</button>
                   	 </c:if>
                    <button id="delete" class="delete btn border border-secondary  px-2 text-primary" type="button">삭제</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</tbody>

                    </table>
                </div>
                    <div class="pagination">
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <a href="javascript:void(0);" data-page="${page}" class="btn-custom ${page == currentPage ? 'active' : ''}">${page}</a>
                        </c:forEach>
                    </div>
            </div>
        </div>
    </main>
    
    <form id="dialog">	
    <div class="dialog-overlay details">
    <div class="dialog-content details">

    </div>
  </div>
  </form>
  
    
    <footer></footer>



</body>
</html>