<%@ page import="org.jasig.cas.client.validation.TicketValidator" %>
<%@ page import="org.jasig.cas.client.validation.Cas20ServiceTicketValidator" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipalImpl" %>
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

// Return a netId (a.k.a., username); null if not logged in or
// can't validate the service ticket from the Web Login Service.
protected String doCasLogin(HttpServletRequest req,
                            HttpServletResponse res,
                            String weblogin,
                            String frontPage,
                            String serviceURL)
throws Exception {
	
    HttpSession sess = req.getSession();
    String sessionId = sess.getId();
    println("sessionId = " + sessionId);
    
    String netId = (String) sess.getAttribute("netId");
    println("netId from session = " + netId);
    
    // if there's a service ticket, try to validate it
    String ticket = req.getParameter("ticket");
    println("got a ticket: " + ticket);
    
            
    if (ticket != null) {
        String validateUrl = weblogin;
        println("validateUrl: " + validateUrl);
        println("serviceURL : " + serviceURL);

        TicketValidator validator = new Cas20ServiceTicketValidator(validateUrl);
        validator.validate(ticket, serviceURL);
        println("validation returned: " + validator);
                
            println("authN successful for " + netId);
            
            // remember the user's username
            sess.setAttribute("netId", netId);
            
            // redirect back to me to get rid of the ticket in URL
            println("redirecting back to " + frontPage);
            
            res.sendRedirect(frontPage);
            return null;        
                
    }
    return netId;
}
%>
