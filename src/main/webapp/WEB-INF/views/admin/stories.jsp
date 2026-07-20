<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Stories" scope="request"/>
<%@ include file="admin-header.jsp" %>

<div class="table-toolbar">
    <a href="${pageContext.request.contextPath}/admin/story/add" class="btn-add">
        <i class="fas fa-plus"></i> Add New Story
    </a>
    <input type="text" id="tableSearch" placeholder="Filter stories..." class="table-filter-input" onkeyup="filterTable()">
</div>

<div class="admin-table-section">
    <table class="admin-table" id="storiesTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Topic</th>
                <th>Era</th>
                <th>Status</th>
                <th>Views</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${stories}">
                <tr>
                    <td>${s.id}</td>
                    <td class="story-title-cell">${s.title}</td>
                    <td><span class="topic-tag">${s.topicName}</span></td>
                    <td>${s.era}</td>
                    <td>
                        <span class="status-badge ${s.published ? 'published' : 'draft'}">
                            ${s.published ? 'Published' : 'Draft'}
                        </span>
                    </td>
                    <td>${s.viewCount}</td>
                    <td>${s.createdAt}</td>
                    <td class="actions-cell">
                        <a href="${pageContext.request.contextPath}/admin/story/edit?id=${s.id}" class="action-edit" title="Edit">
                            <i class="fas fa-pen"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/story/${s.slug}" target="_blank" class="action-view" title="View">
                            <i class="fas fa-eye"></i>
                        </a>
                        <form method="POST" action="${pageContext.request.contextPath}/admin/story/delete"
                              style="display:inline" onsubmit="return confirm('Delete this story?')">
                            <input type="hidden" name="id" value="${s.id}">
                            <button type="submit" class="action-delete" title="Delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="admin-footer.jsp" %>
