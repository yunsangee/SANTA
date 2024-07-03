<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>산타가 궁금해요!</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../img/santa.png"> 
   <!--  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!--  ////////////////////////////////////////////// style ///////////////////////////////////////////////// -->

    <style>
    
            body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        } 

         main {
            flex: 1;
            padding: 20px;
            text-align: center;
            justify-content: center;
            align-items: center;
            margin-top:400; 
        }
        
      /*  .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        } */

        .pagination {
            display: flex;
            justify-content: center;
            margin-top:60px;
        }
        
        .pagination a {
            margin: 0 5px;
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
			/* margin-bottom:5px; */
			 margin-top:25px;
        }

        .dropdown-custom {
            margin-left: 10px;
        }
        
        .search-input {
            width: 200px;
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
        	cursor: pointer;
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

        .btn-write {
            padding: 10px 20px;
            background-color: #81C408;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
           /*  margin-top: 10px; */
            float: right;
            margin-right:20px;
        }

        .btn-write:hover {
            background-color: #578906;
        }
        
            footer {
        	width: 100%;
        	 margin-bottom:-261px;
        }
        
        .QNATITLE h2{
        	margin-top:40px;
        	margin-left:-1100px;
        	font-size:65px;
        }
        
         .QNATITLE h3{
        	margin-left:-910px;
        	font-size:16px;
        }
        
        
 .dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
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
    background-color: white;
    padding: 60px;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 700px; /* 다이얼로그의 너비를 동일하게 설정 */
    max-width: 90%;
    text-align: center;
    position: relative;
}

   .table-responsive {
        max-height: 500px; /* 테이블 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 추가 */
        overflow-x: hidden; /* 가로 스크롤 제거 */
    }

    .table {
        table-layout: fixed; /* 테이블 레이아웃 고정 */
        width: 100%;
    }

    .table th, .table td {
        overflow: hidden;
        text-overflow: ellipsis; /* 내용이 넘칠 경우 말줄임 표시 (...) */
        white-space: nowrap;
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

        .close-button:hover {
            color: #dc3545;
        }

        h2 {
            margin-top: 0;
            font-size: 24px;
            color: #333;
            text-align: center;
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
            margin-bottom: 15px;
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
        
        span {
        color: #EB001F;
        font-weight: bold;
    }
        
        .dialog-content h2 {
        	font-size:20px;
        }
        
        .line {
		    border-bottom: 1px solid #ccc;
		    margin-bottom:15px;
		    margin-top:-15px;
		}
        
      /*   ///////////////////////////////////////////////////////////////////////////////////////// */
      
       .qna-details {
            margin-bottom: 15px;
            text-align: left; /* 왼쪽 정렬 추가 */
        }

        .qna-details p {
            margin: 10px 0;
            font-size: 15px;
            color: #333;
            margin-bottom:30px;
        }

        .qna-answer {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .qna-answer p {
            margin: 0;
            font-size: 15px;
            color: #333;
            text-align: left; /* 왼쪽 정렬 추가 */
            margin-bottom:80px;
        }
        
        .editable {
        	background-color: #f9f9f9;
            border-radius: 5px;
            margin-top: 20px;
            border: none !important; /* 테두리 없애기 */
            outline: none; /* 포커스 시 테두리 없애기 */
        }
        
        .actions {
            text-align: center;
            margin-top: 20px;
        }

        .actions button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px 0;
        }

        .actions .edit-button {
            background-color: #28a745;
            color: white;
        }

        .actions .edit-button:hover {
            background-color: #218838;
        }

        .actions .back-button {
            background-color: #6c757d;
            color: white;
        }

        .actions .back-button:hover {
            background-color: #5a6268;
        }

        .list-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 16px;
        }

        .list-button:hover {
            background-color: #218838;
        }
        

    </style>
    	
    	<c:import url="../common/header.jsp"/>
    	
  <!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->  
    
<!-- 로그인 상태 확인 변수 추가 -->
<c:set var="isLoggedIn" value="${not empty user}"/>

<script>
    var dialogVisible = false;

    $(document).ready(function() {
        // 페이지 로드 시 초기 설정
        $('.search-input').keypress(function(event) {
            if (event.which == 13) {
                event.preventDefault();
                $('#currentPage').val(1);
                $(this).closest('form').submit();
            }
        });

        $(document).on('click', '.pagination a', function(event) {
            event.preventDefault();
            var page = $(this).data('page');
            var form = $('<form></form>');
            form.attr("method", "GET");
            form.attr("action", "/user/getQnAList");

            var input = $('<input>').attr("type", "hidden").attr("name", "currentPage").attr("value", page);
            form.append(input);

            form.appendTo('body').submit();
        });

        $('.btn-write').click(function() {
            if ('${isLoggedIn}' !== 'true') {
                alert('로그인 후 작성 가능합니다.');
                return;
            }
            if (!dialogVisible) {
                $('.dialog-overlay.write').addClass('active');
                dialogVisible = true;
            }
        });

        $('.text').click(function() {
            var postNo = $(this).data('postno');
            var userNo = $(this).data('userno');
            let sessionUserNo = '${sessionScope.user != null ? sessionScope.user.userNo : 0}';
            let isAdmin = '${sessionScope.user != null && sessionScope.user.role == 1 ? true : false}';

            $.ajax({
                url: '/user/rest/getQnA',
                method: 'GET',
                data: { postNo: postNo, userNo: userNo },
                success: function(response) {
                    var qna = response.qna;
                    var qnaUser = response.qnaUser;

                    var content = '<div class="profile-header">' +
                        '<img src="' + qnaUser.profileImage + '" alt="Profile Image">' +
                        '<p>' + qnaUser.nickName + '<img src="' + qnaUser.badgeImage + '" style="width:24px;height:24px;"></p>' +
                        '</div>' +
                        '<div class="line"></div>' +
                        '<div class="qna-details">' +
                        '<p>' + qna.contents + '</p>' +
                        '</div>' +
                        '<div class="qna-answer">' +
                        (qna.answerState == 0 ? '<p class="admin-answer" contenteditable="false">관리자의 답변이 등록되지 않았습니다. 조금만 기다려주세요.</p>' : '<p class="admin-answer" contenteditable="false">' + qna.adminAnswer + '</p>') +
                        '</div>';

                    // 작성자인 경우 삭제 버튼 추가
                    if (isAdmin === 'true' || sessionUserNo == qnaUser.userNo) {
                        content += '<button class="delete-button" data-postno="' + qna.postNo + '" data-userno="' + qnaUser.userNo + '" style="background: none; border: none; cursor: pointer; position: absolute; top: 75px; right: 70px;">' +
                            '<i class="bi bi-trash" style="font-size: 20px;"></i>' +
                            '</button>';
                    }

                    // 관리자인 경우 답변 작성/수정 아이콘 추가
                    if (isAdmin === 'true') {
                        content += '<button type="button" class="edit-button" id="edit-button" style="background: none; border: none; cursor: pointer; position: absolute; top: 75px; right: 40px;" onclick="enableAdminAnswerEdit(' + qna.postNo + ', ' + qnaUser.userNo + ')">' +
                            '✏️</button>';
                    }

                    $('#qnaDetailsContent').html(content);
                    $('.dialog-overlay.details').addClass('active');
                    dialogVisible = true;
                },
                error: function() {
                    //alert('QnA 정보를 불러오는데 실패했습니다.');
                }
            });
        });

        // 답변 작성/수정 기능 활성화 함수
        window.enableAdminAnswerEdit = function(postNo, userNo) {
            var adminAnswerElem = $('.admin-answer');
            if (adminAnswerElem.length > 0) {
                adminAnswerElem.attr('contenteditable', 'true').addClass('editable').focus();

                // 커서를 글 맨 마지막으로 이동
                var range = document.createRange();
                var sel = window.getSelection();
                if (adminAnswerElem[0].childNodes.length > 0) {
                    range.setStart(adminAnswerElem[0].childNodes[adminAnswerElem[0].childNodes.length - 1], adminAnswerElem[0].childNodes[adminAnswerElem[0].childNodes.length - 1].length);
                } else {
                    range.setStart(adminAnswerElem[0], 0);
                }
                range.collapse(true);
                sel.removeAllRanges();
                sel.addRange(range);

                var editButton = $('#edit-button');
                editButton.html('✔️');
                editButton.attr('id', 'save-button'); // edit-button ID를 save-button으로 변경
                editButton.off('click').on('click', function() {
                    saveAdminAnswer(postNo, userNo);
                });
            } else {
                console.error('admin-answer element not found');
            }
        }

        // 답변 저장 함수
        window.saveAdminAnswer = function(postNo, userNo) {
            var adminAnswer = $('.admin-answer').text();

            $.ajax({
                url: '/user/rest/addAdminAnswer',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ postNo: postNo, userNo: userNo, adminAnswer: adminAnswer }),
                success: function(response) {
                   // alert('답변이 저장되었습니다.');
                    location.reload(); // 저장 후 페이지 새로고침
                },
                error: function() {
                   // alert('답변 저장에 실패했습니다.');
                }
            });
        }

        // 삭제 버튼 클릭 시
        $(document).on('click', '.delete-button', function() {
            var postNo = $(this).data('postno');
            var userNo = $(this).data('userno');

            if (confirm('정말로 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/user/rest/deleteQnA',
                    method: 'GET',
                    data: { postNo: postNo, userNo: userNo },
                    success: function(response) {
                        //alert('삭제되었습니다.');
                        $('.dialog-overlay.details').removeClass('active');
                        dialogVisible = false;
                        location.reload(); // 페이지 새로고침
                    },
                    error: function() {
                       // alert('삭제 실패.');
                    }
                });
            }
        });

        $(document).on('click', '.close-button', function() {
            var $dialog = $(this).closest('.dialog-overlay');
            $dialog.removeClass('active');
            dialogVisible = false;
        });

        // 제목 길이 검사
        $('#title').on('input', function() {
            var titleLength = $(this).val().length;
            if (titleLength > 34) {
                $('#title-warning').show();
            } else {
                $('#title-warning').hide();
            }
        });

        // QnA 작성 폼 제출
        $('#qnaForm').submit(function(event) {
            event.preventDefault(); // 기본 폼 제출 동작 방지
            var formData = $(this).serialize(); // 폼 데이터 직렬화

            $.ajax({
                url: '/user/addQnA', // 서버 엔드포인트
                method: 'POST', // POST 메소드 사용
                data: formData, // 직렬화된 폼 데이터 전송
                success: function(response) {
                    //alert('작성 완료되었습니다.'); // 성공 메시지
                    closeDialog();
                    location.reload(); // 페이지 새로고침
                },
                error: function() {
                    //alert('작성에 실패했습니다.'); // 실패 메시지
                	 closeDialog();
                     location.reload();
                }
            });
        });
    });

    function closeDialog() {
        $('.dialog-overlay').removeClass('active');
        dialogVisible = false;
    }

