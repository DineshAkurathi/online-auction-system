package com.login.web;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.bean.ListingBean;
import com.login.bean.LoginBean;
import com.login.database.ListingDAO;
import com.login.database.LoginDAO;
import java.sql.Timestamp;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/createListing")
public class CreateListingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO;

	public void init() {
		listingDAO = new ListingDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("Inside Listing Servlet");
		ListingBean listing = new ListingBean();
		listing.setSellerId(Integer.parseInt(request.getParameter("userId")));
		listing.setBrand(request.getParameter("brand"));
		listing.setCategory(request.getParameter("category"));
		listing.setItemName(request.getParameter("itemName"));
		listing.setColor(request.getParameter("color"));
		listing.setSize(request.getParameter("size"));
		listing.setGender(request.getParameter("gender"));
		listing.setPrice(Float.parseFloat(request.getParameter("listprice")));
		listing.setReservePrice(Float.parseFloat(request.getParameter("reserve")));
		listing.setCloseDate(Timestamp.valueOf(request.getParameter("closeDate").replace("T", " ") + ":00"));
		try {
			
			if(listingDAO.insertListing(listing)>0) {
				HttpSession session = request.getSession();
				request.setAttribute("message", "Successful!");
				request.getRequestDispatcher("createListing.jsp").forward(request, response);

			}
			else {
				HttpSession session = request.getSession();
				request.setAttribute("message", "Create Listing Failed!");
				request.getRequestDispatcher("createListing.jsp").forward(request, response);

			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	

}
}
