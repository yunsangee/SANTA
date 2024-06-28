<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="site.dearmysanta.domain.user.User" %>

<!-- 임의로 session에 user 객체를 설정 -->
<%
    // 세션에 user 객체가 없으면 생성하여 설정합니다.
    if (session.getAttribute("user") == null) {
        User user = new User();
        user.setUserNo(1);  // userNo 값을 임의로 설정합니다.
        session.setAttribute("user", user);
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>모임 게시글 상세조회</title>
    <c:import url="../common/header.jsp"/>
    
    <script type = "text/javascript">
    	
    	var userNo = "${sessionScope.user.userNo}";
    
	    $(function() {
	    	
	    	$('#deletePostButton').on('click', function() {
	    		
	    		var postNo = "${meetingPost.postNo}";
                self.location = "/meeting/deleteMeetingPost?postNo="+postNo;
            });
	    	
			$('#updatePostButton').on('click', function() {
	    		
	    		var postNo = "${meetingPost.postNo}";
                self.location = "/meeting/updateMeetingPost?postNo="+postNo;
            });
	    	
	    	
	    	$('.like-button').on('click', function() {
	    		
	            var $this = $(this);  // 현재 클릭된 요소를 $this 변수에 저장
	            var postNo = $this.data('post-no');  // 데이터 속성을 사용하여 postNo를 가져옴
	            var userNo = $this.data('user-no');  // 데이터 속성을 사용하여 userNo를 가져옴
	            var currentStatus = $this.hasClass('text-secondary') ? 0 : 1; // 현재 상태에 따라 값 설정

	            $.ajax({
	            	
	                url: '/meeting/rest/updateMeetingPostLikeStatus',
	                type: 'GET',
	                dataType: 'text',
	                data: {
	                	
	                    meetingPostLikeStatus: currentStatus,
	                    postNo: postNo,
	                    userNo: userNo
	                },
	                success: function(response, textStatus, xhr) {
	                	
	                    console.log('Response:', response); // 응답 출력
	                    console.log('Status:', xhr.status); // 상태 코드 출력

	                    // 상태 코드가 200인 경우 성공으로 간주
	                    if (xhr.status === 200) {
	                    	
	                        var $likeCount = $this.next('p');
	                        var currentCount = parseInt($likeCount.text());

	                        if (currentStatus === 0) {
	                        	
	                            $this.removeClass('text-secondary').addClass('text-danger');
	                            $likeCount.text(currentCount + 1);
	                        } else {
	                        	
	                            $this.removeClass('text-danger').addClass('text-secondary');
	                            $likeCount.text(currentCount - 1);
	                        }
	                    } else {
	                    	
	                        console.log('Failed to update like status');
	                    }
	                },
	                error: function(xhr, status, error) {
	                	
	                    console.error('AJAX Error:', status, error);
	                }
	            });
	        });
	    	
	    	
	    	$('.update-recruitment-status').on('click', function() {
	    		
	            var $this = $(this);  // 현재 클릭된 요소를 $this 변수에 저장
	            var postNo = $this.data('post-no');  // 데이터 속성을 사용하여 postNo를 가져옴
	            var currentStatus = $this.data('current-status');  // 데이터 속성을 사용하여 currentStatus를 가져옴

	            $.ajax({
	            	
	                url: '/meeting/rest/updateMeetingPostRecruitmentStatus',
	                type: 'GET',
	                dataType: 'text',
	                data: {
	                	
	                    postNo: postNo,
	                    currentStatus: currentStatus
	                },
	                success: function(response, textStatus, xhr) {
	                	
	                    console.log('Response:', response); // 응답 출력
	                    console.log('Status:', xhr.status); // 상태 코드 출력

	                    // 상태 코드가 200인 경우 성공으로 간주
	                    if (xhr.status === 200) {
	                    	
	                        var newStatus = (currentStatus == 0) ? 1 : 0;
	                        $this.data('current-status', newStatus);

	                        if (newStatus == 0) {
	                        	
	                            $this.text('모집 마감하기');
	                        } else {
	                        	
	                            $this.text('모집 마감 취소하기');
	                        }
	                    } else {
	                    	
	                        console.log('Failed to update recruitment status');
	                    }
	                },
	                error: function(xhr, status, error) {
	                	
	                    console.error('AJAX Error:', status, error);
	                }
	            });
	        });
	    	
	    	$(document).on('click', '.update-recruitment-status-end', function() {
	    	    var $this = $(this);  // 현재 클릭된 요소를 $this 변수에 저장
	    	    var postNo = $this.data('post-no');  // 데이터 속성을 사용하여 postNo를 가져옴

	    	    $.ajax({
	    	        url: '/meeting/rest/updateMeetingPostRecruitmentStatusToEnd',
	    	        type: 'GET',
	    	        dataType: 'text',
	    	        data: {
	    	            postNo: postNo,
	    	        },
	    	        success: function(response, textStatus, xhr) {
	    	            console.log('Response:', response); // 응답 출력
	    	            console.log('Status:', xhr.status); // 상태 코드 출력

	    	            // 상태 코드가 200인 경우 성공으로 간주
	    	            if (xhr.status === 200) {
	    	                console.log('Recruitment status updated to end successfully');

	    	                // 버튼을 "종료됨" 버튼으로 변경
	    	                $('#updatePostButton').replaceWith('<button class="btn btn-primary border-0 rounded text-white end">종료됨</button>');

	    	                // "모집 마감하기" 및 "모임 종료하기" 버튼 제거
	    	                $('.update-recruitment-status').remove();
	    	                $('.update-recruitment-status-end').remove();
	    	            } else {
	    	                console.log('Failed to update recruitment status');
	    	            }
	    	        },
	    	        error: function(xhr, status, error) {
	    	            console.error('AJAX Error:', status, error);
	    	        }
	    	    });
	    	});
	    	
	    	$(document).on('click', '.add-participation-button', function() {
	    		
	    		var $this = $(this);
	    	    var postNo = $this.data('post-no');
	    	    var userNo = $this.data('user-no');

	    	    $.ajax({
	    	    	
	    	        url: '/meeting/rest/addMeetingParticipation',
	    	        type: 'GET',
	    	        dataType: 'text',
	    	        data: {
	    	        	
	    	            postNo: postNo,
	    	            userNo: userNo,
	    	            participationStatus: 0,
	    	            participationRole: 1
	    	        },
	    	        success: function(response, textStatus, xhr) {
	    	        	
	    	            console.log('Response:', response);
	    	            console.log('Status:', xhr.status);

	    	            if (xhr.status === 200) {
	    	            	
	    	                console.log('Participation added successfully');

	    	                // 버튼을 "신청 취소하기" 버튼으로 변경
	    	                $this.replaceWith('<button class="btn btn-primary border-0 rounded text-white px-4 py-3 delete-participation-button" data-post-no="' + postNo + '" data-user-no="' + userNo + '">신청 취소하기</button>');
	    	            } else {
	    	            	
	    	                console.log('Failed to add participation');
	    	            }
	    	        },
	    	        error: function(xhr, status, error) {
	    	        	
	    	            console.error('AJAX Error:', status, error);
	    	        }
	    	    });
	        });
	    	
	    	$(document).on('click', '.delete-participation-button', function() {
	    		
				var $this = $(this);
			    var postNo = $this.data('post-no');
			    var userNo = $this.data('user-no');

			    $.ajax({
			    	
			        url: '/meeting/rest/deleteMeetingParticipation',
			        type: 'GET',
			        dataType: 'text',
			        data: {
			        	
			            postNo: postNo,
			            userNo: userNo
			        },
			        success: function(response, textStatus, xhr) {
			        	
			            console.log('Response:', response);
			            console.log('Status:', xhr.status);

			            if (xhr.status === 200) {
			            	
			                console.log('Participation deleted successfully');

			                // 버튼을 "신청하기" 버튼으로 변경
			                $this.replaceWith('<button class="btn btn-primary border-0 rounded text-white px-4 py-3 add-participation-button" data-post-no="' + postNo + '" data-user-no="' + userNo + '">신청하기</button>');
			            } else {
			            	
			                console.log('Failed to delete participation');
			            }
			        },
			        error: function(xhr, status, error) {
			        	
			            console.error('AJAX Error:', status, error);
			        }
			    });
	        });
	    	
			$(document).on('click', '.withdraw-button', function() {
	    		
				var $this = $(this);
			    var postNo = $this.data('post-no');
			    var userNo = $this.data('user-no');

			    $.ajax({
			    	
			        url: '/meeting/rest/updateMeetingParticipationWithdrawStatus',
			        type: 'GET',
			        dataType: 'text',
			        data: {
			        	
			            postNo: postNo,
			            userNo: userNo
			        },
			        success: function(response, textStatus, xhr) {
			        	
			            console.log('Response:', response);
			            console.log('Status:', xhr.status);

			            if (xhr.status === 200) {
			            	
			                console.log('Participation deleted successfully');

			                // 버튼을 "신청하기" 버튼으로 변경
			                $this.replaceWith('<button class="btn btn-primary border-0 rounded text-white px-4 py-3 add-participation-button" data-post-no="' + postNo + '" data-user-no="' + userNo + '">신청하기</button>');
			            } else {
			            	
			                console.log('Failed to delete participation');
			            }
			        },
			        error: function(xhr, status, error) {
			        	
			            console.error('AJAX Error:', status, error);
			        }
			    });
	        });
	    	
	    	$(document).on('click', '.update-participation-button', function() {
	    		
	    	    var $this = $(this);
	    	    var participationNo = $this.data('participation-no');
	    	    var postNo = $this.data('post-no');
	    	    var userNo = $this.data('user-no');
	    	    
	    	    console.log('Participation No:', participationNo);
	    	    
	    	    $.ajax({
	    	    	
	    	        url: '/meeting/rest/updateMeetingParticipationStatus',
	    	        type: 'GET',
	    	        dataType: 'text',
	    	        data: {
	    	        	
	    	            participationNo: participationNo
	    	        },
	    	        success: function(response, textStatus, xhr) {
	    	        	
	    	            console.log('Response:', response);
	    	            console.log('Status:', xhr.status);

	    	            if (xhr.status === 200) {
	    	                console.log('Participation status updated successfully');

	    	                // 버튼을 "내보내기" 버튼으로 변경
	    	                $this.closest('div').html('<button class="btn btn-primary border-0 rounded text-white forced-withdraw-button" data-post-no="' + postNo + '" data-user-no="' + userNo + '">내보내기</button>');
	    	            } else {
	    	            	
	    	                console.log('Failed to update participation status');
	    	            }
	    	        },
	    	        error: function(xhr, status, error) {
	    	        	
	    	            console.error('AJAX Error:', status, error);
	    	        }
	    	    });
	    	});
	    	
	    	$('.reject-participation-button').on('click', function() {
	    		
	            var $this = $(this);
	            var postNo = $this.data('post-no');
	    	    var userNo = $this.data('user-no');

	            $.ajax({
	            	
	                url: '/meeting/rest/deleteMeetingParticipation',
	                type: 'GET',
	                dataType: 'text',
	                data: {
	                	
	                	postNo: postNo,
	    	            userNo: userNo
	                },
	                success: function(response, textStatus, xhr) {
	                	
	                    console.log('Response:', response);
	                    console.log('Status:', xhr.status);

	                    if (xhr.status === 200) {
	                    	
	                        console.log('Participation rejected successfully');
	                        $this.closest('tr').remove();  // 행을 제거하여 UI 업데이트
	                    } else {
	                    	
	                        console.log('Failed to reject participation');
	                    }
	                },
	                error: function(xhr, status, error) {
	                	
	                    console.error('AJAX Error:', status, error);
	                }
	            });
	        });
	    	
	    	$(document).on('click', '.forced-withdraw-button', function() {
	    		
	    	    var $this = $(this);
	    	    var postNo = $this.data('post-no');
	    	    var userNo = $this.data('user-no');

	    	    $.ajax({
	    	    	
	    	        url: '/meeting/rest/updateMeetingParticipationWithdrawStatus',
	    	        type: 'GET',
	    	        dataType: 'text',
	    	        data: {
	    	        	
	    	            postNo: postNo,
	    	            userNo: userNo
	    	        },
	    	        success: function(response, textStatus, xhr) {
	    	        	
	    	            console.log('Response:', response);
	    	            console.log('Status:', xhr.status);

	    	            if (xhr.status === 200) {
	    	            	
	    	                console.log('Participation withdrawal status updated successfully');
	    	                $this.closest('tr').remove();  // 행을 제거하여 UI 업데이트
	    	            } else {
	    	            	
	    	                console.log('Failed to update participation withdrawal status');
	    	            }
	    	        },
	    	        error: function(xhr, status, error) {
	    	        	
	    	            console.error('AJAX Error:', status, error);
	    	        }
	    	    });
	    	});
	    	
	    	$(document).ready(function() {
	    		
	    	    $('.add-comment-button').on('click', function() {
	    	    	
	    	        var $this = $(this);
	    	        var postNo = $this.data('post-no');
	    	        var userNo = $this.data('user-no');
	    	        var commentContents = $this.closest('.row').find('.comment-box').val();

	    	        console.log('Post No:', postNo);
	    	        console.log('User No:', userNo);
	    	        console.log('Comment Contents:', commentContents);

	    	        $.ajax({
	    	        	
	    	            url: '/meeting/rest/addMeetingPostComment',
	    	            type: 'POST',
	    	            contentType: 'application/json',
	    	            dataType: 'json',
	    	            data: JSON.stringify({
	    	            	
	    	                meetingPostNo: postNo,
	    	                userNo: userNo,
	    	                meetingPostCommentContents: commentContents
	    	            }),
	    	            success: function(response) {
	    	            	
	    	                console.log('Response:', response);

	    	                if (response) {
	    	                	
	    	                    console.log('Comment added successfully');

	    	                    // 날짜 포맷팅
	    	                    var date = new Date(response.meetingPostCommentCreationDate);

								var formattedDate = date.getFullYear() + '-' +
								    ('0' + (date.getMonth() + 1)).slice(-2) + '-' +
								    ('0' + date.getDate()).slice(-2) + ' ' +
								    ('0' + date.getHours()).slice(-2) + ':' +
								    ('0' + date.getMinutes()).slice(-2);

								    var newCommentHtml = '<tr><td colspan="3" class="p-0">' +
			                        '<div class="d-flex align-items-center justify-content-between" style="border-bottom: 1px solid #ddd;">' +
			                        '<div class="d-flex align-items-center justify-content-between" style="min-width: 200px; border-right: 1px solid #ddd; padding: 10px;">' +
			                        '<div class="d-flex align-items-center">' +
			                        '<img src="' + response.profileImage + '" alt="Image" class="me-2" style="width: 40px; height: 40px; border-radius: 50%;">' +
			                        '<p class="mb-0">' + response.nickname + '</p>' +
			                        '</div>' +
			                        (userNo == response.userNo ? '<button class="btn p-0 delete-comment-button" data-comment-no="' + response.meetingPostCommentNo + '" style="line-height: 0;"><i class="bi bi-x" style="font-size: 24px; color: red;"></i></button>' : '') +
			                        '</div>' +
			                        '<div class="d-flex align-items-center flex-grow-1" style="border-right: 1px solid #ddd; padding: 10px;">' +
			                        '<p class="mb-0">' + response.meetingPostCommentContents + '</p>' +
			                        '</div>' +
			                        '<div class="d-flex align-items-center" style="min-width: 150px; padding: 10px;">' +
			                        '<p class="mb-0">' + formattedDate + '</p>' +
			                        '</div>' +
			                        '</div></td></tr>';

	    	                    $('.comment-table tbody').append(newCommentHtml);
	    	                    $('.comment-box').val(''); // 댓글 입력 창 비우기
	    	                } else {
	    	                	
	    	                    console.log('Failed to add comment');
	    	                }
	    	            },
	    	            error: function(xhr, status, error) {
	    	            	
	    	                console.error('AJAX Error:', status, error);
	    	            }
	    	        });
	    	    });
	    	});
	    	
	    	$(document).on('click', '.delete-comment-button', function() {
	    		
	            var $this = $(this);
	            var commentNo = $this.data('comment-no');

	            console.log('Comment No:', commentNo);

	            $.ajax({
	            	
	                url: '/meeting/rest/deleteMeetingPostComment',
	                type: 'GET',
	                dataType: 'text',
	                data: {
	                	
	                    meetingPostCommentNo: commentNo
	                },
	                success: function(response, textStatus, xhr) {
	                	
	                    console.log('Response:', response);
	                    console.log('Status:', xhr.status);

	                    if (xhr.status === 200) {
	                    	
	                        console.log('Comment deleted successfully');
	                        $this.closest('tr').remove(); // 댓글 행을 삭제하여 UI 업데이트
	                    } else {
	                    	
	                        console.log('Failed to delete comment');
	                    }
	                },
	                error: function(xhr, status, error) {
	                	
	                    console.error('AJAX Error:', status, error);
	                }
	            });
	        });
	    	
	    	
	    });
	</script>
    
    <style>
    	.title {
    		background-color: #eeeeee !important;
    	}
    	
    	.row .contents {
    		padding-top: 70px !important;
    		padding-bottom: 70px !important;
    	}
    	
    	#postStatus {
    		margin-top: 0 !important;
    	}
    	
    	.end {
    		background-color: #000000 !important;
    	}
    	
    	
        
    }
    	
    
    </style>
    
