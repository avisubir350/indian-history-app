<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-brand">
            <span class="brand-symbol large">☸</span>
            <p>Bharata Katha — Preserving the timeless stories of India's glorious past for future generations.</p>
        </div>
        <div class="footer-links">
            <h4>Explore</h4>
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/topics">All Topics</a>
            <a href="${pageContext.request.contextPath}/search">Search</a>
        </div>
        <div class="footer-links">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/auth/register">Register</a>
            <a href="${pageContext.request.contextPath}/auth/login">Login</a>
        </div>
        <div class="footer-quote">
            <blockquote>"A nation that forgets its past has no future."</blockquote>
            <cite>— Winston Churchill</cite>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2024 Bharata Katha. Built with ❤ for Indian History.</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
