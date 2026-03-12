<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<title>Admin - Booking Management</title>

<style>

body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    background:#f1f3f6;
}

/* Container */

.container{
    width:1200px;
    margin:40px auto;
}

/* Header */

.page-title{
    font-size:28px;
    font-weight:600;
    margin-bottom:20px;
}

/* Card */

.card{
    background:white;
    border-radius:10px;
    padding:25px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

/* Table */

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#343a40;
    color:white;
    padding:12px;
    text-align:left;
}

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

tr:hover{
    background:#f9f9f9;
}

/* Status */

.status{
    padding:5px 12px;
    border-radius:20px;
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

/* Buttons */

.btn{
    padding:6px 12px;
    border-radius:6px;
    border:none;
    font-size:13px;
    cursor:pointer;
}

.btn-edit{
    background:#007bff;
    color:white;
}

.btn-delete{
    background:#dc3545;
    color:white;
}

/* Empty */

.empty{
    text-align:center;
    color:#777;
    padding:20px;
}

</style>

</head>

<body>

<div class="container">

<div class="page-title">
Booking Management
</div>

<div class="card">

<table>

<tr>
<th>ID</th>
<th>User</th>
<th>Room</th>
<th>Check In</th>
<th>Check Out</th>
<th>Total Price</th>
<th>Status</th>
<th>Action</th>
</tr>

<c:choose>

<c:when test="${not empty listBookings}">

<c:forEach var="b" items="${listBookings}">

<tr>

<td>${b.id}</td>
<td>${b.userId}</td>
<td>${b.roomNumber}</td>
<td>${b.checkInDate}</td>
<td>${b.checkOutDate}</td>
<td>$${b.totalPrice}</td>

<td>

<c:choose>

<c:when test="${b.status=='Pending'}"> <span class="status pending">Pending</span>
</c:when>

<c:when test="${b.status=='Confirmed'}"> <span class="status confirmed">Confirmed</span>
</c:when>

<c:otherwise> <span class="status cancelled">${b.status}</span>
</c:otherwise>

</c:choose>

</td>

<td>

<button class="btn btn-edit">Edit</button> <button class="btn btn-delete">Delete</button>

</td>

</tr>

</c:forEach>

</c:when>

<c:otherwise>

<tr>
<td colspan="8" class="empty">
No bookings available
</td>
</tr>

</c:otherwise>

</c:choose>

</table>

</div>

</div>

</body>
</html>
