<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Forgot Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>/* Copy CSS từ login.jsp vào đây */</style>
    </head>
    <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
        <div class="card p-4 shadow" style="width: 400px;">
            <h3 class="text-center mb-3">Quên mật khẩu</h3>
            <p class="text-muted text-center mb-4">Nhập email để nhận mã OTP.</p>

            <p class="text-danger text-center">${error}</p>

            <form action="forgot-password" method="POST">
                <div class="mb-3">
                    <input type="email" name="email" class="form-control py-2" placeholder="Nhập email của bạn" required>
                </div>
                <button type="submit" class="btn btn-dark w-100 py-2">GỬI OTP</button>
            </form>
            <div class="text-center mt-3"><a href="login.jsp" class="text-decoration-none">Quay lại đăng nhập</a></div>
        </div>
    </body>
</html>