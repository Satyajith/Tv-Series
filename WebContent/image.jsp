<%@ page language="java" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %> 
     <%@ page import="java.util.*"%>

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
       <html xmlns="http://www.w3.org/1999/xhtml">
       <head>
    <title></title>
    
     </head>
     <body>

       <%
String url = "jdbc:mysql://127.0.0.1:3306/tvSeriesDB";
Connection con = null;
Statement stmt = null;
ResultSet rs = null;


try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    con = DriverManager.getConnection(url,"root","");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT actor_image FROM actors where actor_id=24");
    int i = 1;
    while(rs.next()) {
        Blob len1 = rs.getBlob("actor_image");
        int len = (int)len1.length();
        byte[] b = new byte[len];
        InputStream readImg = rs.getBinaryStream(1);
        int index = readImg.read(b, 0, len);
        System.out.println("index" +index);
        stmt.close();
        response.reset();
        response.setContentType("image/jpg");
        response.getOutputStream().write(b,0,len);
        response.getOutputStream().flush();
    }
} catch(Exception ex) {
    out.println(ex);
} finally {
    rs.close();
    stmt.close();
    con.close();
}
       %>

    <br>
    <center><input type="button" value="Print" onclick="window.print();return false;"   />        </center>
    </body>
  </html>    