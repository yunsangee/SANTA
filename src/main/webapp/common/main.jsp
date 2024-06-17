<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
    <c:import url="../common/header.jsp"/>

    <script>
        $(document).ready(function() {
            $('.owl-carousel').owlCarousel({
                loop: true,
                margin: 10,
                nav: true,
                items: 1
            });

            $('#logoName').on('click', function(){
                self.location = '/';
            });
        });
    </script>
</head>
<body>
     <header><c:import url="./top.jsp"/></header>
    <main>
        <nav>
            <div class="container-fluid testimonial py-5">
                <div class="container py-5">
                    <div class="testimonial-header text-center">
                        <h4 class="text-primary">인기산 목록</h4>
                    </div>
                    <div class="owl-carousel testimonial-carousel">
                        <c:forEach var="mountain" items="${popularMountainList}">
                            <div class="item">
                                <div class="testimonial-item img-border-radius bg-light rounded p-4">
                                    <div class="position-relative">
                                        <div class="d-flex align-items-center flex-nowrap">
                                            <div class="bg-secondary rounded">
                                                <img src="${mountain.mountainImage}" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
                                            </div>
                                            <div class="ms-4 d-block">
                                                <h4 class="text-dark">${mountain.mountainName}</h4>
                                                <p class="m-0 pb-3">${mountain.likeCount}</p>
                                                <div class="d-flex pe-5">
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </nav>
    </main>
    <footer></footer>
</body>
</html>
