package cn.webmarket.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.webmarket.connection.DbCon;
import cn.webmarket.dao.ProductDao;
import cn.webmarket.model.Cart;
import cn.webmarket.model.Product;

/**
 * Servlet implementation class SeachServlet
 */
@WebServlet("/search")
public class SeachServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try(PrintWriter out = response.getWriter()){
				String txtSearch = request.getParameter("txt");
				ProductDao pd = new ProductDao(DbCon.getConnection());
				
				HttpSession session = request.getSession();
				List<Product> listS = (ArrayList<Product>) session.getAttribute("listS");
				listS = pd.searchProduct(txtSearch);
				request.getSession().setAttribute("listS", listS);
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
