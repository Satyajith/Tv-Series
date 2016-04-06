<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="./header.jsp" /> 
<%
if((request.getParameter("uid")!=null)&&(request.getParameter("tvId")!= null)) 
{
	Class.forName("com.mysql.jdbc.Driver");
	  
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

	  System.out.println("got connection");
try {
	  // Step 1. Load the JDBC driver
	  con.setAutoCommit(false);
	  Statement s = con.createStatement();
	  String str = request.getParameter("uid");
	  String tvStr = request.getParameter("tvId");
	  String query="delete from seasons where s_id='"+str+"' and tv_id = '"+tvStr+"'";
	  s.executeUpdate(query);
	  String delQuery = "delete from episodes where s_id='"+str+"'";
	  s.executeUpdate(delQuery);
	  con.commit();
	  %>
	  </table>
	  </div>
	  <%
	  out.println("Deleted Succsefully");
	  %>
	  <h3>Go back to <a href="./adminCheck.jsp">Home</a></h3>
	  <% 
}
catch(Exception e)
{
	con.rollback();
}
}
%>
</body>
</html>