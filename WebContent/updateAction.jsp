<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- importing the required packages --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
 <%-- Attributes of patient tables which can be updated is mentioned here--%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="./header.jsp" /> 
<%
if((request.getParameter("updateEpisode")!=null)) 
{
		String str = request.getParameter("seasonId");
		int seasonId = Integer.parseInt(str);
        String epiName=request.getParameter("eName");
        String epiLength=request.getParameter("eTime");
        
        
      Connection con=null;

 try {
                Class.forName("com.mysql.jdbc.Driver");
//connecting to the database using jdbc drivers.
   con= DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");
   //the query is stored in stmt
   PreparedStatement stmt= con.prepareStatement("update episodes set episode_name=? , episode_length=? where s_id=?");
             
 stmt.setString(1,epiName);
 stmt.setString(2,epiLength);
 stmt.setInt(3,seasonId);
       //executing the query using executeUpdate()
                stmt.executeUpdate(); 

               out.println("Episode details updated successfully");
       }
       catch(Exception e){
        out.print("try not allowed"+e);
                }
 %>  
                <%
}
                %>
      </body>
      </html>
                      