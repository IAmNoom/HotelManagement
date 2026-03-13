<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctx = request.getContextPath();%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Phòng - Marriott Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f6f9;
                overflow-x: hidden;
            }
            .sidebar {
                min-height: 100vh;
                background-color: #343a40;
                color: #fff;
            }
            .sidebar .brand {
                font-size: 1.2rem;
                font-weight: bold;
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid #4f5962;
            }
            .sidebar a {
                color: #c2c7d0;
                text-decoration: none;
                padding: 15px 20px;
                display: block;
                transition: 0.3s;
            }
            .sidebar a:hover, .sidebar a.active {
                background-color: #007bff;
                color: #fff;
                border-left: 4px solid #fff;
            }
            .table-hover tbody tr:hover {
                background-color: #f1f3f5;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <div class="sidebar" style="width: 250px;">
                <div class="brand"><i class="fas fa-hotel text-warning me-2"></i> MARRIOTT ADMIN</div>
                <a href="<%=ctx%>/admin/admin_dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i> Tổng quan</a>
                <a href="<%=ctx%>/admin/admin_room_form.jsp" class="active"><i class="fas fa-bed me-2"></i> Quản lý Phòng</a>
                <a href="<%=ctx%>/admin/admin_booking_manager.jsp"><i class="fas fa-calendar-check me-2"></i> Quản lý Đặt phòng</a>
                <a href="<%=ctx%>/admin/admin_user_manager.jsp"><i class="fas fa-users me-2"></i> Quản lý Người dùng</a>
                <a href="<%=ctx%>/home" class="mt-5 border-top border-secondary" style="border-left: none;"><i class="fas fa-arrow-left me-2"></i> Về trang Khách</a>
            </div>

            <div class="flex-grow-1 p-4">
                <h2 class="mb-4 fw-bold" style="color: #343a40;"><i class="fas fa-bed me-2"></i>Quản Lý Hệ Thống Phòng</h2>

                <div class="card p-4 shadow-sm border-0 bg-white mb-4" style="border-radius: 12px;">
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="fw-bold">Danh sách phòng hiện có</h5>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#formPhieu"><i class="fas fa-plus me-2"></i>Thêm Phòng Mới</button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã</th>
                                    <th>Số Phòng</th>
                                    <th>Loại Phòng</th>
                                    <th>Giá / Đêm</th>
                                    <th>Trạng Thái</th>
                                    <th class="text-center">Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="r" items="${roomList}">
                                <tr>
                                    <td class="fw-bold text-primary">#${r.roomID}</td>
                                    <td><span class="badge bg-secondary">Phòng ${r.roomNumber}</span></td>

                                    <td class="fw-bold text-success">${r.typeName}</td>

                                    <td class="text-danger fw-bold"><fmt:formatNumber value="${r.price}" type="number" pattern="#,##0"/> đ</td>
                                <td>
                                <c:choose>
                                    <c:when test="${r.status == 'Available'}"><span class="badge bg-success">Trống</span></c:when>
                                    <c:when test="${r.status == 'Occupied'}"><span class="badge bg-warning text-dark">Đang Thuê</span></c:when>
                                    <c:otherwise><span class="badge bg-danger">Bảo Trì</span></c:otherwise>
                                </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="<%=ctx%>/admin/room-manager?action=edit&roomID=${r.roomID}" class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i> Sửa</a>
                                    <a href="<%=ctx%>/admin/room-manager?action=delete&roomID=${r.roomID}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa phòng này?');"><i class="fas fa-trash"></i> Xóa</a>
                                </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="collapse ${not empty room ? 'show' : ''}" id="formPhieu">
                    <div class="card p-4 shadow-sm border-0 bg-light" style="border-radius: 12px; max-width: 800px;">
                        <h5 class="fw-bold mb-3"><i class="fas fa-edit me-2"></i>${room == null ? 'Thêm Phòng Mới' : 'Cập Nhật Thông Tin'}</h5>
                        <form action="<%=ctx%>/admin/room-manager" method="post">
                            <input type="hidden" name="action" value="${room == null ? 'add' : 'update'}">
                            <input type="hidden" name="roomID" value="${room.roomID}">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Số Phòng</label>
                                    <input type="text" class="form-control" name="roomNumber" value="${room.roomNumber}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Loại Phòng</label>
                                    <select class="form-select" name="roomType" required>
                                        <option value="Standard" ${room.typeName == 'Standard' ? 'selected' : ''}>Standard</option>
                                        <option value="Superior" ${room.typeName == 'Superior' ? 'selected' : ''}>Superior</option>
                                        <option value="Deluxe" ${room.typeName == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                                        <option value="Suite" ${room.typeName == 'Suite' ? 'selected' : ''}>Suite</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Giá (VNĐ)</label>
                                    <input type="number" class="form-control" name="price" value="<fmt:formatNumber value='${room.price}' pattern='#'/>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Trạng Thái</label>
                                    <select class="form-select" name="status">
                                        <option value="Available" ${room.status == 'Available' ? 'selected' : ''}>Phòng Trống</option>
                                        <option value="Occupied" ${room.status == 'Occupied' ? 'selected' : ''}>Đang Thuê</option>
                                        <option value="Maintenance" ${room.status == 'Maintenance' ? 'selected' : ''}>Bảo Trì</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Link Ảnh (URL)</label>
                                <input type="text" class="form-control" name="image" value="${room.image}">
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">Mô Tả Tiện Ích</label>
                                <textarea class="form-control" name="description" rows="4">${room.description}</textarea>
                            </div>

                            <div class="text-end">
                                <a href="<%=ctx%>/admin/room-manager" class="btn btn-secondary px-4 me-2">Đóng Form</a>
                                <button type="submit" class="btn btn-primary px-4"><i class="fas fa-save me-2"></i>Lưu Dữ Liệu</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>