<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Register" scope="request"/>
<%@ include file="header.jsp" %>

<div class="auth-page">
    <div class="auth-visual register-visual">
        <div class="auth-visual-content">
            <span class="auth-symbol">🏛</span>
            <h2>Join Bharata Katha</h2>
            <p>Unlock thousands of stories from India's 5000-year history</p>
            <ul class="auth-benefits">
                <li><i class="fas fa-check"></i> Access all historical topics</li>
                <li><i class="fas fa-check"></i> Bookmark your favourite stories</li>
                <li><i class="fas fa-check"></i> Track reading progress</li>
                <li><i class="fas fa-check"></i> 100% free forever</li>
            </ul>
        </div>
    </div>

    <div class="auth-form-wrap">
        <div class="auth-form-box">
            <h2 class="auth-title">Create Account</h2>
            <p class="auth-sub">Join thousands of history enthusiasts</p>

            <c:if test="${not empty error}">
                <div class="alert alert-error"><i class="fas fa-circle-exclamation"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/register" method="POST" class="auth-form" id="registerForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName"><i class="fas fa-id-card"></i> Full Name</label>
                        <input type="text" id="fullName" name="fullName" required placeholder="Your full name"
                               value="${param.fullName}">
                    </div>
                    <div class="form-group">
                        <label for="username"><i class="fas fa-at"></i> Username</label>
                        <input type="text" id="username" name="username" required placeholder="Choose a username"
                               value="${param.username}" pattern="[a-zA-Z0-9_]{3,20}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="your@email.com"
                           value="${param.email}">
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" id="password" name="password" required placeholder="Min. 6 characters"
                               minlength="6">
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword"><i class="fas fa-shield-halved"></i> Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Repeat password">
                    </div>
                </div>

                <!-- Password strength indicator -->
                <div class="password-strength" id="pwStrength">
                    <div class="strength-bar"><span id="strengthBar"></span></div>
                    <span id="strengthText">Enter a password</span>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>

            <p class="auth-switch">Already have an account?
                <a href="${pageContext.request.contextPath}/auth/login">Sign in here</a>
            </p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
