package com.codegnan;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DBConnection {
	private static final String URL = System.getenv("DB_URL") != null 
		    ? System.getenv("DB_URL") 
		    : "jdbc:mysql://localhost:3306/quizdb";
		private static final String USER = System.getenv("DB_USERNAME") != null 
		    ? System.getenv("DB_USERNAME") 
		    : "root";
		private static final String PASSWORD = System.getenv("DB_PASSWORD") != null 
		    ? System.getenv("DB_PASSWORD") 
		    : "harivinnu@143";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    public static boolean register(User u) {
        try(Connection con = getConnection();
            PreparedStatement pst = con.prepareStatement(
              "INSERT INTO users(username,password,email) VALUES(?,?,?)")) {
          pst.setString(1,u.getUsername());
          pst.setString(2,u.getPassword());
          pst.setString(3,u.getEmail());
          return pst.executeUpdate()>0;
        } catch(Exception e){e.printStackTrace();}
        return false;
      }
      public static User login(String user, String pass) {
        try(Connection con=getConnection();
            PreparedStatement pst=con.prepareStatement(
              "SELECT * FROM users WHERE username=? AND password=?")) {
          pst.setString(1,user); pst.setString(2,pass);
          try(ResultSet rs=pst.executeQuery()){
            if(rs.next()) {
              User u = new User();
              u.setId(rs.getInt("id"));
              u.setUsername(rs.getString("username"));
              return u;
            }
          }
        } catch(Exception e){e.printStackTrace();}
        return null;
      }
	
}
  