package com.login.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.bean.ListingBean;
import com.login.database.ListingDAO;

/**
 * Servlet implementation class GetAuctions
 */
@WebServlet("/getAuctions")
public class GetAuctions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private ListingDAO listingDAO;

	public void init() {
		listingDAO = new ListingDAO();
	}
    public GetAuctions() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Getting List of Auctions");
		System.out.println("Inside getListing Servlet");
		int userId = Integer.parseInt(request.getParameter("userId"));
		System.out.println("UserId:"+userId);
		List<ListingBean> listAuctions = listingDAO.selectAllAuctions();
		request.setAttribute("listAuctions", listAuctions);
		request.getRequestDispatcher("loginUser.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		System.out.println("Hello");
	}

}
