/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.controller.main;

/**
 *
 * @author Huyb
 */
import com.khoana.hotelmanagement.dal.BookingDAO;
import com.khoana.hotelmanagement.dal.RoomDAO;
import com.khoana.hotelmanagement.model.Booking;
import com.khoana.hotelmanagement.model.Room;
import com.khoana.hotelmanagement.model.User;
import com.khoana.hotelmanagement.util.Config;
import com.khoana.hotelmanagement.util.EmailUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra xem người dùng đã login chưa
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // 2. Lấy dữ liệu từ form đặt phòng
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");

            // 3. LOGIC TÍNH TIỀN: Tính số ngày lưu trú
            LocalDate checkInDate = LocalDate.parse(checkInStr);
            LocalDate checkOutDate = LocalDate.parse(checkOutStr);

            long daysBetween = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            if (daysBetween <= 0) {
                daysBetween = 1;
            }

            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomByID(roomID);
            double totalPrice = daysBetween * room.getPrice();

            // 4. Đóng gói dữ liệu vào Model và Lưu DB
            Booking newBooking = new Booking();
            newBooking.setUserID(currentUser.getId());
            newBooking.setRoomID(roomID);
            newBooking.setCheckInDate(Date.valueOf(checkInDate));
            newBooking.setCheckOutDate(Date.valueOf(checkOutDate));
            newBooking.setTotalPrice(totalPrice);
            newBooking.setStatus("Pending");

            BookingDAO bookingDAO = new BookingDAO();
            boolean isSuccess = bookingDAO.insertBooking(newBooking);

            // 5. Điều hướng kết quả: Thêm gửi Email và tạo link VNPay
            if (isSuccess) {
                // --- 5.1: Gửi Email Bằng Giao Diện HTML Xịn Xò ---
                String userEmail = currentUser.getEmail();
                if (userEmail != null && !userEmail.trim().isEmpty() && userEmail.contains("@")) {
                    try {
                        String roomName = "Phòng " + room.getRoomNumber();
                        EmailUtils.sendBookingConfirmEmail(userEmail, currentUser.getFullName(), roomName, checkInStr, checkOutStr, totalPrice);
                    } catch (Exception e) {
                        System.out.println("Lỗi gửi email cho: " + userEmail);
                        e.printStackTrace();
                    }
                }

                // --- 5.2: Chuẩn bị thông số gửi sang VNPay ---
                int latestBookingID = bookingDAO.getLatestBookingID(currentUser.getId());
                long amount = (long) (totalPrice * 100);
                String vnp_TxnRef = Config.getRandomNumber(8);

                Map<String, String> vnp_Params = new HashMap<>();
                vnp_Params.put("vnp_Version", "2.1.0");
                vnp_Params.put("vnp_Command", "pay");
                vnp_Params.put("vnp_TmnCode", Config.vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(amount));
                vnp_Params.put("vnp_CurrCode", "VND");
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", String.valueOf(latestBookingID));
                vnp_Params.put("vnp_OrderType", "other");
                vnp_Params.put("vnp_Locale", "vn");
                vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                vnp_Params.put("vnp_IpAddr", Config.getIpAddress(request));

                // --- 5.3: Cấu hình thời gian giao dịch ---
                Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                vnp_Params.put("vnp_CreateDate", formatter.format(cld.getTime()));

                cld.add(Calendar.MINUTE, 15);
                vnp_Params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

                // --- 5.4: Băm mã bảo mật và tạo URL ---
                List fieldNames = new ArrayList(vnp_Params.keySet());
                Collections.sort(fieldNames);
                StringBuilder hashData = new StringBuilder();
                StringBuilder query = new StringBuilder();
                Iterator itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = (String) itr.next();
                    String fieldValue = (String) vnp_Params.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        if (itr.hasNext()) {
                            query.append('&');
                            hashData.append('&');
                        }
                    }
                }

                String queryUrl = query.toString();
                String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
                queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

                // --- BƯỚC 5.5: Đá văng khách sang trang của VNPay ---
                response.sendRedirect(paymentUrl);

            } else {
                response.sendRedirect(request.getContextPath() + "/home.jsp?error=booking_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home.jsp?error=invalid_data");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/home.jsp");
    }
}