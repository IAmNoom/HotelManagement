package com.khoana.hotelmanagement.dal;

import com.khoana.hotelmanagement.model.Room;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO extends DBContext {

    // 1. Lấy tất cả phòng
    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, " +
                     "t.typeName, t.description " +
                     "FROM Rooms r " +
                     "JOIN RoomTypes t ON r.typeID = t.typeID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("roomID"));
                room.setRoomNumber(rs.getString("roomNumber"));
                
                // Set cả ID và Name
                room.setTypeID(rs.getInt("typeID"));
                room.setTypeName(rs.getString("typeName")); 
                
                room.setPrice(rs.getDouble("price"));
                room.setStatus(rs.getString("status"));
                room.setDescription(rs.getString("description"));
                room.setImage(rs.getString("imageURL"));
                
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy phòng theo ID (để sửa)
    public Room getRoomByID(int id) {
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, " +
                     "t.typeName, t.description " +
                     "FROM Rooms r " +
                     "JOIN RoomTypes t ON r.typeID = t.typeID " +
                     "WHERE r.roomID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("roomID"));
                room.setRoomNumber(rs.getString("roomNumber"));
                room.setTypeID(rs.getInt("typeID"));
                room.setTypeName(rs.getString("typeName")); 
                room.setPrice(rs.getDouble("price"));
                room.setStatus(rs.getString("status"));
                room.setDescription(rs.getString("description"));
                room.setImage(rs.getString("imageURL"));
                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Thêm phòng mới
    public void addRoom(Room r) {
        String sql = "INSERT INTO Rooms (roomNumber, typeID, price, status, imageURL) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setInt(2, r.getTypeID()); // Lấy số nguyên truyền thẳng vào DB
            ps.setDouble(3, r.getPrice());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getImage());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 4. Cập nhật phòng
    public void updateRoom(Room r) {
        String sql = "UPDATE Rooms SET roomNumber=?, typeID=?, price=?, status=?, imageURL=? WHERE roomID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setInt(2, r.getTypeID()); // Lấy số nguyên truyền thẳng vào DB
            ps.setDouble(3, r.getPrice());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getImage());
            ps.setInt(6, r.getRoomID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. Xóa phòng
    public void deleteRoom(int id) {
        String sql = "DELETE FROM Rooms WHERE roomID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //Hàm lấy dsach phòng trống dựa trên ngày checkin và checkoun
    public List<Room> searchAvailableRoom(String checkIn, String checkOut){
        List<Room> list = new ArrayList<>();
        //Lệnh sql: Lấy phòng trống(kh trùng lịch sử booking)
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, " +
                "t.typeName, t.description " +
                "FROM Rooms r " + 
                "JOIN RoomTypes t ON r.typeID = t.typeID " +
                "WHERE r.status = 'Available' " +
                "AND r.roomID NOT IN (" + 
                " SELECT roomID FROM Bookings " +
                " WHERE (checkInDate < ?) AND (checkOutDate > ?) and status != 'Cancelled'" +
                ")";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            //Truyền tham số ngày vào
            st.setString(1, checkOut); //Booking In < tham số Out
            st.setString(2, checkOut); //Booking Out < tham số In
            
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("roomID"));
                room.setRoomNumber(rs.getString("roomNumber"));
                room.setTypeID(rs.getInt("typeID"));
                room.setTypeName(rs.getString("typeName")); 
                room.setPrice(rs.getDouble("price"));
                room.setStatus(rs.getString("status"));
                room.setImage(rs.getString("imageURL"));
                room.setDescription(rs.getString("description"));
                
                list.add(room);
            }
        } catch (Exception e){
            System.out.println("Lỗi tại searchAvailableRoom: " + e.getMessage());
        }
        return list;
    }
}
