<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
<meta charset="UTF-8">
<title>산 조아요</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<c:import url="../common/header.jsp"/>
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

  <style>
	 .pagination {
	            display: flex;
	            justify-content: center;
	        }
	        
	        .pagination a {
	            margin: 5px;
	            padding: 10px;
	            border: 1px solid #81C408;
	            border-radius: 5px;
	            text-decoration: none;
	            color: #81C408;
	        }
	        
	        .pagination a:hover {
	            background-color: #DEFBA7;
	        }
	        
	        .pagination .active {
	            background-color: #81C408;
	            color: white;
	        }
	        
	         .dropdown-custom, .search-input {
            padding: 7px;
            font-size: 13px;
            border: 1px solid #D4D4D4;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .dropdown-custom {
            margin-left: 10px;
        }
        
        .search-input {
            margin-right: 10px;
        }

        .search-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        
         .text {
        	color : inherit;
        }
        
          .btn-custom {
            margin: 0 5px;
            padding: 10px;
            border: 1px solid #81C408;
            border-radius: 5px;
            text-decoration: none;
            color: #81C408;
        }

        .btn-custom:hover {
            background-color: #DEFBA7;
        }

        .btn-custom.active {
            background-color: #81C408;
            color: white;
        }
        
	        
</style>

  <!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// --> 

 <script>
    $(document).ready(function() {
        
        
     	$('.search-input').keypress(function(event) {
            if (event.which == 13) {
            	console.log('Enter key pressed'); // Debugging
                event.preventDefault();
                $(this).closest('form').submit();
                
            }
        });    
     
     $(document).on('click', '.pagination a', function(event) {
         event.preventDefault();
         $('#currentPage').val($(this).data('page'));
         $('#searchForm').submit();
     });
     
  });
    
</script>

<style>
	.LikeContainer{
		margin-top:100px;
	
	}
	
	
</style>

</head>

 <!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// --> 

<body>

  <!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// --> 

<header>
    <c:import url="../common/top.jsp" />
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main>
	<div class="LikeContainer">
		<div class="LikeContainer2">
			<div class="search-container">
				<form id="searchForm" action="/mountain/getMountainLikeList" method="get" style="display: flex; align-items: center;">
					<select name="searchCondition" class="dropdown-custom">
                        <option value="0" ${search.searchCondition != null && search.searchCondition == 0 ? 'selected' : '' }>Mt.Name </option>
                        <option value="1"${search.searchCondition != null && search.searchCondition == 1 ? 'selected' : '' }>Location</option>
                    </select>
                    <!--  산 조아요 목록 rest 만들어야겠넹 -->
						
			<input type="text" name="searchKeyword" class="form-control search-input" placeholder="Search by keyword" value="${search.searchKeyword != null ? search.searchKeyword : '' }">
            <input type="hidden" id="currentPage" name="currentPage" value="1">     
                 </form>
             </div>   
             
            <div class="table-responsive">
            	<table class="table">
            		<thead>
            			<tr>
            				<th scope="col">No.</th>
            				<th scope="col">Mountain Name</th>
            				<th scope="col">Location</th>
            				<th scope="col">Like</th>
            				<th scope="col">Like Date</th>
            			</tr>
            		</thead>
            		
            	<tbody id ="LikeTable">
            		<c:forEach var="mountain" items="${mountainList}">
            			<tr>
            				<td>${mountainList.indexOf(mountain) + 1}</td>
            				<td><a class="text" href="/mountain/getMountain?mountainNo=${mountain.mountainNo}&lat=${mountain.mountainLatitude}&lon=${mountain.mountainLongitude}">${mountain.mountainName}</a></td>
            				<td>${mountain.mountainLocation}</td>
            				<td>${mountain.likeCount}</td>
            				<td>${mountain.date}</td>
            			</tr>
            		</c:forEach>
            	</tbody>
            </table>
          </div>
           
           <div class="pagination">
           		<c:forEach var="i" begin="1" end="${totalPages}">
           			 <a href="javascript:void(0);" data-page="${i}" class="btn-custom ${i == currentPage ? 'active' : ''}">${i}</a>
           		</c:forEach>
           </div>
         </div>
       </div>
            				
<%-- <c:forEach var="mountain" items="${mountainList}">
	<div class="mountain-details">
	
    	<img src="${mountain.mountainImage}" alt="Mountain Image">
    	<h2>${mountain.mountainName}</h2>
    	<p><strong>Latitude:</strong> ${mountain.mountainLatitude}</p>
    	<p><strong>Longitude:</strong> ${mountain.mountainLongitude}</p>
    	<p><strong>Locations:</strong> ${mountain.mountainLocation}</p>
    	<p><strong>Description:</strong> ${mountain.mountainDescription}</p>
    	<p><strong>Altitude:</strong> ${mountain.mountainAltitude} m</p>
    	<p><strong>Trails:</strong> ${mountain.mountainTrailCount}</p>
    	<p><strong>Likes:</strong> ${mountain.likeCount}</p>
    	<p><strong>Views:</strong> ${mountain.mountainViewCount}</p>
    	<p><strong>Certified Posts:</strong> ${mountain.certifiedPostCount}</p>
    	<p><strong>Calendar Registered:</strong> ${mountain.calandarRegisteredCount}</p>
    	<p><strong>Meeting Posts:</strong> ${mountain.meetingPostCount}</p>
    	<h3>Trails</h3>
    	<ul>
        	<c:forEach var="trail" items="${mountain.mountainTrail}">
            	<li>${trail}</li>
        	</c:forEach>
    	</ul>
	</div>
</c:forEach> --%>

</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer></footer>

</body>
</html>