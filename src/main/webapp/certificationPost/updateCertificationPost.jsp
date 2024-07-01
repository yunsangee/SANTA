<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:import url="../common/header.jsp"/>
    <title>게시글 수정</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
        main {
            padding: 20px;
            padding-top: 80px;
        }

        header {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .hashtag-input-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .hashtag-input-group input {
            flex-grow: 1;
        }

        .add-hashtag-btn {
            padding: 5px 10px;
            background-color: #81c408;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-hashtag-btn:hover {
            background-color: #ffb524;
        }

        .remove-hashtag {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .remove-hashtag:hover {
            background-color: #c82333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
        }

        .d-flex {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .d-flex .form-control {
            flex-grow: 1;
        }

        .char-counter {
            text-align: right;
            font-size: 0.9em;
            color: #666;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .image-container {
            position: relative;
            display: inline-block;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .image-container img {
            max-width: 150px;
        }

        .delete-image-button {
            position: absolute;
            top: 0;
            right: 0;
            line-height: 0;
            background: none;
            border: none;
            color: red;
            font-size: 24px;
            cursor: pointer;
        }

        .upload-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100px;
            height: 100px;
            border: 2px dashed #81c408;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .upload-container:hover {
            background-color: #f8f9fa;
        }

        .upload-container i {
            font-size: 24px;
            color:#81c408;
        }

        .upload-container p {
            margin: 5px 0 0;
            font-size: 0.8em;
            color: #81c408;
        }

        .preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .preview-container img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .custom-file-list {
            margin-top: 10px;
        }

        .custom-file-list p {
            margin: 0;
            font-size: 0.9em;
            color: #555;
        }

        .btn-primary {
            background-color: #81c408;
            border: 2px solid  #81c408;
            color:  #fff;
            transition: background-color 0.3s, color 0.3s;
            height: 60px; /* 높이 설정 */
            width: 200px; /* 가로 길이 설정 */
            display: block; /* 추가 */
            margin: 20px auto; /* 중앙 정렬을 위해 수정 */
        }
     
        .custom-file-input {
            display: none;
        }
    </style>
    <script>
    $(document).ready(function() {
        var MAX_HASHTAGS = 5;
        var hashtagCount = ${hashtagList.size()};
        var deleteHashtags = [];

        function checkHashtagCount() {
            if (hashtagCount >= MAX_HASHTAGS) {
                $('#hashtagInputContainer').hide(); // 입력 필드 숨김
            } else {
                $('#hashtagInputContainer').show(); // 입력 필드 보임
            }
        }

        // 초기 로드 시 해시태그 개수 체크
        checkHashtagCount();

        $('#addHashtag').click(function() {
            var hashtagInput = $('#certificationPostHashtagContents');
            var hashtagValue = hashtagInput.val().trim();

            if (hashtagValue === "") {
                alert("해시태그를 입력해주세요.");
            } else if (hashtagValue.indexOf('#') !== -1) {
                alert("# 문자는 해시태그에 사용할 수 없습니다.");
                hashtagInput.val(hashtagValue.replace('#', '')); // # 문자를 제거
            } else if (hashtagValue.length > 10) {
                alert("해시태그는 최대 10글자까지 입력 가능합니다.");
            } else {
                if (hashtagCount < MAX_HASHTAGS) {
                    $('#additionalHashtags').append('<div class="hashtag-input-group"><input type="text" class="form-control" name="newHashtags" maxlength="10" value="' + hashtagValue + '" readonly><button type="button" class="remove-hashtag"><i class="fa fa-trash"></i></button></div>');
                    hashtagInput.val('');
                    hashtagCount++;
                    checkHashtagCount(); // 해시태그 개수 체크
                } else {
                    alert("최대 " + MAX_HASHTAGS + "개의 해시태그만 가능합니다.");
                }
            }
        });

        // 엔터키 눌렀을 때 해시태그 추가
        $('#certificationPostHashtagContents').keypress(function(e) {
            if (e.which == 13) {
                $('#addHashtag').click();
                return false;
            }
        });

        // 해시태그 삭제 버튼 기능
        $(document).on('click', '.remove-hashtag', function() {
            var $parent = $(this).closest('.hashtag-input-group');
            var $existingHashtag = $parent.find('.delete-existing-hashtag');

            if ($existingHashtag.length) {
                $existingHashtag.trigger('delete');
            } else {
                $parent.remove();
                hashtagCount--;
                checkHashtagCount(); // 해시태그 개수 체크
            }
        });

        // 기존 해시태그 삭제 버튼 기능
        $(document).on('click', '.delete-existing-hashtag', function() {
            var $parent = $(this).closest('.hashtag-input-group');
            var hashtagNo = $parent.find('input[name="existingHashtagNos"]').val();

            if (hashtagNo) {
                deleteHashtags.push(hashtagNo);
                $parent.remove();
                hashtagCount--;
                checkHashtagCount(); // 해시태그 개수 체크
            } else {
                alert("해시태그 번호를 찾을 수 없습니다.");
            }
        });

        // 폼 제출 시 삭제할 해시태그 번호를 hidden input에 추가
        $('#certificationForm').on('submit', function() {
            var $form = $(this);
            deleteHashtags.forEach(function(hashtagNo) {
                $form.append('<input type="hidden" name="deleteHashtagNos" value="' + hashtagNo + '">');
            });
        });

        $('#contents').on('input', function() {
            var currentLength = $(this).val().length;
            if (currentLength > 1000) {
                $(this).val($(this).val().substring(0, 1000));
                currentLength = 1000;
            }
            $('#charCount').text(currentLength);
        });

        $(document).on('click', '.delete-image-button', function() {
            var $this = $(this);
            var $imageContainer = $this.closest('.image-container');
            $imageContainer.remove();
        });

        // 오늘 날짜를 max 속성으로 설정하여 미래 날짜 선택 방지
        var today = new Date().toISOString().split('T')[0];
        $('#certificationPostHikingDate').attr('max', today);

        function checkTotalTimeLimit() {
            var totalHours = parseInt($('#totalTimeHours').val()) || 0;
            var totalMinutes = parseInt($('#totalTimeMinutes').val()) || 0;
            if (totalHours > 23 || (totalHours === 23 && totalMinutes > 59)) {
                alert("총 소요 시간은 23시간 59분을 초과할 수 없습니다.");
                $('#totalTimeHours').val('');
                $('#totalTimeMinutes').val('');
            }
        }

        $('#totalTimeHours, #totalTimeMinutes').on('change', checkTotalTimeLimit);

        // 드래그 앤 드롭 기능
        $('.upload-container').on('dragover', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).css('background-color', '#f8f9fa');
        });

        $('.upload-container').on('dragleave', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).css('background-color', 'transparent');
        });

        $('.upload-container').on('drop', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var files = e.originalEvent.dataTransfer.files;
            $('#certificationPostImage')[0].files = files;
            $('#certificationPostImage').trigger('change');
        });

        $('.upload-container').on('click', function() {
            $('#certificationPostImage').click();
        });

        function updateImagePreview() {
            var $imagePreview = $('#imagePreview');
            $imagePreview.empty();

            // 기존 이미지 추가
            <c:forEach var="image" items="${certificationPostImages}">
                var existingImage = $('<div>').addClass('image-container')
                    .append('<img src="${image}" class="img-thumbnail" style="max-width: 150px;">')
                    .append('<button type="button" class="delete-image-button">&times;</button>')
                    .append('<input type="hidden" name="updateImageURL" value="${image}"/>');
                $imagePreview.append(existingImage);
            </c:forEach>

            // 새로 추가한 이미지 추가
            var files = $('#certificationPostImage')[0].files;
            for (var i = 0; i < files.length; i++) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = $('<img>').attr('src', e.target.result).addClass('img-thumbnail').css('max-width', '150px');
                    var container = $('<div>').addClass('image-container').append(img).append('<button type="button" class="delete-image-button">&times;</button>');
                    $imagePreview.append(container);
                }
                reader.readAsDataURL(files[i]);
            }
        }

        // 파일 선택 시 파일 개수 제한 및 미리보기 업데이트
        $('#certificationPostImage').on('change', function() {
            updateImagePreview();
        });
    });
    </script>
