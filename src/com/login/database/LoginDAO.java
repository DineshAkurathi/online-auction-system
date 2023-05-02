package com.login.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.login.bean.LoginBean;



public class LoginDAO {
	public Map<String,Object> validate(LoginBean loginBean) throws ClassNotFoundException {
		boolean status = false;
		String role = "";
		int userId= 0;
		Map res_map = new HashMap<String,Object>();
		Class.forName("com.mysql.jdbc.Driver");
		
		
		try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmsproject?useSSL=false&serverTimezone=UTC", "root", "root_123");

			PreparedStatement preparedStatement = connection.prepareStatement("select * from user where username = ? and password = ? ")) {
			preparedStatement.setString(1, loginBean.getUsername());
			preparedStatement.setString(2, loginBean.getPassword());

			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next()){
				role = rs.getString(5);
				userId = rs.getInt(1);
			}
			
			res_map.put("role", role);
			res_map.put("id", userId);

		} catch (SQLException e) {

			printSQLException(e);
		}
		return res_map;
	}

	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}
}
