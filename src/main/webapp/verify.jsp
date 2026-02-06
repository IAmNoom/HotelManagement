<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Verify OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
        <div class="card p-4 shadow" style="width: 400px;">
            <h3 class="text-center mb-3">Xác thực OTP</h3>
            <p class="text-muted text-center">Mã OTP đã được gửi đến email.</p>
            <p class="text-danger text-center">${error}</p>

            <form action="verify-otp" method="POST">
                <div class="mb-3">
                    <input type="text" name="otp" class="form-control py-2 text-center" placeholder="Nhập 6 số OTP" maxlength="6" required>
                </div>
                <button type="submit" class="btn btn-dark w-100 py-2">XÁC NHẬN</button>
            </form>
        </div>
    </body>
</html>