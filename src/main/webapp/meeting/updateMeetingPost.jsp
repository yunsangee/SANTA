<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>모임 게시글 작성</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
    <c:import url="../common/header.jsp"/>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
    
    <script type = "text/javascript">
    
	    function fncUpdateMeetingPost() {
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
	            $("form").attr("method", "POST").attr("action", "/meeting/updateMeetingPost").submit();
	        } else {
	            alert('모든 필수 입력란을 채워주세요.');
	        }
	    }
    	
    	$(function() {
    		
    		$("#recruitmentDeadline").datepicker({
    	        dateFormat: "yy-mm-dd"
    	    });
    	    
    	    $("#appointedHikingDate").datepicker({
    	        dateFormat: "yy-mm-dd"
    	    });
    	    
    	    $("button:contains('수정')").on('click', function() {
		    	fncUpdateMeetingPost();
		    })
		    
		    $(document).on('click', '.delete-image-button', function() {
		        var $this = $(this);
		        var $imageContainer = $this.closest('.image-div');  // 가장 가까운 .image-container를 찾음

		        $imageContainer.remove();  // .image-container를 삭제
		    });
    		
    	})
    	
    	$(document).ready(function() {
    		
	        $('#badgeDropdownUpdate').on('change', function() {
	        	
	            var selectedOption = $(this).find('option:selected');
	            var imgUrl = selectedOption.data('img-url');
	            if (imgUrl) {
	                $(this).css({
	                    'background-image': 'url(' + imgUrl + ')',
	                    'background-repeat': 'no-repeat',
	                    'background-position': 'center center',
	                    'background-size': '20px 20px'
	                }).addClass('selected'); // 선택된 클래스 추가
	            } else {
	                $(this).css('background-image', 'none').removeClass('selected'); // 선택된 클래스 제거
	            }
	        });
	
	        // Trigger change to show the first selected image
	        $('#badgeDropdownUpdate').trigger('change');
	    });
    
	    
    
    </script>
    
    <style>
    
    	.title {
    		background-color: #eeeeee !important;
    	}
    	
    	.row .contents {
    		padding-top: 30px !important;
    		padding-bottom: 30px !important;
    	}
    
    	#badgeDropdownUpdate.selected {
	        color: transparent; /* 텍스트를 투명하게 */
	    }
	    /* 선택된 옵션 텍스트가 드롭다운 열렸을 때 보이도록 하기 */
	    #badgeDropdownUpdate option {
	        color: #747d88; /* 옵션 텍스트 기본 색상 */
	    }
	    
	    .post-image {
	        width: 600px; /* 고정된 가로 크기 */
	        height: 600px; /* 고정된 세로 크기 */
	        object-fit: cover; /* 이미지의 비율을 유지하면서 자르기 */
	        margin: 10px;
	        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
	        border-radius: 8px;
	    }
	    
	    @media (min-width: 1400px) {
		    .post-image {
		        width: 600px;
		        height: 600px;
		    }
		}
		
		/* Large devices (desktops, ≥1200px) */
		@media (min-width: 1200px) and (max-width: 1399.98px) {
		    .post-image {
		        width: 500px;
		        height: 500px;
		    }
		}
		
		/* Medium devices (tablets, ≥992px) */
		@media (min-width: 992px) and (max-width: 1199.98px) {
		    .post-image {
		        width: 400px;
		        height: 400px;
		    }
		}
		
		/* Small devices (landscape phones, ≥768px) */
		@media (min-width: 768px) and (max-width: 991.98px) {
		    .post-image {
		        width: 300px;
		        height: 300px;
		    }
		}
		
		/* Extra small devices (portrait phones, <576px) */
		@media (max-width: 575.98px) {
		    .post-image {
		        width: 100%;
		        height: auto;
		    }
		}
    
    </style>
    
