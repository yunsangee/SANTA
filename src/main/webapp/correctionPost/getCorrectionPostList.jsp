<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:import url="../common/header.jsp"/>
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
		
		
		$("#delete").on('click',function(){
				const data  = {
					crpNo : parseInt(($(this).parent()).find("input:hidden[id='crpNo']").val()),
					userNo : parseInt(($(this).parent()).find("input:hidden[id='userNo']").val())
				}
				
				
				
				$.ajax({
					url:"http://${javaServerIp}/correctionPost/rest/deleteCorrectionPost",
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
            width: 200px;
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

        .tabs-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>


</head>
<body>
<header>
        <c:import url="../common/top.jsp"/>
    </header>
   
    <main>
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
                            <input type="text" name="searchKeyword" class="form-control search-input" placeholder="Search by keyword" value="${search.searchKeyword}">
                            <button type="button" id="search">검색</button>
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
                            </tr>
                        </thead>
                        <tbody>
    <c:forEach var="correctionPost" items="${correctionPostList}">
        <tr data-postid="${correctionPost.postNo}">
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
                    <button id="update" type="button">Update</button>
                    <button id="delete" type="button">Delete</button>
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
    
    <footer></footer>



</body>
</html>