<%@page import="java.awt.Image"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
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
<title>Tv Series</title>
</head>
<body>
<jsp:include page="./header.jsp" /> 
<%
if((request.getParameter("tvSubmit")!= null))
{
	//System.out.println("hello");
	String search_name = request.getParameter("tvName").toString();
	String tv_id = request.getParameter("tvId").toString();
	
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

	  System.out.println("got connection");

	  
	  // Step 3. Create a Statement object and call its executeUpdate 
	  // method to insert a record
	  Statement s = con.createStatement();
	  String sql = "SELECT e.season,e.episode_name,e.episode_length,t.title,e.s_id FROM tvSeries t inner join seasons s on t.tv_id=s.tv_id inner join episodes e on e.s_id=s.s_id where t.tv_id='"+tv_id+"';";
	  ResultSet rs = s.executeQuery(sql);
	  if(rs.next())
	  {
		  
 %>
	  
	  <div style="margin-left:20px;">
	  <br>
	  <button><a href="./addNewEpisode.jsp?tvId=<%=tv_id %>" style="color:blue;">Add New Episode</a></button>
	  <h3>Edit <%=rs.getString("title") %> Details</h3>
	  <table border="1">
		  <tr>
		  <th>Season Number</th>
		  <th>Episode Name</th>
		  <th>Episode Length</th>
		  <th>Update</th>
		  <th>Delete</th>
		  </tr>
	  <% 
	  }
	  rs.beforeFirst();
	  while (rs.next()) {
		  %>
		  <tr>
		  <td align="center"><%=rs.getString("season") %></td>
		  <td align="center"><%=rs.getString("episode_name") %></td>
		  <td align="center"><%=rs.getTime("episode_length") %></td>
		  <td><form><button><a href="./updateEpisode.jsp?uid=<%=rs.getInt("s_id") %>&tvId=<%=tv_id %>">Update</a></button></form></td>
		  <td><form><button><a href="./deleteEpisode.jsp?uid=<%=rs.getInt("s_id") %>&tvId=<%=tv_id %>" style="color:red;">Delete</a></button></form></td>
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
	  }
	  %>
	  