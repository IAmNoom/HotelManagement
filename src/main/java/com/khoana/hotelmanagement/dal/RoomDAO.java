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
        String sql = "SELECT * FROM Rooms";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Room(
                        rs.getInt("roomID"),
                        rs.getString("roomNumber"),
                        rs.getString("roomType"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("image")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy phòng theo ID (để sửa)
    public Room getRoomByID(int id) {
        String sql = "SELECT * FROM Rooms WHERE roomID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Room(
                        rs.getInt("roomID"),
                        rs.getString("roomNumber"),
                        rs.getString("roomType"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Thêm phòng mới
    public void addRoom(Room r) {
        String sql = "INSERT INTO Rooms (roomNumber, roomType, price, status, description, image) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setString(2, r.getRoomType());
            ps.setDouble(3, r.getPrice());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.setString(6, r.getImage());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 4. Cập nhật phòng
    public void updateRoom(Room r) {
        String sql = "UPDATE Rooms SET roomNumber=?, roomType=?, price=?, status=?, description=?, image=? WHERE roomID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRoomNumber());
            ps.setString(2, r.getRoomType());
            ps.setDouble(3, r.getPrice());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.setString(6, r.getImage());
            ps.setInt(7, r.getRoomID());
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
}
