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
if((request.getParameter("sid")!= null)&&(request.getParameter("tvId")!= null))
{
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");
	  System.out.println("got connection");
	  Statement s = con.createStatement();
	  String str = request.getParameter("tvId");
	  String season = request.getParameter("sid");
	  String sql = "SELECT * FROM tvSeries t inner join seasons s on t.tv_id=s.tv_id inner join episodes e on e.s_id=s.s_id where t.tv_id='"+str+"' and e.season = '"+season+"'";
	  ResultSet rs = s.executeQuery(sql);
	  if(rs.next()) {
		  
		 %>
		 <div align="left">
		 <%
		 int image = rs.getInt("tv_id");
		 %>
		 <img src="./images/tvSeries/<%=image%>.jpeg" width="300" height="400"/>
		 </div>
		 <table>
		 <tr>
		 <td>
		 <h1>
		 <%=rs.getString("title") %></h1>
		 </td>
		 </tr>
		 <tr>
		 <td>
		<h3> Season Number: </h3><h4><%=rs.getInt("season") %></h4>
		 </td>
		 </tr>
		
		 <%
	  }
	   rs.beforeFirst();
	   %>
	    <tr>
		 <td>
		 
	    <h3>Episodes:</h3>
	   <% 
	   while(rs.next()) {
		 %>
		
		 <%=rs.getString("episode_name") %> (<%=rs.getString("episode_length") %>)<br>
		 </td>
		 </tr>
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