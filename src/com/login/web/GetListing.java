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
import java.util.List;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/getListing")
public class GetListing extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ListingDAO listingDAO;

	public void init() {
		listingDAO = new ListingDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("Inside getListing Servlet");
		int userId = Integer.parseInt(request.getParameter("userId"));
		System.out.println("UserId:"+userId);
		List<ListingBean> listAuctions = listingDAO.selectAllAuctions();
		request.setAttribute("listAuctions", listAuctions);
		request.getRequestDispatcher("loginUser.jsp").forward(request, response);
		

}
}
