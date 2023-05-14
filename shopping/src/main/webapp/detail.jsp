<%@page import="cn.webmarket.dao.OrderDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.webmarket.dao.*"%>
<%@page import="cn.webmarket.connection.DbCon"%>
<%@page import ="cn.webmarket.model.*" %>
<%@page import="java.text.DecimalFormat"%>
<%
User auth= (User)request.getSession().getAttribute("auth");
if(auth != null){
	  request.setAttribute("auth", auth);

}
%>	
   
<%

	ProductDao pd = new ProductDao(DbCon.getConnection());
	List<Product> listP = pd.getAllProduct();
	
	String category = String.valueOf(request.getAttribute("category"));
	
	String idProduct = String.valueOf(request.getAttribute("idProduct"));
	
	int idP = Integer.parseInt(idProduct);
%>

<%	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
	if(cart_list != null){
		request.setAttribute("cart_list",cart_list );
	}
%>
<!DOCTYPE html>
<html>
<head>

<title>Details</title>
	<%@ include file="includes/header.jsp" %>
</head>
<body>
	<div id="main">
    	<div class="header_top">
			<div class="logo">
				<a href="index.jsp"><img src="./asset/images/logo.png" alt="" /></a>
			</div>
			<div class="header_top_right">
			    <div class="search_box">
				    <form action ="search">
				    	<input name = "txt" type="text" value="" ></input>
				    	<button type = "submit" class = "button-search" >
				    			<i class = "fa fa-search"></i>
				    	</button>
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
                	<a>Hello <%= auth.getName() %></a>
            	<% }else{%>
            		 <a href="./login.jsp" class="btn navbar__signin">
                		<span class="signin__text">Log In</span>
           			 </a>
            	<%}%>
		 <div class="clear"></div>
	 		</div>
 		</div>
			<div class="menu">
			<ul id="menu-store">
			  <li><a href="index.jsp">Home</a></li>
			  <li><a href="index.jsp">Products</a> </li>
			  <li><a href="cart.jsp">Cart</a></li>
			  <li><a href="order.jsp">Order</a></li>
			  <li><a href="Contact.jsp">Contact</a> </li>
			  <div class="clear"></div>
			</ul>
		</div>
		<div class="content">
			<div class="content-1-2">
				<div class="content-heading">
					<a href = "index.jsp" class= "category">All Product</a>
					<a href = "product-implement?category=Cooker" class= "category">Cooker</a>
					<a href = "product-implement?category=Refrigerator"class= "category">Refrigerator</a>
					<a href = "product-implement?category=grinder"class= "category">Grinder</a>
				</div>
				<div class="content-products">
				       			<%	
					if(!listP.isEmpty()){
						for(Product p: listP){
							if(p.getId() == idP){%>
		<div class="detail-container">
        <div class="detail-attribute">
            <div class="detail-img">
                <img src="<%=p.getImg() %>" alt="his is image" class="im">
            </div>
            <div class="name-price">
            <span class = "name-p">Name Product: <p><%=p.getName() %></p></span>
            <span class = "price-p" >Price: <p><%=p.getPrice()%>$</p> </span>
            <div class = "product-about">
            <a  href = "add-to-cart?id=<%= p.getId()%>"><button class = "btn-add" >Add to Cart</button></a>
			<a  href = "order-now?quantity=1&id=<%=p.getId()%>"><button class = "btn-buy" >Buy Now</a></button>
            </div>
            </div>

        </div>
        <div class="detail-infor">
            <h3>Product Information</h3>
            <p><%=p.getDiScription()%></p>
        </div>
    </div>
						<%	}
								
							
						}
					}
				%>
				
				
				
		</div>
    </div>
   </div> 
  </div>
		<%@ include file="includes/footer.jsp" %>
</body>
</html>