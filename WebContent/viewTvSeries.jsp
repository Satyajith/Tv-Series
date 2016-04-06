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
	  String tv_sql = "SELECT tv_id,title, year(start_year) as start_year, year(end_year) as end_year, genre, ratings, No_of_Seasons, tv_image FROM tvSeries;";
	  ResultSet rs = s.executeQuery(tv_sql);
	  %>
	  
	  <div style="margin-left:20px;">
	  <h3>Tv Series Guide:</h3>
	  <table border="1">
		  <tr>
		  <th></th>
		  <th>Series Name</th>
		  <th>Start Year</th>
		  <th>End Year</th>
		  <th>Genre</th>
		  <th>Ratings</th>
		  </tr>
	  <% 
	  while (rs.next()) {
		  %>
		  <tr>
		  <td><a href="./tvseries.jsp?tvId=<%=rs.getInt("tv_id")%>"><img src="./images/tvSeries/<%=rs.getInt("tv_id")%>.jpeg" width="50" height="50"/></a></td>
		  <td align="center"><%=rs.getString("title") %></td>
		  <td align="center"><%=rs.getString("start_year") %></td>
		  <td align="center"><%=rs.getString("end_year") %></td>
		  <td align="center"><%=rs.getString("genre") %></td>
		  <td align="center"><%=rs.getString("ratings") %></td>
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