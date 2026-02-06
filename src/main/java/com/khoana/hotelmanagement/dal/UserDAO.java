package com.khoana.hotelmanagement.dal;

import com.khoana.hotelmanagement.model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
    public void register(String fullName, String email, String password) {
        String sql = "INSERT INTO Users (fullName, email, password, roleID) VALUES (?, ?, ?, 2)";
        try {
            if (connection == null) {
                return;
            }

            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, fullName);
            st.setString(2, email);
            st.setString(3, password);
            st.executeUpdate();

            System.out.println("Đã đăng ký thành công user: " + email);
        } catch (SQLException e) {
            System.out.println("Lỗi register: " + e.getMessage());
            e.printStackTrace();
        }
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

    // 6. MỚI: Hàm Đăng ký cho người dùng từ Google (Không có password)
    public void registerGoogleUser(String fullName, String email) {
        // Gán một mật khẩu mặc định (ví dụ rỗng hoặc một chuỗi cố định)
        // Lưu ý: Đảm bảo cột 'password' trong DB cho phép rỗng (NULL) HOẶC sử dụng giá trị mặc định.
        // Ở đây tôi truyền một chuỗi rỗng để tránh lỗi NULL nếu DB bắt buộc.
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
}
