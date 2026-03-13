<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>

<header class="site-header">
    <div class="header-inner">

        <a class="brand" href="<%=ctx%>/home">
            <img src="<%=ctx%>/assets/img/logo.png" alt="Logo" class="brand-logo">
        </a>

        <nav class="main-nav">
            <ul class="nav-list">
                <li><a href="<%=ctx%>/restaurant.jsp">Nhà hàng</a></li>
                <li><a href="<%=ctx%>/rooms.jsp">Lưu trú</a></li>
                <li><a href="<%=ctx%>/meeting.jsp">Hội nghị</a></li>
                <li><a href="<%=ctx%>/services.jsp">Dịch vụ</a></li>
                <li><a href="<%=ctx%>/promotion.jsp">Khuyến mãi</a></li>
                <li><a href="<%=ctx%>/contact.jsp">Liên hệ</a></li>
            </ul>
        </nav>

        <div class="header-actions" style="display: flex; align-items: center; gap: 15px;">
            <c:choose>
                <%-- NẾU ĐÃ ĐĂNG NHẬP --%>
                <c:when test="${sessionScope.account != null}">
                    <span style="font-weight: bold; color: #fff;">Hi, ${sessionScope.account.fullName}</span>

                    <%-- THÊM ĐOẠN NÀY: HIỆN NÚT QUẢN TRỊ NẾU LÀ ADMIN (roleID = 1) --%>
                    <c:if test="${sessionScope.account.roleID == 1}">
                        <a href="<%=ctx%>/admin/room-list.jsp" class="btn-login" style="background-color: #ffc107; color: #000; border: none; font-weight: bold;">Quản Trị</a>
                    </c:if>

                    <a href="<%=ctx%>/logout" class="btn-login" style="background-color: #dc3545; border-color: #dc3545;">Đăng Xuất</a>
                </c:when>

                <%-- NẾU CHƯA ĐĂNG NHẬP --%>
                <c:otherwise>
                    <a href="<%=ctx%>/login.jsp" class="btn-login">Đăng Nhập</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</header>