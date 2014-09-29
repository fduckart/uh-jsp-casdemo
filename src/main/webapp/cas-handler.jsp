<%@ page import="org.jasig.cas.client.validation.TicketValidator" %>
<%@ page import="org.jasig.cas.client.validation.Cas20ServiceTicketValidator" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>
<%@ page import="org.jasig.cas.client.validation.Assertion" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.xml.sax.SAXException" %>
<%@ page import="javax.xml.parsers.ParserConfigurationException" %>
<%!
// A crude logging method - entry is sent to stdout.
protected void println(String msg) {
    String ts = (new java.util.Date()).toLocaleString();
    System.out.println(ts + " " + msg);
}

// Return a uid (a.k.a., username); null if not logged in or
// can't validate the service ticket from the UH CAS Service.
protected String doCasLogin(HttpServletRequest req,
                            HttpServletResponse res,
                            String weblogin,
                            String frontPage,
                            String serviceURL)
throws Exception {
	
    HttpSession sess = req.getSession();
    String sessionId = sess.getId();
    println("sessionId = " + sessionId);

    println("this = " + this.getClass());
    
    String uid = (String) sess.getAttribute("uid");
    println("uid from session = " + uid);
    
    // if there's a service ticket, try to validate it
    String ticket = req.getParameter("ticket");
    println("got a ticket: " + ticket);
                
    if (ticket != null) {
        String validateUrl = weblogin;
        println("validateUrl: " + validateUrl);
        println("serviceURL : " + serviceURL);

        TicketValidator validator = new Cas20ServiceTicketValidator(validateUrl);
        Assertion assertion = validator.validate(ticket, serviceURL);
        println("assertion  : " + assertion);
                
        AttributePrincipal principal = assertion.getPrincipal();
        uid = principal.getName();
        println("uid from uh cas: " + uid);        
        
        println("authN successful for " + uid);
        
        sess.setAttribute("uid", uid);
        req.setAttribute("uhuid", uid);
        
        // redirect back to me to get rid of the ticket in URL
        println("redirecting back to " + frontPage);
        
        res.sendRedirect(frontPage);
        return null;                        
    }
    
    req.setAttribute("uhuid", uid);
    
    return uid;
}
%>
