<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Form</title>
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 --></head>
<body>
    <div class="container">
        <h1 class="mt-5">Add Schedule</h1>
        <form action="/user/addSchedule" method="post">
            <div class="form-group">
                <label for="title"></label>
                <input type="text" class="form-control" id="title" name="title" placeholder="일정명을 입력하세요"  required>
            </div>
            <div class="form-group">
                <label for="mountainName"></label>
                <input type="text" class="form-control" id="mountainName" name="mountainName" placeholder="산 명칭"  required>
            </div>

            <div class="form-group">
                <label for="hikingTotalTime"></label>
                <input type="text" class="form-control" id="hikingTotalTime" name="hikingTotalTime" placeholder="총 소요시간" required>
            </div>
            <div class="form-group">
                <label for="hikingAscentTime"></label>
                <input type="text" class="form-control" id="hikingAscentTime" name="hikingAscentTime" placeholder="상행시간" required>
            </div>
            <div class="form-group">
                <label for="hikingDescentTime"></label>
                <input type="text" class="form-control" id="hikingDescentTime" name="hikingDescentTime" placeholder="하행시간" required>
            </div>
            <tr>
              <td>등산 난이도</td>
              <br>
            <td>
             <input type="radio" name="hikingDifficulty" value="0"> 어려움
                <input type="radio" name="hikingDifficulty" value="1"> 보통
                <input type="radio" name="hikingDifficulty" value="2"> 쉬움
            </td>
            </tr>
            <br>
            
            <tr>
              <td>교통수단</td>
              <br>
            <td>
             <input type="radio" name="Transportation" value="0"> 도보
                <input type="radio" name="Transportation" value="1"> 자전거
                <input type="radio" name="Transportation" value="2"> 버스
                <input type="radio" name="Transportation" value="3"> 자동차
                <input type="radio" name="Transportation" value="4"> 지하철
                <input type="radio" name="Transportation" value="5"> 기차
            </td>
            </tr>

            <br>
            <div class="form-group">
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" rows="10" placeholder="내용을 입력하세요" required></textarea>
        </div>
            
            <button type="submit" class="btn btn-primary">Submit</button>
            <button type="button" onclick="history.back()">뒤로</button>
        </form>
    </div>
</body>
</html>
