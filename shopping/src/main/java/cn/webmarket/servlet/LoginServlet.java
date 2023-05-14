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
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import cn.webmarket.connection.DbCon;
import cn.webmarket.dao.UserDao;
import cn.webmarket.model.User;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	
	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");
			HttpSession session = request.getSession();
			try {
				UserDao udao = new UserDao(DbCon.getConnection());
				User user = udao.userLogin(email, password);
	
			
				 if(user != null) {
					 request.getSession().setAttribute("auth", user);
					 request.setAttribute("status", "success");
					 dispatcher = request.getRequestDispatcher("index.jsp");
				 }else {
					 request.setAttribute("status", "failed");
					 dispatcher = request.getRequestDispatcher("login.jsp");
				 }
				 dispatcher.forward(request, response);
			}catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
