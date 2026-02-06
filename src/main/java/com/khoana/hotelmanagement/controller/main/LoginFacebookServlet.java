package com.khoana.hotelmanagement.controller.main;

import com.khoana.hotelmanagement.dal.UserDAO;      // Sửa import từ .dao thành .dal
import com.khoana.hotelmanagement.model.GoogleUser; // Import đúng model GoogleUser
import com.khoana.hotelmanagement.model.User;       // Import đúng model User
import com.khoana.hotelmanagement.util.FacebookUtils; // Import đúng util

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginFacebookServlet", urlPatterns = {"/login-facebook"})
public class LoginFacebookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. Lấy Access Token & Info từ Facebook
            String accessToken = FacebookUtils.getToken(code);
            GoogleUser fbUser = FacebookUtils.getUserInfo(accessToken); // Tận dụng GoogleUser để hứng data

            if (fbUser != null) {
                String email = fbUser.getEmail();
                // Xử lý trường hợp FB không trả về email (dùng ID làm email giả)
                if (email == null) {
                    email = fbUser.getId() + "@facebook.com";
                }

                UserDAO dao = new UserDAO();

                // 2. Kiểm tra user đã tồn tại chưa
                if (!dao.checkEmailExist(email)) {
                    // Chưa có -> Đăng ký mới
                    // Lưu ý: Hàm register của bạn nhận (FullName, Email, Password) là chuỗi
                    dao.register(fbUser.getName(), email, "FacebookLogin@123");
                }

                // 3. Lấy thông tin User từ DB lên để lưu vào Session
                // Dùng hàm getUserByEmail bạn vừa thêm trong UserDAO
                User user = dao.getUserByEmail(email);

                // (Fallback) Nếu hàm getUserByEmail chưa chạy, thử dùng checkLogin
                if (user == null) {
                    user = dao.checkLogin(email, "FacebookLogin@123");
                }

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("account", user);
                    // Chuyển hướng về Servlet "home" thay vì "home.jsp" để load dữ liệu
                    response.sendRedirect("home");
                } else {
                    response.sendRedirect("login.jsp?error=FacebookLoginFailed");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Exception");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
