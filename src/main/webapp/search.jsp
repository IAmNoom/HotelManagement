<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm Phòng - Hotel Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">

</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="container">
        <!-- Sidebar Filters -->
        <aside class="sidebar">
            <form method="GET" action="search">
                <!-- Loại phòng -->
                <div class="filter-group">
                    <h3>Loại Phòng</h3>
                    <label>
                        <input type="checkbox" name="roomType" value="single">
                        Phòng Đơn
                    </label>
                    <label>
                        <input type="checkbox" name="roomType" value="double">
                        Phòng Đôi
                    </label>
                    <label>
                        <input type="checkbox" name="roomType" value="suite">
                        Phòng Suite
                    </label>
                </div>
                
                <!-- Giá -->
                <div class="filter-group">
                    <h3>Khoảng Giá</h3>
                    <div class="price-range">
                        <input type="number" name="priceMin" placeholder="Từ" min="0">
                        <span>-</span>
                        <input type="number" name="priceMax" placeholder="Đến" min="0">
                    </div>
                </div>
                
                <!-- Tiện ích -->
                <div class="filter-group">
                    <h3>Tiện Ích</h3>
                    <label>
                        <input type="checkbox" name="amenities" value="wifi">
                        WiFi Miễn Phí
                    </label>
                    <label>
                        <input type="checkbox" name="amenities" value="aircon">
                        Điều Hòa
                    </label>
                    <label>
                        <input type="checkbox" name="amenities" value="tv">
                        TV Màn Hình Phẳng
                    </label>
                    <label>
                        <input type="checkbox" name="amenities" value="minibar">
                        Mini Bar
                    </label>
                </div>
                
                <!-- Xếp hạng -->
                <div class="filter-group">
                    <h3>Xếp Hạng</h3>
                    <label>
                        <input type="radio" name="rating" value="5">
                        ⭐⭐⭐⭐⭐ (5 sao)
                    </label>
                    <label>
                        <input type="radio" name="rating" value="4">
                        ⭐⭐⭐⭐ (4 sao trở lên)
                    </label>
                    <label>
                        <input type="radio" name="rating" value="3">
                        ⭐⭐⭐ (3 sao trở lên)
                    </label>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">
                    Áp Dụng Bộ Lọc
                </button>
            </form>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Search Header -->
            <div class="search-header">
                <h2>Kết Quả Tìm Kiếm</h2>
                <p class="search-info">
                    Từ: <strong>01/01/2024</strong> | Đến: <strong>05/01/2024</strong> | 
                    <strong id="roomCount">0</strong> phòng khả dụng
                </p>
            </div>
            
            <!-- Sort Bar -->
            <div class="sort-bar">
                <span>Sắp xếp theo:</span>
                <select onchange="window.location.href='search?sort=' + this.value">
                    <option value="">-- Lựa chọn --</option>
                    <option value="price_asc">Giá: Thấp → Cao</option>
                    <option value="price_desc">Giá: Cao → Thấp</option>
                    <option value="rating">Xếp hạng cao nhất</option>
                    <option value="newest">Mới nhất</option>
                </select>
            </div>
            
            <!-- Rooms Grid -->
            <div class="rooms-grid">
                <c:if test="${empty rooms}">
                    <div class="empty-state" style="grid-column: 1/-1;">
                        <p>❌ Không tìm thấy phòng phù hợp. Vui lòng thử lại với tiêu chí khác.</p>
                    </div>
                </c:if>
                
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card" onclick="window.location.href='detail?roomId=${room.id}'">
                        <img src="https://via.placeholder.com/280x200?text=${room.name}" 
                             alt="${room.name}" class="room-image">
                        <div class="room-info">
                            <div class="room-name">${room.name}</div>
                            <div class="room-details">
                                <div>👥 ${room.maxGuests} khách</div>
                                <div>📐 ${room.size}m²</div>
                            </div>
                            <div class="room-price">$${room.price}/đêm</div>
                            <div class="room-rating">
                                ⭐ ${room.rating} (${room.reviews} đánh giá)
                            </div>
                            <div class="room-actions">
                                <a href="detail?roomId=${room.id}" class="btn btn-primary">Chi Tiết</a>
                                <a href="booking?roomId=${room.id}" class="btn btn-secondary">Đặt Phòng</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Pagination -->
            <div class="pagination">
                <a href="?page=1">&laquo; Đầu</a>
                <a href="?page=${currentPage - 1}">← Trước</a>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <a href="?page=${currentPage + 1}">Sau →</a>
                <a href="?page=${totalPages}">Cuối &raquo;</a>
            </div>
        </main>
    </div>
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>