</script>




</head>

<!--  ////////////////////////////////////////////// body ///////////////////////////////////////////////// -->

<body>

<!--  ////////////////////////////////////////////// header ///////////////////////////////////////////////// -->

<header>
    <c:import url="../common/top.jsp" />
</header>

<!--  ////////////////////////////////////////////// main ///////////////////////////////////////////////// -->

<main>
    <div class="container-fluid py-5">
        <div class="container py-5">
        
        <div class="QNATITLE">
                <h2>QnA</h2>
                <h3>SANTA에 대해 궁금하신 사항을 작성해주세요!</h3>
                </div>
        
            <div class="search-container">
                <form id="searchForm" action="/user/getQnAList" method="get" style="display: flex; align-items: center;">
                
                    <select name="searchCondition" class="dropdown-custom">
                        <option value="0">Title</option>
                        <option value="1">NickName</option>
                    </select>
                    <input type="text" class="search-input" name="searchKeyword" placeholder="Search" value="${search != null && search.searchKeyword != null ? search.searchKeyword : '' }">
                    <input type="hidden" id="currentPage" name="currentPage" value="1"/>
                </form>
            </div>
            
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Category</th>
                            <th scope="col">Title</th>
                            <th scope="col">Nick Name</th>
                            <th scope="col">Post Date</th>
                            	 <c:if test="${admin != null}">
                           			 <th scope="col">Answer State</th>
                           		 </c:if>
                        </tr>
                    </thead>
                    <tbody id="qnaTable">
                        <c:forEach var="qna" items="${qnaList}">
                            <tr>
                                <td>${qnaList.indexOf(qna) + 1}</td>
                                <td>${qna.qnaPostCategory == 0 ? '계정' : 
                                    qna.qnaPostCategory == 1 ? '일정' : 
                                    qna.qnaPostCategory == 2 ? '인증' : 
                                    qna.qnaPostCategory == 3 ? '모임' : 
                                    qna.qnaPostCategory == 4 ? '등산기록' : 
                                    qna.qnaPostCategory == 5 ? '산 검색' : ''}</td>
                                 <td><a class="text" data-postno="${qna.postNo}" data-userno="${qna.userNo}">${qna.title}</a></td>
                                <td>${qna.nickName}</td>
                                <td>${qna.postDate}</td>
                                	 <c:if test="${admin != null}">
                                <td>${qna.answerState == 0 ? '답변 대기' : '답변 완료'}</td>
                                	</c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            	  
            	  <c:if test="${admin == null}">
            <!--  <button class="btn-write" onclick="location.href='/user/addQnA.jsp'">작성하기</button> -->
             <button class="btn-write" >작성하기</button> 
             	</c:if>
             	
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <a href="javascript:void(0);" data-page="${currentPage - 1}" class="btn-custom">&lt;</a>
			    </c:if>
			
			    <c:choose>
			        <c:when test="${totalPages <= 5}">
			            <c:forEach var="i" begin="1" end="${totalPages}">
			                <a href="javascript:void(0);" data-page="${i}" class="btn-custom ${i == currentPage ? 'active' : ''}">${i}</a>
			            </c:forEach>
			        </c:when>
			        <c:otherwise>
			            <c:forEach begin="0" end="4" varStatus="status">
			                <c:set var="pageNum" value="${currentPage <= 3 ? status.index + 1 : currentPage >= totalPages - 2 ? totalPages - 4 + status.index : currentPage - 2 + status.index}"/>
			                <a href="javascript:void(0);" data-page="${pageNum}" class="btn-custom ${pageNum == currentPage ? 'active' : ''}">${pageNum}</a>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			
			    <c:if test="${currentPage < totalPages}">
			        <a href="javascript:void(0);" data-page="${currentPage + 1}" class="btn-custom">&gt;</a>
			    </c:if>
			</div>

          	 
        </div>
    </div>
    
   <!-- 작성하기 다이얼로그 -->
    <div class="dialog-overlay write">
        <div class="dialog-content">
            <button class="close-button" onclick="closeDialog()">&times;</button>

            <h2></h2>

            <div class="profile-header">
                <img src="${user.profileImage}" alt="Profile Image">
                <p>${user.nickName}</p>
                <img src="${user.badgeImage}" alt="Badge Image" style="width:24px;height:24px;">
            </div>

			<div class="line"></div>
		
            <form id="qnaForm" action="/user/addQnA" method="post">
                <div class="form-group" style="text-align: left;">
                    <label for="title">제목<span>*</span></label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
                    <span id="title-warning" style="color: red; display: none; font-size:13px; text-align: left;">35자 미만의 제목을 입력해주세요.</span>
                </div>
                <div class="form-group">
                    <label for="contents">내용<span>*</span></label>
                    <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
                </div>
                <div class="form-group">
                    <label for="qnaPostCategory">카테고리<span>*</span></label>
                    <select id="qnaPostCategory" name="qnaPostCategory" required>
                        <option value="" disabled selected>질문 카테고리를 선택하세요</option>
                        <option value="0">계정</option>
                        <option value="1">일정</option>
                        <option value="2">인증</option>
                        <option value="3">모임</option>
                        <option value="4">등산기록</option>
                        <option value="5">산 검색</option>
                    </select>
                </div>
                <input type="hidden" id="userNo" name="userNo" value="${user.userNo}">
                <input type="hidden" id="userId" name="userId" value="${user.userId}">
                <div class="form-group">
                    <button type="submit">작성 완료하기</button>
                </div>
            </form>
        </div>
    </div>

    <!-- QNA 상세정보 다이얼로그 -->
    <div class="dialog-overlay details">
        <div class="dialog-content">
            <button class="close-button" onclick="closeDialog()">&times;</button>
            <div id="qnaDetailsContent">
                <!-- 다이얼로그 내용이 여기에 동적으로 삽입됩니다 -->
            </div>
        </div>
    </div>
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
	<c:import url="../common/footer.jsp"/>
</footer>
</body>
</html>