</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
	
	<main>
	
    	<form enctype="multipart/form-data">
			<div class="container-fluid py-5">
	    		<div class="container py-5">
	    			<div class="row mb-5 mt-5">
	    			
	    				<input type="hidden" id="postNo" name="postNo" value="${meetingPost.postNo}">
	    			
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">작성자</div>
    					<div class="col-md-9 border align-items-center text-start py-3">${meetingPost.nickName}</div>
    					
    					<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">제목</div>
                        <div class="col-md-5 border align-items-center text-start py-2">
                            <input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" value="${meetingPost.title}" required>
                        </div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 등급</div>
	    				
		    				<div class="col-md-2 border align-items-center text-center py-2">
							    <select class="form-control" name="participationGrade" id="badgeDropdownUpdate">
							        <c:forEach var="url" items="${badgeImages}" varStatus="status">
							            <option value="${status.index + 1}" data-img-url="${url}" ${meetingPost.participationGrade == status.index + 1 ? 'selected' : ''}>
							                ${badgeDescriptions[status.index]} 등급
							            </option>
							        </c:forEach>
							    </select>
							</div>
	    				
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">모임명</div>
	    				<div class="col-md-5 border align-items-center text-start py-2">
	    					<input type="text" class="form-control" name="meetingName" placeholder="모임명을 입력하세요" value="${meetingPost.meetingName}" required>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">모집 마감일</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" id="recruitmentDeadline" name="recruitmentDeadline" placeholder="날짜 선택" value="${formattedRecruitmentDeadline}" required>
	    				</div>
	    				
	    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">출발 예정지</div>
    					<div class="col-md-9 border align-items-center text-start py-2">
    						<div class="d-flex">
					            <div class="col-md-4 pe-2">
						            <input type="text" class="form-control" id="appointedDeparture" name="appointedDeparture" placeholder="주소" value="${meetingPost.appointedDeparture}" required>
						        </div>
						        <div class="col-md-8 ps-2">
						            <input type="text" class="form-control" id="appointedDetailDeparture" name="appointedDetailDeparture" placeholder="상세주소" value="${meetingPost.appointedDetailDeparture}" required>
						        </div>
					        </div>
    					</div>
    					
    					<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 산</div>
	    				<div class="col-md-5 border align-items-center text-start py-2">
	    					<input type="text" class="form-control" name="appointedHikingMountain" placeholder="ex) 관악산" value="${meetingPost.appointedHikingMountain}" required>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 일자</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" id="appointedHikingDate" name="appointedHikingDate" placeholder="날짜 선택" value="${formattedAppointedHikingDate}" required>
	    				</div>
	    				
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">최대 인원</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<div class="d-flex align-items-center">
		    					<input type="number" class="form-control me-2" name="maximumPersonnel" value="${meetingPost.maximumPersonnel}" min="2" max="15" step="1">
	    						<span>명</span>
    						</div>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 희망 성별</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<select class="form-control" name="participationGender">
						        <option value="0" ${meetingPost.participationGender == 0 ? 'selected' : ''}>여자</option>
						        <option value="1" ${meetingPost.participationGender == 1 ? 'selected' : ''}>남자</option>
						        <option value="2" ${meetingPost.participationGender == 2 ? 'selected' : ''}>상관없음</option>
						    </select>
	    				</div>
	    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 희망 연령대</div>
	    				<div class="col-md-2 border align-items-center text-center py-2">
	    					<input type="text" class="form-control" name="participationAge" placeholder="희망 연령대를 입력하세요" value="${meetingPost.participationAge}">
	    				</div>
	    				
	    				<div class="col-md-2 border bg-light d-flex align-items-center justify-content-center title" id="contents">
						    내용
						</div>
						<div class="col-md-10 border py-2 ">
							<p>
								<c:forEach var="image" items="${meetingPostImages}">
							        <div class="position-relative d-inline-block image-div">
							            <img src="${image}" alt="Image" class="post-image" />
							            <button class="btn pt-3 pe-3 ps-0 pb-0 delete-image-button position-absolute top-0 end-0" style="line-height: 0;">
							                <i class="bi bi-x" style="font-size: 44px; color: red;"></i>
							            </button>
							            <input type="hidden" id="updateImageURL" name="updateImageURL" value="${image}"/>
							        </div>
							        <br/>
							    </c:forEach>
						    </p>
							<p>
						    	<textarea class="form-control mb-2" name="contents" rows="10" placeholder="내용을 입력하세요." style="height: 200px;" required>${meetingPost.contents}</textarea>
						    </p>
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
