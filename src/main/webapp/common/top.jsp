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

	<nav class="navbar navbar-light bg-white navbar-expand-xl">
		<h1 id="logoName" class="text-primary display-6">SANTA</h1>
		<button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="fa fa-bars text-primary"></span>
		</button>
		<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
			<div class="navbar-nav mx-auto">
				<a href="index.html" class="nav-item nav-link active">Home</a> 
				<a href="shop.html" class="nav-item nav-link">Shop</a> 
				<a href="shop-detail.html" class="nav-item nav-link">Shop Detail</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
					<div class="dropdown-menu m-0 bg-secondary rounded-0">
						<a href="cart.html" class="dropdown-item">Cart</a> 
						<a href="chackout.html" class="dropdown-item">Chackout</a> 
						<a href="testimonial.html" class="dropdown-item">Testimonial</a> 
						<a href="404.html" class="dropdown-item">404 Page</a>
					</div>
				</div>
				<a href="contact.html" class="nav-item nav-link">Contact</a>
			</div>
			<div class="d-flex m-3 me-0">
				<button
					class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
					data-bs-toggle="modal" data-bs-target="#searchModal">
					<i class="fas fa-search text-primary"></i>
				</button>
				<a href="#" class="position-relative me-4 my-auto"> <i
					class="fa fa-shopping-bag fa-2x"></i> <span
					class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
					style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
				</a> <a href="#" class="my-auto"> <i class="fas fa-user fa-2x"></i>
				</a>
			</div>
		</div>
	</nav>

</body>
</html>