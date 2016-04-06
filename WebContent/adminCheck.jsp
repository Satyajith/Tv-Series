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
int isLoggedIn = 0;
if(request.getParameter("adminLogin")!= null)
{

    String unm = request.getParameter("admin").toString();    

    String pwd = request.getParameter("pwd").toString();

    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tvSeriesDB", "root", "");

    Statement st = con.createStatement();

    ResultSet rs;

    //Stores the result of query in ResultSet


    if (unm.equals("admin")&&pwd.equals("admin123")) {
		
    	isLoggedIn = 1;
        session.setAttribute("login", isLoggedIn);
        session.setAttribute("Username", unm);
        %>
        <center><font color="black" size="8"> 

<u>Welcome Admin</u></font></br></br></br> 

<b><u> 

<font color="black" size="5">
Enter Tv Series Name<br>
</font><br>
<form  method="post" name="frm" action="./displayEpisodes.jsp">
<input placeholder="Enter Tv Series Id" type="text" name="tvId" id="name"/><br><br>
<input placeholder="Enter Tv Series Name" type="text" name="tvName" id="name"/><br><br>
<button class="btn btn-default" type="submit" name="tvSubmit">Submit</button>
</form>

        <% 

        //redirects the pages to AdminSucess.Jsp

        //response.sendRedirect("AdminSucess.jsp");

       //response.sendRedirect("Request.jsp");

    } else {

        out.println("Invalid password <a href='index.jsp'>try again</a>");

    }
}
    %>
</body>
</html>