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
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-hashtag-btn:hover {
            background-color: #218838;
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

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .file-input {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }

        .btn-upload {
            border: 2px solid #007bff;
            color: #007bff;
            background-color: white;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
    <script>
    $(document).ready(function() {
        // 파일 선택 시 파일 개수 제한
        $('#certificationPostImage').on('change', function() {
            var files = $(this)[0].files;
            if (files.length > 5) {
                alert("사진은 최대 5장까지 가능합니다.");
                $(this).val(''); // 선택한 파일 리셋
            }
        });

        // 해시태그 추가 버튼 기능
        var hashtagCount = ${hashtagList.size()};
        var deleteHashtags = [];
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
                if (hashtagCount < 5) {
                    $('#additionalHashtags').append('<div class="hashtag-input-group"><input type="text" class="form-control" name="newHashtags" maxlength="10" value="' + hashtagValue + '" readonly><button type="button" class="remove-hashtag"><i class="fa fa-trash"></i></button></div>');
                    hashtagInput.val('');
                    hashtagCount++;
                    if (hashtagCount === 5) {
                        $('#hashtagInputContainer').hide(); // 입력 필드 숨김
                    }
                } else {
                    alert("최대 5개의 해시태그만 가능합니다.");
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
                if (hashtagCount < 5) {
                    $('#hashtagInputContainer').show(); // 입력 필드 보임
                }
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
                if (hashtagCount < 5) {
                    $('#hashtagInputContainer').show(); // 입력 필드 보임
                }
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
            <h2 class="text-center">UPDATE Certification Post</h2>
            <form id="certificationForm" action="/certificationPost/updateCertificationPost" method="post" enctype="multipart/form-data">
                <input type="hidden" id="postNo" name="postNo" value="${certificationPost.postNo}"/>
                <div class="form-group">
                    <label for="title">Title<sup>*</sup></label>
                    <input type="text" class="form-control" id="title" name="title"maxlength="50" value="${certificationPost.title}" required>
                </div>
                <div class="form-group">
                    <label for="contents">Contents<sup>*</sup></label>
                    <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="10" required>${certificationPost.contents}</textarea>
                    <div class="char-counter"><span id="charCount">0</span>/1000</div>
                </div>
                <div class="form-group">
                    <label for="certificationPostMountainName">Mountain Name<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" value="${certificationPost.certificationPostMountainName}" required>
                </div>
                <div class="form-group">
                    <label for="certificationPostHikingTrail">Hiking Trail<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="20" value="${certificationPost.certificationPostHikingTrail}" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="totalTimeHours">Total Time<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="totalTimeHours" name="totalTimeHours" min="0" max="23" placeholder="시간" required value="${totalTimeHours}">
                            <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min="0" max="59" placeholder="분" required value="${totalTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ascentTimeHours">Ascent Time<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="ascentTimeHours" name="ascentTimeHours" min="0" max="23" placeholder="시간" required value="${ascentTimeHours}">
                            <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min="0" max="59" placeholder="분" required value="${ascentTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descentTimeHours">Descent Time<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control" id="descentTimeHours" name="descentTimeHours" min="0" max="23" placeholder="시간" required value="${descentTimeHours}">
                            <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min="0" max="59" placeholder="분" required value="${descentTimeMinutes}">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="certificationPostHikingDate">Hiking Date<sup>*</sup></label>
                    <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" value="${certificationPost.certificationPostHikingDate}" required>
                </div>
                <div class="form-group">
                    <label for="certificationPostHashtagContents">HASHTAG<sup>*</sup> <small>(최대 5개)</small></label>
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
                    <label for="certificationPostImage">이미지<sup>*</sup> <small>(최대 5개)</small></label>
                    <div class="mb-3" id="imagePreview">
                        <c:forEach var="image" items="${certificationPostImages}">
                        
                            <div class="image-container">
                                <img src="${image}" class="img-thumbnail" style="max-width: 150px;">
                                <button type="button" class="delete-image-button">&times;</button>
                                <input type="hidden" name="updateImageURL" value="${image}"/>
                            </div>
                            
                        </c:forEach>
                    </div>
                    <div class="file-input-wrapper">
                        <button type="button" class="btn-upload">파일 선택</button>
                        <input type="file" id="certificationPostImage" name="certificationPostImage" class="file-input" multiple/>
                    </div>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <button type="submit" class="btn btn-primary btn-lg mx-2">수정 완료</button>
                    <button type="button" class="btn btn-secondary btn-lg mx-2" onclick="history.back()">뒤로 가기</button>
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
                    
