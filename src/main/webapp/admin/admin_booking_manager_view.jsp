<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctx = request.getContextPath();%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Đơn Hàng - Marriott Admin</title>
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
                <a href="<%=ctx%>/admin/admin_room_form.jsp"><i class="fas fa-bed me-2"></i> Quản lý Phòng</a>
                <a href="<%=ctx%>/admin/admin_booking_manager.jsp" class="active"><i class="fas fa-calendar-check me-2"></i> Quản lý Đặt phòng</a>
                <a href="<%=ctx%>/admin/admin_user_manager.jsp"><i class="fas fa-users me-2"></i> Quản lý Người dùng</a>
                <a href="<%=ctx%>/home" class="mt-5 border-top border-secondary"><i class="fas fa-arrow-left me-2"></i> Về trang Khách</a>
            </div>

            <div class="flex-grow-1 p-4">
                <h2 class="mb-4 fw-bold" style="color: #343a40;"><i class="fas fa-list-alt me-2"></i>Danh Sách Đơn Đặt Phòng</h2>

                <div class="card p-4 shadow-sm border-0 bg-white" style="border-radius: 12px;">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã Đơn</th>
                                    <th>Mã KH</th>
                                    <th>Mã Phòng</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Tổng Tiền</th>
                                    <th>Trạng Thái</th>
                                    <th class="text-center">Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="b" items="${bookingList}">
                                <tr>
                                    <td class="fw-bold text-primary">#${b.bookingID}</td>
                                    <td>KH-${b.userID}</td> 
                                    <td>Phòng ${b.roomID}</td>
                                    <td>${b.checkInDate}</td>
                                    <td>${b.checkOutDate}</td>
                                    <td class="text-danger fw-bold"><fmt:formatNumber value="${b.totalPrice}" type="number" pattern="#,##0"/> đ</td>
                                <td>
                                <c:choose>
                                    <c:when test="${b.status == 'Pending'}"><span class="badge bg-warning text-dark">Chờ Duyệt</span></c:when>
                                    <c:when test="${b.status == 'Confirmed'}"><span class="badge bg-success">Đã Xác Nhận</span></c:when>
                                    <c:when test="${b.status == 'Cancelled'}"><span class="badge bg-danger">Đã Hủy</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${b.status}</span></c:otherwise>
                                </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group">
                                        <form action="<%=ctx%>/admin/admin_booking_manager.jsp" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="confirm">
                                            <input type="hidden" name="bookingID" value="${b.bookingID}">
                                            <button type="submit" class="btn btn-sm btn-outline-success" ${b.status != 'Pending' ? 'disabled' : ''}><i class="fas fa-check"></i></button>
                                        </form>

                                        <form action="<%=ctx%>/admin/admin_booking_manager.jsp" method="post" style="display:inline;" class="ms-1">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="bookingID" value="${b.bookingID}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" ${b.status != 'Pending' ? 'disabled' : ''} onclick="return confirm('Hủy đơn này?');"><i class="fas fa-times"></i></button>
                                        </form>
                                    </div>
                                </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty bookingList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="fas fa-folder-open fa-3x mb-3 opacity-50"></i><br>
                                        Chưa có đơn đặt phòng nào trong hệ thống!
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>