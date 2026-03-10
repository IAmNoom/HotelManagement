<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Phòng - Courtyard Danang Han River</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="form-container">
            <h1 class="form-header">Đặt Phòng</h1>
            <c:if test="${not empty room}">
                <p class="form-subheader">Phòng: <strong>${room.name}</strong> | Giá: $${room.price}/đêm</p>
            </c:if>

            <form action="confirmBooking" method="post">
                <input type="hidden" name="roomId" value="${param.roomId}">
                <div class="form-floating mb-3">
                    <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Họ và tên" required>
                    <label for="fullname">Họ và tên</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="email" id="email" name="email" class="form-control" placeholder="Email" required>
                    <label for="email">Email</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="tel" id="phone" name="phone" class="form-control" placeholder="Số điện thoại" required>
                    <label for="phone">Số điện thoại</label>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating mb-3">
                            <input type="date" id="checkin" name="checkin" class="form-control" placeholder="Ngày nhận phòng" required>
                            <label for="checkin">Ngày nhận phòng</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating mb-3">
                            <input type="date" id="checkout" name="checkout" class="form-control" placeholder="Ngày trả phòng" required>
                            <label for="checkout">Ngày trả phòng</label>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn-form-submit">Xác Nhận</button>
            </form>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>