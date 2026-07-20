<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${story.title}" scope="request"/>
<%@ include file="header.jsp" %>

<div class="story-page">

    <!-- Story Header -->
    <header class="story-header">
        <div class="container">
            <!-- Breadcrumb -->
            <nav class="breadcrumb-inline">
                <a href="${pageContext.request.contextPath}/">Home</a>
                <i class="fas fa-chevron-right"></i>
                <a href="${pageContext.request.contextPath}/topics/${story.topicSlug}">${story.topicName}</a>
                <i class="fas fa-chevron-right"></i>
                <span>${story.title}</span>
            </nav>

            <div class="story-header-body">
                <div class="story-topic-pill">${story.topicName}</div>
                <h1 class="story-title">${story.title}</h1>
                <p class="story-summary">${story.summary}</p>

                <div class="story-info-bar">
                    <c:if test="${not empty story.era}">
                        <span><i class="fas fa-calendar-days"></i> ${story.era}</span>
                    </c:if>
                    <span><i class="fas fa-pen-nib"></i> ${story.authorName}</span>
                    <span><i class="fas fa-eye"></i> ${story.viewCount} views</span>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="story-body container">
        <div class="story-content">
            <!-- Featured Image -->
            <c:if test="${not empty story.imageUrl}">
                <div class="story-featured-image">
                    <img src="${story.imageUrl}" alt="${story.title}">
                </div>
            </c:if>

            <!-- Article Text -->
            <div class="story-article">
                ${story.content}
            </div>

            <!-- Navigation -->
            <div class="story-nav-footer">
                <a href="${pageContext.request.contextPath}/topics/${story.topicSlug}" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to ${story.topicName}
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn-home-link">
                    <i class="fas fa-house"></i> Home
                </a>
            </div>
        </div>

        <!-- Sidebar -->
        <aside class="story-sidebar">
            <div class="sidebar-box">
                <h4><i class="fas fa-info-circle"></i> Quick Facts</h4>
                <ul class="facts-list">
                    <c:if test="${not empty story.era}">
                        <li><strong>Period:</strong> ${story.era}</li>
                    </c:if>
                    <li><strong>Category:</strong> ${story.topicName}</li>
                    <li><strong>Author:</strong> ${story.authorName}</li>
                    <li><strong>Views:</strong> ${story.viewCount}</li>
                </ul>
            </div>

            <div class="sidebar-box share-box">
                <h4><i class="fas fa-share-nodes"></i> Share This Story</h4>
                <div class="share-buttons">
                    <button onclick="shareStory()" class="share-btn"><i class="fas fa-link"></i> Copy Link</button>
                    <span id="shareFeedback" class="share-feedback"></span>
                </div>
            </div>

            <div class="sidebar-box">
                <h4><i class="fas fa-compass"></i> Explore More</h4>
                <a href="${pageContext.request.contextPath}/topics" class="sidebar-link">
                    <i class="fas fa-list"></i> All Topics
                </a>
                <a href="${pageContext.request.contextPath}/search" class="sidebar-link">
                    <i class="fas fa-magnifying-glass"></i> Search Stories
                </a>
            </div>
        </aside>
    </div>
</div>

<%@ include file="footer.jsp" %>
