package com.khoana.hotelmanagement.dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "Hh121213";
            // Thêm loginTimeout=10 để không bị treo web nếu sai cổng hoặc sai pass
            String url = "jdbc:sqlserver://localhost:1433;databaseName=MarriottClone;encrypt=true;trustServerCertificate=true;loginTimeout=10;";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);

        } catch (ClassNotFoundException | SQLException ex) {
            // In lỗi chi tiết ra màn hình Output để dễ sửa
            System.out.println("Lỗi kết nối DB:");
            ex.printStackTrace();
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Hàm main để test kết nối nhanh (Chuột phải file này -> Run File)
    public static void main(String[] args) {
        try {
            System.out.println("Đang thử kết nối đến SQL Server...");
            DBContext db = new DBContext();
            if (db.connection != null) {
                System.out.println("Kết nối thành công!");
            } else {
                System.out.println("Kết nối thất bại! (Kiểm tra lại Pass 'sa' hoặc TCP/IP 1433)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
