<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

          events.forEach(function(event) {
            // Check if there is an event on the clicked date
            if (event.startStr === clickedDate) {
              eventExists = true;
              window.location.href = '/user/getSchedule.jsp?scheduleId=' + event.id +"&userNo=${schedule.userNo}"; // Redirect to the schedule details page
              return;
            }
          });

          if (!eventExists) {
            // If no event exists on the clicked date, redirect to the schedule register page
            window.location.href = '/user/addSchedule.jsp?date=' + clickedDate;
          }
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
		url:"http://192.168.0.66:8001/user/getSchedule?postNo="+schedule.postNo + "&userNo="+schedule.userNo
        
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
  }
  /* #calendar {
    max-width: 1100px;
    margin: 0 auto;
  } */
</style>
</head>
<body>
  <div id='calendar'></div>
</body>
</html>
