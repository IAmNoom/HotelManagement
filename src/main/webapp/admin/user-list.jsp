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

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Lỗi:</strong> ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/users?action=new" class="btn btn-success fw-bold me-2">+ Thêm Người Dùng</a>
                        <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-primary fw-bold">Quản Lý Phòng</a>
                    </div>
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
                                            <%-- Nút Sửa --%>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}" class="btn btn-info btn-sm fw-bold">Sửa</a>
                                            <%-- Nút Thay đổi quyền --%>
                                            <c:if test="${u.roleID == 2}">
                                                <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;" onsubmit="return confirm('Cấp quyền Admin cho người dùng này?');">
                                                    <input type="hidden" name="action" value="changeRole">
                                                    <input type="hidden" name="id" value="${u.id}">
                                                    <input type="hidden" name="role" value="1">
                                                    <button type="submit" class="btn btn-success btn-sm fw-bold">Cấp quyền Admin</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${u.roleID == 1}">
                                                <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;" onsubmit="return confirm('Hạ quyền người dùng này xuống User?');">
                                                    <input type="hidden" name="action" value="changeRole">
                                                    <input type="hidden" name="id" value="${u.id}">
                                                    <input type="hidden" name="role" value="2">
                                                    <button type="submit" class="btn btn-warning btn-sm fw-bold text-dark">Hạ quyền User</button>
                                                </form>
                                            </c:if>
                                            
                                            <%-- Nút Xóa --%>
                                            <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa người dùng ${u.fullName} không?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${u.id}">
                                                <button type="submit" class="btn btn-danger btn-sm fw-bold ms-1">Xóa</button>
                                            </form>
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
