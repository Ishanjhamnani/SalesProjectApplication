<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<!-- ✅ jQuery must be loaded before sidebar.jsp runs -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body { margin:0; font-family:Arial; background:#0f172a; color:white; }
.container { display:flex; }
.content { flex:1; padding:40px; }
</style>
</head>
<body>
<div class="container">
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp"/>
    <div class="content">
        <h1>Sales Management Dashboard</h1>
        <p>Use the left panel to manage Customers, Products, Orders.</p>
    </div>
</div>
</body>
</html>
