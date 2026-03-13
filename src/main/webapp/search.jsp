<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctx = request.getContextPath();%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tìm Kiếm Phòng - Marriott Hotel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f6f9;
            }
            /* Hiệu ứng di chuột cho Card phòng */
            .room-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border-radius: 12px;
                overflow: hidden;
                border: none;
            }
            .room-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.15) !important;
            }
            /* Tiêu đề bộ lọc */
            .filter-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 12px;
                border-bottom: 2px solid #007bff;
                padding-bottom: 5px;
                display: inline-block;
                color: #343a40;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />

        <div class="container my-5">
            <div class="row">
                <div class="col-lg-3 col-md-4 mb-4">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 20px; border-radius: 12px;">
                        <div class="card-body p-4">
                            <h4 class="fw-bold mb-4 text-primary"><i class="fas fa-filter me-2"></i>Lọc Kết Quả</h4>
                            <form method="GET" action="<%=ctx%>/search">

                                <input type="hidden" name="checkin" value="${param.checkin}">
                                <input type="hidden" name="checkout" value="${param.checkout}">
                                <input type="hidden" name="guests" value="${param.guests}">

                                <div class="mb-4">
                                    <div class="filter-title">Loại Phòng</div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="roomType" value="single" id="typeSingle">
                                        <label class="form-check-label" for="typeSingle">Phòng Đơn</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="roomType" value="double" id="typeDouble">
                                        <label class="form-check-label" for="typeDouble">Phòng Đôi</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="roomType" value="suite" id="typeSuite">
                                        <label class="form-check-label" for="typeSuite">Phòng Suite</label>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="filter-title">Khoảng Giá (VNĐ)</div>
                                    <div class="row g-2">
                                        <div class="col-6">
                                            <input type="number" class="form-control form-control-sm" name="priceMin" placeholder="Từ..." min="0" value="${param.priceMin}">
                                        </div>
                                        <div class="col-6">
                                            <input type="number" class="form-control form-control-sm" name="priceMax" placeholder="Đến..." min="0" value="${param.priceMax}">
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="filter-title">Tiện Ích</div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="amenities" value="wifi" id="amWifi">
                                        <label class="form-check-label" for="amWifi"><i class="fas fa-wifi text-muted me-2"></i>WiFi Miễn Phí</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="amenities" value="aircon" id="amAir">
                                        <label class="form-check-label" for="amAir"><i class="fas fa-snowflake text-muted me-2"></i>Điều Hòa</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" name="amenities" value="tv" id="amTV">
                                        <label class="form-check-label" for="amTV"><i class="fas fa-tv text-muted me-2"></i>TV Phẳng</label>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="filter-title">Xếp Hạng</div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="rating" value="5" id="rate5">
                                        <label class="form-check-label text-warning" for="rate5">⭐⭐⭐⭐⭐</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="rating" value="4" id="rate4">
                                        <label class="form-check-label text-warning" for="rate4">⭐⭐⭐⭐+</label>
                                    </div>
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="radio" name="rating" value="3" id="rate3">
                                        <label class="form-check-label text-warning" for="rate3">⭐⭐⭐+</label>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 fw-bold py-2"><i class="fas fa-search me-2"></i>Áp Dụng Lọc</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-9 col-md-8">

                    <div class="d-flex justify-content-between align-items-center bg-white p-3 rounded shadow-sm mb-4">
                        <div>
                            <h2 class="h4 mb-1 fw-bold text-dark">Phòng Khả Dụng</h2>
                            <small class="text-muted">Tìm thấy <strong class="text-primary">${empty rooms ? '0' : rooms.size()}</strong> phòng phù hợp với tiêu chí của bạn.</small>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="me-2 text-muted text-nowrap">Sắp xếp:</span>
                            <select class="form-select form-select-sm" onchange="window.location.href = 'search?sort=' + this.value" style="width: 180px;">
                                <option value="">-- Mặc định --</option>
                                <option value="price_asc">Giá: Thấp → Cao</option>
                                <option value="price_desc">Giá: Cao → Thấp</option>
                                <option value="rating">Đánh giá cao nhất</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-4">

                        <c:if test="${empty rooms}">
                            <div class="col-12 text-center py-5 bg-white rounded shadow-sm">
                                <i class="fas fa-search-minus fa-4x text-muted mb-3 opacity-50"></i>
                                <h5 class="text-muted">Rất tiếc, không tìm thấy phòng phù hợp.</h5>
                                <p class="text-secondary">Vui lòng thử thay đổi tiêu chí lọc hoặc ngày nhận/trả phòng!</p>
                            </div>
                        </c:if>

                        <c:forEach var="room" items="${rooms}">
                            <div class="col-lg-4 col-md-6">
                                <div class="card room-card h-100 shadow-sm">
                                    <img src="${not empty room.image ? room.image : 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=600&h=400&fit=crop'}" 
                                         class="card-img-top" alt="Ảnh phòng" style="height: 200px; object-fit: cover;">

                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="badge bg-info text-dark">${room.typeName}</span>
                                            <span class="text-warning small"><i class="fas fa-star"></i> ${room.rating != null ? room.rating : 5}</span>
                                        </div>
                                        <h5 class="card-title fw-bold text-dark mb-3">Phòng ${room.roomNumber}</h5>

                                        <ul class="list-unstyled text-muted small mb-3">
                                            <li class="mb-1"><i class="fas fa-user-friends me-2 text-primary"></i>Tối đa ${room.maxGuests != 0 ? room.maxGuests : 2} khách</li>
                                            <li class="mb-1"><i class="fas fa-vector-square me-2 text-primary"></i>Diện tích: ${room.size != null ? room.size : '30'}m²</li>
                                            <li><i class="fas fa-bed me-2 text-primary"></i>Giường cao cấp</li>
                                        </ul>

                                        <div class="mt-auto">
                                            <div class="fs-4 fw-bold text-danger mb-3">
                                                <fmt:formatNumber value="${room.price}" type="number" pattern="#,##0"/> đ <span class="fs-6 text-muted fw-normal">/ đêm</span>
                                            </div>
                                            <div class="d-grid gap-2">
                                                <a href="<%=ctx%>/detail?roomId=${room.roomID}" class="btn btn-outline-primary fw-bold">Xem Chi Tiết</a>
                                                <a href="<%=ctx%>/booking?roomId=${room.roomID}" class="btn btn-primary fw-bold">Đặt Ngay</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <c:if test="${not empty totalPages && totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-5">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i> Trước</a>
                                </li>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}">Sau <i class="fas fa-chevron-right"></i></a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>

                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>