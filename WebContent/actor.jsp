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
if(request.getParameter("aid")!= null)
{
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");
	  System.out.println("got connection");
	  Statement s = con.createStatement();
	  String str = request.getParameter("aid");
	  String sql = "SELECT * FROM actors where actor_id = '"+str+"'";
	  ResultSet rs = s.executeQuery(sql);
	  while (rs.next()) {
		  
		 %>
		 <div align="left" style="float:right;">
		 <%
		 int image = rs.getInt("actor_id");
		 %>
		 <img src="./images/<%=image%>.jpeg" width="300" height="400"/>
		 </div>
		 <table>
		 <tr>
		 <td>
		 <h1 style="color:brown;">
		 <%=rs.getString("actor_name") %></h1>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>D.O.B:</h3> 
		 <%=rs.getDate("actor_dob") %>
		 </td>
		 </tr>
		 <tr>
		 <td>
		<h3>Nominations:</h3> 
		 <%=rs.getString("actor_nominations") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <h3>Awards:</h3>
		 <%=rs.getString("actor_awards") %>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Blog:</h3>
		 <a href="<%=rs.getString("actor_blog") %>">
		 <%=rs.getString("actor_blog") %></a>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Biography:</h3>
		 <%=rs.getString("actor_bio") %>
		 </td>
		 </tr>
		 <%
		 String actor_sql = "select a.actor_name,tv.title,ai.character_name,tv.genre,tv.tv_id from actors a inner join actsIn ai on a.actor_id = ai.actor_id inner join tvSeries tv on tv.tv_id = ai.tv_id where a.actor_id = "+rs.getInt("actor_id")+";";
		  ResultSet actor_rs = s.executeQuery(actor_sql);
		  while(actor_rs.next())
		  {
			%>
			<tr>
		 <td>
		 <h3>Tv Series Name:</h3>
		<a href="./tvseries.jsp?tvId=<%=actor_rs.getString(5) %>"><%=actor_rs.getString(2) %></a> 
		 </td>
		 </tr>
			<tr>
		 <td>
		 <h3>Character Name:</h3>
		 <%=actor_rs.getString(3) %>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Genre:</h3>
		 <%=actor_rs.getString(4) %>
		 </td>
		 </tr>
			<%   
		  }
		 %>
		 
		 </table>
		 <%
		 
	     
	  }
	  rs.close();
	  
}
catch(Exception e)
{
}
}
%>
</body>
</html>