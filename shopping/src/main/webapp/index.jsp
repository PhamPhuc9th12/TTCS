<%@page import="java.util.*"%>
<%@page import="cn.webmarket.dao.ProductDao"%>
<%@page import="cn.webmarket.connection.DbCon"%>
<%@page import ="cn.webmarket.model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	
%>

<%	
	ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
	if(cart_list != null){
		request.setAttribute("cart_list",cart_list );
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="includes/header.jsp" %>
 <title>HomePage</title>
</head>
<body>
<input type = "hidden" id = "status" value ="<%= request.getAttribute("status") %>">
<input type = "hidden" id = "addedProduct" value ="<%= request.getAttribute("addedProduct") %>">
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
        <%@include file="includes/navbar.jsp" %>
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
						for(Product p: listP){%>
								<div class="content-products-1-4">
								<div class="product-img">
									<img src="<%=p.getImg() %>" alt="products-image">
								</div>
								<h3><%= p.getName() %></h3>
								<div class="product-about">
									<a href="detail-product?id=<%=p.getId() %>" ><button class = "detail">Details</button></a>
									<p class = "price">Price: <%= Double.toString(p.getPrice())%>$</p>
									<a  href = "add-to-cart?id=<%= p.getId()%>"><button class = "btn-add" >Add to Cart</button></a>
									<a  href = "order-now?quantity=1&id=<%=p.getId()%>"><button class = "btn-buy" >Buy Now</a></button>
								</div>
							</div>
							<%
						}
					}
				%>
				
				
				
		</div>
    </div>
   </div> 
  </div>


	<%@ include file="includes/footer.jsp" %>
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
   <link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type = "text/javascript">
	var status = document.getElementById("status").value;
	if(status == "success"){
		swal("Congrats", "Login Successful", "Welcome")
	}
	var added = document.getElementById("addedProduct").value;
	if(added == "success"){
		swal("Your Product is added in Cart")
	}
</script>
</body>
</html>