<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<p>Hello addCertificationPost.jsp</p>

<table>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" maxLength="20"></td>
        </tr>
        <tr>
            <td>Contents:</td>
            <td><input type="text" name="contents" maxLength="20"></td>
        </tr>
        <tr>
            <td>Mountain Name:</td>
            <td><input type="text" name="certificationPostMountainName" maxLength="20"></td>
        </tr>
        <tr>
            <td>Hiking Trail:</td>
            <td><input type="text" name="certificationPostHikingTrail" maxLength="20"></td>
        </tr>
        <tr>
            <td>Total Time:</td>
            <td><input type="text" name="certificationPostTotalTime" maxLength="20"></td>
        </tr>
        <tr>
            <td>Ascent Time:</td>
            <td><input type="text" name="certificationPostAscentTime" maxLength="20"></td>
        </tr>
        <tr>
            <td>Descent Time:</td>
            <td><input type="text" name="certificationPostDescentTime" maxLength="20"></td>
        </tr>
        <tr>
            <td>Hiking Date:</td>
            <td><input type="text" name="certificationPostHikingDate" maxLength="20"></td>
        </tr>
        <tr>
            <td>Transportation:</td>
            <td><input type="text" name="certificationPostTransportation" maxLength="20"></td>
        </tr>
        <tr>
            <td>Hiking Difficulty:</td>
            <td><input type="text" name="certificationPostHikingDifficulty" maxLength="20"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Submit">
            </td>
        </tr>
    </table>
</body>
</html>