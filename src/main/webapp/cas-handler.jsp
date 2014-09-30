<%@ page import="org.jasig.cas.client.validation.TicketValidator" %>
<%@ page import="org.jasig.cas.client.validation.Cas20ServiceTicketValidator" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>
<%@ page import="org.jasig.cas.client.validation.Assertion" %>
<%@ page import="java.net.URLEncoder" %>
<%!
// A simple logging method; entry is sent to stdout.
protected void println(String msg) {
    String ts = String.format("%1$tY-%1$tb-%1$te %1$tT", new java.util.Date());
    System.out.println(ts + " DEBUG " + msg);
}

// Do a CAS login and save the uid (username).
protected void doCasLogin(HttpServletRequest req,
                          HttpServletResponse res,
                          String casUrl,
                          String frontPage,
                          String insidePage)
throws Exception {

    HttpSession sess = req.getSession();
    String sessionId = sess.getId();
    println("doCasLogin; sessionId: " + sessionId);

    String ticket = req.getParameter("ticket");
    if (ticket != null) {
        // There is a service ticket, need to validate it.
        println("doCasLogin; ticket     : " + ticket);
        println("doCasLogin; casUrl     : " + casUrl);
        println("doCasLogin; insidePage : " + insidePage);

        TicketValidator validator = new Cas20ServiceTicketValidator(casUrl);
        Assertion assertion = validator.validate(ticket, insidePage);
        AttributePrincipal principal = assertion.getPrincipal();
        String uid = principal.getName();
        println("doCasLogin; uh-cas uid : " + uid);

        sess.setAttribute("uid", uid);
        req.setAttribute("uid", uid);

        // Redirect to remove the ticket from URL.
        println("doCasLogin; redirecting: " + frontPage);
        res.sendRedirect(frontPage);
        return;
    }

    String uid = (String) sess.getAttribute("uid");
    println("doCasLogin; uid from session: " + uid);
    req.setAttribute("uid", uid);
}

protected void doCasLogout(HttpServletRequest req,
                           HttpServletResponse res,
                           String logoutUrl)
throws Exception {
    println("doCasLogout; invalidate session and logout.");
    req.getSession().invalidate();
    res.sendRedirect(logoutUrl);
}
%>
