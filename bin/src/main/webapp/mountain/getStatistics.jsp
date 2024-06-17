<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<h1>Daily Statistics</h1>
    <canvas id="dailyChart"></canvas>

    <script>
        var dailyStats = ${dailyStats};
        var labels = [];
        var searchCounts = [];
        var postCounts = [];
        
        
        console.log("dailyStats");
        console.log(dailyStats);

        dailyStats.forEach(function(stat) {
            labels.push(stat.mountainName);
            searchCounts.push(stat.searchCount);
            postCounts.push(stat.postCount);
        });

        var ctx = document.getElementById('dailyChart').getContext('2d');
        var dailyChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Search Count',
                        data: searchCounts,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Post Count',
                        data: postCounts,
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
    
    
     <h1>Weekly Statistics</h1>
    <canvas id="weeklyChart"></canvas>

    <script>
        var weeklyStats = ${weeklyStats};
        var labels = [];
        var searchCounts = [];
        var postCounts = [];
        
        console.log("weeklyStats");
        console.log(weeklyStats);

        weeklyStats.forEach(function(stat) {
            labels.push(stat.mountainName);
            searchCounts.push(stat.searchCount);
            postCounts.push(stat.postCount);
        });

        var ctx = document.getElementById('weeklyChart').getContext('2d');
        var weeklyChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Search Count',
                        data: searchCounts,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Post Count',
                        data: postCounts,
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
    
    
    

</body>
</html>