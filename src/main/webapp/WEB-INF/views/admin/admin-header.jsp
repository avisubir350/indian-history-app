<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — ${not empty pageTitle ? pageTitle : 'Dashboard'} | Bharata Katha</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<div class="admin-layout">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-brand">
            <span class="brand-symbol">☸</span>
            <span>Admin Panel</span>
        </div>
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="${pageTitle eq 'Dashboard' ? 'active' : ''}">
                <i class="fas fa-gauge-high"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/stories"
               class="${pageTitle eq 'Stories' ? 'active' : ''}">
                <i class="fas fa-scroll"></i> Stories
            </a>
            <a href="${pageContext.request.contextPath}/admin/story/add">
                <i class="fas fa-plus-circle"></i> Add Story
            </a>
            <a href="${pageContext.request.contextPath}/admin/topics"
               class="${pageTitle eq 'Topics' ? 'active' : ''}">
                <i class="fas fa-tags"></i> Topics
            </a>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="${pageTitle eq 'Users' ? 'active' : ''}">
                <i class="fas fa-users"></i> Users
            </a>
            <hr class="nav-divider">
            <a href="${pageContext.request.contextPath}/" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Site
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="logout-link">
                <i class="fas fa-right-from-bracket"></i> Logout
            </a>
        </nav>
        <div class="admin-user-info">
            <i class="fas fa-user-shield"></i>
            <span>${sessionScope.loggedUser.fullName}</span>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        <div class="admin-topbar">
            <h1 class="admin-page-title">${pageTitle}</h1>
            <div class="admin-topbar-right">
                <span class="admin-date" id="adminDate"></span>
            </div>
        </div>
        <div class="admin-content">
