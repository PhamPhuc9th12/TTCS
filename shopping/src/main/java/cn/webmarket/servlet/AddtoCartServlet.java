package cn.webmarket.servlet;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.webmarket.model.*;
/*
 * Servlet implementation class AddtoCartServlet
 */
@WebServlet("/add-to-cart")
public class AddtoCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		
		try(PrintWriter out = response.getWriter()){
			ArrayList<Cart> cartList = new ArrayList<>();
			
			int id = Integer.parseInt(request.getParameter("id"));
			Cart cm = new Cart();
			cm.setId(id);
			cm.setQuantity(1);
			
			HttpSession session = request.getSession();
			ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
			 if(cart_list == null) {
				 cartList.add(cm);
				 session.setAttribute("cart-list", cartList);
				 response.sendRedirect("index.jsp");
			 }else {
				 cartList = cart_list;
				 boolean exist = false;
				 
				 
				 for(Cart c: cartList) {
					 if(c.getId() == id) {
						 exist = true;
						 request.setAttribute("addedProduct", "success");
						 request.getRequestDispatcher("index.jsp").forward(request, response);
					 }
				 }
				 if(!exist) {
					 cartList.add(cm);
					 response.sendRedirect("index.jsp");
				 }
			 }
		}
		
	}


}
