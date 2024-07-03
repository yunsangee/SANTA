<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script src='../fullcalendar/dist/index.global.js'></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
  body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
  header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1001;
    background-color: white;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
  main {
    display: flex;
    margin-top: 60px; /* Adjust this based on your header height */
    justify-content: center;
  }
  #calendar {
    width: 90%; /* Set the desired width */
    max-width: 1300px; /* Maximum width */
    margin-top: 70px; /* Adjust vertical margin if needed */
    transition: margin-right 0.3s, max-width 0.3s; /* Add transition for smooth resizing */
  }
  .sidebar {
    width: 600px; /* Sidebar width */
    position: fixed;
    top: 100px; /* Adjust this based on your header height */
    right: -600px; /* Initially hide the sidebar */
    height: calc(100% - 80px); /* Adjust height based on your header height */
    background-color: #f8f9fa;
    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
    transition: right 0.3s;
    z-index: 1000;
    overflow-y: auto;
  }
  .sidebar.active {
    right: 0; /* Show the sidebar */
  }
  .sidebar .content {
    padding: 20px;
  }
</style>
<c:import url="../common/header.jsp"/>
</head>
<body>
  
<header>
  <c:import url="../common/top.jsp"/>
</header>

<main>
  <div id='calendar'></div>
  <div class="sidebar" id="sidebar">
    <div class="content">
      <button type="button" class="close" aria-label="Close" onclick="closeSidebar()">
        <span aria-hidden="true">&times;</span>
      </button>
      <div id="sidebar-content"></div>
    </div>
  </div>
</main>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var sidebarEl = document.getElementById('sidebar');
    var sidebarContentEl = document.getElementById('sidebar-content');
    var today = new Date();
    var currentDate = today.toISOString().split('T')[0];

    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialDate: currentDate,
      editable: true,
      selectable: true,
      businessHours: false,
      displayEventTime: false,
      dayMaxEvents: true,
      dateClick: function(info) {
        var clickedDate = info.dateStr;
        var addScheduleUrl = '/user/rest/addSchedule?date=' + clickedDate;
        $.ajax({
          url: addScheduleUrl,
          type: 'GET',
          success: function(response) {
            $('#sidebar-content').html(response);
            openSidebar();
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.error('AJAX request failed:', textStatus, errorThrown);
          }
        });
      },
      eventClick: function(info) {
        $.ajax({
          url: '/user/rest/getSchedule',
          type: 'GET',
          data: { postNo: info.event.id, userNo: info.event.extendedProps.userNo },
          success: function(response) {
            $('#sidebar-content').html(response);
            openSidebar();
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.error('AJAX request failed:', textStatus, errorThrown);
          }
        });
        info.jsEvent.preventDefault();
      }
    });

    var scheduleList = ${scheduleList}; // JSON 파싱 없이 스크립트 변수로 바로 사용
    scheduleList.forEach(function(schedule) {
      calendar.addEvent({
        id: schedule.postNo,
        title: schedule.title,
        start: schedule.scheduleDate,
        extendedProps: {
          userNo: schedule.userNo
        }
      });
    });

    calendar.render();
  });

  function openSidebar() {
    document.getElementById('sidebar').classList.add('active');
  }

  function closeSidebar() {
    document.getElementById('sidebar').classList.remove('active');
  }
</script>

</body>
</html>
