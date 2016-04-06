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
if((request.getParameter("submit")!= null) && (request.getParameter("search")!=null))
{
	System.out.println("hello");
	String search_name = request.getParameter("name").toString();
	String search = request.getParameter("search").toString();
	System.out.println(search);
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

	  System.out.println("got connection");

	  
	  // Step 3. Create a Statement object and call its executeUpdate 
	  // method to insert a record
	  Statement s = con.createStatement();
	  if(search.equals("Actor"))
	  {
		  System.out.println("2");
	  // Step 4. Use the same Statement object to obtain a ResultSet object
	  String sql = "SELECT * FROM actors where actor_name like '%" + search_name + "%'";
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
		 String actor_sql = "select a.actor_name,tv.title,ai.character_name,tv.genre from actors a inner join actsIn ai on a.actor_id = ai.actor_id inner join tvSeries tv on tv.tv_id = ai.tv_id where a.actor_id = "+rs.getInt("actor_id")+";";
		  ResultSet actor_rs = s.executeQuery(actor_sql);
		  while(actor_rs.next())
		  {
			%>
			<tr>
		 <td>
		 <h3>Tv Series Name:</h3>
		 <%=actor_rs.getString(2) %>
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
else if(search.equals("Writer"))
{
	

	String w_sql = "SELECT * FROM writer where w_name like '%" + search_name + "%'";
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
		 <h1 style="color:brown;">
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
		 
		 Blog:
		 <a href="<%=rs.getString("w_blog") %>">
		 <%=rs.getString("w_blog") %></a>
		 <%
		 }
		 %>
		 </td>
		 </tr>
		 <%
		 String writer_sql = "SELECT tv.title, tv.genre, tv.ratings from writes wr inner join tvSeries tv on wr.tv_id=tv.tv_id inner join writer w on w.wid = wr.wid  where w.wid= "+rs.getInt("wid")+";";
		 ResultSet writer_rs = s.executeQuery(writer_sql);
		  while(writer_rs.next())
			  {
				%>
				<tr>
			 <td>
			 <h3>Tv Series Name:</h3>
			 <%=writer_rs.getString(1) %>
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
			 
	  rs.close();
	  
  
	  }
}
else if(search.equals("Tv_Series"))
{
	String tv_sql = "SELECT tv_id,title, year(start_year) as start_year, year(end_year) as end_year, genre, ratings, No_of_Seasons, tv_image FROM tvSeries where title like '%" + search_name + "%'";
	  ResultSet rs = s.executeQuery(tv_sql);
	  while (rs.next()) {
		  
		 %>
		  <div align="left" style="float:right;">
		 <%
		 int image = rs.getInt("tv_id");
		 %>
		 <img src="./images/tvSeries/<%=image%>.jpeg" width="300" height="400"/>
		 </div>
		 <table>
		 <tr>
		 <td>
		 <h1 style="color:green;">
		 <%=rs.getString("title") %></h1>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Start Year</h3> 
		 <%=rs.getString("start_year") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <h3>End Year</h3>
		 <%=rs.getString("end_year") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <tr>
		 <td>
		 <h3>Genre</h3>
		 <%=rs.getString("genre") %>
		 </td>
		 </tr>
		 
		 <tr>
		 <td>
		 <h3>Ratings</h3>
		 <%=rs.getInt("ratings") %>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Number of Seasons</h3>
		 <%=rs.getInt(	"No_of_Seasons" ) %>
		 </td>
		 </tr>
		 		 <%
		 String tvseries_sql = "select w.w_name, a.actor_name, w.wid,a.actor_id from  tvSeries tv inner join writes wr on tv.tv_id = wr.tv_id inner join writer w on w.wid=wr.wid inner join actsIn ain on ain.tv_id=tv.tv_id inner join actors a on ain.actor_id = a.actor_id where tv.tv_id= "+rs.getInt("tv_id")+";";
		 ResultSet tvseries_rs = s.executeQuery(tvseries_sql);
		  if(tvseries_rs.next())
			  {
				%>
				<tr>
			 <td>
			 <h3>Writer:</h3>
			 
			 <% image = tvseries_rs.getInt(3);
		 %>
		 <img src="./images/writer/<%=image%>.jpeg" width="50" height="50"/><a href=./writer.jsp?wid=<%=tvseries_rs.getString(3)%>><%=tvseries_rs.getString(1) %></a>
			
			 </td>
			 </tr>
			 <%
			  }
			 %>
			 <tr>
			 <td>
			 <h3>Actors:</h3></td></tr>
			<%
			  
		  tvseries_rs.beforeFirst();
		  while(tvseries_rs.next()){
			  
			%>
			<tr>
				<td>
			
			<%  image = tvseries_rs.getInt(4);
		 %>
		 <img src="./images/<%=image%>.jpeg" width="50" height="50"/><a href=./actor.jsp?aid=<%=tvseries_rs.getString(4) %>><%=tvseries_rs.getString(2) %></a><br>
			
			 </td>
			 </tr>
				<%   
			  }
			 %>
		
		 
				 </table>
			 <%  
			 
	  rs.close();
	  
  
	  }

}
	  s.close();
	  con.close();
	
}
	catch (Exception e) {
	  // other unexpected exception, print error message to the console
	  System.out.println(e.toString());
	}
}
%>
</body>
</html>