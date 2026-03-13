package com.khoana.hotelmanagement.controller.admin;

import com.khoana.hotelmanagement.dal.RoomDAO;
import com.khoana.hotelmanagement.model.Room;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// ĐÃ FIX: Đổi đường dẫn cho khớp với Menu Sidebar
@WebServlet(name = "RoomManagerServlet", urlPatterns = {"/admin/room-manager"})
public class RoomManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO dao = new RoomDAO();
        String action = request.getParameter("action");

        // 1. XỬ LÝ NÚT XÓA (Gửi bằng link GET)
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("roomID"));
                dao.deleteRoom(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin/room-manager");
            return;
        }

        // 2. XỬ LÝ NÚT SỬA (Lấy thông tin phòng đẩy lên Form)
        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("roomID"));
                Room room = dao.getRoomByID(id);
                request.setAttribute("room", room);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 3. MẶC ĐỊNH LÚC NÀO CŨNG LOAD DANH SÁCH PHÒNG
        List<Room> listRooms = dao.getAllRooms();
        request.setAttribute("roomList", listRooms);

        // ĐÃ FIX: Trỏ về đúng 1 trang duy nhất (vừa có bảng, vừa có form ẩn hiện)
        request.getRequestDispatcher("/admin/admin_room_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        RoomDAO dao = new RoomDAO();

        try {
            // Lấy các tham số từ Form giao diện (tên biến đã khớp 100% với file JSP)
            String roomNumber = request.getParameter("roomNumber");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            // Mẹo xử lý: Chuyển đổi tên loại phòng thành ID để nhét vào Database
            String roomType = request.getParameter("roomType");
            int typeID = 1; // Mặc định là Standard
            if ("Superior".equals(roomType)) {
                typeID = 2;
            } else if ("Deluxe".equals(roomType)) {
                typeID = 3;
            } else if ("Suite".equals(roomType)) {
                typeID = 4;
            }

            // XỬ LÝ THÊM MỚI
            if ("add".equals(action)) {
                Room newRoom = new Room(0, roomNumber, typeID, roomType, price, status, description, image);
                dao.addRoom(newRoom);
            } // XỬ LÝ CẬP NHẬT
            else if ("update".equals(action)) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                Room room = new Room(roomID, roomNumber, typeID, roomType, price, status, description, image);
                dao.updateRoom(room);
            }

        } catch (NumberFormatException e) {
            System.out.println("Lỗi parse số: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Xong việc thì load lại trang
        response.sendRedirect(request.getContextPath() + "/admin/room-manager");
    }
}
