<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home - Hotel Management</title>
        <link rel="stylesheet" href="<%=ctx%>/assets/css/style.css" />
    </head>

    <body>
        <jsp:include page="/includes/header.jsp"/>

        <section class="hero">
            <img class="hero-img" src="<%=ctx%>/assets/img/banner.jpg" alt="Banner" />
            <div class="hero-overlay"></div>

            <div class="hero-content">
                <h1>Hotel</h1>
                <p>Nghỉ dưỡng hiện đại - dịch vụ tận tâm</p>

                <form class="hero-search" action="<%=ctx%>/search" method="get">
                    <div class="hs-grid">
                        <input type="date" name="checkin" id="checkin" required title="Ngày nhận phòng" />
                        <input type="date" name="checkout" id="checkout" required title="Ngày trả phòng" />

                        <select name="guests">
                            <option value="1">1 khách</option>
                            <option value="2">2 khách</option>
                            <option value="3">3 khách</option>
                            <option value="4">4 khách</option>
                        </select>
                        <button type="submit">Tìm phòng</button>
                    </div>
                </form>
            </div>
        </section>

        <section class="section about">
            <div class="container about-grid">
                <div class="about-text">
                    <h2 class="section-title">Về chúng tôi</h2>
                    <p>
                        Hotel mang đến trải nghiệm lưu trú hiện đại, tinh tế và tiện nghi.
                        Vị trí thuận lợi, phòng ốc sạch đẹp, cùng đội ngũ nhân viên thân thiện.
                    </p>
                    <p>
                        Chúng tôi hướng đến dịch vụ chuyên nghiệp, không gian ấm cúng, phù hợp cho
                        nghỉ dưỡng và công tác.
                    </p>
                    <a class="btn-outline" href="<%=ctx%>/about.jsp">Xem thêm</a>
                </div>

                <div class="about-photo">
                    <img src="<%=ctx%>/assets/img/about.jpg" alt="About" />
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title center">Lưu trú</h2>

                <div class="stay">
                    <div class="stay-media">
                        <button class="stay-arrow left" type="button" aria-label="Prev">‹</button>

                        <img id="stayImage" class="stay-img"
                             src="<%=ctx%>/assets/img/room-1.jpg" alt="Room" />

                        <button class="stay-arrow right" type="button" aria-label="Next">›</button>
                    </div>

                    <div class="stay-card">
                        <h3 id="stayTitle">Studio Partial Sea View &amp; City View</h3>
                        <div class="stay-line"></div>

                        <div class="stay-meta">
                            <span id="stayGuest">👤 2 người</span>
                            <span class="stay-sep">|</span>
                            <span id="staySize">📐 33m²</span>
                        </div>
                    </div>
                </div>
                <div class="stay-bottom">
                    <div class="stay-pager">
                        <button type="button" class="stay-page active" data-index="0">1</button>
                        <button type="button" class="stay-page" data-index="1">2</button>
                    </div>

                    <a class="stay-all" href="<%=ctx%>/rooms.jsp">Xem tất cả</a>
                </div>          
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title center">Nhà hàng tại Hotel</h2>

                <div class="full-slider">
                    <button class="nav-arrow left" type="button" aria-label="Prev">‹</button>

                    <div class="full-slide">
                        <img src="<%=ctx%>/assets/img/restaurant-1.jpg" alt="Restaurant" />
                        <div class="full-caption">Restaurant</div>
                    </div>

                    <button class="nav-arrow right" type="button" aria-label="Next">›</button>
                </div>

                <div class="center mt-24">
                    <a class="btn-outline" href="<%=ctx%>/restaurant.jsp">Xem tất cả</a>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <h2 class="section-title center">Tiện ích</h2>

                <div class="svc-tabs" role="tablist">
                    <button class="svc-tab active" type="button" data-service="pool">Hồ Bơi Ngoài Trời</button>
                    <button class="svc-tab" type="button" data-service="fitness">Phòng GYM hiện đại</button>
                    <button class="svc-tab" type="button" data-service="spa">Spa</button>
                    <button class="svc-tab" type="button" data-service="coffee">Coffee</button>
                </div>

                <div class="svc-stage">
                    <img id="svcMainImg" src="<%=ctx%>/assets/img/services/pool/1.jpg" alt="Service image" />
                </div>

                <div class="svc-thumbs">

                    <div class="svc-thumbset active" data-service="pool">
                        <button type="button" class="svc-thumb active" data-src="<%=ctx%>/assets/img/services/pool/1.jpg">
                            <img src="<%=ctx%>/assets/img/services/pool/1.jpg" alt="pool 1">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/pool/2.jpg">
                            <img src="<%=ctx%>/assets/img/services/pool/2.jpg" alt="pool 2">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/pool/3.jpg">
                            <img src="<%=ctx%>/assets/img/services/pool/3.jpg" alt="pool 3">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/pool/4.jpg">
                            <img src="<%=ctx%>/assets/img/services/pool/4.jpg" alt="pool 4">
                        </button>
                    </div>

                    <div class="svc-thumbset" data-service="fitness">
                        <button type="button" class="svc-thumb active" data-src="<%=ctx%>/assets/img/services/fitness/1.jpg">
                            <img src="<%=ctx%>/assets/img/services/fitness/1.jpg" alt="fitness 1">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/fitness/2.jpg">
                            <img src="<%=ctx%>/assets/img/services/fitness/2.jpg" alt="fitness 2">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/fitness/3.jpg">
                            <img src="<%=ctx%>/assets/img/services/fitness/3.jpg" alt="fitness 3">
                        </button>
                    </div>

                    <div class="svc-thumbset" data-service="spa">
                        <button type="button" class="svc-thumb active" data-src="<%=ctx%>/assets/img/services/spa/1.jpg">
                            <img src="<%=ctx%>/assets/img/services/spa/1.jpg" alt="spa 1">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/spa/2.jpg">
                            <img src="<%=ctx%>/assets/img/services/spa/2.jpg" alt="spa 2">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/spa/3.jpg">
                            <img src="<%=ctx%>/assets/img/services/spa/3.jpg" alt="spa 3">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/spa/4.jpg">
                            <img src="<%=ctx%>/assets/img/services/spa/4.jpg" alt="spa 4">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/spa/5.jpg">
                            <img src="<%=ctx%>/assets/img/services/spa/5.jpg" alt="spa 5">
                        </button>
                    </div>

                    <div class="svc-thumbset" data-service="coffee">
                        <button type="button" class="svc-thumb active" data-src="<%=ctx%>/assets/img/services/coffee/1.jpg">
                            <img src="<%=ctx%>/assets/img/services/coffee/1.jpg" alt="coffee 1">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/coffee/2.jpg">
                            <img src="<%=ctx%>/assets/img/services/coffee/2.jpg" alt="coffee 2">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/coffee/3.jpg">
                            <img src="<%=ctx%>/assets/img/services/coffee/3.jpg" alt="coffee 3">
                        </button>
                        <button type="button" class="svc-thumb" data-src="<%=ctx%>/assets/img/services/coffee/4.jpg">
                            <img src="<%=ctx%>/assets/img/services/coffee/4.jpg" alt="coffee 4">
                        </button>
                    </div>

                </div>

                <div class="center mt-24">
                    <a class="btn-outline" href="<%=ctx%>/services.jsp">Xem tất cả</a>
                </div>
            </div>
        </section>

        <section class="review-sec">
            <div class="container">
                <h2 class="review-title">Đánh giá</h2>

                <div class="review-grid">
                    <div class="review-card">
                        <div class="review-quote">“</div>

                        <p class="review-text">
                            Awaken is the perfect combination of dedicated service and modern design.
                            The friendly and enthusiastic staff created a cozy space for my travel.
                            I was delighted with the convenient amenities and attentiveness in meeting all my requests.
                        </p>

                        <div class="review-footer">
                            <div class="review-user">
                                <img class="review-avatar" src="${pageContext.request.contextPath}/assets/img/u1.jpg" alt="Tuan Nguyen">
                                <div class="review-userinfo">
                                    <div class="review-name">Tuan Nguyen</div>
                                    <div class="review-source">From Tripadvisor</div>
                                </div>
                            </div>

                            <div class="review-stars">★★★★★</div>
                        </div>
                    </div>

                    <div class="review-card">
                        <div class="review-quote">“</div>

                        <p class="review-text">
                            The rooms at the Awaken are spacious, clean, and the amenities are smartly laid out.
                            I was really impressed with the attention to detail, from the decoration to the amenities in the room.
                            The bed is soft and the sleep quality is excellent, helping me to have a deep and relaxing sleep.
                        </p>

                        <div class="review-footer">
                            <div class="review-user">
                                <img class="review-avatar" src="${pageContext.request.contextPath}/assets/img/u2.jpg" alt="Phuong Huynh">
                                <div class="review-userinfo">
                                    <div class="review-name">Phuong Huynh</div>
                                    <div class="review-source">From Agoda</div>
                                </div>
                            </div>

                            <div class="review-stars">★★★★★</div>
                        </div>
                    </div>

                    <div class="review-card">
                        <div class="review-quote">“</div>

                        <p class="review-text">
                            Another commendable point is the hotel's restaurant. The breakfast is varied and delicious,
                            giving me a truly special feeling every morning. I also tried the food at the restaurant during my stay
                            and really liked the food here. I will return one day soon.
                        </p>

                        <div class="review-footer">
                            <div class="review-user">
                                <img class="review-avatar" src="${pageContext.request.contextPath}/assets/img/u3.jpg" alt="Ha Minh">
                                <div class="review-userinfo">
                                    <div class="review-name">Ha Minh</div>
                                    <div class="review-source">From Booking.com</div>
                                </div>
                            </div>

                            <div class="review-stars">★★★★★</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="/includes/footer.jsp"/>
        <script>
            const contextPath = "${pageContext.request.contextPath}";
        </script>
        <script src="${pageContext.request.contextPath}/assets/js/stay.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/services.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // 1. Tính toán "Hôm nay" và "Ngày mai" chuẩn theo múi giờ địa phương (tránh lỗi UTC)
                let todayObj = new Date();
                todayObj.setMinutes(todayObj.getMinutes() - todayObj.getTimezoneOffset());
                let todayStr = todayObj.toISOString().slice(0, 10);

                let tomorrowObj = new Date(todayObj);
                tomorrowObj.setDate(tomorrowObj.getDate() + 1);
                let tomorrowStr = tomorrowObj.toISOString().slice(0, 10);

                let checkinInput = document.getElementById('checkin');
                let checkoutInput = document.getElementById('checkout');

                if (checkinInput && checkoutInput) {
                    // 2. Gán ngày nhỏ nhất để chặn khách chọn quá khứ
                    checkinInput.setAttribute('min', todayStr);
                    checkoutInput.setAttribute('min', tomorrowStr);

                    // 3. TỰ ĐỘNG ĐIỀN SẴN ngày hôm nay và ngày mai cho đẹp form
                    checkinInput.value = todayStr;
                    checkoutInput.value = tomorrowStr;

                    // 4. Lắng nghe sự kiện thay đổi ngày Nhận phòng
                    checkinInput.addEventListener('change', function () {
                        // Tính ngày liền sau ngày khách vừa chọn
                        let selectedCheckinObj = new Date(this.value);
                        selectedCheckinObj.setDate(selectedCheckinObj.getDate() + 1);
                        let nextDayStr = selectedCheckinObj.toISOString().slice(0, 10);

                        // Ngày trả phòng tối thiểu phải là 1 ngày sau ngày nhận phòng
                        checkoutInput.setAttribute('min', nextDayStr);

                        // Nếu khách lỡ chọn check-out trước hoặc bằng check-in -> Tự đẩy check-out lên 1 ngày
                        if (checkoutInput.value <= this.value) {
                            checkoutInput.value = nextDayStr;
                        }
                    });
                }
            });
        </script>
    </body>
</html>