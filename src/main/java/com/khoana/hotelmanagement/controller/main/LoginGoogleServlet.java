package com.khoana.hotelmanagement.controller.main;

import com.khoana.hotelmanagement.dal.UserDAO;
import com.khoana.hotelmanagement.model.GoogleUser;
import com.khoana.hotelmanagement.model.User;
import com.khoana.hotelmanagement.util.GoogleUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginGoogleServlet", urlPatterns = {"/login-google"})
public class LoginGoogleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: --- BẮT ĐẦU LOGIN GOOGLE ---");

        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            System.out.println("DEBUG: Không nhận được Code từ Google.");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=AccessDenied");
            return;
        }

        try {
            System.out.println("DEBUG: Đang lấy Access Token...");
            String accessToken = GoogleUtils.getToken(code);

            System.out.println("DEBUG: Đang lấy thông tin User...");
            GoogleUser googleUser = GoogleUtils.getUserInfo(accessToken);
            System.out.println("DEBUG: Email Google: " + googleUser.getEmail());

            if (googleUser != null) {
                String email = googleUser.getEmail();
                UserDAO dao = new UserDAO();

                System.out.println("DEBUG: Kiểm tra email trong DB...");
                if (!dao.checkEmailExist(email)) {
                    System.out.println("DEBUG: Email chưa tồn tại -> Đang ĐĂNG KÝ...");
                    // FIX: Sử dụng hàm registerGoogleUser thay vì register
                    dao.registerGoogleUser(googleUser.getName(), email);
                    System.out.println("DEBUG: Đã chạy lệnh registerGoogleUser xong.");
                }

                // FIX: Chỉ cần lấy user bằng email, không cần checkLogin với password giả
                User user = dao.getUserByEmail(email);

                if (user != null) {
                    System.out.println("DEBUG: Đăng nhập THÀNH CÔNG! Email: " + user.getEmail());

                    HttpSession session = request.getSession();
                    session.setAttribute("account", user);

                    // Thêm ContextPath để đường dẫn chính xác
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    System.out.println("DEBUG: LỖI NGHIÊM TRỌNG - Không tìm thấy User trong DB sau khi đăng ký.");
                    response.sendRedirect(request.getContextPath() + "/login.jsp?error=RegisterFailed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=GoogleInfoEmpty");
            }
        } catch (Exception e) {
            System.out.println("DEBUG: GẶP LỖI EXCEPTION:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Exception");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
