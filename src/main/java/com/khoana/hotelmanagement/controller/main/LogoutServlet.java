package com.khoana.hotelmanagement.controller.main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie; // Bắt buộc phải có import này để xử lý Cookie
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Hủy Session an toàn (xóa toàn bộ thông tin đăng nhập bao gồm cả "account")
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 2. Xóa Cookie "Remember Me" để lần sau vào lại web nó hiện Form trắng
        Cookie c_user = new Cookie("uName", "");
        Cookie c_pass = new Cookie("uPass", "");
        Cookie c_rem = new Cookie("uRem", "");

        c_user.setMaxAge(0);
        c_user.setPath("/");
        c_pass.setMaxAge(0);
        c_pass.setPath("/");
        c_rem.setMaxAge(0);
        c_rem.setPath("/");

        response.addCookie(c_user);
        response.addCookie(c_pass);
        response.addCookie(c_rem);

        // 3. Chuyển hướng về trang chủ
        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Giữ lại doPost để lỡ gọi qua Form POST thì vẫn xử lý như doGet
        doGet(request, response);
    }
}
