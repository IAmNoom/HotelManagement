<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Phòng Thành Công - Courtyard Danang Han River</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="form-container text-center">
            <h1 class="form-header" style="color: #28a745;">🎉 Đặt phòng thành công!</h1>
            <p class="form-subheader">Cảm ơn bạn đã đặt phòng với chúng tôi. Chúng tôi sẽ gửi thông tin xác nhận vào email của bạn.</p>
            <a href="home" class="btn btn-primary">Về trang chủ</a>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>