package cn.webmarket.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.webmarket.connection.DbCon;
import cn.webmarket.dao.*;
import cn.webmarket.model.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/user-registration")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String name = request.getParameter("uName");
			String email = request.getParameter("uEmail");
			String password = request.getParameter("uPassword");
			String phone = request.getParameter("uPhone");
			User newUser = new User(0,name,email,password,phone);
			UserDao udao = new UserDao(DbCon.getConnection());
			boolean added = udao.userRegisted(newUser);
			if(added) {
				request.setAttribute("statusRegis", "success");
				 dispatcher = request.getRequestDispatcher("login.jsp");
			}else {
				request.setAttribute("statusRegis", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
