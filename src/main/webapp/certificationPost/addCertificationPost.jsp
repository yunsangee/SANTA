<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../common/header.jsp"/>
    <title>Certification Post</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <header>
        <c:import url="../common/top.jsp"/>
    </header>
    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h2 class="text-center">Add Certification Post</h2>
                <form id="certificationForm" action="/certificationPost/addCertificationPost" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="userNo">User No<sup>*</sup></label>
                            <input type="text" class="form-control" id="userNo" name="userNo" maxlength="20" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="title">Title<sup>*</sup></label>
                            <input type="text" class="form-control" id="title" name="title" maxlength="20" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="contents">Contents<sup>*</sup></label>
                        <input type="text" class="form-control" id="contents" name="contents" maxlength="100" required>
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
                        <div class="form-group col-md-4">
                            <label for="certificationPostTotalTime">Total Time<sup>*</sup></label>
                            <input type="text" class="form-control" id="certificationPostTotalTime" name="certificationPostTotalTime" maxlength="20" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="certificationPostAscentTime">Ascent Time<sup>*</sup></label>
                            <input type="text" class="form-control" id="certificationPostAscentTime" name="certificationPostAscentTime" maxlength="20" required>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="certificationPostDescentTime">Descent Time<sup>*</sup></label>
                            <input type="text" class="form-control" id="certificationPostDescentTime" name="certificationPostDescentTime" maxlength="20" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="certificationPostHikingDate">Hiking Date<sup>*</sup></label>
                            <input type="date" class="form-control" id="certificationPostHikingDate" name="certificationPostHikingDate" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="certificationPostHashtagContents">HASHTAG</label>
                            <input type="text" class="form-control" id="certificationPostHashtagContents" name="certificationPostHashtagContents" maxlength="20">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Transportation<sup>*</sup></label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation0" value="0">
                                <label class="form-check-label" for="transportation0">도보</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation1" value="1">
                                <label class="form-check-label" for="transportation1">자전거</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation2" value="2">
                                <label class="form-check-label" for="transportation2">버스</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation3" value="3">
                                <label class="form-check-label" for="transportation3">자동차</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation4" value="4">
                                <label class="form-check-label" for="transportation4">지하철</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostTransportation" id="transportation5" value="5">
                                <label class="form-check-label" for="transportation5">기차</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Hiking Difficulty<sup>*</sup></label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty0" value="0">
                                <label class="form-check-label" for="difficulty0">어려움</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty1" value="1">
                                <label class="form-check-label" for="difficulty1">중간</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="certificationPostHikingDifficulty" id="difficulty2" value="2">
                                <label class="form-check-label" for="difficulty2">쉬움</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="certificationPostImage">이미지</label>
                        <input type="file" class="form-control-file" id="certificationPostImage" name="certificationPostImage" maxlength="20">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
