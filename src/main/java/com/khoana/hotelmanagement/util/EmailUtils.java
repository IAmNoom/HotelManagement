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

    public static boolean sendEmail(String toEmail, String subject, String body) {
        // Ưu tiên sử dụng IPv4 để tránh lỗi kết nối mạng trên một số môi trường Windows
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
            // Thiết lập người gửi và tên hiển thị (Hỗ trợ tiếng Việt)
            msg.setFrom(new InternetAddress(EMAIL_FROM, "Hotel Management Admin", "UTF-8"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // Thiết lập tiêu đề và nội dung hỗ trợ HTML/UTF-8
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
}
