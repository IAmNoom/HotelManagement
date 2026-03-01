package com.khoana.hotelmanagement.controller.main;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.khoana.hotelmanagement.dal.RoomDAO;
import com.khoana.hotelmanagement.model.Room;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu từ form (Viết thường cho khớp với name="checkin" trong HTML)
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        String guests = request.getParameter("guests"); // Lấy thêm số khách để gửi qua JSP hiển thị

        RoomDAO roomDAO = new RoomDAO();
        List<Room> roomList;

        // 2. Logic tìm kiếm phòng
        if (checkin == null || checkout == null || checkin.trim().isEmpty() || checkout.trim().isEmpty()) {
            roomList = roomDAO.getAllRooms();
        } else {
            // Hàm này phải viết chuẩn trong RoomDAO để lọc phòng trống nhé
            roomList = roomDAO.searchAvailableRoom(checkin, checkout);
        }

        // 3. Truyền dữ liệu sang search.jsp
        request.setAttribute("availableRooms", roomList); // Phải tên là availableRooms
        request.setAttribute("checkin", checkin);
        request.setAttribute("checkout", checkout);
        request.setAttribute("guests", guests);

        // 4. Chuyển hướng sang giao diện
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
