package com.login.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.bean.ListingBean;
import com.login.bean.LoginBean;
import com.login.database.LoginDAO;
import com.login.database.*;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDao;

	public void init() {
		loginDao = new LoginDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Map res_map = new HashMap<>();
		LoginBean loginBean = new LoginBean();
		loginBean.setUsername(username);
		loginBean.setPassword(password);
		loginBean.setPassword(password);

		try {
			ListingDAO listingDAO = new ListingDAO();
			res_map = loginDao.validate(loginBean);
			String role = (String) res_map.get("role");
			int userId = (int) res_map.get("id");
			System.out.println(role);
			if (!role.isEmpty()) {
				if(role.equals("A")) {
					System.out.println("Admin loop");
					response.sendRedirect("loginAdmin.jsp");
				}
				else {
					if(role.equals("U")) {
						
						System.out.println("Getting list of auctions");
						List<ListingBean> listAuctions = listingDAO.selectAllAuctions();
						request.setAttribute("listAuctions", listAuctions);
						request.setAttribute("userId", userId);
						request.getRequestDispatcher("loginUser.jsp").forward(request, response);

					}
					else
					{
						System.out.println("Support loop");
						response.sendRedirect("loginSupport.jsp");
					}
				}
				
			} else {
		
				//session.setAttribute("user", username);
				request.setAttribute("errorMessage", "Invalid username or password");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				//response.sendRedirect("login.jsp");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
