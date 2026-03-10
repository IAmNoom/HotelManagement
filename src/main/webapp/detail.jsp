<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Phòng - Hotel Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="detail-container">
            <c:if test="${empty room}">
                <p class="text-center">Phòng không tồn tại.</p>
            </c:if>
            <c:if test="${not empty room}">
                <div class="room-images">
                    <c:forEach var="img" items="${room.images}">
                        <img src="${img}" alt="${room.name}">
                    </c:forEach>
                    <c:if test="${empty room.images}">
                        <img src="https://via.placeholder.com/400x250?text=${room.name}" alt="${room.name}">
                    </c:if>
                </div>
                <div class="room-info">
                    <h1>${room.name}</h1>
                    <p>${room.description}</p>
                    <div class="rating">⭐ ${room.rating} (${room.reviews} đánh giá)</div>
                    <ul class="amenities">
                        <c:forEach var="amen" items="${room.amenities}">
                            <li>${amen}</li>
                        </c:forEach>
                    </ul>
                    <p class="price">Giá: $${room.price}/đêm</p>
                    <a href="booking?roomId=${room.id}" class="btn-book">Đặt Phòng</a>
                </div>
                <div class="reviews">
                    <h2>Đánh giá &amp; Bình luận</h2>
                    <c:forEach var="rev" items="${room.reviewList}">
                        <div class="review">
                            <strong>${rev.author}</strong> - ⭐ ${rev.rating}<br>
                            <p>${rev.comment}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty room.reviewList}">
                        <p>Chưa có đánh giá.</p>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>