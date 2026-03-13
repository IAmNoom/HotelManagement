package com.khoana.hotelmanagement.controller.main;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.khoana.hotelmanagement.dal.RoomDAO;
import com.khoana.hotelmanagement.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ChatbotServlet", urlPatterns = { "/chatbot" })
public class ChatbotServlet extends HttpServlet {

    private static final String GEMINI_API_KEY = "AIzaSyDy8xB3itsD7looqHDdhX8lg2zmu-LDDdk";
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
            + GEMINI_API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userMessage = request.getParameter("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            sendResponse(response, "error", "Tin nhắn rỗng.");
            return;
        }

        try {
            // 1. Lấy dữ liệu từ Database (Vd: danh sách các phòng đang trống)
            RoomDAO roomDAO = new RoomDAO();
            List<Room> allRooms = roomDAO.getAllRooms();
            StringBuilder contextData = new StringBuilder();
            contextData.append("Các phòng của khách sạn để bạn tham khảo tư vấn:\n");

            for (Room r : allRooms) {
                if ("Available".equalsIgnoreCase(r.getStatus())) {
                    contextData.append("- Phòng ").append(r.getRoomNumber())
                            .append(" (Hạng: ").append(r.getTypeName())
                            .append("), Giá: ").append(r.getPrice())
                            .append(" VND. Tình trạng: Trống.\n");
                }
            }

            // Thêm thông tin tĩnh về khách sạn để AI trả lời phong phú hơn
            contextData.append("\nThông tin chung về khách sạn Hotel:\n")
                    .append("- Địa chỉ: Ngũ Hành Sơn - Đà Nẵng.\n")
                    .append("- Điện thoại liên hệ: 0123 456 789.\n")
                    .append("- Email: info@abcd.com.\n")
                    .append("- Thời gian Check-in: 14:00, Check-out: 12:00.\n")
                    .append("- Các tiện ích và Dịch vụ: Hồ bơi ngoài trời miễn phí, Spa thư giãn, ...\n")
                    .append("- Nhà hàng phụ vụ Buffet sáng và nhà hàng với các món Á - Âu.\n");

            // 2. System Prompt
            String systemPrompt = "Bạn là nhân viên tư vấn ảo của hệ thống quản lý khách sạn. "
                    + "Nhiệm vụ của bạn là tư vấn các loại phòng, kiểm tra phòng trống, và hướng dẫn đặt phòng dựa trên dữ liệu được cung cấp. "
                    + "Tuyệt đối không được trả lời bất cứ câu hỏi nào không liên quan đến khách sạn, đặt phòng, hoặc dịch vụ lưu trú. "
                    + "Nếu người dùng hỏi về các chủ đề khác, bạn phải trả lời nguyên văn câu sau: 'Xin lỗi. Tôi chỉ là một trợ lý về hotel, không thể trả lời về vấn đề khác.'."
                    + "\n\n" + contextData.toString()
                    + "\nHãy trả lời ngắn gọn, lịch sự, thân thiện.";

            String aiReply = callGemini(systemPrompt, userMessage);

            // 3. Trả kết quả về Frontend
            sendResponse(response, "success", aiReply);

        } catch (Exception e) {
            e.printStackTrace();
            sendResponse(response, "error", "Lỗi server: " + e.getMessage());
        }
    }

    private String callGemini(String systemPrompt, String userMessage) throws Exception {
        URL url = new URL(GEMINI_API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        // Cấu trúc JSON cho Gemini
        JsonObject requestBody = new JsonObject();

        // 1. Cấu hình System Instruction (Học dữ liệu)
        JsonObject systemInstruction = new JsonObject();
        JsonObject systemParts = new JsonObject();
        systemParts.addProperty("text", systemPrompt);
        JsonArray systemPartsArr = new JsonArray();
        systemPartsArr.add(systemParts);
        systemInstruction.add("parts", systemPartsArr);
        requestBody.add("system_instruction", systemInstruction);

        // 2. Nội dung người dùng hỏi
        JsonArray contents = new JsonArray();
        JsonObject userContent = new JsonObject();
        userContent.addProperty("role", "user");

        JsonObject userParts = new JsonObject();
        userParts.addProperty("text", userMessage);
        JsonArray userPartsArr = new JsonArray();
        userPartsArr.add(userParts);

        userContent.add("parts", userPartsArr);
        contents.add(userContent);

        requestBody.add("contents", contents);

        Gson gson = new Gson();
        String jsonInputString = gson.toJson(requestBody);

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        // Đọc Response từ Gemini
        int responseCode = conn.getResponseCode();
        BufferedReader br;
        if (responseCode >= 200 && responseCode <= 299) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
        }

        StringBuilder responseBuilder = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            responseBuilder.append(line);
        }
        br.close();

        String responseStr = responseBuilder.toString();

        if (responseCode >= 200 && responseCode <= 299) {
            // Parse kết quả JSON của Gemini
            JsonObject jsonResponse = JsonParser.parseString(responseStr).getAsJsonObject();
            JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
            if (candidates != null && candidates.size() > 0) {
                JsonObject contentObj = candidates.get(0).getAsJsonObject().getAsJsonObject("content");
                JsonArray parts = contentObj.getAsJsonArray("parts");
                if (parts != null && parts.size() > 0) {
                    return parts.get(0).getAsJsonObject().get("text").getAsString();
                }
            }
        } else {
            System.out.println("Gemini Error: " + responseStr);
            throw new Exception("Lỗi gọi Gemini API (" + responseCode + "): " + responseStr);
        }

        return "Xin lỗi, hiện tại tôi không thể phản hồi.";
    }

    private void sendResponse(HttpServletResponse response, String status, String reply) throws IOException {
        JsonObject json = new JsonObject();
        json.addProperty("status", status);
        json.addProperty("reply", reply);

        Gson gson = new Gson();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(json));
    }
}
