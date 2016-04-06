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
		  Statement s = con.createStatement();
		  String str = request.getParameter("uid");
		  String tvStr = request.getParameter("tvId");
		  String sql = "SELECT e.season,e.episode_name,e.episode_length,t.title,e.s_id FROM tvSeries t inner join seasons s on t.tv_id=s.tv_id inner join episodes e on e.s_id=s.s_id where t.tv_id='"+tvStr+"' and e.s_id='"+str+"';";
		  ResultSet rs = s.executeQuery(sql);
		  while(rs.next())
		  {
			  %>
			  <form method="post" action="./updateAction.jsp">
			  <center>
			  <h4>Update Episode Details:</h4><br>
			  <b>TV Series Name:&nbsp;</b><%=rs.getString("title") %><br>
			  <b>season:&nbsp;</b><%=rs.getInt("season") %><br><br>
			  <b>Episode name:&nbsp;&nbsp;&nbsp;</b><input type="text" name="eName" value="<%=rs.getString("episode_name") %>"/><br>
			  <b>Episode Length:&nbsp;</b><input type="text" name="eTime" value="<%=rs.getTime("episode_length") %>"/><br><br>
			  <input type="hidden" name="seasonId" value="<%=str%>"/>
			   <button type="submit" name="updateEpisode">Update</button>
			   </center>
			   </form>
			   <%
		  }
	  }
	  catch(Exception e){
	  
	  }
	  }
	  %>
	  </body>
	  </html>