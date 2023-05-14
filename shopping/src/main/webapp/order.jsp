<%@page import="cn.webmarket.dao.OrderDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="cn.webmarket.dao.*"%>
<%@page import="cn.webmarket.connection.DbCon"%>
<%@page import ="cn.webmarket.model.*" %>
<%@page import="java.text.DecimalFormat"%>
<%

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null){
	request.setAttribute("cart_list", cart_list);
}
%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if(auth != null){
	request.setAttribute("auth", auth);
	OrderDao od = new OrderDao(DbCon.getConnection());
	orders = od.userOrder(auth.getId());	
	
}else{
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>

<title>Order</title>
	<%@ include file="includes/header.jsp" %>
</head>
<body>
	<div id= "main">
	<div class="header_top">
			<div class="logo">
				<a href="index.jsp"><img src="./asset/images/logo.png" alt="" /></a>
			</div>
			<div class="header_top_right">
			    <div class="search_box">
				    <form>
				    	<input type="text" value="Search for Products" ><input type="submit" value="SEARCH">
				    </form>
			    </div>
			    <div class="shopping_cart">
					<div class="cart" >
						<a href="cart.jsp" title="View my shopping cart" rel="nofollow">
								<span class="cart_title" >Cart</span>
								<span class = "badge badge-danger">${cart_list.size()}</span>
						</a>
					</div>
			    </div>
		   <%	if(auth != null){%>
            		<a href="log-out" class="btn navbar__signin">
                    	<span class="signin__text">Log out</span>
                	</a>
            	<% }else{%>
            		 <a href="./login.jsp" class="btn navbar__signin">
                		<span class="signin__text">Sign in</span>
           			 </a>
            	<%}%>
		 <div class="clear"></div>
	 		</div>
 		</div>
		<div class="menu">
			<ul id="menu-store">
			  <li><a href="index.jsp">Home</a></li>
			  <li><a href="product.jsp">Products</a> </li>
			  <li><a href="cart.jsp">Cart</a></li>
			  <li><a href="order.jsp">Order</a></li>
			  <li><a href="Contact.jsp">Contact</a> </li>
			  <div class="clear"></div>
			</ul>
		</div>
	<div class = "card-header my-3">All Orders</div>
	<table class = "table table-Light">
		<thead>
			<tr>
				<th scope ="col">Date</th>
				<th scope ="col">Name</th>
				<th scope ="col">Quantity</th>
				<th scope ="col">Price</th>
				<th scope ="col">Cancel</th>
			</tr>
		</thead>
		<tbody>
		<%
			if(orders != null){
				for(Order o: orders){%>
				<tr>
					<td><%= o.getDate() %></td>
					<td><%= o.getName() %></td>
					<td><%= o.getQuantity() %></td>
					<td><%= o.getPrice() %></td>
					<td><a class = "btn btn-sm btn-danger" href ="cancel-order?id=<%= o.getOrderId()%>">Cancel</a></td>
				</tr>			
			<% }
				}
		%>
		</tbody>
	</table>
	</div>
</body>
</html>