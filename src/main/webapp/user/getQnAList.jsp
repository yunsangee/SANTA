<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<!--  ////////////////////////////////////////////// head ///////////////////////////////////////////////// -->

<head>
    <meta charset="UTF-8">
    <title>산타가 궁금해요!</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            float: right;
        }

        .btn-write:hover {
            background-color: #578906;
        }
        
            footer {
        	width: 100%;
        	 margin-bottom:-249px;
        }
        
    </style>
    	
    	<c:import url="../common/header.jsp"/>
    	
  <!--  ////////////////////////////////////////////// script ///////////////////////////////////////////////// -->  
    
    <script>
    $(document).ready(function() {
        $('#searchForm').submit(function(event) {
            event.preventDefault();
            $.ajax({
                url: $(this).attr('action'),
                type: 'GET',
                dataType: 'json',
                data: $(this).serialize(),
                success: function(data) {
                    updateTable(data);
                },
                error: function(xhr, status, error) {
                    console.error('Error:', status, error);
                }
            });
        });

        $('.search-input').keypress(function(event) {
            if (event.which == 13) {
                $(this).closest('form').submit();
                event.preventDefault();
            }
        });

        $(document).on('click', '.pagination a', function(event) {
            event.preventDefault();
            $('#currentPage').val($(this).data('page'));
            $('#searchForm').submit();
        });

        function updateTable(data) {
            var qnaTable = $('#qnaTable');
            qnaTable.empty();
            $.each(data.qnaList, function(index, qna) {
                qnaTable.append(
                    '<tr>' +
                    '<td>' + (index + 1) + '</td>' +
                    '<td>' + getCategory(qna.qnaPostCategory) + '</td>' +
                    '<td><a href="/user/getQnA?qnaNo=' + qna.qnaNo + '">' + qna.title + '</a></td>' +
                    '<td>' + qna.nickName + '</td>' +
                    '<td>' + qna.postDate + '</td>' +
                    '<td>' + (qna.answerState === 0 ? '답변 대기' : '답변 완료') + '</td>' +
                    '</tr>'
                );
            });

            var pagination = $('.pagination');
            pagination.empty();
            for (var i = 1; i <= data.totalPages; i++) {
                pagination.append(
                    '<a href="javascript:void(0);" data-page="' + i + '" class="btn-custom ' + (i === data.currentPage ? 'active' : '') + '">' + i + '</a>'
                );
            }

            $('#totalQna').text('Total Posts: ' + data.totalCount + ', Posts on This Page: ' + data.currentPageCount);
        }

        function getCategory(category) {
            switch (category) {
                case 0: return '계정';
                case 1: return '일정';
                case 2: return '인증';
                case 3: return '모임';
                case 4: return '등산기록';
                case 5: return '산 검색';
                default: return '';
            }
        }
    });
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
            <div class="search-container">
                <form id="searchForm" action="/user/rest/getQnAList" method="get" style="display: flex; align-items: center;">
                    <select name="searchCondition" class="dropdown-custom">
                        <option value="0">Title</option>
                        <option value="1">NickName</option>
                    </select>
                    <input type="text" name="searchKeyword" class="form-control search-input" placeholder="Search by keyword">
                    <input type="hidden" id="currentPage" name="currentPage" value="1">
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
                                <td><a class="text" href="/user/getQnA?postNo=${qna.postNo}&userNo=${qna.userNo}">${qna.title}</a></td>
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
            
            <div class="pagination">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="javascript:void(0);" data-page="${i}" class="btn-custom ${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>
            </div>
          	 	  <c:if test="${admin == null}">
             <button class="btn-write" onclick="location.href='/user/addQnA.jsp'">작성하기</button>
             	</c:if>
        </div>
    </div>
    
</main>

<!--  ////////////////////////////////////////////// footer ///////////////////////////////////////////////// -->

<footer>
	<c:import url="../common/footer.jsp"/>
</footer>
</body>
</html>
