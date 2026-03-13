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
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, "
                + "t.typeName, t.description "
                + "FROM Rooms r "
                + "JOIN RoomTypes t ON r.typeID = t.typeID";
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
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, "
                + "t.typeName, t.description "
                + "FROM Rooms r "
                + "JOIN RoomTypes t ON r.typeID = t.typeID "
                + "WHERE r.roomID = ?";
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
            ps.setInt(2, r.getTypeID());
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
            ps.setInt(2, r.getTypeID());
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

    // ĐÃ FIX: Hàm lấy dsach phòng trống dựa trên ngày checkin và checkout
    public List<Room> searchAvailableRoom(String checkIn, String checkOut) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, "
                + "t.typeName, t.description "
                + "FROM Rooms r "
                + "JOIN RoomTypes t ON r.typeID = t.typeID "
                + "WHERE r.status = 'Available' "
                + "AND r.roomID NOT IN ("
                + " SELECT roomID FROM Bookings "
                + " WHERE (checkInDate < ?) AND (checkOutDate > ?) and status != 'Cancelled'"
                + ")";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            // ĐÃ FIX LỖI TẠI ĐÂY: Tham số 2 phải là checkIn
            st.setString(1, checkOut);
            st.setString(2, checkIn);

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
        } catch (Exception e) {
            System.out.println("Lỗi tại searchAvailableRoom: " + e.getMessage());
        }
        return list;
    }

    // =========================================================
    // HÀM MỚI TẠO: Lọc phòng nâng cao (Theo Ngày và Khoảng Giá)
    // Phải có hàm này thì cái thanh Sidebar bên trái mới hoạt động!
    // =========================================================
    public List<Room> searchAdvancedRooms(String checkIn, String checkOut, String priceMin, String priceMax) {
        List<Room> list = new ArrayList<>();

        // 1. Khởi tạo câu SQL cơ bản (Chỉ lấy phòng Available)
        StringBuilder sql = new StringBuilder(
                "SELECT r.roomID, r.roomNumber, r.typeID, r.price, r.status, r.imageURL, t.typeName, t.description "
                + "FROM Rooms r JOIN RoomTypes t ON r.typeID = t.typeID "
                + "WHERE r.status = 'Available' "
        );

        // 2. Nếu khách có nhập Ngày -> Thêm điều kiện lọc ngày
        boolean hasDate = (checkIn != null && checkOut != null && !checkIn.trim().isEmpty() && !checkOut.trim().isEmpty());
        if (hasDate) {
            sql.append("AND r.roomID NOT IN (SELECT roomID FROM Bookings WHERE checkInDate < ? AND checkOutDate > ? AND status != 'Cancelled') ");
        }

        // 3. Nếu khách có nhập Giá -> Thêm điều kiện lọc Giá
        boolean hasMinPrice = (priceMin != null && !priceMin.trim().isEmpty());
        boolean hasMaxPrice = (priceMax != null && !priceMax.trim().isEmpty());

        if (hasMinPrice) {
            sql.append("AND r.price >= ? ");
        }
        if (hasMaxPrice) {
            sql.append("AND r.price <= ? ");
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Truyền giá trị vào các dấu hỏi chấm (?)
            if (hasDate) {
                st.setString(paramIndex++, checkOut);
                st.setString(paramIndex++, checkIn);
            }
            if (hasMinPrice) {
                st.setDouble(paramIndex++, Double.parseDouble(priceMin));
            }
            if (hasMaxPrice) {
                st.setDouble(paramIndex++, Double.parseDouble(priceMax));
            }

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
        } catch (Exception e) {
            System.out.println("Lỗi tại searchAdvancedRooms: " + e.getMessage());
        }
        return list;
    }
}
