<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="404 Not Found" scope="request"/>
<%@ include file="header.jsp" %>
<div class="empty-state section">
    <i class="fas fa-map-signs" style="font-size:5rem;color:#E8D5B0;margin-bottom:1.5rem;display:block;text-align:center"></i>
    <h2 style="text-align:center;color:#5C3A1E">Page Not Found</h2>
    <p style="text-align:center;color:#9A6800;margin:1rem auto 2rem;max-width:400px">
        The page you're looking for has been lost to history.
    </p>
    <div style="text-align:center">
        <a href="${pageContext.request.contextPath}/" class="btn-primary">
            <i class="fas fa-house"></i> Return Home
        </a>
    </div>
</div>
<%@ include file="footer.jsp" %>
