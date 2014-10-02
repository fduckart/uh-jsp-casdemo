<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="cas-handler.jsp" %>
<%

final String casUrl     = "https://cas-test.its.hawaii.edu/cas";

// Handle logout, if requested.
if (request.getParameter("logout") != null) {
    doCasLogout(request, response, casUrl + "/logout");
    return;
}

final String insidePage = "https://localhost:8443/casjspdemo/index.jsp";
final String serviceURL = URLEncoder.encode(insidePage, "UTF-8");
final String frontPage  = request.getRequestURL().toString();

doCasLogin(request, response, casUrl, frontPage, insidePage);

final String loginLink  = casUrl + "/login?service=" + serviceURL;
final String logoutLink = frontPage + "?logout";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>UH CAS Demonstration JSP</title>
</head>

<body>
    <h2>UH CAS Demonstration JSP</h2>

    <c:choose>
        <c:when test="${not empty username}">
            <p>Welcome, ${username}</p>
            <c:set var="vLogoutLink" value="<%= logoutLink %>" />
            <p><a href="<c:out value="${vLogoutLink}"/>">Log out</a></p>
        </c:when>

        <c:otherwise>
            <pWelcome!</p>
            <c:set var="vLoginLink" value="<%= loginLink %>" />
            <p>Please
               <a href="<c:out value="${vLoginLink}"/>">login securely</a>
               by clicking on the link.
            </p>
        </c:otherwise>
    </c:choose>

    <c:set var="now" value="<%=new java.util.Date()%>" />
    <p><fmt:formatDate type="both" dateStyle="medium" timeStyle="medium" value="${now}"/></p>

  </body>
</html>
