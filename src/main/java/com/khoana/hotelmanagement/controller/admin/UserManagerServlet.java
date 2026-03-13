package com.khoana.hotelmanagement.controller.admin;

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
            if ("new".equals(action)) {
                request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    User existingUser = dao.getUserByID(id);
                    if (existingUser == null) {
                        request.getSession().setAttribute("error", "Không tìm thấy người dùng!");
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                        return;
                    }
                    request.setAttribute("user", existingUser);
                    request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("error", "ID người dùng không hợp lệ!");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                }
            } else {
                // Lấy danh sách user và đẩy sang trang JSP cho Frontend hiển thị
                List<User> listUsers = dao.getAllUsers();
                request.setAttribute("listUsers", listUsers);
                request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        try {
            if ("insert".equals(action)) {
                User newUser = new User();
                newUser.setFullName(request.getParameter("fullName"));
                newUser.setEmail(request.getParameter("email"));
                newUser.setPassword(request.getParameter("password")); // Hash if needed
                newUser.setRoleID(Integer.parseInt(request.getParameter("roleID")));
                if (dao.checkEmailExist(newUser.getEmail())) {
                   request.getSession().setAttribute("error", "Email đã tồn tại trong hệ thống!");
                } else {
                    dao.insertUserAdmin(newUser);
                }
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else if ("update".equals(action)) {
                User user = new User();
                user.setId(Integer.parseInt(request.getParameter("id")));
                user.setFullName(request.getParameter("fullName"));
                user.setEmail(request.getParameter("email"));
                user.setPassword(request.getParameter("password")); // Hash if needed
                user.setRoleID(Integer.parseInt(request.getParameter("roleID")));
                dao.updateUserProfile(user);
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else if ("delete".equals(action)) {
                int delId = Integer.parseInt(request.getParameter("id"));
                dao.deleteUser(delId);
                // Xóa xong thì chuyển hướng lại trang danh sách
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else if ("changeRole".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("id"));
                int newRole = Integer.parseInt(request.getParameter("role"));
                dao.changeUserRole(userId, newRole);
                // Đổi quyền xong thì chuyển hướng lại trang danh sách
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID hoặc Role người dùng không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi hệ thống!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}