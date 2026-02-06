<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 
    String cookieEmail = "";
    String cookiePass = "";
    String cookieRem = "";

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            
            if (c.getName().equals("uName")) {
                cookieEmail = URLDecoder.decode(c.getValue(), "UTF-8");
            }
            if (c.getName().equals("uPass")) {
                cookiePass = URLDecoder.decode(c.getValue(), "UTF-8");
            }
            if (c.getName().equals("uRem")) {
                cookieRem = c.getValue();
            }
        }
    }

  
    String inputEmail = (String) request.getAttribute("email");
    if (inputEmail != null) {
        cookieEmail = inputEmail;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In - Marriott Bonvoy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Swiss+721+BT:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Swiss 721 BT', 'Roboto', sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .login-container {
                background: #ffffff;
                width: 100%;
                max-width: 480px;
                padding: 40px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            }
            .brand-header {
                font-size: 1.75rem;
                font-weight: 700;
                color: #1c1c1c;
                margin-bottom: 10px;
            }
            .sub-header {
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 30px;
            }
            .form-floating > .form-control {
                border-radius: 0;
                border: 1px solid #707070;
                height: 55px;
            }
            .form-floating > .form-control:focus {
                box-shadow: none;
                border-color: #b31b1b;
                border-width: 2px;
            }
            .form-floating > label {
                color: #666;
                font-size: 0.9rem;
            }
            .btn-marriott {
                background-color: #1c1c1c;
                color: #fff;
                font-weight: 600;
                border-radius: 0;
                padding: 12px 0;
                width: 100%;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                border: none;
            }
            .btn-marriott:hover {
                background-color: #b31b1b;
                color: #fff;
            }
            .btn-social-modern {
                background-color: #fff;
                border: 1px solid #dadce0;
                border-radius: 8px;
                color: #3c4043;
                font-weight: 500;
                font-size: 1rem;
                padding: 10px 0;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                transition: all 0.2s ease-in-out;
                text-decoration: none;
            }
            .btn-social-modern:hover {
                background-color: #f7f8f8;
                border-color: #d2e3fc;
                color: #202124;
            }
            .social-logo {
                width: 20px;
                height: 20px;
            }
            .link-text {
                color: #1c1c1c;
                text-decoration: none;
                font-size: 0.85rem;
                font-weight: 500;
            }
            .link-text:hover {
                text-decoration: underline;
            }
            .divider {
                border-top: 1px solid #ddd;
                margin: 30px 0;
            }
            .or-separator {
                display: flex;
                align-items: center;
                text-align: center;
                color: #6c757d;
                font-size: 0.9rem;
                margin: 25px 0;
            }
            .or-separator::before, .or-separator::after {
                content: '';
                flex: 1;
                border-bottom: 1px solid #ddd;
            }
            .or-separator:not(:empty)::before {
                margin-right: .5em;
            }
            .or-separator:not(:empty)::after {
                margin-left: .5em;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="mb-4">
                <h1 class="brand-header">Sign In</h1>
                <p class="sub-header">Access your account to manage your bookings.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-0 mb-4" role="alert">
                    <c:choose>
                        <c:when test="${param.error == 'AccessDenied'}">Bạn đã hủy đăng nhập Google.</c:when>
                        <c:when test="${param.error == 'RegisterFailed'}">Lỗi đăng ký tài khoản Google vào hệ thống.</c:when>
                        <c:when test="${param.error == 'GoogleInfoEmpty'}">Không lấy được thông tin từ Google.</c:when>
                        <c:otherwise>${error}</c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <form action="login" method="POST" autocomplete="off">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="email" name="email" 
                           placeholder="name@example.com" 
                           value="<%= cookieEmail%>" required>
                    <label for="email">Email or Member Number</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Password" 
                           value="<%= cookiePass%>" autocomplete="new-password" required>
                    <label for="password">Password</label>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input rounded-0" type="checkbox" id="remember" name="remember" 
                               <%= (cookieRem != null && !cookieRem.isEmpty()) ? "checked" : ""%>>
                        <label class="form-check-label" style="font-size: 0.85rem;" for="remember">
                            Remember me
                        </label>
                    </div>
                    <a href="forgot-password" class="link-text">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-marriott">Sign In</button>

                <div class="or-separator">Hoặc tiếp tục với</div>
                <div class="row gx-3">
                    <div class="col-6">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8081%2FHotelManagement%2Flogin-google&response_type=code&client_id=564583690749-82fah1b28gfo5v8mi91qs309uc9a2n5n.apps.googleusercontent.com&approval_prompt=force" class="btn btn-social-modern">
                            <img src="https://www.svgrepo.com/show/475656/google-color.svg" class="social-logo" alt="Google">
                            Google
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="https://www.facebook.com/dialog/oauth?client_id=YOUR_FB_APP_ID&redirect_uri=http%3A%2F%2Flocalhost%3A8081%2FHotelManagement%2Flogin-facebook&scope=email" class="btn btn-social-modern">
                            <img src="https://www.svgrepo.com/show/475647/facebook-color.svg" class="social-logo" alt="Facebook">
                            Facebook
                        </a>
                    </div>
                </div>
            </form>

            <div class="divider"></div>
            <div class="text-center">
                <span style="font-size: 0.9rem;">Not a member? </span>
                <a href="register.jsp" class="link-text fw-bold ms-1">Join Now</a>
            </div>
            <div class="text-center mt-3">
                <a href="home" class="link-text text-muted" style="font-size: 0.8rem;">Back to Home</a>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>