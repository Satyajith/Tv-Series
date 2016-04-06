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
if(request.getParameter("tvId")!= null)
{
try {
	  // Step 1. Load the JDBC driver
	  Class.forName("com.mysql.jdbc.Driver");
	  
	  // Step 2. Create a Connection object
	  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

	  System.out.println("got connection");
	  Statement s = con.createStatement();
	  String tv_id = request.getParameter("tvId");
	  String tv_sql = "SELECT tv_id,title, year(start_year) as start_year, year(end_year) as end_year, genre, ratings, No_of_Seasons, tv_image FROM tvSeries where tv_id = '"+tv_id+"';";
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
		 <h1>
		 <font color="green"><%=rs.getString("title") %></font></h1>
		 </td>
		 </tr>
		 <tr>
		 <td>
		 <h3>Start Year-End Year</h3>
		 <%=rs.getString("start_year") %>-<%=rs.getString("end_year") %>
		 </td>
		 <td>
		 
		 
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
		 String tvseries_sql = "select w.w_name, a.actor_name,w.wid,a.actor_id, ain.character_name from  tvSeries tv inner join writes wr on tv.tv_id = wr.tv_id inner join writer w on w.wid= wr.wid inner join actsIn ain on ain.tv_id=tv.tv_id inner join actors a on ain.actor_id = a.actor_id where tv.tv_id= "+rs.getInt("tv_id")+";";
		 ResultSet tvseries_rs = s.executeQuery(tvseries_sql);
		  if(tvseries_rs.next())
			  {
				%>
				<tr>
			 <td>
			 <h3>Writer:</h3>
			 <a href="./writer.jsp?wid=<%=tvseries_rs.getString(3) %>"> <%
			 image = tvseries_rs.getInt(3);
		 %>
		 <img src="./images/writer/<%=image%>.jpeg" width="50" height="50"/><%=tvseries_rs.getString(1) %></a>
			
			
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
			 <a href="./actor.jsp?aid=<%=tvseries_rs.getString(4) %>"> <%
		  image = tvseries_rs.getInt(4);
		 %>
		 <img src="./images/<%=image%>.jpeg" width="50" height="50"/><%=tvseries_rs.getString(2) %></a> .......... <%=tvseries_rs.getString(5) %>
			 </td>
			 </tr>
				<%   
			  }
			 %>
		
		 
				 </table>
				
			 <%  
			 System.out.print(tv_id);
			  String seasons_sql = "SELECT e.season FROM tvSeries t inner join seasons s on t.tv_id=s.tv_id inner join episodes e on e.s_id=s.s_id where t.tv_id="+tv_id+" group by e.season;";
			  ResultSet seasons_rs = s.executeQuery(seasons_sql);
			  %>
			  <h3>Seasons List:</h3>
			  <% 
			  while(seasons_rs.next())
			  {
				 %>
				  <a href="./episode.jsp?tvId=<%=tv_id%>&sid=<%=seasons_rs.getInt("season")%>"><%=seasons_rs.getInt("season")%></a>
				  <%
			  }
	  rs.close();
}
	  
}
catch(Exception e)
{
	
}
}
 %>
</body>
</html>