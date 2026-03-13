// chatbot.js
document.addEventListener('DOMContentLoaded', () => {
    const toggleBtn = document.getElementById('chatbot-toggle-btn');
    const closeBtn = document.getElementById('chatbot-close-btn');
    const chatWindow = document.getElementById('chatbot-window');
    const chatInput = document.getElementById('chatbot-input');
    const sendBtn = document.getElementById('chatbot-send-btn');
    const messagesContainer = document.getElementById('chatbot-messages');

    // Toggle Chat Window
    toggleBtn.addEventListener('click', () => {
        chatWindow.classList.remove('hidden');
        chatInput.focus();
    });

    closeBtn.addEventListener('click', () => {
        chatWindow.classList.add('hidden');
    });

    // Handle Send Message
    const sendMessage = async () => {
        const text = chatInput.value.trim();
        if (!text) return;

        // 1. Add user message to UI
        appendMessage('user', text);
        chatInput.value = '';

        // 2. Show loading indicator
        const loadingId = showLoading();

        try {
            // 3. Send request to server
            // Note: CHATBOT_API_URL is defined in chatbot.jsp
            const response = await fetch(CHATBOT_API_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({ message: text })
            });

            const data = await response.json();

            // 4. Remove loading indicator
            removeLoading(loadingId);

            // 5. Build bot message from response
            if (data.status === 'success') {
                appendMessage('bot', data.reply);
            } else {
                appendMessage('bot', 'Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại sau.');
            }

        } catch (error) {
            console.error('Chatbot Error:', error);
            removeLoading(loadingId);
            appendMessage('bot', 'Không thể kết nối với máy chủ. Vui lòng kiểm tra kết nối mạng.');
        }
    };

    // Events for sending
    sendBtn.addEventListener('click', sendMessage);
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });

    // Helper to append message bubble
    function appendMessage(sender, text) {
        const msgDiv = document.createElement('div');
        msgDiv.className = `chat-msg ${sender}-msg`;

        const contentDiv = document.createElement('div');
        contentDiv.className = 'msg-content';

        // Convert newlines to <br> for better formatting
        contentDiv.innerHTML = text.replace(/\n/g, '<br>');

        msgDiv.appendChild(contentDiv);
        messagesContainer.appendChild(msgDiv);
        scrollToBottom();
    }

    // Helper to show loading typing indicator
    function showLoading() {
        const id = 'loading-' + Date.now();
        const msgDiv = document.createElement('div');
        msgDiv.className = `chat-msg bot-msg`;
        msgDiv.id = id;

        const contentDiv = document.createElement('div');
        contentDiv.className = 'msg-content typing-indicator';
        contentDiv.innerHTML = '<span></span><span></span><span></span>';

        msgDiv.appendChild(contentDiv);
        messagesContainer.appendChild(msgDiv);
        scrollToBottom();
        return id;
    }

    function removeLoading(id) {
        const el = document.getElementById(id);
        if (el) {
            el.remove();
        }
    }

    function scrollToBottom() {
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
});
