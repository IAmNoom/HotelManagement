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
import com.khoana.hotelmanagement.dal.VNPayBillDAO;
import com.khoana.hotelmanagement.model.User;
import com.khoana.hotelmanagement.model.VNPay_Bill;
import com.khoana.hotelmanagement.util.EmailUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PaymentStatusServlet", urlPatterns = {"/paymentStatus"})
public class PaymentStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo"); // Chứa bookingID
        String vnp_PayDate = request.getParameter("vnp_PayDate");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        if ("00".equals(vnp_ResponseCode)) {
            int bookingID = Integer.parseInt(vnp_OrderInfo);

            // 1. Update Booking Status
            BookingDAO bookingDAO = new BookingDAO();
            bookingDAO.updateBookingStatus(bookingID, "Confirmed");

            // 2. Lưu hóa đơn VNPay
            VNPayBillDAO billDAO = new VNPayBillDAO();
            VNPay_Bill bill = new VNPay_Bill(vnp_TxnRef, Float.parseFloat(vnp_Amount)/100, vnp_PayDate, "00", bookingID);
            billDAO.createVNPayBill(bill);

            // 3. Gửi Email xác nhận
            if (currentUser != null && currentUser.getEmail() != null && currentUser.getEmail().contains("@")) {
                try {
                    EmailUtils.sendEmail(currentUser.getEmail(), "Thanh toán thành công!", "Phòng của bạn đã được thanh toán và xác nhận (Confirmed).");
                } catch (Exception e) {}
            }

            response.sendRedirect("booking_success.jsp?status=paid");
        } else {
            response.sendRedirect("booking_success.jsp?status=failed");
        }
    }
}
