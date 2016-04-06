<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TvSeries</title>
<link rel="stylesheet" type="text/css" href="./css/styles.css">
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="./index.jsp">Tv Series</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li><a href="./index.jsp">Home</a></li>
        <li><a href="./viewTvSeries.jsp">View Tv Series</a></li>
        <li><a href="./viewActors.jsp">View Actors</a></li>
        <li><a href="./viewWriters.jsp">View Writers</a></li>
      </ul>
    
<div class="col-sm-4 col-md-4 pull-center">
<form  class="navbar-form" role="search" method="post" name="frm" action="./results.jsp"> 
 <div class="input-group">
<table>  
<tr>
<td align="center"><input class="form-control" placeholder="Search" type="text" name="name" id="name"> 
</td> 
<td>
<select name="search" class="form-control">
  <option value="Actor">Actor</option>
  <option value="Writer">Writer</option>
  <option value="Tv_Series">Tv Series</option>
</select>
</td>
<div class="input-group-btn">
<td> 
<button class="btn btn-default" type="submit" name="submit"><i class="glyphicon glyphicon-search"></i></button></td></div></tr> 
</table> 
</div>
</form> 
</div>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
       <% 
       if(session.getAttribute("login")!= null){
       //String i = session.getAttribute("login").toString();
        System.out.println("hello");
        String i = session.getAttribute("login").toString();
        if(Integer.parseInt(i)==1)
        {
        	%>
        	<a href="./adminCheck.jsp" class="dropdown-toggle" data-toggle="dropdown"><b>admin</b><span class="caret"></span></a>
        	<ul id="login-dp" class="dropdown-menu">
				<li>
				<div class="row">
				<div class="form-group">    <a href="./adminCheck.jsp"><span class="btn btn-primary btn-block">Admin Home</span></a>
											 <a href="./logout.jsp"><span class="btn btn-primary btn-block">Log out</span></a>
										</div>
				</div>
				</li>
				</ul>
        	<% 
        }
        }
        else {
       %>
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><b>Login</b> <span class="caret"></span></a>
			<ul id="login-dp" class="dropdown-menu">
				<li>
					 <div class="row">
								 <form class="form" role="form" method="post" action="./adminCheck.jsp" accept-charset="UTF-8" id="login-nav">
										<div class="form-group">
											 <label class="sr-only" for="exampleInputEmail2">Admin Name</label>
											 <input name="admin" type="text" class="form-control"  placeholder="Admin Name" required>
										</div>
										<div class="form-group">
											 <label class="sr-only" for="exampleInputPassword2">Password</label>
											 <input name="pwd" type="password" class="form-control" id="exampleInputPassword2" placeholder="Password" required>
  
										</div>
										<div class="form-group">
											 <button name="adminLogin" type="submit" class="btn btn-primary btn-block">Sign in</button>
										</div>
								 </form>
							</div>
					 </div>
				</li>
			</ul>
			<%
        }
			%>
        </li>
      </ul>
</div>
  </div>
</nav>