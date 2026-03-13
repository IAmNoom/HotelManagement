<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String cbCtx=request.getContextPath(); %>
    <link rel="stylesheet" href="<%=cbCtx%>/assets/css/chatbot.css" />

    <div id="chatbot-toggle-btn" class="chatbot-toggle-btn">
        <img src="<%=cbCtx%>/assets/img/chatbot-icon.svg" alt="Icon Chatbot" style="width: 28px; height: 28px;" />
    </div>

    <div id="chatbot-window" class="chatbot-window hidden">
        <div class="chatbot-header">
            <div class="chatbot-title">
                <span class="chatbot-avatar">🤖</span>
                <span>Hotel Assistant</span>
            </div>
            <button id="chatbot-close-btn" class="chatbot-close-btn">&times;</button>
        </div>

        <div id="chatbot-messages" class="chatbot-messages">
            <div class="chat-msg bot-msg">
                <div class="msg-content">Xin chào! Tôi là trợ lý ảo của khách sạn. Tôi có thể giúp gì cho bạn? </div>
            </div>
        </div> 

        <div class="chatbot-input-area">
            <input type="text" id="chatbot-input" placeholder="Nhập câu hỏi..." autocomplete="off" />
            <button id="chatbot-send-btn">Gửi</button>
        </div>
    </div>

    <script>
        const CHATBOT_API_URL = '<%=cbCtx%>/chatbot'; 
    </script>
    <script src="<%=cbCtx%>/assets/js/chatbot.js"></script>