/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.controller.main;

/**
 *
 * @author Huyb
 */
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.khoana.hotelmanagement.dal.RoomDAO;
import com.khoana.hotelmanagement.model.Room;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");
        
        RoomDAO roomDAO = new RoomDAO();
        List<Room> roomList;

        if (checkIn == null || checkOut == null || checkIn.trim().isEmpty() || checkOut.trim().isEmpty()) {
            roomList = roomDAO.getAllRooms();
        } else {
            roomList = roomDAO.searchAvailableRoom(checkIn, checkOut);
        }

        request.setAttribute("roomList", roomList); 
        request.setAttribute("checkIn", checkIn);   
        request.setAttribute("checkOut", checkOut); 
        
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}