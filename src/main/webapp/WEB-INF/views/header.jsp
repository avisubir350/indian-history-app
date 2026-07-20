<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle.concat(' | ') : ''}भारत की कहानियाँ — Indian History</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Lora:ital,wght@0,400;0,600;1,400&family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<!-- ── Top Navigation ────────────────────────────────────── -->
<nav class="navbar">
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/" class="brand">
            <span class="brand-symbol">☸</span>
            <span class="brand-text">
                <span class="brand-main">Bharata Katha</span>
                <span class="brand-sub">भारत की कहानियाँ</span>
            </span>
        </a>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/topics">Topics</a>
            <a href="${pageContext.request.contextPath}/search">Search</a>

            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                    <c:if test="${sessionScope.loggedUser.admin}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-admin">
                            <i class="fas fa-shield-halved"></i> Admin
                        </a>
                    </c:if>
                    <div class="user-menu">
                        <span class="user-name"><i class="fas fa-user-circle"></i> ${sessionScope.loggedUser.fullName}</span>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">Logout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/login"    class="btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn-register">Join Free</a>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Mobile menu toggle -->
        <button class="hamburger" onclick="toggleMobileMenu()"><i class="fas fa-bars"></i></button>
    </div>

    <!-- Mobile dropdown -->
    <div class="mobile-menu" id="mobileMenu">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/topics">Topics</a>
        <a href="${pageContext.request.contextPath}/search">Search</a>
        <c:choose>
            <c:when test="${not empty sessionScope.loggedUser}">
                <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/auth/login">Login</a>
                <a href="${pageContext.request.contextPath}/auth/register">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
