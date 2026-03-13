<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Phòng - Marriott Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="card shadow-sm p-4 border-0">
                <h2 class="text-center mb-4 fw-bold">QUẢN LÝ PHÒNG KHÁCH SẠN</h2>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="${pageContext.request.contextPath}/admin/rooms?action=new" class="btn btn-success fw-bold">+ Thêm Phòng Mới</a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Trở Về Trang Chủ</a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Số Phòng</th>
                                <th>Loại Phòng</th>
                                <th>Giá Tiền</th>
                                <th>Trạng Thái</th>
                                <th>Hình Ảnh</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Kiểm tra nếu danh sách trống --%>
                        <c:choose>
                            <c:when test="${empty listRooms}">
                                <tr>
                                    <td colspan="7" class="text-center text-danger fw-bold py-4">
                                        Hệ thống hiện chưa có dữ liệu phòng nào!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <%-- Lặp qua danh sách phòng --%>
                                <c:forEach var="r" items="${listRooms}">
                                    <tr>
                                        <td>${r.roomID}</td>
                                        <td class="fw-bold fs-5">${r.roomNumber}</td>
                                        <td>
                                            <span class="badge bg-secondary">${r.roomType}</span>
                                        </td>
                                        <td class="text-success fw-bold">
                                    <fmt:formatNumber value="${r.price}" type="number" pattern="#,##0"/> đ
                                    </td>
                                    <td>
                                        <span class="badge ${r.status == 'Available' ? 'bg-success' : 'bg-danger'}">
                                            ${r.status}
                                        </span>
                                    </td>
                                    <td>
                                        <img src="${r.image}" alt="Room ${r.roomNumber}" class="rounded" style="width: 90px; height: 60px; object-fit: cover; border: 1px solid #ddd;">
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${r.roomID}" class="btn btn-warning btn-sm fw-bold">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${r.roomID}" class="btn btn-danger btn-sm fw-bold" onclick="return confirm('Bạn có chắc chắn muốn xóa phòng ${r.roomNumber} không?');">Xóa</a>
                                    </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>