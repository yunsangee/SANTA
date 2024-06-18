<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta charset="UTF-8">
<c:import url="../common/header.jsp"/>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=xpk093fqk1&submodules=geocoder"></script>

<script type="text/javascript">
	let latitude;
	let longitude;
    let map;
    let mountainList;
    let zoomValue;
    var markers = [];
    
    var customIcon = {
            content: `
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="36" viewBox="0 0 24 36" fill="#7FFF00">
                    <path d="M12 0C5.37 0 0 5.37 0 12c0 6.63 12 24 12 24s12-17.37 12-24C24 5.37 18.63 0 12 0zm0 18a6 6 0 110-12 6 6 0 010 12z"/>
                </svg>
            `,
            size: new naver.maps.Size(24, 36),
            anchor: new naver.maps.Point(12, 36)
        };
    //let zoomValue = 15; // 5:100km 10:10km 12:3km 15:300m  50:5m

	$(function(){
		
		mountainList = ${mountainList != null ? mountainList : 'null'};
		console.log('mountainList:' + mountainList);
		
		clearMarkers();
		getLocation();
		
		if(mountainList != null){
			waitForMapAndProcess();
		}
		
	}); // jquery for call js
	
	function waitForMapAndProcess() {
	    const checkInterval = setInterval(() => {
	        if (map !== null & markers.length != 0) {
	            clearInterval(checkInterval);
	            if (mountainList !== null) {
	                getMountainMarker();
	            }
	        }
	    }, 100); // Check every 100 milliseconds
	}
	
	

	function getLocation() {

		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
					position => {
						showPosition(position);
					},
					error => {
						showError(error);
					}
			
			); // request current position information
		} else {
			alert("Geolocation is not supported by this browser.");
		}
	}

	function showPosition(position) {
		latitude = position.coords.latitude;
		longitude = position.coords.longitude;
		zoomValue = 15; // 300m
		console.log('lat lon set end');
		moveToCurrentPosition();
	} //show current location in 300m distances

	
	function moveToCurrentPosition() {
		console.log("위도: " + latitude + ", 경도: " + longitude);

		let currentLocation = new naver.maps.LatLng(latitude, longitude);

		map = new naver.maps.Map('naverMap', {
			//center: new naver.maps.LatLng(37.4458,126.9368),
			center : currentLocation,
			zoom : zoomValue
		});

		let marker = new naver.maps.Marker({
			position : currentLocation,
			map : map
		});

		markers.push(marker);
	}
	
	function showError(error) {
		switch (error.code) {
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

	function calculateCenterAndBounds(latitudes, longitudes) {
	    if (latitudes.length === 0 || longitudes.length === 0 || latitudes.length !== longitudes.length) {
	        throw new Error("Latitude and longitude arrays must be non-empty and of the same length.");
	    }

	    // 중앙의 위도와 경도 계산
	    const avgLatitude = latitudes.reduce((acc, curr) => acc + curr, 0) / latitudes.length;
	    const avgLongitude = longitudes.reduce((acc, curr) => acc + curr, 0) / longitudes.length;
	    const center = new naver.maps.LatLng(avgLatitude, avgLongitude);

	    // 경계값 계산
	    const maxLat = Math.max(...latitudes);
	    const minLat = Math.min(...latitudes);
	    const maxLng = Math.max(...longitudes);
	    const minLng = Math.min(...longitudes);

	    const bounds = new naver.maps.LatLngBounds(
	        new naver.maps.LatLng(minLat, minLng),
	        new naver.maps.LatLng(maxLat, maxLng)
	    );

	    return { center, bounds };
	}
	
	function getMountainMarker(){
		
		let mountainLocation;
		let latitudes = [];
		let longitudes = [];
		$(mountainList).each(
				function(index, mountain) {
					//console.log(mountain);
					mountain = JSON.parse(JSON.stringify(mountain));
					console.log(mountain.mountainLatitude + ':'  + mountain.mountainLongitude);
					
					latitudes.push(mountain.mountainLatitude);
					longitudes.push(mountain.mountainLongitude);
					
					mountainLocation = new naver.maps.LatLng(
							mountain.mountainLatitude,
							mountain.mountainLongitude);
					let mountainMarker = new naver.maps.Marker({
						position : mountainLocation,
/* 						map : map, */
						icon: customIcon
					});

					markers.push(mountainMarker)
				});
		
		
		
 		latitudes.push(latitude);
		longitudes.push(longitude); 
		
		const {center, bounds} = calculateCenterAndBounds(latitudes, longitudes);
		
		map.fitBounds(bounds);
		map.setZoom((map.getZoom() > 15 ? 15 : map.getZoom()));
		
		markers.forEach(function(marker){
			if(marker != null){
				marker.setMap(map);
			}
		});
	}// call Naver Map
	
	
	$(function() {
		$('#search').on('click', function() {
			getAddressFromUserInput();
		});
	}); // if user input the location
	//
	// REST CONTROLLER 이용 지역 위치 정보 확인 
	//

	function getAddressFromUserInput() {
		var userInput = $('#address').val();
		clearMarkers();

		$.ajax({
			url : 'http://127.0.0.1:8001/mountain/rest/searchKeywordToAddress',
			type : 'GET',
			dataType : 'text',
			data : {
				query : userInput
			},
			success : function(address) {
				console.log('user input to address success');
				console.log(address);

				naver.maps.Service.geocode({
					query : address
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
					map.setZoom(13);
					let searchMarker = new naver.maps.Marker({
						position : location,
						map : map
					});

					markers.push(searchMarker);
				});
			},
			error : function(xhr, status, error) {
				console.error('Error occurred while searching for the place:',
						error);
				alert('Error occurred while searching for the place.');
			}
		});
	}
	
	//
	// 나중에 현재 위치로 이동 할 때도 clearMarkers()
	//
	
	function clearMarkers() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
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
	
	<!-- <div id="currentLocationIcon">
        <img src="bi bi-geo-alt-fill" alt="Current Location">
    </div> -->

</body>
</html>