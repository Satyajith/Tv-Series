import java.sql.*;
import java.io.*;
public class InsertImages{
	public static void main(String[] args){
		System.out.println("Insert Image Example!");
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://127.0.0.1:3306/";
		String dbName = "tvSeriesDB";
		String userName = "root";
		String password = "";
		Connection con = null;
		try{
		   Class.forName(driverName);
		   con = DriverManager.getConnection(url+dbName,userName,password);
		   Statement st = con.createStatement();
		   File imgfile = new File("/Users/satyajitvure/Downloads/Tyler_blackburn.jpeg");
		  
		  FileInputStream fin = new FileInputStream(imgfile);
		 
		   PreparedStatement pre =
		   con.prepareStatement("update actors set actor_image = ? where actor_id=24");
		   pre.setBinaryStream(1,(InputStream)fin,(int)imgfile.length());
		   pre.executeUpdate();
		   System.out.println("Successfully inserted the file into the database!");

		   pre.close();
		   con.close(); 
		}catch (Exception e1){
			System.out.println(e1.getMessage());
		}
	}
}