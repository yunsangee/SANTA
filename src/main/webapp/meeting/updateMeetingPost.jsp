<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>모임 게시글 작성</title>
    <c:import url="../common/header.jsp"/>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
    
    <script type = "text/javascript">
    	
    	$(function() {
    		
    		$("#recruitmentDeadline").datepicker({
    	        dateFormat: "yy-mm-dd"
    	    });
    	    
    	    $("#appointedHikingDate").datepicker({
    	        dateFormat: "yy-mm-dd"
    	    });
    		
    	})
    
	    
    
    </script>
    
    <style>
    
    </style>
    
</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
	
	<main>
		
		<div class="container-fluid page-header py-5">
    		<h1 class="text-center text-white display-6">update Meeting Post</h1>
    	</div>
	
    	<form enctype="multipart/form-data">
			<div class="container-fluid py-5">
	    		<div class="container py-5">
	    			<div class="row mb-5">
	    			
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">작성자</div>
    					<div class="col-md-9 border align-items-center text-start py-3">${meetingPost.nickName}</div>
    					
    					<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">제목</div>
                        <div class="col-md-5 border align-items-center text-start py-2">
                            <input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" value="${meetingPost.title}" required>
                        </div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 등급</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
						    <select class="form-control" name="participationGrade">
						        <option value="0" ${meetingPost.participationGrade == 0 ? 'selected' : ''}>1번등급이미지</option>
						        <option value="1" ${meetingPost.participationGrade == 1 ? 'selected' : ''}>2번등급이미지</option>
						        <option value="2" ${meetingPost.participationGrade == 2 ? 'selected' : ''}>3번등급이미지</option>
						        <option value="3" ${meetingPost.participationGrade == 3 ? 'selected' : ''}>4번등급이미지</option>
						        <option value="4" ${meetingPost.participationGrade == 4 ? 'selected' : ''}>5번등급이미지</option>
						        <option value="5" ${meetingPost.participationGrade == 5 ? 'selected' : ''}>6번등급이미지</option>
						        <option value="6" ${meetingPost.participationGrade == 6 ? 'selected' : ''}>7번등급이미지</option>
						    </select>
						</div>
	    				
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">모임명</div>
	    				<div class="col-md-5 border align-items-center text-start py-2">
	    					<input type="text" class="form-control" name="meetingName" placeholder="모임명을 입력하세요" value="${meetingPost.meetingName}" required>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">모집 마감일</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" id="recruitmentDeadline" name="recruitmentDeadline" placeholder="날짜 선택" value="${meetingPost.recruitmentDeadline}" required>
	    				</div>
	    				
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">출발 예정지</div>
    					<div class="col-md-9 border align-items-center text-start py-2">
    						<div class="d-flex">
					            <div class="col-md-4 pe-2">
						            <input type="text" class="form-control" id="appointedDeparture" name="appointedDeparture" placeholder="주소" required>
						        </div>
						        <div class="col-md-8 ps-2">
						            <input type="text" class="form-control" id="appointedDetailDeparture" name="appointedDetailDeparture" placeholder="상세주소" required>
						        </div>
					        </div>
    					</div>
    					
    					<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 산</div>
	    				<div class="col-md-5 border align-items-center text-start py-2">
	    					<input type="text" class="form-control" name="appointedHikingMountain" placeholder="ex) 관악산" required>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 일자</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" id="appointedHikingDate" name="appointedHikingDate" placeholder="날짜 선택" required>
	    				</div>
	    				
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">최대 인원</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<div class="d-flex align-items-center">
		    					<input type="number" class="form-control me-2" name="maximumPersonnel" value="5" min="2" max="15" step="1">
	    						<span>명</span>
    						</div>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 희망 성별</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<select class="form-control" name="participationGender">
						        <option value="0">여성</option>
						        <option value="1">남성</option>
						        <option value="2">상관없음</option>
						    </select>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 희망 연령대</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" name="participationAge" placeholder="희망 연령대를 입력하세요">
	    				</div>
	    				
	    				<div class="col-md-2 border bg-light d-flex align-items-center justify-content-center title" id="contents">
						    내용
						</div>
						<div class="col-md-10 border py-2">
						    <textarea class="form-control mb-2" name="contents" rows="10" placeholder="내용을 입력하세요." style="height: 200px;" required></textarea>
						    <input type="file" id="meetingPostImage" name="meetingPostImage" multiple/><br/>
						</div>
						
	    			</div>
	    			
	    			<div class="row g-4 mb-4 d-flex ">
    					<div class="d-flex justify-content-end" id="postStatus">
    					
    						<button class="btn btn-primary border-0 rounded text-white px-4 py-3">수정하기</button>
    					
    					</div>
    				</div>
	    			
	    		</div>
	    	</div>
		
		</form>
    
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
