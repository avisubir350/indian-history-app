<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="${topic.name}" scope="request"/>
<%@ include file="header.jsp" %>

<!-- Topic Hero -->
<section class="topic-hero" style="--accent:${topic.color}">
    <div class="topic-hero-overlay"></div>
    <div class="container">
        <div class="topic-hero-content">
            <div class="topic-hero-icon"><i class="fas ${topic.icon}"></i></div>
            <h1>${topic.name}</h1>
            <p>${topic.description}</p>
            <span class="story-count-badge">${fn:length(stories)} Stories</span>
        </div>
    </div>
</section>

<!-- Breadcrumb -->
<div class="breadcrumb-bar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <i class="fas fa-chevron-right"></i>
        <span>${topic.name}</span>
    </div>
</div>

<!-- Stories List -->
<section class="section">
    <div class="container">
        <c:choose>
            <c:when test="${empty stories}">
                <div class="empty-state">
                    <i class="fas fa-scroll"></i>
                    <h3>No stories yet</h3>
                    <p>Check back soon — more stories are being added.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="stories-grid">
                    <c:forEach var="story" items="${stories}">
                        <article class="story-card">
                            <div class="story-card-image">
                                <c:choose>
                                    <c:when test="${not empty story.imageUrl}">
                                        <img src="${story.imageUrl}" alt="${story.title}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="story-placeholder">
                                            <i class="fas fa-landmark"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
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
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="footer.jsp" %>
