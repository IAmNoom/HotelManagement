document.addEventListener("DOMContentLoaded", function () {
  const mainImg = document.getElementById("svcMainImg");
  const tabs = Array.from(document.querySelectorAll(".svc-tab"));
  const sets = Array.from(document.querySelectorAll(".svc-thumbset"));
  const thumbsRoot = document.querySelector(".svc-thumbs");

  // ===== CONFIG =====
  const AUTO_PLAY = true;
  const INTERVAL_MS = 3000;      // 3s đổi 1 ảnh
  const PAUSE_ON_HOVER = false;  // để false để tránh tự dừng

  let timer = null;
  let currentService =
    tabs.find(t => t.classList.contains("active"))?.dataset.service || "pool";

  function getActiveSet(serviceKey) {
    return document.querySelector(`.svc-thumbset[data-service="${serviceKey}"]`);
  }

  function getThumbs(setEl) {
    return setEl ? Array.from(setEl.querySelectorAll(".svc-thumb")) : [];
  }

  // Cuộn NGANG bên trong thumbset, KHÔNG dùng scrollIntoView (tránh kéo trang)
  function scrollThumbIntoCenter(setEl, thumbEl) {
    if (!setEl || !thumbEl) return;

    const targetLeft = thumbEl.offsetLeft - (setEl.clientWidth - thumbEl.clientWidth) / 2;
    setEl.scrollTo({
      left: Math.max(0, targetLeft),
      behavior: "smooth"
    });
  }

  function setMain(src) {
    if (!mainImg) return;
    // fade nhẹ
    mainImg.style.opacity = "0.35";
    mainImg.src = src;

    // bảo vệ trường hợp cache khiến onload không bắn
    const done = () => (mainImg.style.opacity = "1");
    mainImg.onload = done;
    setTimeout(done, 180);
  }

  function activateService(serviceKey) {
    currentService = serviceKey;

    // active tab
    tabs.forEach(t => t.classList.toggle("active", t.dataset.service === serviceKey));

    // active thumbset
    sets.forEach(s => s.classList.toggle("active", s.dataset.service === serviceKey));

    const setEl = getActiveSet(serviceKey);
    const thumbs = getThumbs(setEl);
    if (!setEl || thumbs.length === 0) return;

    // lấy thumb active nếu có, không thì chọn thumb đầu
    let activeThumb = setEl.querySelector(".svc-thumb.active");
    if (!activeThumb) {
      thumbs.forEach(b => b.classList.remove("active"));
      activeThumb = thumbs[0];
      activeThumb.classList.add("active");
    }

    setMain(activeThumb.dataset.src);
    scrollThumbIntoCenter(setEl, activeThumb);
  }

  function setActiveThumb(setEl, thumbEl) {
    const thumbs = getThumbs(setEl);
    thumbs.forEach(b => b.classList.remove("active"));
    thumbEl.classList.add("active");

    setMain(thumbEl.dataset.src);
    scrollThumbIntoCenter(setEl, thumbEl);
  }

  function nextImage() {
    const setEl = getActiveSet(currentService);
    const thumbs = getThumbs(setEl);
    if (!setEl || thumbs.length <= 1) return; // ít nhất 2 ảnh mới thấy đổi

    const idx = Math.max(0, thumbs.findIndex(t => t.classList.contains("active")));
    const nextIdx = (idx + 1) % thumbs.length;

    setActiveThumb(setEl, thumbs[nextIdx]);
  }

  function start() {
    if (!AUTO_PLAY) return;
    stop();
    timer = setInterval(nextImage, INTERVAL_MS);
  }

  function stop() {
    if (timer) clearInterval(timer);
    timer = null;
  }

  function reset() {
    stop();
    start();
  }

  // ===== EVENTS =====
  // Click tab
  tabs.forEach(tab => {
    tab.addEventListener("click", function () {
      activateService(this.dataset.service);
      reset();
    });
  });

  // Click thumbnail (event delegation)
  thumbsRoot?.addEventListener("click", function (e) {
    const btn = e.target.closest(".svc-thumb");
    if (!btn) return;

    const setEl = btn.closest(".svc-thumbset");
    if (!setEl) return;

    const serviceKey = setEl.dataset.service;
    if (serviceKey && serviceKey !== currentService) {
      activateService(serviceKey);
    }

    setActiveThumb(setEl, btn);
    reset();
  });

  // Click ảnh lớn -> next
  mainImg?.addEventListener("click", function () {
    nextImage();
    reset();
  });

  // Optional pause on hover
  if (PAUSE_ON_HOVER) {
    const wrap = document.querySelector(".svc-stage") || document.body;
    wrap.addEventListener("mouseenter", stop);
    wrap.addEventListener("mouseleave", start);
  }

  // ===== INIT =====
  if (mainImg) mainImg.style.transition = "opacity .25s ease";
  activateService(currentService);

  // đảm bảo interval chạy sau init
  setTimeout(start, 200);
});