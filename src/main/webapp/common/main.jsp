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
	<main></main>
	<footer></footer>

</body>
</html>