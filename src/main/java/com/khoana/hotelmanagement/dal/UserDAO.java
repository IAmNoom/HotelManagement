package com.khoana.hotelmanagement.dal;

import com.khoana.hotelmanagement.model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    // 1. Hàm lấy User bằng Email
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            if (connection == null) {
                return null;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("userID"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getInt("roleID")
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getUserByEmail: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // 2. Hàm Check Login (Username/Password)
    public User checkLogin(String email, String password) {
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
        try {
            if (connection == null) {
                return null;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("userID"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getInt("roleID")
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi checkLogin: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // 3. Hàm kiểm tra Email tồn tại
    public boolean checkEmailExist(String email) {
        String sql = "SELECT userID FROM Users WHERE email = ?";
        try {
            if (connection == null) {
                return false;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. Hàm Đăng ký (Người dùng tự đăng ký có password)
    public boolean register(String fullName, String email, String password) {
        String sql = "INSERT INTO Users (fullName, email, password, roleID) VALUES (?, ?, ?, 2)";
        try {
            if (connection == null) {
                return false;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, fullName);
            st.setString(2, email);
            st.setString(3, password);

            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Đã đăng ký thành công user: " + email);
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi register: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // 5. Hàm Đổi Mật Khẩu
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";
        try {
            if (connection == null) {
                return;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, email);
            st.executeUpdate();

            System.out.println("Đã đổi mật khẩu thành công cho: " + email);
        } catch (SQLException e) {
            System.out.println("Lỗi updatePassword: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 6. Hàm Đăng ký cho người dùng từ Google (Không có password)
    public void registerGoogleUser(String fullName, String email) {
        String defaultPassword = "";
        String sql = "INSERT INTO Users (fullName, email, password, roleID) VALUES (?, ?, ?, 2)";
        try {
            if (connection == null) {
                return;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, fullName);
            st.setString(2, email);
            st.setString(3, defaultPassword);
            st.executeUpdate();

            System.out.println("Đã đăng ký thành công Google user: " + email);
        } catch (SQLException e) {
            System.out.println("Lỗi registerGoogleUser: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 7. Hàm lấy danh sách toàn bộ người dùng (Để Admin xem)
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            if (connection == null) {
                return list;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("userID"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getInt("roleID")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // 8. Hàm Xóa người dùng theo ID (Dành cho Admin)
    public void deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE userID = ?";
        try {
            if (connection == null) {
                return;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Đã xóa thành công user ID: " + id);
        } catch (SQLException e) {
            System.out.println("Lỗi deleteUser: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 9. Hàm Thay đổi quyền
    public void changeUserRole(int id, int newRoleID) {
        String sql = "UPDATE Users SET roleID = ? WHERE userID = ?";
        try {
            if (connection == null) {
                return;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, newRoleID);
            ps.setInt(2, id);
            ps.executeUpdate();
            System.out.println("Đã đổi quyền thành công cho user ID: " + id);
        } catch (SQLException e) {
            System.out.println("Lỗi changeUserRole: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 10. Hàm lấy User theo ID (Dành cho Admin Edit)
    public User getUserByID(int id) {
        String sql = "SELECT * FROM Users WHERE userID = ?";
        try {
            if (connection == null) {
                return null;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("userID"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getInt("roleID")
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getUserByID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // 11. Hàm Admin Thêm User Mới
    public boolean insertUserAdmin(User user) {
        String sql = "INSERT INTO Users (fullName, email, password, roleID) VALUES (?, ?, ?, ?)";
        try {
            if (connection == null) {
                return false;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRoleID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi insertUserAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // 12. Hàm Admin Cập nhật User
    public boolean updateUserProfile(User user) {
        String sql = "UPDATE Users SET fullName = ?, email = ?, password = ?, roleID = ? WHERE userID = ?";
        try {
            if (connection == null) {
                return false;
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRoleID());
            ps.setInt(5, user.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi updateUserProfile: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
