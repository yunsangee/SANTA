<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>
<meta charset="UTF-8">

    <title>Fruitables - Free Bootstrap 5 eCommerce Website Template</title>
    <link rel="canonical" href="https://themewagon.com/themes/fruitables-free/">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <c:import url="../html/icons.html" />
	<script>
        // JavaScript to dynamically load link.html into the head section
        document.addEventListener("DOMContentLoaded", function() {
            fetch('../html/link.html')
                .then(response => response.text())
                .then(data => {
                    let head = document.querySelector('head');
                    let tempDiv = document.createElement('div');
                    tempDiv.innerHTML = data;
                    Array.from(tempDiv.children).forEach(child => {
                        head.appendChild(child);
                    });
                })
                .catch(error => console.error('Error loading link.html:', error));
        });
    </script>
    
    <script>
        // JavaScript to dynamically load meta.html into the head section
        document.addEventListener("DOMContentLoaded", function() {
            fetch('../html/meta.html')
                .then(response => response.text())
                .then(data => {
                    let head = document.querySelector('head');
                    let tempDiv = document.createElement('div');
                    tempDiv.innerHTML = data;
                    Array.from(tempDiv.children).forEach(child => {
                        head.appendChild(child);
                    });
                })
                .catch(error => console.error('Error loading meta.html:', error));
        });
    </script>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/style.css">
    <script src="../javascript/scripts.js" type="module"></script>
    <script type="module">
        import './import.js';
    </script>
    
    <script>
    	$(function(){
    		$('#logoName').on('click',function(){
    			self.location = '/';
    		});
    	});
    
    </script>
</head>

<body>
	<header> <c:import url="./top.jsp"/> </header>
	<main>
		<nav>
			<div class="container-fluid testimonial py-5">
            <div class="container py-5">
                <div class="testimonial-header text-center">
                    <h4 class="text-primary">인기산 목록</h4>
                </div>
                <div class="owl-carousel testimonial-carousel owl-loaded owl-drag">
                    
                    
                    
                <div class="owl-stage-outer"><div class="owl-stage" style="transform: translate3d(-2163px, 0px, 0px); transition: all 2s ease 0s; width: 5047px;"><div class="owl-item cloned" style="width: 696px; margin-right: 25px;"><div class="testimonial-item img-border-radius bg-light rounded p-4">
                        <div class="position-relative">
                            <div class="d-flex align-items-center flex-nowrap">
                                <div class="bg-secondary rounded">
                                    <img src="img/testimonial-1.jpg" class="img-fluid rounded" style="width: 100px; height: 100px;" alt="">
                                </div>
                                <div class="ms-4 d-block">
                                    <h4 class="text-dark">Client Name</h4>
                                    <p class="m-0 pb-3">Profession</p>
                                    <div class="d-flex pe-5">
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                        <i class="fas fa-star text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div></div>
				</div></div>
				<div class="owl-nav"><div class="owl-prev"><i class="bi bi-arrow-left"></i></div><div class="owl-next"><i class="bi bi-arrow-right"></i></div></div><div class="owl-dots"><div class="owl-dot"><span></span></div><div class="owl-dot active"><span></span></div><div class="owl-dot"><span></span></div></div></div>
            </div>
        </div>
		</nav>
	
	</main>
	<footer></footer>

</body>
</html>