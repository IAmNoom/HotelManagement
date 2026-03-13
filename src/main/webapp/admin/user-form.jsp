<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user != null ? 'Cập Nhật Người Dùng' : 'Thêm Người Dùng'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5 col-md-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white text-center">
                <h3 class="mb-0 fw-bold">${user != null ? 'Cập Nhật Người Dùng' : 'Thêm Người Dùng Mới'}</h3>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger mb-3">
                        ${sessionScope.error}
                        <c:remove var="error" scope="session"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/users" method="POST">
                    <input type="hidden" name="action" value="${user != null ? 'update' : 'insert'}" />
                    
                    <c:if test="${user != null}">
                        <input type="hidden" name="id" value="${user.id}" />
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Họ và Tên:</label>
                        <input type="text" name="fullName" value="${user.fullName}" class="form-control" placeholder="Nhập họ và tên..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Email:</label>
                        <input type="email" name="email" value="${user.email}" class="form-control" placeholder="example@email.com" required 
                               ${user != null ? 'readonly' : ''} />
                        <c:if test="${user != null}">
                            <small class="text-muted">Không được thay đổi Email sau khi tạo.</small>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Mật khẩu:</label>
                        <input type="password" name="password" value="${user.password}" class="form-control" placeholder="Nhập mật khẩu..." required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Phân Quyền (Role):</label>
                        <select name="roleID" class="form-select">
                            <option value="2" ${user.roleID == 2 ? 'selected' : ''}>User (Khách Hàng)</option>
                            <option value="1" ${user.roleID == 1 ? 'selected' : ''}>Admin (Quản Trị Viên)</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary px-4">Hủy</a>
                        <button type="submit" class="btn btn-primary px-4 fw-bold">Lưu Thông Tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
