<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Reset Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
        <div class="card p-4 shadow" style="width: 400px;">
            <h3 class="text-center mb-3">Mật khẩu mới</h3>
            <p class="text-danger text-center">${error}</p>

            <form action="reset-password" method="POST">
                <div class="mb-3">
                    <input type="password" name="password" class="form-control py-2" placeholder="Mật khẩu mới" required>
                </div>
                <div class="mb-3">
                    <input type="password" name="confirmPassword" class="form-control py-2" placeholder="Xác nhận mật khẩu" required>
                </div>
                <button type="submit" class="btn btn-dark w-100 py-2">ĐỔI MẬT KHẨU</button>
            </form>
        </div>
    </body>
</html>