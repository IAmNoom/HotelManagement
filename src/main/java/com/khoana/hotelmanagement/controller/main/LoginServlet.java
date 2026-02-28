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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã đăng nhập thì đá về home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // FIX: Thêm .trim() để cắt khoảng trắng vô tình nhập phải
        String email = request.getParameter("email");
        if (email != null) {
            email = email.trim();
        }

        String pass = request.getParameter("password");
        if (pass != null) {
            pass = pass.trim();
        }

        String remember = request.getParameter("remember");

        System.out.println("DEBUG: Đang thử login với Email: [" + email + "] | Pass: [" + pass + "]");

        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(email, pass);

        if (user == null) {
            System.out.println("DEBUG: --> ĐĂNG NHẬP THẤT BẠI! (Sai email hoặc pass)");

            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            System.out.println("DEBUG: --> ĐĂNG NHẬP THÀNH CÔNG! User: " + user.getEmail());
            System.out.println("DEBUG: --> Đang chuyển hướng sang 'home'...");

            String encodedEmail = URLEncoder.encode(email, "UTF-8");
            String encodedPass = URLEncoder.encode(pass, "UTF-8");

            Cookie c_user = new Cookie("uName", encodedEmail);
            Cookie c_pass = new Cookie("uPass", encodedPass);
            Cookie c_rem = new Cookie("uRem", remember);

            c_user.setPath("/");
            c_pass.setPath("/");
            c_rem.setPath("/");

            if (remember != null) {
                int age = 60 * 60 * 24 * 7; // 7 ngày
                c_user.setMaxAge(age);
                c_pass.setMaxAge(age);
                c_rem.setMaxAge(age);
            } else {
                c_user.setMaxAge(0);
                c_pass.setMaxAge(0);
                c_rem.setMaxAge(0);
            }

            response.addCookie(c_user);
            response.addCookie(c_pass);
            response.addCookie(c_rem);

            HttpSession session = request.getSession();
            session.setAttribute("account", user);
            session.setMaxInactiveInterval(1800);

            // Chuyển hướng về trang chủ một cách an toàn
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
