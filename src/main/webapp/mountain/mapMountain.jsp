<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=xpk093fqk1&submodules=geocoder"></script>

<script type="text/javascript">
	let latitude;
	let longitude;
    let map;
    //let zoomValue = 15; // 5:100km 10:10km 12:3km 15:300m  50:5m

	$(function(){
		getLocation();
	}); // jquery for call js
	
	function initMap(){
		
		console.log("위도: " + latitude + ", 경도: " + longitude);
		map = new naver.maps.Map('naverMap',{
			//center: new naver.maps.LatLng(37.4458,126.9368),
			center: new naver.maps.LatLng(latitude,longitude),
			zoom:15
		});
		
	}// call Naver Map
	
	function getLocation() {
	    
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(showPosition, showError); // request current position information
	    } else {
	        alert("Geolocation is not supported by this browser.");
	    }
	}

	
	function showPosition(position) {
	    latitude = position.coords.latitude;
	    longitude = position.coords.longitude;
	   	zoomValue = 15; // 300m 
	    initMap();
	} //show current location in 300m distances

	
	function showError(error) {
	    switch(error.code) {
	        case error.PERMISSION_DENIED:
	            alert("User denied the request for Geolocation.");
	            break;
	        case error.POSITION_UNAVAILABLE:
	            alert("Location information is unavailable.");
	            break;
	        case error.TIMEOUT:
	            alert("The request to get user location timed out.");
	            break;
	        case error.UNKNOWN_ERROR:
	            alert("An unknown error occurred.");
	            break;
	    }
	} // show error when cannot get position information
	
	$(function () {
		$('#search').on('click',function(){
			getAddressFromUserInput();
		});		
	}); // if user input the location
	//
	// REST CONTROLLER 이용 지역 위치 정보 확인 
	//
	
	
	
	function getAddressFromUserInput(){
		var userInput = $('#address').val();
		
		$.ajax({
	        url: 'http://127.0.0.1:8001/mountain/rest/searchKeywordToAddress',
	        type: 'GET',
	        dataType: 'text',
	        data: {
	            query: userInput
	        },
	        success: function(address) {
	            console.log('user input to address success');
	            console.log(address);

	            naver.maps.Service.geocode({
	                query: address
	            }, function(status, response) {
	                if (status !== naver.maps.Service.Status.OK) {
	                    return alert('Something wrong!');
	                }
	                console.log('geocode response:' + response);
	                console.log(response);

	                var result = response.v2.addresses[0];
	                console.log('geocode result:' + result);

	                var location = new naver.maps.LatLng(result.y, result.x);

	                map.setCenter(location);
	               	map.setZoom(12);
	                new naver.maps.Marker({
	                    position: location,
	                    map: map
	                });
	            });
	        },
	        error: function(xhr, status, error) {
	            console.error('Error occurred while searching for the place:', error);
	            alert('Error occurred while searching for the place.');
	        }
	    });
	}

</script>

<style>

 	#searchContainer {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1000;
            background: white;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }


</style>


</head>
<body>

	<div id="searchContainer">
        <input type="text" id="address" placeholder="Enter address" style="width: 200px;">
        <button id="search">Search</button>
    </div>
    
	<div id="naverMap" style="width:100%;height:75%; margin:0 auto;"></div> 

</body>
</html>