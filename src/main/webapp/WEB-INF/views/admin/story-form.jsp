<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty story ? 'Add Story' : 'Edit Story'}" scope="request"/>
<%@ include file="admin-header.jsp" %>

<div class="admin-form-page">
    <div class="admin-form-card">
        <h2 class="form-card-title">
            <i class="fas ${empty story ? 'fa-plus-circle' : 'fa-pen-to-square'}"></i>
            ${empty story ? 'Add New Story' : 'Edit Story'}
        </h2>

        <form method="POST" action="${pageContext.request.contextPath}/admin/story/save" class="admin-story-form">
            <c:if test="${not empty story}">
                <input type="hidden" name="id" value="${story.id}">
            </c:if>

            <div class="form-row">
                <div class="form-group">
                    <label>Topic / Era <span class="required">*</span></label>
                    <select name="topicId" required class="form-select">
                        <option value="">-- Select Topic --</option>
                        <c:forEach var="t" items="${topics}">
                            <option value="${t.id}" ${story.topicId == t.id ? 'selected' : ''}>
                                ${t.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Historical Era / Period</label>
                    <input type="text" name="era" value="${story.era}" placeholder="e.g. 1556–1605 CE">
                </div>
            </div>

            <div class="form-group">
                <label>Story Title <span class="required">*</span></label>
                <input type="text" name="title" required value="${story.title}" placeholder="Enter a compelling title...">
            </div>

            <div class="form-group">
                <label>Summary / Excerpt</label>
                <textarea name="summary" rows="3" placeholder="Brief description shown in story cards...">${story.summary}</textarea>
            </div>

            <div class="form-group">
                <label>Full Content <span class="required">*</span> <small>(HTML supported)</small></label>
                <textarea name="content" id="storyContent" rows="18" required
                          placeholder="Write the full story here. You can use HTML tags like &lt;p&gt;, &lt;h3&gt;, &lt;strong&gt;, &lt;em&gt; etc.">${story.content}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Cover Image URL</label>
                    <input type="url" name="imageUrl" value="${story.imageUrl}" placeholder="https://example.com/image.jpg">
                </div>
                <div class="form-group form-group-checkbox">
                    <label class="checkbox-label">
                        <input type="checkbox" name="isPublished" ${story.published ? 'checked' : ''}>
                        <span class="checkbox-custom"></span>
                        Publish immediately
                    </label>
                </div>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/stories" class="btn-cancel">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn-save">
                    <i class="fas fa-save"></i> Save Story
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="admin-footer.jsp" %>
