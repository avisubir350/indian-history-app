<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Home" scope="request"/>
<%@ include file="header.jsp" %>

<!-- ── Hero Section ─────────────────────────────────────── -->
<section class="hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <div class="hero-badge">🇮🇳 Discover 5000 Years of History</div>
        <h1 class="hero-title">
            Journey Through<br>
            <span class="highlight">Incredible India</span>
        </h1>
        <p class="hero-subtitle">
            From the Indus Valley to Independence — explore the epic stories,
            legendary warriors, mighty empires, and cultural treasures that shaped the world's oldest civilisation.
        </p>
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/topics" class="btn-primary">
                <i class="fas fa-compass"></i> Explore Topics
            </a>
            <c:if test="${empty sessionScope.loggedUser}">
                <a href="${pageContext.request.contextPath}/auth/register" class="btn-secondary">
                    <i class="fas fa-user-plus"></i> Join Free
                </a>
            </c:if>
        </div>
    </div>
    <div class="hero-scroll">
        <span>Scroll to explore</span>
        <i class="fas fa-chevron-down bounce"></i>
    </div>
</section>

<!-- ── Stats Banner ──────────────────────────────────────── -->
<section class="stats-banner">
    <div class="stat-item"><span class="stat-number">5000+</span><span class="stat-label">Years of History</span></div>
    <div class="stat-item"><span class="stat-number">8</span><span class="stat-label">Major Eras</span></div>
    <div class="stat-item"><span class="stat-number">100+</span><span class="stat-label">Stories & Articles</span></div>
    <div class="stat-item"><span class="stat-number">∞</span><span class="stat-label">Knowledge to Explore</span></div>
</section>

<!-- ── Topics Grid ───────────────────────────────────────── -->
<section class="section topics-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Browse by Era</h2>
            <p class="section-subtitle">Select a chapter of India's grand story</p>
        </div>

        <div class="topics-grid">
            <c:forEach var="topic" items="${topics}">
                <a href="${pageContext.request.contextPath}/topics/${topic.slug}" class="topic-card" style="--accent:${topic.color}">
                    <div class="topic-icon-wrap">
                        <i class="fas ${topic.icon}"></i>
                    </div>
                    <div class="topic-info">
                        <h3>${topic.name}</h3>
                        <p>${topic.description}</p>
                        <span class="story-count">${topic.storyCount} Stories</span>
                    </div>
                    <div class="topic-arrow"><i class="fas fa-arrow-right"></i></div>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ── Latest Stories ────────────────────────────────────── -->
<section class="section latest-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Latest Stories</h2>
            <p class="section-subtitle">Recently added tales from India's past</p>
        </div>

        <div class="stories-grid">
            <c:forEach var="story" items="${latestStories}">
                <article class="story-card">
                    <div class="story-card-image">
                        <c:choose>
                            <c:when test="${not empty story.imageUrl}">
                                <img src="${story.imageUrl}" alt="${story.title}" loading="lazy">
                            </c:when>
                            <c:otherwise>
                                <div class="story-placeholder">
                                    <i class="fas fa-scroll"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <span class="story-topic-badge">${story.topicName}</span>
                    </div>
                    <div class="story-card-body">
                        <div class="story-meta">
                            <c:if test="${not empty story.era}">
                                <span class="era-tag"><i class="fas fa-clock-rotate-left"></i> ${story.era}</span>
                            </c:if>
                            <span class="view-tag"><i class="fas fa-eye"></i> ${story.viewCount}</span>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/story/${story.slug}">${story.title}</a></h3>
                        <p>${story.summary}</p>
                        <a href="${pageContext.request.contextPath}/story/${story.slug}" class="read-more">
                            Read Full Story <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </article>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ── Call to Action ────────────────────────────────────── -->
<c:if test="${empty sessionScope.loggedUser}">
<section class="cta-section">
    <div class="cta-content">
        <h2>Start Your Journey Into History</h2>
        <p>Create a free account to bookmark stories, track your reading, and explore India's rich heritage.</p>
        <a href="${pageContext.request.contextPath}/auth/register" class="btn-primary large">
            <i class="fas fa-user-plus"></i> Create Free Account
        </a>
    </div>
</section>
</c:if>

<%@ include file="footer.jsp" %>
