<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html >
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
    
                
                <!-- 유저 정보 출력 -->
                <c:set var="user" value="${sessionScope.user}" />
                <c:if test="${user != null}">
                    <p>Logged in as: ${user.userName} (${user.userId})</p>
                </c:if>

                <form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">Title<sup>*</sup></label>
                        <input type="text" class="form-control" id="title" name="title" maxlength="50" required>
                    </div>
                    <div class="form-group">
                        <label for="contents">Contents<sup>*</sup></label>
                        <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="5" required></textarea>
                        <div class="char-counter"><span id="charCount">0</span>/1000</div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostMountainName">Mountain Name<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHikingTrail">Hiking Trail<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="20" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="totalTimeHours">Total Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="totalTimeHours" name="totalTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ascentTimeHours">Ascent Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="ascentTimeHours" name="ascentTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="descentTimeHours">Descent Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control" id="descentTimeHours" name="descentTimeHours" min="0" max="23" placeholder="시간" required>
                                <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min="0" max="59" placeholder="분" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHikingDate">Hiking Date<sup>*</sup></label>
                        <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" required>
                    </div>
                   <div class="form-group">
    <label for="certificationPostHashtagContents">HASHTAG<sup>*</sup> <small>(최대 5개)</small></label>
    <div class="hashtag-input-group" id="hashtagInputContainer">
        <input type="text" class="form-control" id="certificationPostHashtagContents" maxlength="10">
        <button type="button" id="addHashtag" class="add-hashtag-btn">+</button>
    </div>
    <div id="additionalHashtags"></div>
</div>

                 
                    <div class="form-group">
                        <label>Transportation<sup>*</sup></label>
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
                        <label>Hiking Difficulty<sup>*</sup></label>
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
                        <label for="certificationPostImage">이미지<sup>*</sup> <small>(최대 5개)</small></label>
                        <input type="file" class="form-control-file" id="certificationPostImage" name="certificationPostImage" multiple maxlength="5" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </div>
        </div>
    </main>
    <footer>
        <c:import url="../common/footer.jsp"/>
    </footer>
</body>
</html>
