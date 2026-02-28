package com.khoana.hotelmanagement.controller.main;

import com.khoana.hotelmanagement.dal.UserDAO;
import com.khoana.hotelmanagement.model.User;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        if (fullName != null) {
            fullName = fullName.trim();
        }

        String email = request.getParameter("email");
        if (email != null) {
            email = email.trim();
        }

        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (pass == null || !pass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        if (dao.checkEmailExist(email)) {
            request.setAttribute("error", "Email này đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // FIX: Nhận kết quả boolean từ hàm register
            boolean isSuccess = dao.register(fullName, email, pass);

            if (isSuccess) {
                // NẾU DATABASE LƯU THÀNH CÔNG -> Tự động đăng nhập
                User user = dao.getUserByEmail(email);

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("account", user);
                    session.setMaxInactiveInterval(1800);

                    String encodedEmail = URLEncoder.encode(email, "UTF-8");
                    String encodedPass = URLEncoder.encode(pass, "UTF-8");

                    Cookie c_user = new Cookie("uName", encodedEmail);
                    Cookie c_pass = new Cookie("uPass", encodedPass);
                    Cookie c_rem = new Cookie("uRem", "on");

                    int age = 60 * 60 * 24 * 7;
                    c_user.setMaxAge(age);
                    c_pass.setMaxAge(age);
                    c_rem.setMaxAge(age);

                    c_user.setPath("/");
                    c_pass.setPath("/");
                    c_rem.setPath("/");

                    response.addCookie(c_user);
                    response.addCookie(c_pass);
                    response.addCookie(c_rem);
                }

                // Chuyển về trang chủ
                response.sendRedirect(request.getContextPath() + "/home");

            } else {
                // NẾU DATABASE TỪ CHỐI LƯU (Bị lỗi SQL)
                request.setAttribute("error", "Hệ thống từ chối lưu! Vui lòng kiểm tra lỗi SQL màu đỏ trong Output của NetBeans.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