</head>
<body>
	<header><c:import url="../common/top.jsp"/></header>
	<main>
		
		<div class="container-fluid page-header py-5">
    		<h1 class="text-center text-white display-6">Meeting Post Detail</h1>
    	</div>
    	
    	<div class="container-fluid py-5">
    		<div class="container py-5">
    			<div class="row g-4 mb-4 d-flex align-items-center">
    			
    				<div class="col-md-3 d-flex align-items-center">
	    				<i class="fa fa-heart fa-3x like-button ${meetingPost.meetingPostLikeStatus == 0 ? 'text-secondary' : 'text-danger'}" data-post-no="${meetingPost.postNo}" data-user-no="${sessionScope.user.userNo}"></i>
	    				<p class="mb-0 ml-2 fa-2x">${meetingPost.meetingPostLikeCount}</p>
    				</div>
    				
    				<div class="col-md-9 d-flex justify-content-end">
    				
    					<c:choose>
						    <c:when test="${sessionScope.user.userNo == meetingPost.userNo}">
						        <%-- 게시글 작성자라면 항상 삭제하기 버튼 표시 --%>
						        <button id="deletePostButton" class="btn btn-danger border-0 rounded text-white me-1">삭제하기</button>
						        
						        <c:choose>
						            <c:when test="${meetingPost.recruitmentStatus == 2}">
						                <%-- 모임이 끝난 상태라면 종료됨 버튼 표시 --%>
						                <button class="btn btn-primary border-0 rounded text-white end">종료됨</button>
						            </c:when>
						            <c:otherwise>
						                <%-- 모임이 끝난 상태가 아니라면 수정하기 버튼 표시 --%>
						                <button id="updatePostButton" class="btn btn-primary border-0 rounded text-white" id="update">수정하기</button>
						            </c:otherwise>
						        </c:choose>
						        
						    </c:when>
						    <c:otherwise>
						    
						        <c:choose>
						            <c:when test="${meetingPost.recruitmentStatus == 2}">
						                <%-- 모임이 끝난 상태라면 종료됨 버튼 표시 --%>
						                <button class="btn btn-primary border-0 rounded text-white end">종료됨</button>
						            </c:when>
						            <%-- 게시글 작성자가 아니고 모임이 끝난 상태가 아니라면 아무 버튼도 표시되지 않음 --%>
						        </c:choose>
						        
						    </c:otherwise>
						</c:choose>

    				</div>
    				    				
    				    			
    			</div>
    			
    			<div class="row mb-5">
    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">작성자</div>
    				<div class="col-md-5 border align-items-center text-start py-3">${meetingPost.nickName}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">작성 일자</div>
    				<div class="col-md-2 border align-items-center text-center py-3">
    					<fmt:formatDate value="${meetingPost.postDate}" pattern="yyyy-MM-dd HH:mm" />
    				</div>
    				
    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">제목</div>
    				<div class="col-md-5 border align-items-center text-start py-3">${meetingPost.title}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 등급</div>
    				<div class="col-md-2 border align-items-center text-center py-3">${meetingPost.participationGrade}(이미지) 이상</div>
    				
    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">모임 명</div>
    				<div class="col-md-5 border align-items-center text-start py-3">${meetingPost.meetingName}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">모집 마감일</div>
    				<div class="col-md-2 border align-items-center text-center py-3">
    					<fmt:formatDate value="${meetingPost.recruitmentDeadline}" pattern="yyyy-MM-dd" />
    				</div>
    				
    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">출발 예정지</div>
    				<div class="col-md-9 border align-items-center text-start py-3">${meetingPost.appointedDeparture} ${meetingPost.appointedDetailDeparture}</div>
    				
    				<div class="col-md-3 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 산</div>
    				<div class="col-md-5 border align-items-center text-start py-3">${meetingPost.appointedHikingMountain}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">등산 예정 일자</div>
    				<div class="col-md-2 border align-items-center text-center py-3">
    					<fmt:formatDate value="${meetingPost.appointedHikingDate}" pattern="yyyy-MM-dd" />
    				</div>
    				
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">최대 인원</div>
    				<div class="col-md-2 border align-items-center text-center py-3">${meetingPost.maximumPersonnel}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 성별</div>
    				<div class="col-md-2 border align-items-center text-center py-3">${meetingPost.participationGender}</div>
    				<div class="col-md-2 border bg-light align-items-center text-center justify-content-center py-3 title">참여 가능 연령대</div>
    				<div class="col-md-2 border align-items-center text-center py-3">${meetingPost.participationAge}</div>
    				
    				<div class="col-md-2 border bg-light align-items-center title contents d-flex justify-content-center">내용</div>
    				<div class="col-md-10 border align-items-center text-start contents">
    					<c:forEach var="image" items="${meetingPostImages}">
					        <img src="${image}" alt="Image" />
					    </c:forEach>
    					${meetingPost.contents}
    				</div>
    			
    			</div>
    			
    			<div class="row g-4 mb-4 d-flex">
    			    			
	
    				<div class="d-flex justify-content-end" id="postStatus">
    				
    					<%-- 게시글 작성자가 아닌 경우 --%>
					    <c:if test="${sessionScope.user.userNo != meetingPost.userNo}">
					    	
					    	<!-- sessionScope.user.userNo 값 출력 -->
						    <c:out value="${sessionScope.user.userNo}" />
						    <!-- meetingPost.userNo 값 출력 -->
						    <c:out value="${meetingPost.userNo}" />
					    
					        <c:choose>
					            <c:when test="${meetingPost.recruitmentStatus != 2}">
					            
					                <c:choose>
					                    <c:when test="${isMember == 0}">
					                        <%-- 게시글 작성자가 아니고 모임 끝 상태가 아니며 isMember가 0인 경우 --%>
					                        <button class="btn btn-primary border-0 rounded text-white px-4 py-3 add-participation-button" 
					                        data-post-no="${meetingPost.postNo}" data-user-no="${sessionScope.user.userNo}">신청하기</button>
					                    </c:when>
					                    <c:when test="${isMember == 1}">
					                        <%-- 게시글 작성자가 아니고 모임 끝 상태가 아니며 isMember가 1인 경우 --%>
					                        <button class="btn btn-primary border-0 rounded text-white px-4 py-3 delete-participation-button"
					                        data-post-no="${meetingPost.postNo}" data-user-no="${sessionScope.user.userNo}">신청 취소하기</button>
					                    </c:when>
					                </c:choose>
					                
					            </c:when>
					            <c:when test="${isMember == 2}">
					                <%-- 게시글 작성자가 아니고 isMember가 2인 경우 --%>
					                <button class="btn btn-primary border-0 rounded text-white px-4 py-3 withdraw-button" 
					                data-post-no="${meetingPost.postNo}" data-user-no="${sessionScope.user.userNo}">모임 탈퇴하기</button>
					            </c:when>
					        </c:choose>
					        
					    </c:if>
					
					    <%-- 게시글 작성자인 경우 --%>
					    <c:if test="${sessionScope.user.userNo == meetingPost.userNo}">
					    	<!-- sessionScope.user.userNo 값 출력 -->
						    <c:out value="${sessionScope.user.userNo}" />
						    <!-- meetingPost.userNo 값 출력 -->
						    <c:out value="${meetingPost.userNo}" />
					    
					        <c:choose>
					            <c:when test="${meetingPost.recruitmentStatus == 0}">
					                <%-- 게시글 작성자이며 모집 상태가 0인 경우 --%>
					                <button class="btn btn-primary border-0 rounded text-white me-1 px-4 py-3 update-recruitment-status"
            							data-post-no="${meetingPost.postNo}" data-current-status="0">모집 마감하기</button>
					                <button class="btn btn-primary border-0 rounded text-white px-4 py-3 update-recruitment-status-end"
					                	data-post-no="${meetingPost.postNo}">모임 종료하기</button>
					            </c:when>
					            <c:when test="${meetingPost.recruitmentStatus == 1}">
					                <%-- 게시글 작성자이며 모집 상태가 1인 경우 --%>
					                <button class="btn btn-primary border-0 rounded text-white me-1 px-4 py-3 update-recruitment-status"
            							data-post-no="${meetingPost.postNo}" data-current-status="1">모집 마감 취소하기</button>
					                <button class="btn btn-primary border-0 rounded text-white px-4 py-3 update-recruitment-status-end"
					                	data-post-no="${meetingPost.postNo}">모임 종료하기</button>
					            </c:when>
					            <%-- 모집 상태가 2인 경우 아무 버튼도 표시되지 않음 --%>
					        </c:choose>
					        
					    </c:if>
    					
    				</div>
    				
    			</div>
    			
				<button class="btn btn-primary py-2 px-4 text-white">모임원들</button>
				        
    			<div class="row g-4 mb-5">
    				<div class="table-responsive participation-table">
		    			<table class="table border-top">
		    				<thead>
		    				
		    				</thead>
		    				<tbody>
		    					<c:forEach var="participation" items="${meetingParticipations}">
					                <c:choose>
					                    
					                    <c:when test="${sessionScope.user.userNo == meetingPost.userNo}">
					                        <tr>
					                            <td class="pb-3 pt-3">
					                                <div class="d-flex justify-content-between align-items-center w-100">
					                                    <div class="d-flex align-items-center">
					                                        <img src="${participation.profileImage}" alt="Image" class="me-2" style="width: 40px; height: 40px; border-radius: 50%;">
					                                        <p class="mb-0">${participation.nickname}</p>
					                                    </div>
					                                    <div class="d-flex align-items-center">
					                                        <c:if test="${participation.userNo != sessionScope.user.userNo}">
					                                            <c:if test="${participation.participationStatus == 0}">
					                                                <button class='btn p-0 update-participation-button' data-participation-no="${participation.participationNo}" 
					                                                data-post-no="${meetingPost.postNo}" data-user-no="${participation.userNo}" style="line-height: 0;">
					                                                    <i class='bi bi-check' style='font-size: 32px; color: green;'></i>
					                                                </button>
					                                                <button class='btn p-0 reject-participation-button' data-post-no="${meetingPost.postNo}" data-user-no="${participation.userNo}" 
					                                                style="line-height: 0;">
					                                                    <i class='bi bi-x' style='font-size: 32px; color: red;'></i>
					                                                </button>
					                                            </c:if>
					                                            <c:if test="${participation.participationRole == 2}">
					                                                <button class="btn btn-primary border-0 rounded text-white forced-withdraw-button" data-post-no="${meetingPost.postNo}" 
					                                                data-user-no="${participation.userNo}">내보내기</button>
					                                            </c:if>
					                                        </c:if>
					                                    </div>
					                                </div>
					                            </td>
					                        </tr>
					                    </c:when>
					                    
					                    <c:otherwise>
					                        <c:if test="${participation.participationStatus != 0}">
					                            <tr>
					                                <td class="pb-3 pt-3">
					                                    <div class="d-flex justify-content-between align-items-center w-100">
					                                        <div class="d-flex align-items-center">
					                                            <img src="${participation.profileImage}" alt="Image" class="me-2" style="width: 40px; height: 40px; border-radius: 50%;">
					                                            <p class="mb-0">${participation.nickname}</p>
					                                        </div>
					                                    </div>
					                                </td>
					                            </tr>
					                        </c:if>
					                    </c:otherwise>
					                </c:choose>
					            </c:forEach>

		    				</tbody>
		    			</table>
		    		</div> <!-- table-responsive -->
    			
    			</div>
    			
    			<div class="row mb-4">
	                <div class="col-md-12 mt-5">
	                    <textarea class="form-control comment-box" rows="5" placeholder="주제와 무관한 댓글, 타인의 권리를 침해하거나 명예를 훼손하는 게시물은 별도의 통보 없이 제재를 받을 수 있습니다."></textarea>
	                </div>
	                <div class="col-md-12 d-flex justify-content-end mt-3">
	                    <button class="btn btn-primary text-white add-comment-button" data-post-no="${meetingPost.postNo}" data-user-no="${sessionScope.user.userNo}">댓글 등록하기</button>
	                </div>
	            </div>
    				
    			
    			<button class="btn btn-primary py-2 px-4 text-white">댓글 (${meetingPost.meetingPostCommentCount})</button>
    			
    			<div class="row g-4 mb-5">
    				<div class="table-responsive comment-table">
		    			<table class="table border-top">
		    				<thead>
		    				
		    				</thead>
		    				<tbody>
		    				
		    					<c:forEach var="comment" items="${meetingPostComments}">
				                    <tr>
				                        <td colspan="3" class="p-0">
				                            <div class="d-flex align-items-center justify-content-between" style="border-bottom: 1px solid #ddd;">
				                                <div class="d-flex align-items-center justify-content-between" style="min-width: 200px; border-right: 1px solid #ddd; padding: 10px;">
				                                    <div class="d-flex align-items-center">
				                                        <img src="${comment.profileImage}" alt="Image" class="me-2" style="width: 40px; height: 40px; border-radius: 50%;">
				                                        <p class="mb-0">${comment.nickname}</p>
				                                    </div>
				                                    <c:if test="${sessionScope.user.userNo == comment.userNo}">
				                                        <button class='btn p-0 delete-comment-button' data-comment-no="${comment.meetingPostCommentNo}" style="line-height: 0;"><i class='bi bi-x' style='font-size: 24px; color: red;'></i></button>
				                                    </c:if>
				                                </div>
				                                <div class="d-flex align-items-center flex-grow-1" style="border-right: 1px solid #ddd; padding: 10px;">
				                                    <p class="mb-0">${comment.meetingPostCommentContents}</p>
				                                </div>
				                                <div class="d-flex align-items-center" style="min-width: 150px; padding: 10px;">
				                                    <p class="mb-0"><fmt:formatDate value="${comment.meetingPostCommentCreationDate}" pattern="yyyy-MM-dd HH:mm" /></p>
				                                </div>
				                            </div>
				                        </td>
				                    </tr>
				                </c:forEach>

		    				</tbody>
		    			</table>
		    		</div> <!-- table-responsive -->
    			
    			</div>
    			
    			
    		</div>
    	</div>
    
    </main>
    <footer><c:import url="../common/footer.jsp"/></footer>
    
</body>
</html>