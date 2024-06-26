<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../common/header.jsp"/>
    <title>Certification Post</title>
 
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
            var hashtagCount = 1;
            $('#addHashtag').click(function() {
                if (hashtagCount < 5) {
                    $('#additionalHashtags').append('<input type="text" class="form-control" name="certificationPostHashtagContents" maxlength="10">');
                    hashtagCount++;
                } else {
                    alert("최대 5개의 해시태그만 가능합니다.");
                }
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
                <h2 class="text-center">Add Certification Post</h2>
                
                <!-- 세션에서 user 객체를 가져와서 JSTL 변수로 설정 -->
                <c:set var="user" value="${sessionScope.user}" />

                <!-- 유저 정보 출력 -->
                <c:if test="${user != null}">
                    <p>확인용Logged in as: ${user.userName} (${user.userId})</p>
                </c:if>

                <form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="title">Title<sup>*</sup></label>
                            <input type="text" class="form-control" id="title" name="title" maxlength="50" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="contents">Contents<sup>*</sup></label>
                        <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="10" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostMountainName">Mountain Name<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostHikingTrail">Hiking Trail<sup>*</sup></label>
                        <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="50" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label for="totalTimeHours">Total Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control mr-2" id="totalTimeHours" name="totalTimeHours" min=0 max=24 placeholder="시간" required>
                                <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min=0 max=59 placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="ascentTimeHours">Ascent Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control mr-2" id="ascentTimeHours" name="ascentTimeHours" min=0 max=12 placeholder="시간" required>
                                <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min=0 max=59 placeholder="분" required>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="descentTimeHours">Descent Time<sup>*</sup></label>
                            <div class="d-flex">
                                <input type="number" class="form-control mr-2" id="descentTimeHours" name="descentTimeHours" min=0 max=12 placeholder="시간" required>
                                <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min=0 max=59 placeholder="분" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="certificationPostHikingDate">Hiking Date<sup>*</sup></label>
                        <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="certificationPostHashtagContents">HASHTAG<sup>*</sup> <small>(최대 5개)</small></label>
                        <input type="text" class="form-control" id="certificationPostHashtagContents" name="certificationPostHashtagContents" maxlength="10">
                        <button type="button" id="addHashtag">+</button>
                    </div>
                    <div id="additionalHashtags"></div>
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
</body>
</html>
