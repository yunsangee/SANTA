<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../common/header.jsp"/>
    <title>게시글 수정</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script>
        $(document).ready(function() {
            var hashtagCount = ${hashtagList.size()};
            $('#addHashtag').click(function() {
                if (hashtagCount < 5) {
                    $('#additionalHashtags').append('<div class="d-flex mb-2"><input type="text" class="form-control" name="newHashtags" maxlength="20"><button type="button" class="btn btn-danger ml-2 remove-hashtag">삭제</button></div>');
                    hashtagCount++;
                } else {
                    alert("최대 5개의 해시태그만 가능합니다.");
                }
            });

            $(document).on('click', '.remove-hashtag', function() {
                $(this).parent().remove();
                hashtagCount--;
            });

            $(document).on('click', '.delete-existing-hashtag', function() {
                var $parent = $(this).parent();
                var hashtagNo = $parent.find('input[name="existingHashtagNos"]').val();

                if (hashtagNo) {
                    $.ajax({
                        url: 'rest/deleteHashtag',
                        type: 'POST',
                        data: { hashtagNo: hashtagNo },
                        success: function(result) {
                            $parent.remove();
                            hashtagCount--;
                        },
                        error: function(xhr, status, error) {
                            alert("해시태그 삭제에 실패했습니다.");
                        }
                    });
                } else {
                    alert("해시태그 번호를 찾을 수 없습니다.");
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
            <h2 class="text-center">UPDATE Certification Post</h2>
            <form id="certificationForm" action="/certificationPost/updateCertificationPost" method="post" enctype="multipart/form-data">
                <input type="hidden" id="postNo" name="postNo" value="${certificationPost.postNo}"/>
                <div class="form-group">
                    <label for="title">제목<sup>*</sup></label>
                    <input type="text" class="form-control" id="title" name="title" maxlength="50" value="${certificationPost.title}" required>
                </div>
                <div class="form-group">
                    <label for="contents">내용<sup>*</sup></label>
                    <textarea class="form-control" id="contents" name="contents" maxlength="1000" rows="10" required>${certificationPost.contents}</textarea>
                </div>
                <div class="form-group">
                    <label for="certificationPostMountainName">산 이름<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostMountainName" name="certificationPostMountainName" maxlength="20" value="${certificationPost.certificationPostMountainName}" required>
                </div>
                <div class="form-group">
                    <label for="certificationPostHikingTrail">등산 경로<sup>*</sup></label>
                    <input type="text" class="form-control" id="certificationPostHikingTrail" name="certificationPostHikingTrail" maxlength="50" value="${certificationPost.certificationPostHikingTrail}" required>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="totalTimeHours">총 소요 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control mr-2" id="totalTimeHours" name="totalTimeHours" min="0" max="24" placeholder="시간" required value="${totalTimeHours}">
                            <input type="number" class="form-control" id="totalTimeMinutes" name="totalTimeMinutes" min="0" max="59" placeholder="분" required value="${totalTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="ascentTimeHours">상행 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control mr-2" id="ascentTimeHours" name="ascentTimeHours" min="0" max="12" placeholder="시간" required value="${ascentTimeHours}">
                            <input type="number" class="form-control" id="ascentTimeMinutes" name="ascentTimeMinutes" min="0" max="59" placeholder="분" required value="${ascentTimeMinutes}">
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="descentTimeHours">하행 시간<sup>*</sup></label>
                        <div class="d-flex">
                            <input type="number" class="form-control mr-2" id="descentTimeHours" name="descentTimeHours" min="0" max="12" placeholder="시간" required value="${descentTimeHours}">
                            <input type="number" class="form-control" id="descentTimeMinutes" name="descentTimeMinutes" min="0" max="59" placeholder="분" required value="${descentTimeMinutes}">
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="certificationPostHikingDate">등산 일자<sup>*</sup></label>
                    <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" value="${certificationPost.certificationPostHikingDate}" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="certificationPostHashtagContents">해시태그<sup>*</sup> <small>(최대 5개)</small></label>
                    <c:forEach var="hashtag" items="${hashtagList}">
                        <div class="d-flex mb-2">
                            <input type="text" class="form-control" name="existingHashtags" maxlength="20" value="${hashtag.certificationPostHashtagContents}" required>
                            <input type="hidden" name="existingHashtagNos" value="${hashtag.hashtagNo}">
                            <button type="button" class="btn btn-danger ml-2 delete-existing-hashtag" data-hashtag-no="${hashtag.hashtagNo}">삭제</button>
                        </div>
                    </c:forEach>
                    <div id="additionalHashtags"></div>
                    <button type="button" id="addHashtag" class="btn btn-secondary mt-2">추가</button>
                </div>
                <div class="form-group">
                    <label>교통수단<sup>*</sup></label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation0" value="0" <c:if test="${certificationPost.certificationPostTransportation == 0}">checked</c:if> required>
                            <label class="form-check-label" for="transportation0">도보</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation1" value="1" <c:if test="${certificationPost.certificationPostTransportation == 1}">checked</c:if> required>
                            <label class="form-check-label" for="transportation1">자전거</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation2" value="2" <c:if test="${certificationPost.certificationPostTransportation == 2}">checked</c:if> required>
                            <label class="form-check-label" for="transportation2">버스</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation3" value="3" <c:if test="${certificationPost.certificationPostTransportation == 3}">checked</c:if> required>
                            <label class="form-check-label" for="transportation3">자동차</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation4" value="4" <c:if test="${certificationPost.certificationPostTransportation == 4}">checked</c:if> required>
                            <label class="form-check-label" for="transportation4">지하철</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation5" value="5" <c:if test="${certificationPost.certificationPostTransportation == 5}">checked</c:if> required>
                            <label class="form-check-label" for="transportation5">기차</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>등산 난이도<sup>*</sup></label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty0" value="0" <c:if test="${certificationPost.certificationPostHikingDifficulty == 0}">checked</c:if> required>
                            <label class="form-check-label" for="difficulty0">어려움</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty1" value="1" <c:if test="${certificationPost.certificationPostHikingDifficulty == 1}">checked</c:if> required>
                            <label class="form-check-label" for="difficulty1">중간</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty2" value="2" <c:if test="${certificationPost.certificationPostHikingDifficulty == 2}">checked</c:if> required>
                            <label class="form-check-label" for="difficulty2">쉬움</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="certificationPostImage">이미지<sup>*</sup> <small>(최대 5개)</small></label>
                    <div class="mb-3">
                        <c:forEach var="image" items="${certificationPostImages}">
                            <img src="${image}" class="img-thumbnail" style="max-width: 150px; margin-right: 10px;">
                        </c:forEach>
                    </div>
                    <input type="file" class="form-control-file" id="certificationPostImage" name="certificationPostImage" multiple maxlength="5" >
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
