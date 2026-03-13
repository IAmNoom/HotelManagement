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

        // 1. Lấy dữ liệu ngày tháng
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");

        // 2. Lấy thêm dữ liệu Lọc (Giá tiền)
        String priceMin = request.getParameter("priceMin");
        String priceMax = request.getParameter("priceMax");

        RoomDAO roomDAO = new RoomDAO();
        List<Room> roomList;

        // 3. Gọi hàm lọc xịn xò vừa tạo ở DAO
        roomList = roomDAO.searchAdvancedRooms(checkin, checkout, priceMin, priceMax);

        // 4. ĐÃ FIX LỖI TÊN BIẾN: Bắt buộc phải là "rooms" để khớp với giao diện search.jsp
        request.setAttribute("rooms", roomList);

        // Trả lại các giá trị khách vừa nhập để hiển thị lên giao diện cho đẹp
        request.setAttribute("checkin", checkin);
        request.setAttribute("checkout", checkout);
        request.setAttribute("priceMin", priceMin);
        request.setAttribute("priceMax", priceMax);

        // 5. Chuyển hướng
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
