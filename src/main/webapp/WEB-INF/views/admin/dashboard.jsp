<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<%@ include file="admin-header.jsp" %>

<!-- Stats Cards -->
<div class="admin-stats-grid">
    <div class="stat-card blue">
        <div class="stat-card-icon"><i class="fas fa-scroll"></i></div>
        <div class="stat-card-info">
            <span class="stat-number">${totalStories}</span>
            <span class="stat-label">Total Stories</span>
        </div>
    </div>
    <div class="stat-card saffron">
        <div class="stat-card-icon"><i class="fas fa-tags"></i></div>
        <div class="stat-card-info">
            <span class="stat-number">${totalTopics}</span>
            <span class="stat-label">Topics / Eras</span>
        </div>
    </div>
    <div class="stat-card green">
        <div class="stat-card-icon"><i class="fas fa-users"></i></div>
        <div class="stat-card-info">
            <span class="stat-number">${totalUsers}</span>
            <span class="stat-label">Registered Users</span>
        </div>
    </div>
    <div class="stat-card purple">
        <div class="stat-card-icon"><i class="fas fa-eye"></i></div>
        <div class="stat-card-info">
            <span class="stat-number">∞</span>
            <span class="stat-label">Views Today</span>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="admin-quick-actions">
    <h3>Quick Actions</h3>
    <div class="quick-actions-grid">
        <a href="${pageContext.request.contextPath}/admin/story/add" class="quick-btn">
            <i class="fas fa-plus"></i> Add New Story
        </a>
        <a href="${pageContext.request.contextPath}/admin/topics" class="quick-btn">
            <i class="fas fa-folder-plus"></i> Manage Topics
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="quick-btn">
            <i class="fas fa-users-gear"></i> Manage Users
        </a>
        <a href="${pageContext.request.contextPath}/" target="_blank" class="quick-btn">
            <i class="fas fa-globe"></i> View Website
        </a>
    </div>
</div>

<!-- Recent Stories -->
<div class="admin-table-section">
    <div class="table-header">
        <h3>Recent Stories</h3>
        <a href="${pageContext.request.contextPath}/admin/stories" class="view-all">View All</a>
    </div>
    <table class="admin-table">
        <thead>
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Topic</th>
                <th>Status</th>
                <th>Views</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${latestStories}">
                <tr>
                    <td>${s.id}</td>
                    <td class="story-title-cell">${s.title}</td>
                    <td><span class="topic-tag">${s.topicName}</span></td>
                    <td>
                        <span class="status-badge ${s.published ? 'published' : 'draft'}">
                            ${s.published ? 'Published' : 'Draft'}
                        </span>
                    </td>
                    <td>${s.viewCount}</td>
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/admin/story/edit?id=${s.id}" class="action-edit" title="Edit">
                            <i class="fas fa-pen"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/story/${s.slug}" target="_blank" class="action-view" title="View">
                            <i class="fas fa-eye"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="admin-footer.jsp" %>
