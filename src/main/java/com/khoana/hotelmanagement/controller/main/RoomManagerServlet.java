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

@WebServlet(name = "RoomManagerServlet", urlPatterns = {"/admin/rooms"})
public class RoomManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        RoomDAO dao = new RoomDAO();

        switch (action) {
            case "new":
                request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
                break;
            case "edit":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Room existingRoom = dao.getRoomByID(id);
                    request.setAttribute("room", existingRoom);
                    request.getRequestDispatcher("/admin/room-form.jsp").forward(request, response);
                } catch (Exception e) {
                    response.sendRedirect(request.getContextPath() + "/admin/rooms");
                }
                break;
            case "delete":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.deleteRoom(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
                break;
            default:
                List<Room> listRooms = dao.getAllRooms();
                request.setAttribute("listRooms", listRooms);
                request.getRequestDispatcher("/admin/room-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        RoomDAO dao = new RoomDAO();

        try {
            if ("insert".equals(action)) {
              
                Room newRoom = new Room(0,
                        request.getParameter("roomNumber"),
                        request.getParameter("roomType"),
                        Double.parseDouble(request.getParameter("price")),
                        request.getParameter("status"),
                        request.getParameter("description"),
                        request.getParameter("image"));
                dao.addRoom(newRoom);

            } else if ("update".equals(action)) {
                Room room = new Room(Integer.parseInt(request.getParameter("id")),
                        request.getParameter("roomNumber"),
                        request.getParameter("roomType"),
                        Double.parseDouble(request.getParameter("price")),
                        request.getParameter("status"),
                        request.getParameter("description"),
                        request.getParameter("image"));
                dao.updateRoom(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }
}
