<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Topics" scope="request"/>
<%@ include file="admin-header.jsp" %>

<div class="admin-two-col">
    <!-- Topics List -->
    <div class="admin-table-section">
        <div class="table-header">
            <h3>All Topics</h3>
        </div>
        <table class="admin-table">
            <thead>
                <tr><th>#</th><th>Icon</th><th>Name</th><th>Slug</th><th>Stories</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:forEach var="t" items="${topics}">
                    <tr>
                        <td>${t.id}</td>
                        <td><i class="fas ${t.icon}" style="color:${t.color}; font-size:1.2rem"></i></td>
                        <td>${t.name}</td>
                        <td><code>${t.slug}</code></td>
                        <td>${t.storyCount}</td>
                        <td>
                            <button class="action-edit" onclick="fillTopicForm(${t.id},'${t.name}','${t.description}','${t.icon}','${t.color}')" title="Edit">
                                <i class="fas fa-pen"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add/Edit Topic Form -->
    <div class="admin-form-card">
        <h3 id="topicFormTitle"><i class="fas fa-plus-circle"></i> Add Topic</h3>
        <form method="POST" action="${pageContext.request.contextPath}/admin/topic/save" class="admin-story-form">
            <input type="hidden" name="id" id="topicId">

            <div class="form-group">
                <label>Topic Name <span class="required">*</span></label>
                <input type="text" name="name" id="topicName" required placeholder="e.g. Vedic Period">
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" id="topicDesc" rows="3" placeholder="Brief description..."></textarea>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Font Awesome Icon Class</label>
                    <input type="text" name="icon" id="topicIcon" placeholder="fa-landmark">
                </div>
                <div class="form-group">
                    <label>Accent Color</label>
                    <input type="color" name="color" id="topicColor" value="#C8860A">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn-cancel" onclick="resetTopicForm()">
                    <i class="fas fa-times"></i> Reset
                </button>
                <button type="submit" class="btn-save">
                    <i class="fas fa-save"></i> Save Topic
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="admin-footer.jsp" %>
