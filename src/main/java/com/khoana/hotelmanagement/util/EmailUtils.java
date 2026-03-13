package com.khoana.hotelmanagement.util;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

    private static final String EMAIL_FROM = "hoangchanelqbvn@gmail.com";
    private static final String APP_PASSWORD = "hcml isdn ocew aeus";

    public static String generateOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    // Hàm gửi email nền tảng (Giữ nguyên code chuẩn của bạn)
    public static boolean sendEmail(String toEmail, String subject, String body) {
        System.setProperty("java.net.preferIPv4Stack", "true");

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, APP_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(EMAIL_FROM, "Hotel Management Admin", "UTF-8"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            msg.setSubject(subject, "UTF-8");
            msg.setContent(body, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println("✅ GỬI MAIL THÀNH CÔNG TỚI: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("❌ LỖI GỬI MAIL: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // THÊM MỚI: Hàm chuyên dụng tạo HTML và gửi email xác nhận đặt phòng
    public static boolean sendBookingConfirmEmail(String toEmail, String customerName, String roomName, String checkin, String checkout, double totalAmount) {
        String subject = "Xác nhận đặt phòng thành công - Marriott Hotel";

        // Thiết kế khung HTML cho Email trông thật xịn xò
        String htmlBody = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #ddd; padding: 20px; border-radius: 10px;'>"
                + "<h2 style='color: #0056b3; text-align: center;'>Xác Nhận Đặt Phòng</h2>"
                + "<p>Xin chào <b>" + customerName + "</b>,</p>"
                + "<p>Cảm ơn bạn đã tin tưởng và đặt phòng tại hệ thống của chúng tôi. Dưới đây là thông tin chi tiết kỳ nghỉ của bạn:</p>"
                + "<table style='width: 100%; border-collapse: collapse; margin-top: 15px;'>"
                + "<tr><td style='padding: 8px; border-bottom: 1px solid #eee;'><b>Phòng:</b></td><td style='padding: 8px; border-bottom: 1px solid #eee;'>" + roomName + "</td></tr>"
                + "<tr><td style='padding: 8px; border-bottom: 1px solid #eee;'><b>Nhận phòng:</b></td><td style='padding: 8px; border-bottom: 1px solid #eee;'>" + checkin + "</td></tr>"
                + "<tr><td style='padding: 8px; border-bottom: 1px solid #eee;'><b>Trả phòng:</b></td><td style='padding: 8px; border-bottom: 1px solid #eee;'>" + checkout + "</td></tr>"
                + "<tr><td style='padding: 8px; border-bottom: 1px solid #eee;'><b>Tổng tiền thanh toán:</b></td><td style='padding: 8px; border-bottom: 1px solid #eee;'><span style='color: #d9534f; font-weight: bold; font-size: 16px;'>" + String.format("%,.0f", totalAmount) + " VNĐ</span></td></tr>"
                + "</table>"
                + "<p style='margin-top: 20px;'>Vui lòng xuất trình email này cho lễ tân khi làm thủ tục nhận phòng. Nếu cần hỗ trợ thêm, hãy liên hệ ngay với chúng tôi.</p>"
                + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>"
                + "<p style='text-align: center; color: #888; font-size: 12px;'><i>Trân trọng,<br>Ban Quản Lý Marriott Hotel</i></p>"
                + "</div>";

        // Gọi lại hàm sendEmail có sẵn của bạn để thực thi
        return sendEmail(toEmail, subject, htmlBody);
    }
}
