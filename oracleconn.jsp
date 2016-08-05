<%@ page import="java.sql.*"%>
<%
if (session.getAttribute("adminid") == null | session.getAttribute("adminid") == "")
  {
    response.sendRedirect("validlogoutr.jsp");
  }
  
Class.forName("oracle.jdbc.OracleDriver");
DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
Connection conn =
            DriverManager.getConnection("jdbc:oracle:thin:@172.16.56.192:1521:ngc1", "kevint","pwd");

%>
