<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<footer class="site-footer">
    <div class="footer-container">

        <!-- LOGO -->
        <div class="footer-col footer-logo">
            <img src="<%=ctx%>/assets/img/logo.png" alt="Logo" class="footer-brand-logo">
        </div>

        <!-- THÔNG TIN -->
        <div class="footer-col">
            <h3>THÔNG TIN LIÊN HỆ</h3>
            <p>Hotel</p>
            <p>Ngũ Hành Sơn - Đà Nẵng</p>
            <p>Điện thoại: 0123 456 789</p>
            <p>Email: info@abcd.com</p>
        </div>

        <!-- MẠNG XÃ HỘI -->
        <div class="footer-col">
            <h3>KẾT NỐI VỚI CHÚNG TÔI</h3>
            <a href="#">Facebook</a>
            <a href="#">Instagram</a>
            <a href="#">YouTube</a>
        </div>

    </div>

    <div class="footer-bottom">
        © 2026 Hotel. All Rights Reserved.
    </div>
</footer>