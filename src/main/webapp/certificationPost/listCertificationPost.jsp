<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
<meta charset="UTF-8">
<title>Certification Post List</title>
<style>
    .certification-post-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }
    .certification-post {
        border: 1px solid #ccc;
        border-radius: 10px;
        overflow: hidden;
        width: 300px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: transform 0.2s;
    }
    .certification-post:hover {
        transform: scale(1.05);
    }
    .certification-post img {
        width: 100%;
        height: auto;
    }
    .certification-post .details {
        padding: 15px;
    }
</style>
</head>
<body>
    <header> 
        <c:import url="../common/top.jsp"/> 
    </header>

    <main>
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="certification-post-container">
                    <c:forEach var="certificationPost" items="${certificationPost}" varStatus="status">
                        <div class="certification-post">
                            <div class="fruite-img">
                                <img src="img/fruite-item-5.jpg" alt="Certification Post Image">
                            </div>
                           
                            <div class="details">
                                <h4>${certificationPost.title}</h4>
                                <p>산명칭 : ${certificationPost.certificationPostMountainName}</p>

                                <p>Hiking Date: ${certificationPost.certificationPostHikingDate}</p>
                   			    <p>좋아요수: ${certificationPost.certificationPostLikeCount}</p>
                                <p>등산난이도 :
                                    <c:choose>
                                        <c:when test="${certificationPost.certificationPostHikingDifficulty == 0}">
                                            어려움
                                        </c:when>
                                        <c:when test="${certificationPost.certificationPostHikingDifficulty == 1}">
                                            중간
                                        </c:when>
                                        <c:when test="${certificationPost.certificationPostHikingDifficulty == 2}">
                                            쉬움
                                        </c:when>
                                    </c:choose>
                                </p>
                             <c:forEach var="hashtag" items="${hashtagList}">
							    <p># ${hashtag.certificationPostHashtagContents}</p>
							</c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
    
    <footer></footer>
</body>
</html>
