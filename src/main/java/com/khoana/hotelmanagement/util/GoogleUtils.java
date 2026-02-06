package com.khoana.hotelmanagement.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.khoana.hotelmanagement.model.GoogleUser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class GoogleUtils {

    public static final String GOOGLE_CLIENT_ID = "564583690749-82fah1b28gfo5v8mi91qs309uc9a2n5n.apps.googleusercontent.com";
    public static final String GOOGLE_CLIENT_SECRET = "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";

    // Link này phải trùng KHỚP 100% với link trong Google Cloud Console
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8081/HotelManagement/login-google";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://oauth2.googleapis.com/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    // 1. Lấy Access Token từ Code
    public static String getToken(String code) throws IOException {
        URL url = new URL(GOOGLE_LINK_GET_TOKEN);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        // encode redirect_uri để tránh lỗi ký tự
        String params = "client_id=" + GOOGLE_CLIENT_ID
                + "&client_secret=" + GOOGLE_CLIENT_SECRET
                + "&code=" + code
                + "&redirect_uri=" + URLEncoder.encode(GOOGLE_REDIRECT_URI, StandardCharsets.UTF_8.toString())
                + "&grant_type=" + GOOGLE_GRANT_TYPE;

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes());
            os.flush();
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            JsonObject jobj = new Gson().fromJson(response.toString(), JsonObject.class);
            return jobj.get("access_token").getAsString();
        } else {
            // Đọc lỗi chi tiết từ Google nếu thất bại (Quan trọng để debug)
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            System.out.println("Google Token Error: " + response.toString());
            throw new IOException("Failed to get token. Server response: " + responseCode);
        }
    }

    // 2. Lấy thông tin User từ Token
    public static GoogleUser getUserInfo(String accessToken) throws IOException {
        String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
        URL url = new URL(link);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            return new Gson().fromJson(response.toString(), GoogleUser.class);
        } else {
            throw new IOException("Failed to get user info. Response Code: " + responseCode);
        }
    
    }
}