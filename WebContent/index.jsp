<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TvSeries</title>
<link rel="stylesheet" type="text/css" href="./css/styles.css">

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

	  
	  // Step 3. Create a Statement object and call its executeUpdate 
	  // method to insert a record
	  Statement s = con.createStatement();
	  Calendar currentDate = Calendar.getInstance();
		 int Year = currentDate.get(Calendar.YEAR);
		 String[] monthName = {"January","February","March","April","May","June","July","August","September","October","November","December"};
		 
		 //String month = monthName[currentDate.get(Calendar.MONTH)];
		 int month = currentDate.get(Calendar.MONTH)+1;
		 int day = currentDate.get(Calendar.DAY_OF_MONTH);
		 %>
		 <h3>Born Today</h3>
		 <%
	  // Step 4. Use the same Statement object to obtain a ResultSet object
	  String sql = "SELECT year(actor_dob) as y,actor_name,actor_id FROM actors where month(actor_dob) = "+month+" and day(actor_dob) = "+day+";";
	  ResultSet rs = s.executeQuery(sql);
	  while (rs.next()) {
		 %>
		 <table>
		 <tr>
		 <td>
		 </td>
		 </tr>
		 </table>
		 <%
		 int d = rs.getInt("y");
		 int age = Year - d;
	  %>
	   <%
		 int image = rs.getInt("actor_id");
		 %>
		 <div class="grow">
		 <table>
		 <tr>
		 <td>
		 <a href="./actor.jsp?aid=<%=rs.getInt("actor_id")%>"><img src="./images/<%=image%>.jpeg" width="200" height="200"/></a>&nbsp;&nbsp;
		 <span class="caption"> <a href="./actor.jsp?aid=<%=rs.getInt("actor_id")%>"><%=rs.getString("actor_name") %></a>(<%= age%>)</span>
		 </td>
		 	<% 
	  }
	  rs.close();
	  String sql_query = "SELECT year(w_dob) as w,w_name,wid FROM writer where month(w_dob) = "+month+" and day(w_dob) = "+day+";";
	  ResultSet rs_writer = s.executeQuery(sql_query);
	  while (rs_writer.next()) {
		 %>
		 
		 <%
		 int writer = rs_writer.getInt("w");
		 int age_writer = Year - writer;
		 int w_image = rs_writer.getInt("wid");
	  %>
	  <td>
     <a href="./writer.jsp?wid=<%=rs_writer.getInt("wid")%>"><img src="./images/writer/<%=w_image%>.jpeg" width="200" height="200"/></a>&nbsp;&nbsp;
    <span class="caption"><a href="./writer.jsp?wid=<%=rs_writer.getInt("wid")%>"> <%=rs_writer.getString("w_name") %></a>
		(<%= age_writer%>)</span>
		</td>
		</tr>
		</table>
</div>		
		 	<% 
	  }
	  %>
	  <h3>Find your Favorite Tv Series</h3>
	  
	  <% 
	  String tv_query = "select * from tvseries";
	  ResultSet rs_query = s.executeQuery(tv_query);
	  while(rs_query.next())
	  {
		  %>
		  <%
		 int image = rs_query.getInt("tv_id");
		 %>
		 <div class="item">
		 <a href="./tvseries.jsp?tvId=<%=rs_query.getInt("tv_id")%>"> <img class="series" src="./images/tvSeries/<%=image%>.jpeg" width="200" height="300" "/></a>&nbsp;&nbsp;
		 <span class="caption"><a href="./tvseries.jsp?tvId=<%=rs_query.getInt("tv_id")%>"><%=rs_query.getString("title")%></a></span>
		 </div>
		  <% 
	  }
	  s.close();
	  con.close();
	}
	catch (Exception e) {
	  // other unexpected exception, print error message to the console
	  System.out.println(e.toString());
	}
%>
</body>
</html>