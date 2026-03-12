<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f5f6f8;
    margin:0;
}

.container{
    width:1000px;
    margin:60px auto;
}

.card{
    background:white;
    border-radius:10px;
    padding:25px;
    margin-bottom:25px;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
}

.title{
    font-size:22px;
    font-weight:600;
    margin-bottom:15px;
}

.profile-grid{
    display:flex;
    gap:80px;
    font-size:16px;
}

.profile-grid span{
    color:#777;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    text-align:left;
    padding:12px;
    background:#2d2f33;
    color:white;
}

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

.status{
    padding:4px 10px;
    border-radius:12px;
    font-size:13px;
    font-weight:600;
}

.pending{
    background:#fff3cd;
    color:#856404;
}

.confirmed{
    background:#d4edda;
    color:#155724;
}

.cancelled{
    background:#f8d7da;
    color:#721c24;
}

.empty{
    text-align:center;
    color:#888;
    padding:20px;
}

</style>

</head>

<body>

<div class="container">

<!-- PROFILE -->
<div class="card">

<div class="title">My Account</div>

<div class="profile-grid">

<div>
<span>Full Name</span><br>
<b>${sessionScope.account.fullName}</b>
</div>

<div>
<span>Email</span><br>
<b>${sessionScope.account.email}</b>
</div>

</div>

</div>


<!-- BOOKING HISTORY -->
<div class="card">

<div class="title">Booking History</div>

<table>

<tr>
<th>Room</th>
<th>Type</th>
<th>Check In</th>
<th>Check Out</th>
<th>Total Price</th>
<th>Status</th>
</tr>

<c:choose>

<c:when test="${not empty listBookings}">

<c:forEach var="b" items="${listBookings}">

<tr>
<td>${b.roomNumber}</td>
<td>${b.typeName}</td>
<td>${b.checkInDate}</td>
<td>${b.checkOutDate}</td>
<td>$${b.totalPrice}</td>

<td>

<c:choose>

<c:when test="${b.status=='Pending'}">
<span class="status pending">Pending</span>
</c:when>

<c:when test="${b.status=='Confirmed'}">
<span class="status confirmed">Confirmed</span>
</c:when>

<c:otherwise>
<span class="status cancelled">${b.status}</span>
</c:otherwise>

</c:choose>

</td>

</tr>

</c:forEach>

</c:when>

<c:otherwise>

<tr>
<td colspan="6" class="empty">
You have no bookings yet
</td>
</tr>

</c:otherwise>

</c:choose>

</table>

</div>

</div>

</body>
</html>