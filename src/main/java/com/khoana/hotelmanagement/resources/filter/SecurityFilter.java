package com.khoana.hotelmanagement.filter;

import com.khoana.hotelmanagement.model.User;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter(filterName = "SecurityFilter", urlPatterns = {"/admin/*"})
public class SecurityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

 
        User account = (User) session.getAttribute("account");

        if (account != null && account.getRoleID() == 1) {
           
            chain.doFilter(request, response);
        } else {
            
            req.setAttribute("error", "Bạn không có quyền truy cập trang Quản trị!");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
