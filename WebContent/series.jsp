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

try {
  // Step 1. Load the JDBC driver
  Class.forName("com.mysql.jdbc.Driver");
  
  // Step 2. Create a Connection object
  Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

  System.out.println("got connection");

  
  // Step 3. Create a Statement object and call its executeUpdate 
  // method to insert a record
  Statement s = con.createStatement();
  
  // Step 4. Use the same Statement object to obtain a ResultSet object
  String sql = "SELECT title FROM tvSeries";
  ResultSet rs = s.executeQuery(sql);
  while (rs.next()) {
    //out.println(rs.getString(1) + "<br>");
    %>
    <h1><%=rs.getString(1) %></h1>
    <% 
  }
  rs.close();
  s.close();
  con.close();
}
catch (ClassNotFoundException e1) {
  // JDBC driver class not found, print error message to the console
  System.out.println(e1.toString());
}
catch (SQLException e2) {
  // Exception when executing java.sql related commands, print error message to the console
  System.out.println(e2.toString());
}
catch (Exception e3) {
  // other unexpected exception, print error message to the console
  System.out.println(e3.toString());
}
%>
</body>
</html>