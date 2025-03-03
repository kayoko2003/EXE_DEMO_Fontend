<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: kttan
  Date: 6/2/2024
  Time: 3:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <!-- Fontawesome CDN Link -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

    <!-- Google Fonts -->
    <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
    />
    <!-- MDB -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.min.css"
            rel="stylesheet"
    />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common/home.css">
    <style>
        .i {
            background: #0CA4F6;
            display: flex;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            align-content: center;
            justify-content: center;
            margin-left: 210px;
        }

        .footer {
            margin-top: 50px;
        }
        .banner {
            position: relative;
            width: 100%;
            height: 850px;
            margin: 10px 30px 20px 0;
            justify-content: center;
            box-shadow: 4px 6px 8px rgba(0, 0, 0, 0.6);
        }
        .banner img {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>

<section class="banner">
    <img src="${pageContext.request.contextPath}/img/home/1.png" class="active">
    <img src="${pageContext.request.contextPath}/img/home/2.png">
</section>

<div class="show-top-mentor">
    <h1>Top Gia sư</h1>
    <div class="wrapper">
        <i id="left" class="fa-solid fa-angle-left angle"></i>
        <ul class="carousel">
            <c:forEach items="${requestScope.mentor}" var="m">
                <li class="card" onclick="changeToMentorProfile('${m.account.id}')">
                    <div class="img"><img src="${pageContext.request.contextPath}/${m.account.avatar}" alt="img" draggable="false"></div>
                    <h2>${m.account.name}</h2>
                    <div class="rate-follower">
                        <div class="stars-outer rate col-md-9">
                            <div class="stars-inner" data-rating="${m.rating}"></div>
                        </div>
                        <div class="col-md-9 booking">
                            <i class="fa-solid fa-user-graduate"></i> ${m.totalBookings}
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <i id="right" class="fa-solid fa-angle-right angle"></i>
    </div>
</div>

<div class="stakeholder">
    <h2>Doanh nghiệp đồng hành</h2>
    <h4>Hơn 200 doanh nghiệp, tổ chức phi chính phủ và câu lạc bộ sinh viên</h4>
    <div class="img">
        <img src="${pageContext.request.contextPath}/img/stakeholder.jpg">
    </div>
</div>
<div class="benefit">
    <h5>Lợi ích</h5>
    <h3>Những gì bạn nhận được khi học tại Frog Community</h3>
    <div class="row detail">
        <div class="col-md-4">
            <div class="i"><i class="fa-solid fa-thumbs-up" style="color: #63E6BE;"></i></div>
            <h4>Gia sư uy tín</h4>
            <h6>Gia sư đến từ các trường đại học hàng đầu, công ty lớn</h6>
        </div>
        <div class="col-md-4">
            <div class="i"><i class="fa-solid fa-book" style="color: #63E6BE;"></i></div>
            <h4>Lộ trình bài bản</h4>
            <h6>Được xây dựng qua nhiều năm giảng dạy</h6>
        </div>
        <div class="col-md-4">
            <div class="i"><i class="fa-solid fa-users" style="color: #63E6BE;"></i></div>
            <h4>Kết nối & chia sẻ</h4>
            <h6>Kết nối với cộng đồng học viên rộng lớn</h6>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="section-container footer-container">
        <div class="footer-col">
            <h3>FROG COMMUNITY</h3>
            <p>Frog Community là nền tảng đặt lịch học với gia sư một cách thuận tiện và dễ dàng.</p>
        </div>
        <div class="footer-col">
            <h4>Công ty</h4>
            <p>Về chúng tôi</p>
            <p>Đội ngũ</p>
            <p>Blog</p>
            <p>Liên hệ</p>
        </div>
        <div class="footer-col">
            <h4>Pháp lý</h4>
            <p>Câu hỏi thường gặp</p>
            <p>Điều khoản</p>
            <p>Chính sách bảo mật</p>
        </div>
    </div>
</footer>
<script>
    const wrapper = document.querySelector(".wrapper");
    const carousel = document.querySelector(".carousel");
    const firstCardWidth = carousel.querySelector(".card").offsetWidth;
    const arrowBtns = document.querySelectorAll(".wrapper i");
    const carouselChildrens = [...carousel.children];
    let isDragging = false, isAutoPlay = true, startX, startScrollLeft, timeoutId;
    // Get the number of cards that can fit in the carousel at once
    let cardPerView = Math.round(carousel.offsetWidth / firstCardWidth);
    // Insert copies of the last few cards to beginning of carousel for infinite scrolling
    carouselChildrens.slice(-cardPerView).reverse().forEach(card => {
        carousel.insertAdjacentHTML("afterbegin", card.outerHTML);
    });
    // Insert copies of the first few cards to end of carousel for infinite scrolling
    carouselChildrens.slice(0, cardPerView).forEach(card => {
        carousel.insertAdjacentHTML("beforeend", card.outerHTML);
    });
    // Scroll the carousel at appropriate postition to hide first few duplicate cards on Firefox
    carousel.classList.add("no-transition");
    carousel.scrollLeft = carousel.offsetWidth;
    carousel.classList.remove("no-transition");
    // Add event listeners for the arrow buttons to scroll the carousel left and right
    arrowBtns.forEach(btn => {
        btn.addEventListener("click", () => {
            carousel.scrollLeft += btn.id == "left" ? -firstCardWidth : firstCardWidth;
        });
    });
    const dragStart = (e) => {
        isDragging = true;
        carousel.classList.add("dragging");
        // Records the initial cursor and scroll position of the carousel
        startX = e.pageX;
        startScrollLeft = carousel.scrollLeft;
    }
    const dragging = (e) => {
        if(!isDragging) return; // if isDragging is false return from here
        // Updates the scroll position of the carousel based on the cursor movement
        carousel.scrollLeft = startScrollLeft - (e.pageX - startX);
    }
    const dragStop = () => {
        isDragging = false;
        carousel.classList.remove("dragging");
    }
    const infiniteScroll = () => {
        // If the carousel is at the beginning, scroll to the end
        if(carousel.scrollLeft === 0) {
            carousel.classList.add("no-transition");
            carousel.scrollLeft = carousel.scrollWidth - (2 * carousel.offsetWidth);
            carousel.classList.remove("no-transition");
        }
        // If the carousel is at the end, scroll to the beginning
        else if(Math.ceil(carousel.scrollLeft) === carousel.scrollWidth - carousel.offsetWidth) {
            carousel.classList.add("no-transition");
            carousel.scrollLeft = carousel.offsetWidth;
            carousel.classList.remove("no-transition");
        }
        // Clear existing timeout & start autoplay if mouse is not hovering over carousel
        clearTimeout(timeoutId);
        if(!wrapper.matches(":hover")) autoPlay();
    }
    const autoPlay = () => {
        if(window.innerWidth < 800 || !isAutoPlay) return; // Return if window is smaller than 800 or isAutoPlay is false
        // Autoplay the carousel after every 2500 ms
        timeoutId = setTimeout(() => carousel.scrollLeft += firstCardWidth, 2500);
    }
    autoPlay();
    carousel.addEventListener("mousedown", dragStart);
    carousel.addEventListener("mousemove", dragging);
    document.addEventListener("mouseup", dragStop);
    carousel.addEventListener("scroll", infiniteScroll);
    wrapper.addEventListener("mouseenter", () => clearTimeout(timeoutId));
    wrapper.addEventListener("mouseleave", autoPlay);

    document.addEventListener('DOMContentLoaded', function() {
        const slides = document.querySelectorAll('.banner img');
        let currentSlide = 0;
        const slideInterval = setInterval(nextSlide, 2000);

        function nextSlide() {
            slides[currentSlide].classList.remove('active');
            currentSlide = (currentSlide + 1) % slides.length;
            slides[currentSlide].classList.add('active');
        }
    });

    document.addEventListener('DOMContentLoaded', () => {
        const starsTotal = 5;

        // Get all star rating elements
        const starContainers = document.querySelectorAll('.stars-inner');

        starContainers.forEach(starsInner => {
            // Get the rating from the data-rating attribute
            const rating = parseFloat(starsInner.getAttribute('data-rating'));
            console.log(starsInner.getAttribute('data-rating'));
            // Calculate the percentage of stars to fill
            const starPercentage = (rating / starsTotal) * 100;

            // Set the width of the stars-inner to the calculated percentage
            starsInner.style.width = starPercentage + '%';
        });
    })

    function changeToMentorProfile(id) {
        window.location.href = 'mentor/profile?mentor' +
            'id='+ id;
    }

</script>
<!-- MDB -->
<script
        type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.3.0/mdb.umd.min.js"
></script>
</body>
</html>
