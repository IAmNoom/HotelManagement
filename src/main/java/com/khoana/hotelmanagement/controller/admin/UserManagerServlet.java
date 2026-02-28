/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.controller.admin;

/**
 *
 * @author Huyb
 */
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.khoana.hotelmanagement.dal.UserDAO;
import com.khoana.hotelmanagement.model.User;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagerServlet", urlPatterns = {"/admin/users"})
public class UserManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Nhận action từ giao diện gửi lên (nếu không có thì mặc định là list)
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; 
        }

        UserDAO dao = new UserDAO();

        try {
            switch (action) {
                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    dao.deleteUser(delId);
                    // Xóa xong thì chuyển hướng lại trang danh sách
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    break;
                    
                case "changeRole":
                    int userId = Integer.parseInt(request.getParameter("id"));
                    int newRole = Integer.parseInt(request.getParameter("role"));
                    dao.changeUserRole(userId, newRole);
                    // Đổi quyền xong thì chuyển hướng lại trang danh sách
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    break;
                    
                default: 
                    // Lấy danh sách user và đẩy sang trang JSP cho Frontend hiển thị
                    List<User> listUsers = dao.getAllUsers();
                    request.setAttribute("listUsers", listUsers);
                    request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}