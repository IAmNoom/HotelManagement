
package com.khoana.hotelmanagement.controller.admin;

import com.khoana.hotelmanagement.dal.BookingDAO;
import com.khoana.hotelmanagement.model.Booking;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

// Tên link trên thanh địa chỉ mà bạn muốn:
@WebServlet(name = "BookingManagerServlet", urlPatterns = {"/admin/admin_booking_manager.jsp"})
public class BookingManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            BookingDAO dao = new BookingDAO();

            // 1. Kéo toàn bộ danh sách đặt phòng từ SQL lên
            List<Booking> list = dao.getAllBookings();
            request.setAttribute("bookingList", list);

        } catch (Exception e) {
            System.out.println("Lỗi load danh sách Booking: " + e.getMessage());
        }

        // ĐÃ FIX: Chuyển hướng sang file giao diện CÓ TÊN KHÁC (thêm chữ _view) để không bị đụng hàng
        request.getRequestDispatcher("/admin/admin_booking_manager_view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        BookingDAO dao = new BookingDAO();

        try {
            // Lấy ID của đơn hàng mà Admin vừa bấm
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));

            // 2. Xử lý nút Tick xanh (Xác nhận đơn)
            if ("confirm".equals(action)) {
                dao.updateStatus(bookingID, "Confirmed");
            } // 3. Xử lý nút X đỏ (Hủy đơn)
            else if ("cancel".equals(action)) {
                dao.updateStatus(bookingID, "Cancelled");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ĐÃ FIX: Cập nhật DB xong thì load lại đúng cái link có đuôi .jsp
        response.sendRedirect(request.getContextPath() + "/admin/admin_booking_manager.jsp");
    }
}
