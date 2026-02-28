/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.khoana.hotelmanagement.dal;

/**
 *
 * @author Huyb
 */
import com.khoana.hotelmanagement.model.Booking;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO extends DBContext {

    // Hàm lưu đơn đặt phòng mới vào Database
    public boolean insertBooking(Booking booking) {
        String sql = "INSERT INTO Bookings (userID, roomID, checkInDate, checkOutDate, totalPrice, status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            if (connection == null) return false;
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, booking.getUserID());
            ps.setInt(2, booking.getRoomID());
            ps.setDate(3, booking.getCheckInDate()); // Dùng java.sql.Date
            ps.setDate(4, booking.getCheckOutDate());
            ps.setDouble(5, booking.getTotalPrice());
            ps.setString(6, booking.getStatus());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            System.out.println("Lỗi tại insertBooking: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    //Hàm lấy dsach lịch sử book phòng của 1 User cụ thể
    public List<Booking> getBookingsByUserID(int userID){
        List<Booking> list = new ArrayList<>();
        //Dung Join de lay kem in4 So phong va Loai Phong
        String sql = "SELECT b.*, r.roomNumber, t.typeName " + "FROM Bookings b " +
                "JOIN Rooms r ON b.roomID = r.roomID " +
                "JOIN RoomTypes t ON r.typeID = t.typeID " +
                "WHERE b.userID = ? " +
                "ORDER BY b.bookingDate DESC";
        
        try{
            if(connection == null) return list;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()){
                Booking b = new Booking();
                b.setBookingID(rs.getInt("bookingID"));
                b.setUserID(rs.getInt("userID"));
                b.setRoomID(rs.getInt("roomID"));
                b.setCheckInDate(rs.getDate("checkInDate"));
                b.setCheckOutDate(rs.getDate("checkOutDate"));
                b.setTotalPrice(rs.getDouble("totalPrice"));
                b.setStatus(rs.getString("status"));
                b.setBookingDate(rs.getTimestamp("bookingDate"));
                
                // Set thêm thông tin phụ cho Frontend dễ hiển thị
                b.setRoomNumber(rs.getString("roomNumber"));
                b.setTypeName(rs.getString("typeName"));
                
                list.add(b);
            }
        } catch (Exception e){
            System.out.println("Lỗi tại getBookingsByUserID: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy ID của đơn đặt phòng vừa mới tạo xong (để gửi sang VNPay)
    public int getLatestBookingID(int userID) {
        String sql = "SELECT TOP 1 bookingID FROM Bookings WHERE userID = ? ORDER BY bookingID DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("bookingID");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Cập nhật trạng thái sau khi thanh toán xong
    public void updateBookingStatus(int bookingID, String status) {
        String sql = "UPDATE Bookings SET status = ? WHERE bookingID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