</head>
<body>
<header>
    <c:import url="../common/top.jsp"/>
</header>
<main class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <form id="certificationForm" action="/certificationPost/updateCertificationPost" method="post" enctype="multipart/form-data">
                <input type="hidden" id="postNo" name="postNo" value="${certificationPost.postNo}"/>
                <div class="form-group">
                    <label for="title">제목<sup>*</sup></label>
                    <input type="text" class="form-control" id="title" name="title"maxlength="50" value="${certificationPost.title}" required>
                </div>
                <div class="form-group">
                    <label for="contents">이렇게 다녀왔어요!<sup>*</sup></label>
                    <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="10" required>${certificationPost.contents}</textarea>
                    <div class="char-counter"><span id="charCount">0</span>/1000</div>
                </div>
                <div class="form-group">
                    <label for="certificationPostMountainName">산 이름<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" value="${certificationPost.certificationPostMountainName}" required>
                </div>
                <div class="form-group">
                    <label for="certificationPostHikingTrail">등산 경로<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="20" value="${certificationPost.certificationPostHikingTrail}" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="totalTimeHours">총 소요 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="totalTimeHours" name="totalTimeHours" min="0" max="23" placeholder="시간" required value="${totalTimeHours}">
                            <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min="0" max="59" placeholder="분" required value="${totalTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ascentTimeHours">상행 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="ascentTimeHours" name="ascentTimeHours" min="0" max="23" placeholder="시간" required value="${ascentTimeHours}">
                            <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min="0" max="59" placeholder="분" required value="${ascentTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descentTimeHours">하행 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="descentTimeHours" name="descentTimeHours" min="0" max="23" placeholder="시간" required value="${descentTimeHours}">
                            <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min="0" max="59" placeholder="분" required value="${descentTimeMinutes}">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="certificationPostHikingDate">등산 일자<sup>*</sup></label>
                    <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" value="${certificationPost.certificationPostHikingDate}" required>
                </div>
                <div class="form-group">
                    <label for="certificationPostHashtagContents">해시태그<sup>*</sup> <small>(최대 5개)</small></label>
                    <div class="hashtag-input-group" id="hashtagInputContainer">
                        <input type="text" class="form-control" id="certificationPostHashtagContents" maxlength="10">
                        <button type="button" id="addHashtag" class="add-hashtag-btn">+</button>
                    </div>
                    <div id="additionalHashtags"></div>
                    <c:forEach var="hashtag" items="${hashtagList}">
                        <div class="hashtag-input-group">
                            <input type="text" class="form-control" name="existingHashtags" maxlength="20" value="${hashtag.certificationPostHashtagContents}" readonly>
                            <input type="hidden" name="existingHashtagNos" value="${hashtag.hashtagNo}">
                            <button type="button" class="remove-hashtag delete-existing-hashtag"><i class="fa fa-trash"></i></button>
                        </div>
                    </c:forEach>
                </div>
                <div class="form-group">
				    <label for="certificationPostImage">사진<sup>*</sup> <small>(최대 5개)</small></label>
				    <div class="upload-container">
				        <i class="fa fa-file-upload"></i>
				        <p> 파일 선택 또는<br> 드래그 앤 드롭</p>
				    </div>
				    <input type="file" class="custom-file-input" id="certificationPostImage" name="certificationPostImage" multiple maxlength="5">
				    <div id="fileList" class="custom-file-list"></div>
				    <div class="mb-3" id="imagePreview">
				        <c:forEach var="image" items="${certificationPostImages}">
				            <div class="image-container">
				                <img src="${image}" class="img-thumbnail" style="max-width: 150px;">
				                <button type="button" class="delete-image-button">&times;</button>
				                <input type="hidden" name="updateImageURL" value="${image}"/>
				            </div>
				        </c:forEach>
				    </div>
				</div>

                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-primary btn-lg mx-2">수정 완료!</button>
                </div>
            </form>
        </div>
    </div>
</main>
<footer>
    <c:import url="../common/footer.jsp"/>
</footer>
</body>
</html>
