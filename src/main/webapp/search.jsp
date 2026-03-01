<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm - Marriott Hotel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="<%=ctx%>/assets/css/style.css" />
    </head>
    <body class="bg-light">

        <jsp:include page="/includes/header.jsp"/>

        <div class="container mt-5 mb-5" style="min-height: 60vh;">
            <h2 class="mb-4 text-center fw-bold" style="color: #0056b3;">KẾT QUẢ TÌM KIẾM PHÒNG</h2>

            <div class="alert alert-info text-center shadow-sm">
                Bạn đang tìm phòng từ ngày <strong class="text-danger">${param.checkin}</strong> 
                đến <strong class="text-danger">${param.checkout}</strong> 
                cho <strong>${param.guests}</strong> khách.
            </div>

            <div class="row g-4 mt-3">
                <%-- Kiểm tra nếu không có phòng nào --%>
                <c:choose>
                    <c:when test="${empty availableRooms}">
                        <div class="col-12 text-center mt-5">
                            <h4 class="text-danger">Rất tiếc, hệ thống chưa tìm thấy phòng nào phù hợp trong thời gian này!</h4>
                            <a href="<%=ctx%>/home" class="btn btn-outline-primary mt-3">Thử tìm ngày khác</a>
                        </div>
                    </c:when>

                    <%-- Nếu có phòng trống, vẽ danh sách phòng ra --%>
                    <c:otherwise>
                        <c:forEach var="r" items="${availableRooms}">
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                                    <%-- LƯU Ý: Nếu ảnh không hiện, có thể biến trong Room.java của bạn tên là imageUrl, imagePath... --%>
                                    <img src="${r.image}" class="card-img-top" alt="Room" style="height: 220px; object-fit: cover;">
                                    <div class="card-body d-flex flex-column">
                                        <%-- ĐÃ FIX LỖI: Bỏ phần roomType gây crash web --%>
                                        <h5 class="card-title fw-bold">Phòng ${r.roomNumber}</h5>
                                        <p class="card-text text-muted mb-3">Tận hưởng không gian lưu trú sang trọng, tiện nghi và dịch vụ đẳng cấp 5 sao.</p>

                                        <h4 class="text-danger fw-bold mb-4">
                                            <fmt:formatNumber value="${r.price}" type="number" pattern="#,##0"/> đ <span class="fs-6 text-muted fw-normal">/ đêm</span>
                                        </h4>

                                        <form action="<%=ctx%>/booking" method="post" class="mt-auto">
                                            <input type="hidden" name="roomID" value="${r.roomID}">
                                            <input type="hidden" name="checkIn" value="${param.checkin}">
                                            <input type="hidden" name="checkOut" value="${param.checkout}">

                                            <button type="submit" class="btn btn-warning w-100 fw-bold py-2 shadow-sm">
                                                ĐẶT PHÒNG NGAY
                                            </button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="/includes/footer.jsp"/>

    </body>
</html>