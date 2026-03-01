document.addEventListener("DOMContentLoaded", function () {

  const rooms = [
    {
      image: contextPath + "/assets/img/room-1.jpg",
      title: "Studio Partial Sea View & City View",
      guest: "👤 2 người",
      size: "📐 33m²"
    },
    {
      image: contextPath + "/assets/img/room-2.jpg",
      title: "Deluxe Partial Sea View",
      guest: "👤 2 người",
      size: "📐 30m²"
    }
  ];

  const img = document.getElementById("stayImage");
  const title = document.getElementById("stayTitle");
  const guest = document.getElementById("stayGuest");
  const size = document.getElementById("staySize");
  const pages = document.querySelectorAll(".stay-page");

  let current = 0;

  function render(i) {
    current = i;
    img.src = rooms[i].image;
    title.textContent = rooms[i].title;
    guest.textContent = rooms[i].guest;
    size.textContent = rooms[i].size;

    pages.forEach(p => p.classList.remove("active"));
    pages[i].classList.add("active");
  }

  pages.forEach(btn => {
    btn.addEventListener("click", function () {
      render(Number(this.dataset.index));
    });
  });

  // (Tuỳ chọn) cho mũi tên trái phải đổi phòng luôn
  const left = document.querySelector(".stay-arrow.left");
  const right = document.querySelector(".stay-arrow.right");

  left.addEventListener("click", function(){
    render((current - 1 + rooms.length) % rooms.length);
  });

  right.addEventListener("click", function(){
    render((current + 1) % rooms.length);
  });

});