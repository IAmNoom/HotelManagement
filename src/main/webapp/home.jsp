
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Courtyard Danang Han River | PRJ301 Demo</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Swiss+721+BT:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">

        <style>
            /* Tùy chỉnh CSS để giống Marriott */
            body {
                font-family: 'Swiss 721 BT', 'Roboto', sans-serif;
                color: #1c1c1c;
            }
            .navbar {
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 15px 0;
            }
            .navbar-brand {
                font-weight: 700;
                color: #b31b1b;
                font-size: 1.5rem;
                text-transform: uppercase;
            }
            .nav-link {
                color: #1c1c1c;
                font-weight: 500;
                margin-left: 20px;
                font-size: 0.9rem;
                text-transform: uppercase;
            }
            .nav-link:hover {
                color: #b31b1b;
            }
            .hero-header {
                background: url('https://cache.marriott.com/content/dam/marriott-renditions/DADCY/dadcy-exterior-0036-hor-wide.jpg') no-repeat center center/cover;
                height: 85vh;
                position: relative;
                display: flex;
                align-items: flex-end;
                justify-content: center;
                padding-bottom: 50px;
            }
            .hero-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to bottom, rgba(0,0,0,0.2), rgba(0,0,0,0.6));
            }
            .booking-widget {
                position: relative;
                background: #fff;
                padding: 20px 30px;
                border-radius: 4px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                width: 80%;
                max-width: 1100px;
                z-index: 10;
            }
            .form-label-custom {
                font-size: 0.75rem;
                font-weight: 700;
                color: #767676;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 5px;
                display: block;
            }
            .form-control-custom {
                border: none;
                border-bottom: 1px solid #ccc;
                border-radius: 0;
                padding: 10px 0;
                font-weight: 500;
            }
            .form-control-custom:focus {
                box-shadow: none;
                border-color: #b31b1b;
            }
            .btn-marriott {
                background-color: #1c1c1c;
                color: #fff;
                font-weight: 700;
                border-radius: 2px;
                padding: 12px 30px;
                text-transform: uppercase;
                width: 100%;
                transition: all 0.3s;
            }
            .btn-marriott:hover {
                background-color: #b31b1b;
            }
            .section-title {
                text-align: center;
                margin: 60px 0 40px;
            }
            .section-title h2 {
                font-weight: 300;
                font-size: 2.5rem;
            }
            .section-title .divider {
                width: 60px;
                height: 3px;
                background-color: #b31b1b;
                margin: 20px auto;
            }
            .room-card {
                border: none;
                margin-bottom: 30px;
                transition: transform 0.3s;
            }
            .room-card:hover {
                transform: translateY(-5px);
            }
            .room-img-wrapper {
                overflow: hidden;
                position: relative;
                height: 250px;
            }
            .room-card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s;
            }
            .room-card:hover img {
                transform: scale(1.1);
            }
            .price-tag {
                font-size: 1.2rem;
                font-weight: 700;
                color: #1c1c1c;
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container">
                <a class="navbar-brand" href="home">
                    <i class="fa-solid fa-hotel me-2"></i> Courtyard
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#">Overview</a></li>

                        <li class="nav-item"><a class="nav-link" href="admin/rooms">Rooms</a></li>

                        <li class="nav-item"><a class="nav-link" href="#">Dining</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Gallery</a></li>
                        <li class="nav-item ms-3">
                        <c:if test="${sessionScope.account == null}">
                            <a href="login.jsp" class="btn btn-outline-dark btn-sm px-4 rounded-0">Sign In</a>
                        </c:if>

                        <c:if test="${sessionScope.account != null}">
                            <span class="nav-link text-secondary">Hi, ${sessionScope.account.fullName}</span>
                            <a href="logout" class="btn btn-link nav-link" style="display:inline; padding:0; margin-left:10px; font-size: 0.8rem;">(Logout)</a>
                        </c:if>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <header class="hero-header">
            <div class="hero-overlay"></div>

            <div class="booking-widget">
                <form action="search" method="GET">
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <label class="form-label-custom">Destination</label>
                            <input type="text" class="form-control form-control-custom" value="Danang, Vietnam" readonly>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-custom">Check-in / Check-out</label>
                            <div class="d-flex gap-2">
                                <input type="date" name="checkin" class="form-control form-control-custom" required>
                                <input type="date" name="checkout" class="form-control form-control-custom" required>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-custom">Guests & Rooms</label>
                            <select name="guests" class="form-control form-control-custom">
                                <option value="1">1 Room, 1 Adult</option>
                                <option value="2" selected>1 Room, 2 Adults</option>
                                <option value="3">2 Rooms, 4 Adults</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-marriott">
                                Check Availability
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </header>

        <div class="container py-5">
            <div class="section-title">
                <h2>Accommodations</h2>
                <div class="divider"></div>
                <p class="text-muted">Stay in the heart of Danang with stunning Han River views.</p>
            </div>

            <div class="row">
                <c:forEach items="${listR}" var="r">
                    <div class="col-md-4">
                        <div class="card room-card h-100">
                            <div class="room-img-wrapper">
                                <img src="${r.image}" onerror="this.src='https://cache.marriott.com/content/dam/marriott-renditions/DADCY/dadcy-guestroom-0012-hor-wide.jpg'" alt="${r.roomNumber}">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title fw-bold">Room ${r.roomNumber} - ${r.roomType}</h5>

                                <p class="text-muted small">
                                    ${r.description != null ? r.description : 'City View, Guest room, 1 King, Sofa bed'}
                                </p>
                                <hr>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div>
                                        <span class="text-muted small">From</span><br>
                                        <span class="price-tag">
                                            <fmt:formatNumber value="${r.price}" type="number" maxFractionDigits="0"/> VND
                                        </span> 
                                        <span class="small">/night</span>
                                    </div>

                                    <a href="detail?id=${r.roomID}" class="btn btn-outline-dark rounded-0">View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <footer class="bg-dark text-white pt-5 pb-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <h5 class="text-uppercase mb-3 fw-bold">Courtyard by Marriott</h5>
                        <p class="small text-secondary">58 Bach Dang Street, Hai Chau District, Da Nang, Vietnam</p>
                        <p class="small text-secondary">Tel: +84 236-3937979</p>
                    </div>
                    <div class="col-md-2 mb-4">
                        <h6 class="text-uppercase fw-bold">Company</h6>
                        <ul class="list-unstyled small text-secondary">
                            <li><a href="#" class="text-secondary text-decoration-none">About Us</a></li>
                            <li><a href="#" class="text-secondary text-decoration-none">Careers</a></li>
                        </ul>
                    </div>
                    <div class="col-md-2 mb-4">
                        <h6 class="text-uppercase fw-bold">Support</h6>
                        <ul class="list-unstyled small text-secondary">
                            <li><a href="#" class="text-secondary text-decoration-none">Help Center</a></li>
                            <li><a href="#" class="text-secondary text-decoration-none">Privacy & Terms</a></li>
                        </ul>
                    </div>
                </div>
                <hr class="border-secondary">
                <div class="text-center small text-secondary">
                    &copy; 2024 Courtyard by Marriott Danang Clone. PRJ301 Student Project.
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>