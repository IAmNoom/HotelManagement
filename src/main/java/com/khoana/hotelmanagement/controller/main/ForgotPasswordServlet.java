package com.khoana.hotelmanagement.controller.main;

import com.khoana.hotelmanagement.dal.UserDAO;
import com.khoana.hotelmanagement.model.User;
import com.khoana.hotelmanagement.util.EmailUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password", "/verify-otp", "/reset-password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/forgot-password")) {
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        } else if (path.equals("/verify-otp")) {
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        } else if (path.equals("/reset-password")) {
            request.getRequestDispatcher("new-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); 
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();

      
        if (path.equals("/forgot-password")) {
            String email = request.getParameter("email");
            User user = dao.getUserByEmail(email);

            if (user != null) {
        
                String otp = EmailUtils.generateOTP();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                session.setMaxInactiveInterval(300); 
               
                final String toEmail = email;
                final String otpCode = otp;

           
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        EmailUtils.sendEmail(toEmail, "Mã xác thực đặt lại mật khẩu",
                                "Mã OTP của bạn là: <b>" + otpCode + "</b>. Mã này sẽ hết hạn sau 5 phút.");
                    }
                }).start();
               
                response.sendRedirect("verify-otp");
            } else {
                request.setAttribute("error", "Email không tồn tại trong hệ thống!");
                request.getRequestDispatcher("forgot.jsp").forward(request, response);
            }
        }
        else if (path.equals("/verify-otp")) {
            String inputOtp = request.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("otp");

            if (inputOtp != null && inputOtp.equals(sessionOtp)) {
    
                response.sendRedirect("reset-password");
            } else {
                request.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn!");
                request.getRequestDispatcher("verify.jsp").forward(request, response);
            }
        }
        else if (path.equals("/reset-password")) {
            String newPass = request.getParameter("password");
            String confirmPass = request.getParameter("confirmPassword");
            String email = (String) session.getAttribute("email");

            if (newPass != null && newPass.equals(confirmPass)) {
               
                dao.updatePassword(email, newPass);

               
                session.removeAttribute("otp");
                session.removeAttribute("email");

               
                response.sendRedirect("login.jsp?message=ResetSuccess");
            } else {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
            }
        }
    }
}
