<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script src='../fullcalendar/dist/index.global.js'></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var today = new Date();
    var currentDate = today.toISOString().split('T')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialDate: currentDate,
      editable: true,
      selectable: true,
      businessHours: false,
      displayEventTime: false,
      dayMaxEvents: true, // allow "more" link when too many events
     /*  events: [], // 빈 배열로 초기화
      eventTimeFormat: { // 시간 형식을 24시간으로 설정
          hour: '2-digit',
          minute: '2-digit',
          hour12: false
        }, */
      dateClick: function(info) {
          var clickedDate = info.dateStr; // Get the clicked date in YYYY-MM-DD format
          var events = calendar.getEvents(); // Get all events from the calendar
          var eventExists = false;
          console.log('Checking event:', info); // 디버깅용 로그
          console.log('Event start:', info.startStr); // 디버깅용 로그
          console.log('Clicked date:', clickedDate); // 디버깅용 로그
          
          console.log('calendarClicked')

        events.forEach(function(event) {
                var eventDate = event.startStr.split('T')[0]; // 이벤트 시작 날짜에서 시간 부분을 제거
                console.log('Checking event:', event); // 디버깅용 로그
                console.log('Event start:', eventDate); // 디버깅용 로그

                // Check if there is an event on the clicked date
                if (eventDate === clickedDate) {
                    eventExists = true;
                    console.log('Event found:', event); // 디버깅용 로그

                    var popup = $.ajax({
                        url: '/user/rest/getSchedule?postNo=' + event.id + '&userNo=' + event.extendedProps.userNo,
                        type: 'GET',
                        success: function(response) {
                            console.log('AJAX response:', response); // 디버깅용 로그
                            if (response === true) {
                                var popup = window.open('/user/getSchedule.jsp', '일정조회', 'width=600,height=900');
                                var popupChecker = setInterval(function() {
                                    if (popup.closed) {
                                        clearInterval(popupChecker);
                                        location.reload();
                                    }
                                }, 500);
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error('AJAX request failed:', textStatus, errorThrown); // 오류 로그
                        }
                    });

                    return;
                }
            });

            if (!eventExists) {
                console.log('No event on clicked date:', clickedDate); // 디버깅용 로그
                // If no event exists on the clicked date, redirect to the schedule register page
                var popup = window.open('/user/addSchedule.jsp?date=' + clickedDate, '일정등록', 'width=600,height=900');
                var popupChecker = setInterval(function() {
                    if (popup.closed) {
                        clearInterval(popupChecker);
                        location.reload();
                    }
                }, 500);
            }
      },
      eventClick: function(info) {
          console.log('Event clicked:', info.event); // 디버깅용 로그

          $.ajax({
              url: '/user/rest/getSchedule?postNo=' + info.event.id + '&userNo=' + info.event.extendedProps.userNo,
              type: 'GET',
              success: function(response) {
                  console.log('AJAX response:', response); // 디버깅용 로그
                  if (response === true) {
                      window.open('/user/getSchedule.jsp', '일정조회', 'width=600,height=900');
                  }
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.error('AJAX request failed:', textStatus, errorThrown); // 오류 로그
              }
          });

          info.jsEvent.preventDefault(); // prevents the browser from navigating to the link
      }
    
    
    });

    // 스케줄 목록을 JSP 모델에서 가져오기
    var scheduleList = JSON.parse('${scheduleList}');
	console.log(${scheduleList});
	
    // 스케줄 목록을 FullCalendar 이벤트로 추가
    scheduleList.forEach(function(schedule) {
      calendar.addEvent({
    	id:schedule.postNo,
        title: schedule.title,
        start: schedule.scheduleDate, // 스케줄의 시작 날짜
        extendedProps: {
            userNo: schedule.userNo
        }
	 	//url:"/user/getSchedule?postNo="+schedule.postNo + "&userNo="+schedule.userNo 
		/* url:"https://localhost:8001//user/getSchedule?postNo="+schedule.postNo + "&userNo="+schedule.userNo
         */
        // 필요한 다른 속성들 추가
      });
    });

    calendar.render();
  });
</script>
<style>
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
    justify-content: center;
    align-items: center;
    margin-top:100px;
    margin-left:200px;
  }
  #calendar {
    max-width: 1100px;
    margin-top:200px;
    margin: 0 auto;
  } 
</style>

<c:import url="../common/header.jsp"/>
</head>
<body>
  
  
  <header>
  	<c:import url="../common/top.jsp"/>
  </header>
  
  <main style="margin-top:100px;">
  	<div id='calendar'></div>
  </main>
  
</body>
</html>
