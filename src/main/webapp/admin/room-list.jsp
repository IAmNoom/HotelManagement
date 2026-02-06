<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Room Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Quản Lý Phòng Khách Sạn</h2>

            <a href="${pageContext.request.contextPath}/admin/rooms?action=new" class="btn btn-success mb-3">+ Thêm Phòng Mới</a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary mb-3 ms-2">Về Trang Chủ</a>

            <table class="table table-bordered table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Số Phòng</th>
                        <th>Loại</th>
                        <th>Giá</th>
                        <th>Trạng Thái</th>
                        <th>Hình Ảnh</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${listRooms}">
                    <tr>
                        <td>${r.roomID}</td>
                        <td class="fw-bold">${r.roomNumber}</td>
                        <td>${r.roomType}</td>
                        <td><fmt:formatNumber value="${r.price}" type="number"/> đ</td>
                    <td>
                        <span class="badge ${r.status == 'Available' ? 'bg-success' : 'bg-danger'}">
                            ${r.status}
                        </span>
                    </td>
                    <td>
                        <img src="${r.image}" alt="Room" style="width: 80px; height: 50px; object-fit: cover;">
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${r.roomID}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${r.roomID}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                    </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>