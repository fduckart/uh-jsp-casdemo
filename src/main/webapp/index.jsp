<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Demo of Sessions Using JSP</title>
</head>
 
<body>
  <h1>Web Login Demo Client Application</h1>
  <%@ include file="cas-handler.jsp" %>
  <%
  /* String frontPage  = request.getRequestURL().toString(); */
  println("requestUrl: " + request.getRequestURL());  
  String frontPage  = "http://localhost:8080/casjspdemo"; 
  String insidePage = "https://localhost:8443/casjspdemo/index.jsp";
  //final String serviceURL = URLEncoder.encode(insidePage, "UTF-8");
  final String serviceURL = insidePage;  
  final String weblogin   = "https://cas-test.its.hawaii.edu/cas";
  
  String uid = doCasLogin(request, response, weblogin, frontPage, serviceURL);
  
  // handle other actions like logging off
  String logoff = request.getParameter("logoff");
  if (logoff != null) {
	  println("logging off and invalidating session");
      session.invalidate();
      response.sendRedirect(frontPage);
      return;  // bail here or get weird results
  }
  
  // The main part: show the front page or the inside protected page.
  if (uid == null) { // not logged in --> the outside page
      // show login link
      String loginLink   = weblogin + "/login?service=" + serviceURL;
      println("setting loginLink to = " + loginLink);
      println("not logged in yet; showing welcome page");
  %>
      <p> Welcome! </p>
      <p>Please <a href="<%= loginLink %>">login securely</a> by clicking
          on the link.</p>
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
  <p>
  <%= (new java.util.Date()).toLocaleString() %>
  </p>
  </body>
</html>
