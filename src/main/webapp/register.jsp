<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Join Marriott Bonvoy</title>

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

            .register-container {
                background: #ffffff;
                width: 100%;
                max-width: 600px;
                padding: 40px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            }

            .brand-header {
                font-size: 1.75rem;
                font-weight: 700;
                color: #1c1c1c;
                margin-bottom: 5px;
            }

            .sub-header {
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 25px;
            }

            /* Input Styles */
            .form-floating > .form-control {
                border-radius: 0;
                border: 1px solid #707070;
                height: 50px;
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

            /* Button Styles */
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
            }

            .btn-marriott:hover {
                background-color: #b31b1b;
            }

            .link-text {
                color: #1c1c1c;
                text-decoration: none;
                font-size: 0.9rem;
                font-weight: 500;
            }

            .link-text:hover {
                text-decoration: underline;
            }

            .divider {
                border-top: 1px solid #ddd;
                margin: 30px 0;
            }
        </style>
    </head>
    <body>

        <div class="register-container">
            <h1 class="brand-header">Join Marriott Bonvoy</h1>
            <p class="sub-header">Unlock extraordinary experiences and free nights.</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-0 small py-2 mb-4">${error}</div>
            </c:if>

            <form action="register" method="POST">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="fullName" placeholder="Full Name" required>
                    <label>Full Name</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="email" class="form-control" name="email" placeholder="Email" required>
                    <label>Email Address</label>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="password" placeholder="Password" required>
                            <label>Password</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm" required>
                            <label>Confirm Password</label>
                        </div>
                    </div>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input rounded-0" type="checkbox" required id="agree">
                    <label class="form-check-label small text-secondary" for="agree">
                        I agree to the Terms & Conditions and Privacy Policy.
                    </label>
                </div>

                <button type="submit" class="btn-marriott">Join Now</button>
            </form>

            <div class="divider"></div>

            <div class="text-center">
                <span class="small">Already a member?</span>
                <a href="login.jsp" class="link-text fw-bold ms-1">Sign In</a>
            </div>
            <div class="text-center mt-2">
                <a href="home" class="link-text small text-muted">Back to Home</a>
            </div>
        </div>

    </body>
</html>