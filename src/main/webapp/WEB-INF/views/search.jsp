<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Search" scope="request"/>
<%@ include file="header.jsp" %>

<div class="search-page">
    <div class="search-hero">
        <div class="container">
            <h1><i class="fas fa-magnifying-glass"></i> Search Stories</h1>
            <p>Search across all eras, empires, and events of Indian history</p>

            <form action="${pageContext.request.contextPath}/search" method="GET" class="search-form-large">
                <input type="text" name="q" value="${keyword}" placeholder="e.g. Mughal, Ashoka, Battle of Panipat..." autofocus>
                <button type="submit"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>
    </div>

    <div class="container section">
        <c:choose>
            <c:when test="${not empty keyword and empty results}">
                <div class="empty-state">
                    <i class="fas fa-file-circle-question"></i>
                    <h3>No results found for "<em>${keyword}</em>"</h3>
                    <p>Try different keywords or browse topics.</p>
                    <a href="${pageContext.request.contextPath}/topics" class="btn-primary">Browse All Topics</a>
                </div>
            </c:when>
            <c:when test="${not empty results}">
                <h2 class="results-heading">
                    <span>${fn:length(results)}</span> result<c:if test="${fn:length(results) != 1}">s</c:if>
                    for "<em>${keyword}</em>"
                </h2>
                <div class="stories-grid">
                    <c:forEach var="story" items="${results}">
                        <article class="story-card">
                            <div class="story-card-image">
                                <c:choose>
                                    <c:when test="${not empty story.imageUrl}">
                                        <img src="${story.imageUrl}" alt="${story.title}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="story-placeholder"><i class="fas fa-scroll"></i></div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="story-topic-badge">${story.topicName}</span>
                            </div>
                            <div class="story-card-body">
                                <div class="story-meta">
                                    <c:if test="${not empty story.era}">
                                        <span class="era-tag"><i class="fas fa-clock-rotate-left"></i> ${story.era}</span>
                                    </c:if>
                                </div>
                                <h3><a href="${pageContext.request.contextPath}/story/${story.slug}">${story.title}</a></h3>
                                <p>${story.summary}</p>
                                <a href="${pageContext.request.contextPath}/story/${story.slug}" class="read-more">
                                    Read Story <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="search-suggestions">
                    <h3>Popular Searches</h3>
                    <div class="suggestion-tags">
                        <a href="?q=Mughal">Mughal Empire</a>
                        <a href="?q=Ashoka">Ashoka</a>
                        <a href="?q=Gandhi">Mahatma Gandhi</a>
                        <a href="?q=Shivaji">Shivaji</a>
                        <a href="?q=Indus">Indus Valley</a>
                        <a href="?q=1857">1857 Revolt</a>
                        <a href="?q=Akbar">Akbar</a>
                        <a href="?q=salt march">Salt March</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="footer.jsp" %>
