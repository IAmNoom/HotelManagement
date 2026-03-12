<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<title>Admin Dashboard</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
margin:0;
}

.container{
width:1000px;
margin:50px auto;
}

.title{
font-size:28px;
font-weight:600;
margin-bottom:30px;
}

.grid{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:20px;
}

.card{
background:white;
padding:30px;
border-radius:10px;
text-align:center;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
cursor:pointer;
transition:0.2s;
}

.card:hover{
transform:translateY(-5px);
}

.card a{
text-decoration:none;
font-size:18px;
font-weight:500;
color:#333;
}

</style>

</head>

<body>

<div class="container">

<div class="title">
Admin Dashboard
</div>

<div class="grid">

<div class="card">
<a href="admin_room_manager.jsp">
Manage Rooms
</a>
</div>

<div class="card">
<a href="admin_booking_manager.jsp">
Manage Bookings
</a>
</div>

<div class="card">
<a href="profile.jsp">
User Profile
</a>
</div>

</div>

</div>

</body>
</html>
