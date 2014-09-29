<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>Demo of Sessions Using JSP</title>
</head>
 
<body>
  <h1>UH CAS Demonstration Client Application</h1>
  <%@ include file="cas-handler.jsp" %>      
  <%
  
  String frontPage  = request.getRequestURL().toString(); 
  println("requestUrl: " + request.getRequestURL());
  //String frontPage  = "http://localhost:8080/casjspdemo"; 
  String insidePage = "https://localhost:8443/casjspdemo/index.jsp";
  final String serviceURL = insidePage;  
  final String weblogin   = "https://cas-test.its.hawaii.edu/cas";
  final String logoutUrl = "https://cas-test.its.hawaii.edu/cas/logout";
  
  String uid = doCasLogin(request, response, weblogin, frontPage, serviceURL);
  
  // handle other actions like logging off
  String logoff = request.getParameter("logoff");
  if (logoff != null) {
	  println("logging off and invalidating session");
      session.invalidate();
      response.sendRedirect(logoutUrl);
      return;  
  }
  
  // The main part: show the front page or the inside protected page.
  if (uid == null) { // not logged in --> the outside page
      // show login link
      String loginLink   = weblogin + "/login?service=" + serviceURL;
      println("setting loginLink to = " + loginLink);
      println("not logged in yet; showing welcome page");
  %>
  
      <p>Welcome!</p>     
      <c:set var="vLoginLink" value="<%= loginLink %>" />    
      <p>Please <a href="<c:out value="${vLoginLink}"/>">login securely</a> 
      by clicking on the link.</p>                  
  <%
  }
  else {  // logged in --> the inside protected page
      // show the number of times the user visited me
      Integer visits = (Integer) session.getAttribute("visits");
      if (visits == null) {
          visits = new Integer(1);
          println("first visit");
      }
      else {
          visits = new Integer(visits.intValue() + 1);
          println("bumped visits to " + visits);
      }
      session.setAttribute("visits", visits);
  %>
      <p> Welcome, <%= uid %> </p>
      <p> Number of visits = <%= visits.toString() %></p>
      <p><a href="<%= frontPage %>"> do it again </a></p>
      <p><a href="<%= frontPage + "?logoff" %>">log off (clear session)</a></p>
  <%
  } // else {  // logged in --> the inside protected page
  %>
  <c:if test="${not empty uhuid}">UH Username: ${uhuid}</c:if>
  <p>
  <%= (new java.util.Date()).toLocaleString() %>
  </p>
  </body>
</html>
