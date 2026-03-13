<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Người Dùng - Marriott Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="card shadow-sm p-4 border-0">
                <h2 class="text-center mb-4 fw-bold">QUẢN LÝ NGƯỜI DÙNG</h2>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-primary fw-bold">Quản Lý Phòng</a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Trở Về Trang Chủ</a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Họ Tên</th>
                                <th>Email</th>
                                <th>Quyền (Role)</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Kiểm tra nếu danh sách trống --%>
                        <c:choose>
                            <c:when test="${empty listUsers}">
                                <tr>
                                    <td colspan="5" class="text-center text-danger fw-bold py-4">
                                        Hệ thống hiện chưa có người dùng nào!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <%-- Lặp qua danh sách người dùng --%>
                                <c:forEach var="u" items="${listUsers}">
                                    <tr>
                                        <td>${u.id}</td>
                                        <td class="fw-bold">${u.fullName}</td>
                                        <td>${u.email}</td>
                                        <td>
                                            <span class="badge ${u.roleID == 1 ? 'bg-danger' : 'bg-success'}">
                                                ${u.roleID == 1 ? 'Admin' : 'User'}
                                            </span>
                                        </td>
                                        <td>
                                            <%-- Nút Thay đổi quyền --%>
                                            <c:if test="${u.roleID == 2}">
                                                <a href="${pageContext.request.contextPath}/admin/users?action=changeRole&id=${u.id}&role=1" class="btn btn-success btn-sm fw-bold" onclick="return confirm('Cấp quyền Admin cho người dùng này?');">Cấp quyền Admin</a>
                                            </c:if>
                                            <c:if test="${u.roleID == 1}">
                                                <a href="${pageContext.request.contextPath}/admin/users?action=changeRole&id=${u.id}&role=2" class="btn btn-warning btn-sm fw-bold text-dark" onclick="return confirm('Hạ quyền người dùng này xuống User?');">Hạ quyền User</a>
                                            </c:if>
                                            
                                            <%-- Nút Xóa --%>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" class="btn btn-danger btn-sm fw-bold ms-1" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng ${u.fullName} không?');">Xóa</a>
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
