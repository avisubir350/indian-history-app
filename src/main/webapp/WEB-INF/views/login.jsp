<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Login" scope="request"/>
<%@ include file="header.jsp" %>

<div class="auth-page">
    <div class="auth-visual">
        <div class="auth-visual-content">
            <span class="auth-symbol">☸</span>
            <h2>Welcome Back</h2>
            <p>Continue your journey through India's incredible history</p>
            <div class="auth-quotes">
                <blockquote>"India is not a nation, nor a country. It is a subcontinent of nationalities."</blockquote>
            </div>
        </div>
    </div>

    <div class="auth-form-wrap">
        <div class="auth-form-box">
            <h2 class="auth-title">Sign In</h2>
            <p class="auth-sub">Enter your credentials to continue</p>

            <c:if test="${not empty error}">
                <div class="alert alert-error"><i class="fas fa-circle-exclamation"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="fas fa-circle-check"></i> ${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/login" method="POST" class="auth-form">
                <div class="form-group">
                    <label for="identifier"><i class="fas fa-user"></i> Username or Email</label>
                    <input type="text" id="identifier" name="identifier" required placeholder="Enter username or email"
                           value="${param.identifier}">
                </div>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <div class="password-wrap">
                        <input type="password" id="password" name="password" required placeholder="Enter password">
                        <button type="button" class="toggle-pw" onclick="togglePassword('password')">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-right-to-bracket"></i> Sign In
                </button>
            </form>

            <p class="auth-switch">Don't have an account?
                <a href="${pageContext.request.contextPath}/auth/register">Create one free</a>
            </p>

            <div class="admin-hint">
                <i class="fas fa-info-circle"></i>
                Admin demo: <strong>admin</strong> / <strong>Admin@123</strong>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
