<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Keywords</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h1>Mountain Search Keywords</h1>
<ul>
    <c:forEach var="searchKeyword" items="${mountainSearchKeywords}">
        <li>
            <button class="search-button" type="button" name="searchKeyword" value="${searchKeyword}">
                ${searchKeyword}
            </button>
        </li>
    </c:forEach>
</ul>

<h1>Popular Search Keywords</h1>
<ul>
    <c:forEach var="searchKeyword" items="${popularSearchKeywords}">
        <li>
            <button class="search-button" type="button" name="searchKeyword" value="${searchKeyword.mountainName}">
                ${searchKeyword.mountainName}
            </button>
        </li>
    </c:forEach>
</ul>

<h1>Search</h1>
<form id="searchForm" action="/mountain/mapMountain" method="get">
    <input type="text" id="searchInput" name="searchKeyword" value="">
    
    <button type="submit">button</button>
</form>

<script>
    $(document).ready(function() {
        $(".search-button").click(function() {
            var keyword = $(this).val();
            $("#searchInput").val(keyword);
            $("#searchForm").submit();
        });
    });
</script>

</body>