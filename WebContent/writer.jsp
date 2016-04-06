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
if(request.getParameter("wid")!= null)
{
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");
	  System.out.println("got connection");
	  Statement s = con.createStatement();
	  String str = request.getParameter("wid");
	  String w_sql = "SELECT * FROM writer where wid = '"+str+"'";
	  ResultSet rs = s.executeQuery(w_sql);
	  while (rs.next()) {
		  %>
			 <div align="left" style="float:right;">
			 <%
			 int image = rs.getInt("wid");
			 %>
			 <img src="./images/writer/<%=image%>.jpeg" width="300" height="400"/>
			 </div>
		 <table>
		 <tr>
		 <td>
		 <h1 style="color:brown">
		 <%=rs.getString("w_name") %></h1>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>D.O.B:</h3> 
		 <%=rs.getDate("w_dob") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <h3>Awards:</h3>
		 <%=rs.getString("w_awards") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <%
		 if(rs.getString("w_blog")!= null)
		 {
		 %>
		 
		 <h3>Blog:</h3>
		 <a href="<%=rs.getString("w_blog") %>">
		 <%=rs.getString("w_blog") %></a>
		 <%
		 }
		 %>
		 </td>
		 </tr>
		 <%
		 String writer_sql = "SELECT tv.title, tv.genre, tv.ratings,tv.tv_id from writes wr inner join tvSeries tv on wr.tv_id=tv.tv_id inner join writer w on w.wid= wr.wid where w.wid= "+rs.getInt("wid")+";";
		 ResultSet writer_rs = s.executeQuery(writer_sql);
		  while(writer_rs.next())
			  {
				%>
				<tr>
			 <td>
			 <h3>Tv Series Name:</h3>
			<a href="./tvseries.jsp?tvId=<%=writer_rs.getString(4)%>"><%=writer_rs.getString(1) %></a> 
			 </td>
			 </tr>
				<tr>
			 <td>
			 <h3>Genre:</h3>
			 <%=writer_rs.getString(2) %>
			 </td>
			 </tr>
			 <tr>
			 <td>
			 <h3>Ratings:</h3>
			 <%=writer_rs.getInt(3) %>
			 </td>
			 </tr>
				<%   
			  }
			 %>
			 
			 </table>
			 <%   
	  } 
	  rs.close();
}catch(Exception e){
	
}
}
%>
</body>
</html>