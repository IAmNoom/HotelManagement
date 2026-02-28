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
import com.khoana.hotelmanagement.model.Booking;
import com.khoana.hotelmanagement.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HistoryServlet", urlPatterns = {"/history"})
public class HistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // 1. Lấy thông tin người dùng đang đăng nhập từ Session
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        // Nếu chưa đăng nhập, đá về trang login
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Gọi DAO lấy danh sách lịch sử (Đã sửa lại tên hàm cho khớp với file DAO của bạn)
        BookingDAO dao = new BookingDAO();
        List<Booking> listBookings = dao.getBookingsByUserID(currentUser.getId());

        // 3. Đẩy dữ liệu sang trang profile.jsp
        request.setAttribute("listBookings", listBookings);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
