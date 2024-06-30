<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:import url="../common/header.jsp"/>
    <title>Certification Post</title>
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

        .custom-file-input {
            display: none;
        }

    .upload-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100px; /* 이미지 미리보기 크기와 동일하게 조정 */
    height: 100px; /* 이미지 미리보기 크기와 동일하게 조정 */
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
    color: #81c408
}

.upload-container p {
    margin: 5px 0 0;
    font-size: 0.8em;
    color: #81c408;
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
     
         
     
    </style>
    <script>
        $(document).ready(function() {
            // 파일 선택 시 파일 개수 제한 및 미리보기
            $('#certificationPostImage').on('change', function() {
                var files = $(this)[0].files;
                if (files.length > 5) {
                    alert("사진은 최대 5장까지 가능합니다.");
                    $(this).val(''); // 선택한 파일 리셋
                    $('#imagePreview').empty(); // 미리보기 초기화
                    $('#fileList').empty(); // 파일 리스트 초기화
                } else {
                    $('#imagePreview').empty(); // 기존 미리보기 초기화
                    $('#fileList').empty(); // 기존 파일 리스트 초기화
                    $.each(files, function(i, file) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $('#imagePreview').append('<img src="' + e.target.result + '" alt="Image Preview">');
                        }
                        reader.readAsDataURL(file);
                        $('#fileList').append('<p>' + file.name + '</p>');
                    });
                }
            });

            // 해시태그 추가 버튼 기능
            var hashtagCount = 0;
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
                        $('#additionalHashtags').append('<div class="hashtag-input-group"><input type="text" class="form-control" name="certificationPostHashtagContents" maxlength="10" value="' + hashtagValue + '" readonly><button type="button" class="remove-hashtag"><i class="fa fa-trash"></i></button></div>');
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
                $(this).closest('.hashtag-input-group').remove();
                hashtagCount--;
                if (hashtagCount < 5) {
                    $('#hashtagInputContainer').show(); // 입력 필드 보임
                }
            });

            $('#contents').on('input', function() {
                var currentLength = $(this).val().length;
                if (currentLength > 1000) {
                    $(this).val($(this).val().substring(0, 1000));
                    currentLength = 1000;
                }
                $('#charCount').text(currentLength);
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
                <form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">제목<sup>*</sup></label>
                        <input type="text" class="form-control" id="title" name="title" maxlength="50" required>
                    </div>
                    <div class="form-group">
                        <label for="contents">내용<sup>*</sup></label>
                        <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="5" required></textarea>
                        <div class="char-counter"><span id="charCount">0</span>/1000</div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostMountainName">산 이름<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHikingTrail">등산로<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="20" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="totalTimeHours">총 소요시간<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="totalTimeHours" name="totalTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ascentTimeHours">상행 시간<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="ascentTimeHours" name="ascentTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="descentTimeHours">하행 시간<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="descentTimeHours" name="descentTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHikingDate">등산 일자<sup>*</sup></label>
                        <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" required>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHashtagContents">해시태그<sup>*</sup> <small>(최대 5개)</small></label>
                        <div class="hashtag-input-group" id="hashtagInputContainer">
                            <input type="text" class="form-control" id="certificationPostHashtagContents" maxlength="10">
                            <button type="button" id="addHashtag" class="add-hashtag-btn">+</button>
                        </div>
                        <div id="additionalHashtags"></div>
                    </div>
                    <div class="form-group">
                        <label>교통수단<sup>*</sup></label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation0" value="0" required>
                                <label class="form-check-label" for="transportation0">도보</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation1" value="1" required>
                                <label class="form-check-label" for="transportation1">자전거</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation2" value="2" required>
                                <label class="form-check-label" for="transportation2">버스</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation3" value="3" required>
                                <label class="form-check-label" for="transportation3">자동차</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation4" value="4" required>
                                <label class="form-check-label" for="transportation4">지하철</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation5" value="5" required>
                                <label class="form-check-label" for="transportation5">기차</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>등산 난이도<sup>*</sup></label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty0" value="0" required>
                                <label class="form-check-label" for="difficulty0">어려움</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty1" value="1" required>
                                <label class="form-check-label" for="difficulty1">중간</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty2" value="2" required>
                                <label class="form-check-label" for="difficulty2">쉬움</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostImage">사진<sup>*</sup> <small>(최대 5개)</small></label>
                        <div class="upload-container">
                            <i class="fa fa-file-upload"></i>
                            <p> 파일 선택 또는<br> 드래그 앤 드롭</p>
                        </div>
                        <input type="file" class="custom-file-input" id="certificationPostImage" name="certificationPostImage" multiple maxlength="5" required>
                        <div id="fileList" class="custom-file-list"></div>
                        <div id="imagePreview" class="preview-container"></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">작성완료!</button>
               
                </form>
            </div>
        </div>
    </main>
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
