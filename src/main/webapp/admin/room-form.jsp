<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>${room != null ? 'Edit Room' : 'Add Room'}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5 col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3>${room != null ? 'Cập Nhật Phòng' : 'Thêm Phòng Mới'}</h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/rooms" method="post">
                        <input type="hidden" name="action" value="${room != null ? 'update' : 'insert'}" />

                        <c:if test="${room != null}">
                            <input type="hidden" name="id" value="${room.roomID}" />
                        </c:if>

                        <div class="mb-3">
                            <label>Số Phòng:</label>
                            <input type="text" name="roomNumber" value="${room.roomNumber}" class="form-control" required />
                        </div>

                        <div class="mb-3">
                            <label>Loại Phòng:</label>
                            <select name="roomType" class="form-select">
                                <option value="Single" ${room.roomType == 'Single' ? 'selected' : ''}>Single</option>
                                <option value="Double" ${room.roomType == 'Double' ? 'selected' : ''}>Double</option>
                                <option value="VIP" ${room.roomType == 'VIP' ? 'selected' : ''}>VIP</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Giá Tiền:</label>
                            <input type="number" step="1000" name="price" value="${room.price}" class="form-control" required />
                        </div>

                        <div class="mb-3">
                            <label>Trạng Thái:</label>
                            <select name="status" class="form-select">
                                <option value="Available" ${room.status == 'Available' ? 'selected' : ''}>Available</option>
                                <option value="Booked" ${room.status == 'Booked' ? 'selected' : ''}>Booked</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Link Ảnh:</label>
                            <input type="text" name="image" value="${room.image}" class="form-control" />
                        </div>

                        <div class="mb-3">
                            <label>Mô tả:</label>
                            <textarea name="description" class="form-control">${room.description}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Lưu Lại</button>
                        <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">Hủy</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>