<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���̵� ã�� ���</title>
</head>
<body>
    <h2>���̵� ã�� ���</h2>
    <%
        String userId = (String) request.getAttribute("userId");
    %>
    <div>
        <% if (userId != null) { %>
            <p>ȸ������ ���̵��: <strong><%= userId %></strong> �Դϴ�.</p>
        <% } else { %>
            <p>�Է��Ͻ� ������ ��ġ�ϴ� ���̵� �����ϴ�.</p>
        <% } %>
    </div>
    <div>
        <a href="/user/login.jsp">�α��� �������� �̵�</a>
    </div>
</body>
</html>
