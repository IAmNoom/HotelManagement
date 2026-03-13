<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath();%>

<footer class="bg-dark text-light pt-5 pb-3 mt-5 shadow-lg">
    <div class="container">
        <div class="row">

            <div class="col-md-4 col-lg-4 mb-4 text-center text-md-start">
                <img src="<%=ctx%>/assets/img/logo.png" alt="Logo" class="bg-white rounded p-2 mb-3" style="height: 80px; width: auto; object-fit: contain;">
                <p class="text-secondary small mt-2">
                    Khách sạn sang trọng bậc nhất tại Đà Nẵng, mang đến trải nghiệm lưu trú đẳng cấp và dịch vụ hoàn hảo.
                </p>
            </div>

            <div class="col-md-4 col-lg-4 mb-4">
                <h5 class="text-uppercase fw-bold mb-4 text-warning">Thông Tin Liên Hệ</h5>
                <p class="mb-2"><i class="fas fa-building me-3 text-secondary"></i> Marriott Hotel</p>
                <p class="mb-2"><i class="fas fa-map-marker-alt me-3 text-secondary"></i> Ngũ Hành Sơn, Đà Nẵng</p>
                <p class="mb-2"><i class="fas fa-phone-alt me-3 text-secondary"></i> 083 273 6689</p>
                <p class="mb-2"><i class="fas fa-envelope me-3 text-secondary"></i> info@marriott.com</p>
            </div>

            <div class="col-md-4 col-lg-4 mb-4">
                <h5 class="text-uppercase fw-bold mb-4 text-warning">Kết Nối Với Chúng Tôi</h5>
                <div class="d-flex gap-3">
                    <a href="#" class="btn btn-outline-light rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-outline-light rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="btn btn-outline-light rounded-circle" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

        </div>

        <hr class="border-secondary my-4">

        <div class="row text-center text-md-start">
            <div class="col-md-12 text-secondary small">
                © 2026 Marriott Hotel. All Rights Reserved.
            </div>
        </div>
    </div>

    <jsp:include page="/includes/chatbot.jsp" />
</footer>