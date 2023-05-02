package com.login.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/*
 * Listing Auto Updater
 * 
 * A server side thread that periodically does checks for all auctions.
 * These checks include:
 * 		- Check if a listing needs to be closed
 * 		- Update the auto bids to beat the current max on a listing
 * 
 * These checks are done periodically based on the TIMEOUT_SECONDS.
 */
class AutoUpdater extends Thread {
	private static final long TIMEOUT_SECONDS = 1;
	Connection c;

	public AutoUpdater(Connection c) {
		this.c = c;
	}

	public void run() {
		while (true) {
			pollListings();
			updateAutoBids();
			try {
				Thread.sleep(TIMEOUT_SECONDS * 1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/*
	 * Go through our current set auto bids and check if they have been out bidded.
	 * If so, go to each relevant listing and attempt to outbid the current max as
	 * long as we do not violate the maximum set for the autobid.
	 */
	private void updateAutoBids() {
		try {
			//Inner query: find the maximum bidder per listing
			//Outer query: filter the auto bids table to only include auto bidders who are not the maximum bidders
			
			String statement = "select * from (SELECT userId , auctionId, increment, b_limit, current_price FROM auto_bids WHERE (userId, auctionId) NOT IN (     SELECT b.buyerId, b.auctionId     FROM bids b     INNER JOIN (         SELECT auctionId, MAX(bidAmount) AS max_bid         FROM bids         GROUP BY auctionId     ) temp ON temp.auctionId = b.auctionId AND b.bidAmount = temp.max_bid )) as t1 inner join (select max(bidAmount) as max_bid,auctionId from bids group by(auctionId)) as t2 on t1.auctionId=t2.auctionId;";
			java.sql.PreparedStatement ps = c.prepareStatement(
					statement
			);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				
				int userId = rs.getInt(1);
				int auctionId = rs.getInt(2);
				double incr = rs.getDouble(3);
				double limit = rs.getDouble(4);
				double max_bid = rs.getDouble(6);
				
				if (limit > max_bid + incr)
				{
					ps = c.prepareStatement("INSERT INTO bids(auctionId,buyerId,bidAmount) VALUES(?,?,?)");
					ps.setInt(1, auctionId);
					ps.setInt(2, userId);
					ps.setDouble(3, max_bid + incr);
					System.out.println(ps);
					ps.executeUpdate();
				}
				
				
				}
			}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/*
	 * Poll the currently open listings and close them if they are past date.
	 * If they should be closed, check if the listing has met the minimum sell
	 * price. If it has met the sale price, generate a new sale.
	 */
	private void pollListings() {
		try {
			Timestamp curr_time = new Timestamp(System.currentTimeMillis());
			java.sql.PreparedStatement ps = c.prepareStatement(
				//"SELECT l_id, dt, price, minsale FROM listings WHERE closed=0"
				
				"SELECT auctionId,sellerId,itemName, closeDate, listprice, reserve FROM auctions WHERE status='OPEN';"
			);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int auctionId = rs.getInt(1);
				int sellerId = rs.getInt(2);
				String itemName = rs.getString(3);
				double reserve = rs.getDouble(6);
				System.out.println(reserve);
				String ts = rs.getString(4);
				System.out.println(ts);
				Timestamp close_time = Timestamp.valueOf(rs.getString(4));
				System.out.println(close_time);
				if (close_time.before(curr_time) || close_time.equals(curr_time)) {
					PreparedStatement us = c.prepareStatement(
							"UPDATE auctions SET status='CLOSED' WHERE auctionId=(?)"
					);
					us.setInt(1, auctionId);
					us.executeUpdate();
					
					String bid_query = "select * from ( SELECT buyerId, bidAmount FROM bids WHERE auctionId = ? ORDER BY bidAmount DESC LIMIT 1) as t1  inner join (select userId, username from user) as u on  t1.buyerId=u.userId;";
					PreparedStatement bq = c.prepareStatement(bid_query);
					bq.setInt(1, auctionId);
					ResultSet cbids = bq.executeQuery();
					if(cbids.next())
					{
						int buyerId = cbids.getInt(1);
						double bidAmount = cbids.getDouble(2);
						int userId = cbids.getInt(3);
						String username = cbids.getString(4);
						PreparedStatement is = c.prepareStatement("INSERT INTO closed_auction(auctionId,sellerId,itemName,close_amount,winner,username) VALUES(?,?,?,?,?,?)");
						is.setInt(1, auctionId);
						is.setInt(2, sellerId);
						is.setString(3, itemName);
						if (bidAmount >= reserve)
						{

							is.setDouble(4, bidAmount);
							is.setInt(5, userId);
							is.setString(6, username);
							is.executeUpdate();
					
						}	
						else
						{
							is.setDouble(4, 0.0);
							is.setInt(5,0);
							is.setString(6, "None");
							is.executeUpdate();
						}
						}
					else
					{
						PreparedStatement is = c.prepareStatement("INSERT INTO closed_auction(auctionId,sellerId,itemName,close_amount,winner,username) VALUES(?,?,?,?,?,'None')");
						is.setInt(1, auctionId);
						is.setInt(2, sellerId);
						is.setString(3, itemName);
						is.setDouble(4, 0.0);
						is.setInt(5, 0);
						is.executeUpdate();
					}
					}

			
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}