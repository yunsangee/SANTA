<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<%@ page import="site.dearmysanta.domain.user.User" %>

<%
    // 세션에 user 객체가 없으면 생성하여 설정합니다.
    if (session.getAttribute("user") == null) {
        User user = new User();
        user.setUserNo(1);  // userNo 값을 임의로 설정합니다.
        user.setNickName("재호짱");
        session.setAttribute("user", user);
    }
%>

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
    
	    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
			console.log("hi");
		    $("#appointedDeparture").val(roadAddrPart1);
		    $("#appointedDetailDeparture").val(addrDetail);
		}
	    
	    function fncAddMeetingPost() {
	        var isValid = true;
	        $('form input[required], form textarea[required]').each(function() {
	            if ($(this).val() === '') {
	                isValid = false;
	                $(this).css('border', '2px solid red');
	            } else {
	                $(this).css('border', '');
	            }
	        });
	        if (isValid) {
	            $("form").attr("method", "POST").attr("action", "/meeting/addMeetingPost").submit();
	        } else {
	            alert('모든 필수 입력란을 채워주세요.');
	        }
	    }
    
    	$(function() {
    		
		    $("#recruitmentDeadline").datepicker({
		        dateFormat: "yy-mm-dd"
		    });
		    
		    $("#appointedDeparture").on('click', function() {
		    	window.open("/user/address.jsp", "pop", "width=570, height=420, scrollbars=yes, resizable=yes");
		    })
		    
		    $("#appointedHikingDate").datepicker({
		        dateFormat: "yy-mm-dd"
		    });
		    
		    $("button:contains('등록')").on('click', function() {
		    	fncAddMeetingPost();
		    })
		    
    	});
    
    </script>
    
    <style>
    
    	.title {
    		background-color: #eeeeee !important;
    	}
    
    	#recruitmentDeadline {
    		background-color: #e9ecef;
    	}
    	
    	#appointedHikingDate {
    		background-color: #e9ecef;
    	}
    	
    	#contents {
    		padding-top: 4rem !important;
    		padding-bottom: 4rem !important;
    	}
    
    </style>
    
</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
	
	<main>
		
		<div class="container-fluid page-header py-5">
    		<h1 class="text-center text-white display-6">add Meeting Post</h1>
    	</div>
	
		<form enctype="multipart/form-data">
			<div class="container-fluid py-5">
	    		<div class="container py-5">
	    			<div class="row mb-5">
	    			
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">작성자</div>
    					<div class="col-md-9 border align-items-center text-start py-3">${sessionScope.user.nickName}</div>
    					
    					<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">제목</div>
                        <div class="col-md-5 border align-items-center text-start py-2">
                            <input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" required>
                        </div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 등급</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<select class="form-control" name="participationGrade">
						        <option value="0">1번등급이미지</option>
						        <option value="1">2번등급이미지</option>
						        <option value="2">3번등급이미지</option>
						        <option value="3">4번등급이미지</option>
						        <option value="4">5번등급이미지</option>
						        <option value="5">6번등급이미지</option>
						        <option value="6">7번등급이미지</option>
						    </select>
	    				</div>
	    				
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">모임명</div>
	    				<div class="col-md-5 border align-items-center text-start py-2">
	    					<input type="text" class="form-control" name="meetingName" placeholder="모임명을 입력하세요" required>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">모집 마감일</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" id="recruitmentDeadline" name="recruitmentDeadline" placeholder="날짜 선택" required>
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
    					
    						<button class="btn btn-primary border-0 rounded text-white px-4 py-3">등록하기</button>
    					
    					</div>
    				</div>
	    			
	    		</div>
	    	</div>
		
		</form>
    
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
</body>
</html>
