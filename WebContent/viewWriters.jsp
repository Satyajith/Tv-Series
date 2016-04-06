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
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

	  System.out.println("got connection");
	  Statement s = con.createStatement();
	  String tv_sql = "SELECT * FROM writer;";
	  ResultSet rs = s.executeQuery(tv_sql);
	  %>
	  
	  <div style="margin-left:20px;">
	  <h3>List of Writers:</h3>
	  <table border="1">
		  <tr>
		  <th></th>
		  <th>Writer Name</th>
		  <th>Date of Birth</th>
		  <th>Awards</th>
		  <th>Writer Blog</th>
		  </tr>
	  <% 
	  while (rs.next()) {
		  %>
		  <tr>
		  <td><a href="./writer.jsp?wid=<%=rs.getInt("wid")%>"><img src="./images/writer/<%=rs.getInt("wid")%>.jpeg" width="50" height="50"/></a></td>
		  <td><%=rs.getString("w_name") %></td>
		  <td><%=rs.getDate("w_dob") %></td>
		  <td><%=rs.getString("w_awards") %></td>
		  <td><a><%=rs.getString("w_blog") %></a></td>
		  </tr>
		  <%
	  }
	  %>
	  </table>
	  </div>
	  <%
}
catch(Exception e)
{
	
}
%>
</body>
</html>