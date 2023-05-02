package com.login.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.login.bean.ListingBean;

public class ListingDAO {
		
		public List selectAllAuctions()
		{
			List<ListingBean> auctions = new ArrayList<>();
			try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmsproject?useSSL=false&serverTimezone=UTC", "root", "root_123");

				PreparedStatement preparedStatement = connection.prepareStatement("select * from auctions;"))			{
				ResultSet rs = preparedStatement.executeQuery();
				while(rs.next()){
					int auctionId = rs.getInt("auctionId");
					int sellerId = rs.getInt("sellerId");
					String itemName = rs.getString("itemName");
					String size = rs.getString("size");
					String color = rs.getString("color");
					String gender = rs.getString("gender");
					String brand = rs.getString("brand");
					String category = rs.getString("category");
					float reserve = rs.getFloat("reserve");
					float listprice = rs.getFloat("listprice");
					Timestamp closeDate = rs.getTimestamp("closeDate");
				
					auctions.add(new ListingBean(auctionId, sellerId, category, itemName,brand, color, size,gender,listprice,reserve, closeDate));
					
				}
					
					

					

				} catch (SQLException e) {

					e.printStackTrace();
				}
			return auctions;
		}
		public int insertListing(ListingBean list) throws ClassNotFoundException {
			int rs=0;
			String role = "";
			Class.forName("com.mysql.jdbc.Driver");
			
			try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmsproject?useSSL=false&serverTimezone=UTC", "root", "root_123");

				PreparedStatement preparedStatement = connection.prepareStatement("insert into auctions (sellerId, itemName,reserve,listprice,closeDate, size,color,gender,brand,category) values(?,?,?,?,?,?,?,?,?,?);"))
						{
				preparedStatement.setInt(1, list.getSellerId());
				preparedStatement.setString(2, list.getItemName());
				preparedStatement.setFloat(3, list.getReservePrice());
				preparedStatement.setFloat(4, list.getPrice());
				preparedStatement.setTimestamp(5, list.getCloseDate());
				preparedStatement.setString(6, list.getSize());
				preparedStatement.setString(7, list.getColor());
				preparedStatement.setString(8, list.getGender());
				preparedStatement.setString(9, list.getBrand());
				preparedStatement.setString(10, list.getCategory());
				
				
				

				System.out.println(preparedStatement);
				rs  = preparedStatement.executeUpdate();
				
				System.out.println(rs);
				

			} catch (SQLException e) {

				e.printStackTrace();
			}
			return rs;
		}
		}


