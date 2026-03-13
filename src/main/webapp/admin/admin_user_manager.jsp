<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctx = request.getContextPath();%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Người Dùng - Marriott Admin</title>
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
        </style>
    </head>
    <body>
        <div class="d-flex">
            <div class="sidebar" style="width: 250px;">
                <div class="brand"><i class="fas fa-hotel text-warning me-2"></i> MARRIOTT ADMIN</div>
                <a href="<%=ctx%>/admin/admin_dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i> Tổng quan</a>
                <a href="<%=ctx%>/admin/admin_room_form.jsp"><i class="fas fa-bed me-2"></i> Quản lý Phòng</a>
                <a href="<%=ctx%>/admin/admin_booking_manager.jsp"><i class="fas fa-calendar-check me-2"></i> Quản lý Đặt phòng</a>
                <a href="<%=ctx%>/admin/admin_user_manager.jsp" class="active"><i class="fas fa-users me-2"></i> Quản lý Người dùng</a>
                <a href="<%=ctx%>/home" class="mt-5 border-top border-secondary" style="border-left: none;"><i class="fas fa-arrow-left me-2"></i> Về trang Khách</a>
            </div>

            <div class="flex-grow-1 p-4">
                <h2 class="mb-4 fw-bold" style="color: #343a40;"><i class="fas fa-users me-2"></i>Quản Lý Người Dùng</h2>

                <div class="card p-4 shadow-sm border-0 bg-white" style="border-radius: 12px;">
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="fw-bold">Danh sách tài khoản hệ thống</h5>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#addUserForm">
                            <i class="fas fa-user-plus me-2"></i>Thêm Admin/User
                        </button>
                    </div>

                    <div class="collapse mb-4" id="addUserForm">
                        <div class="card card-body bg-light border-0">
                            <form action="<%=ctx%>/admin/user-manager" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" name="fullName" placeholder="Họ và Tên" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="email" class="form-control" name="email" placeholder="Email đăng nhập" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="password" class="form-control" name="password" placeholder="Mật khẩu" required>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" name="roleID">
                                            <option value="2">Khách hàng</option>
                                            <option value="1">Admin</option>
                                        </select>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="submit" class="btn btn-success w-100"><i class="fas fa-check"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và Tên</th>
                                    <th>Email</th>
                                    <th>Vai Trò (Role)</th>
                                    <th class="text-center">Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="u" items="${userList}">
                                <tr>
                                    <td class="fw-bold">#${u.userID}</td>
                                    <td>${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>
                                <c:choose>
                                    <c:when test="${u.roleID == 1}"><span class="badge bg-danger">Quản Trị Viên</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">Khách Hàng</span></c:otherwise>
                                </c:choose>
                                </td>
                                <td class="text-center">
                                    <form action="<%=ctx%>/admin/user-manager" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="changeRole">
                                        <input type="hidden" name="userID" value="${u.userID}">
                                        <input type="hidden" name="newRole" value="${u.roleID == 1 ? 2 : 1}">
                                        <button type="submit" class="btn btn-sm btn-outline-primary" title="Đổi quyền (Admin <-> Khách)">
                                            <i class="fas fa-sync-alt"></i> Đổi Quyền
                                        </button>
                                    </form>

                                    <form action="<%=ctx%>/admin/user-manager" method="post" style="display:inline;" class="ms-1">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userID" value="${u.userID}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa tài khoản này vĩnh viễn?');" title="Xóa tài khoản">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty userList}">
                                <tr>
                                    <td class="fw-bold">#1</td>
                                    <td>Huy Hoàng</td>
                                    <td>admin@gmail.com</td>
                                    <td><span class="badge bg-danger">Quản Trị Viên</span></td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary"><i class="fas fa-sync-alt"></i> Đổi Quyền</button>
                                        <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">#2</td>
                                    <td>Nguyễn Văn A</td>
                                    <td>khachhang@gmail.com</td>
                                    <td><span class="badge bg-secondary">Khách Hàng</span></td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary"><i class="fas fa-sync-alt"></i> Đổi Quyền</button>
                                        <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
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