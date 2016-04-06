<%@page import="java.awt.Image"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
if((request.getParameter("tvId")!= null)&&(request.getParameter("addEpisode") != null))
{
	System.out.print("hello");
	try {
		  // Step 1. Load the JDBC driver
		  Class.forName("com.mysql.jdbc.Driver");
		  
		  // Step 2. Create a Connection object
		  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

		  System.out.println("got connection");
		  Statement s = con.createStatement();
		  String tvid = request.getParameter("tvId");
		  //int tid = Integer.parseInt(tvid);
		
		  String epiName=request.getParameter("eName");
	      String epiLength=request.getParameter("eLength");
		  String epiNumber = request.getParameter("eNumber");
		  //int eNumber = Integer.parseInt(epiNumber);
		  String seasonNumber = request.getParameter("sName");
		  //int sNum= Integer.parseInt(seasonNumber);
		 String stmt="insert into episodes (e_id,season,episode_name,episode_length) values ('"+epiNumber+"','"+seasonNumber+"','"+epiName+"','"+epiLength+"')";
		  s.executeUpdate(stmt); 
		  out.println("Episode added successfully");
		 
		  String sql = "SELECT s_id from episodes where e_id="+epiNumber+" and season = "+seasonNumber+" and episode_name = '"+epiName+"';";
		  ResultSet rs = s.executeQuery(sql);
		  if(rs.next())
		  {
			 // out.println("Episode found");
			  String seasonId = rs.getString("s_id");
			  String st = "insert into seasons (tv_id,s_id) values ('"+tvid+"','"+seasonId+"')";
			  s.executeUpdate(st);
			  //out.println("season updated");
		  }
	}catch(Exception e)
	{
		
	}
}


%>
<form method="post" action="./addNewEpisode.jsp?tvId=<%=request.getParameter("tvId")%>">
			  <center>
			  <h4>Add New Episode:</h4><br>
			  <b>Episode Number:&nbsp;</b><input type="text" name="eNumber" value=""/><br>
			  <b>Season Number:&nbsp;</b><input type="text" name="sName" value=""/><br>
			  <b>Episode name:&nbsp;&nbsp;&nbsp;</b><input type="text" name="eName" value=""/><br>
			  <b>Episode Length:&nbsp;</b><input type="text" name="eLength" value=""/><br><br>
			   <button type="submit" name="addEpisode">Add</button>
			   </center>
			   </form>
</body>
</html>