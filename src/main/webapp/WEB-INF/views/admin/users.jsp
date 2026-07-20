<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Users" scope="request"/>
<%@ include file="admin-header.jsp" %>

<div class="admin-table-section">
    <div class="table-header">
        <h3>All Registered Users</h3>
        <input type="text" id="userSearch" placeholder="Filter users..." class="table-filter-input" onkeyup="filterUsers()">
    </div>
    <table class="admin-table" id="usersTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Joined</th>
                <th>Last Login</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.fullName}</td>
                    <td><strong>${u.username}</strong></td>
                    <td>${u.email}</td>
                    <td>
                        <span class="role-badge ${u.role == 'ADMIN' ? 'admin' : 'user'}">
                            ${u.role}
                        </span>
                    </td>
                    <td>${u.createdAt}</td>
                    <td>${u.lastLogin != null ? u.lastLogin : 'Never'}</td>
                    <td>
                        <span class="status-badge ${u.active ? 'published' : 'draft'}">
                            ${u.active ? 'Active' : 'Banned'}
                        </span>
                    </td>
                    <td>
                        <c:if test="${u.role != 'ADMIN'}">
                            <form method="POST" action="${pageContext.request.contextPath}/admin/user/toggle" style="display:inline">
                                <input type="hidden" name="id" value="${u.id}">
                                <button type="submit" class="${u.active ? 'action-delete' : 'action-edit'}"
                                        title="${u.active ? 'Ban User' : 'Activate User'}"
                                        onclick="return confirm('${u.active ? 'Ban' : 'Activate'} this user?')">
                                    <i class="fas ${u.active ? 'fa-ban' : 'fa-circle-check'}"></i>
                                </button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="admin-footer.jsp" %>
