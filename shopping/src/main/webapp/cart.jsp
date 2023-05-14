<%@page import="java.text.DecimalFormat"%>
<%@page import="cn.webmarket.connection.DbCon"%>
<%@page import="cn.webmarket.dao.ProductDao"%>
<%@page import="java.util.*"%>
<%@page import = "cn.webmarket.model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
  User auth= (User)request.getSession().getAttribute("auth");
  if(auth != null){
	  request.setAttribute("auth", auth);

  }
 %>	   
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if(cart_list != null){
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	request.setAttribute("cart_list",cart_list );
	
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="includes/header.jsp" %>
   <title>Cart</title>
</head>
<body>
    <div id="main">
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
       <%@include file="includes/navbar.jsp" %>
        <div class="content-cart">
            <div class="cartoption">		
                <div class="cartpage">
                        <h2>Your Cart</h2>
                            <table class="tblone">
                                  <th width="20%">Product Name</th>
                                    <th width="10%">Image</th>
                                    <th width="15%">Price</th>
                                    <th width="25%">Quantity</th>
                                    <th width="20%">Total Price</th>
                                    <th width="10%">Action</th>
                                </tr>
<%
                                	if(cart_list != null){
                                		for(Cart c: cartProduct){%>
                                			 <tr>
                                             <td><%= c.getName() %></td>
                                             <td><img src="<%=c.getImg()%>" alt="Image is here" ></td>
                                             <td><%=Double.toString(c.getPrice()) %></td>
                                             <td>
                                                 <form action="">
                                                 <input type = "hidden" name = "id" value ="<%= c.getId()%>" class ="form-imput">
                                                     <a href ="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class = "fas fa-minus-square"></i></a>
                                                     <input type="text" name="quantity" value="<%=c.getQuantity() %>" readonly/>
                                                     <a href ="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class = "fas fa-plus-square"></i></a>
                                              
                                                 </form>
                                             </td>
                                             <td><%= Double.toString(c.setEachTotalPrice(c.getPrice(), c.getQuantity())) %></td>
                                             <td><a href="remove-from-cart?id=<%= c.getId()%>">Remove</a></td>
                                         </tr>
                                        
                                			
                                		<%}
                                	}
                                %>
                               
                                
                            </table>
                            <table style="float:right;text-align:left;" width="40%">
                                <tr>
                                    <th>Sub Total : ${(total>0)?dcf.format(total):0} </th>
                           
                                </tr>
                             
                           </table>
                           <div class="clear"></div>
                        </div>
                        <div class="shopping">
                            <div class="shopleft">
                                <a href="index.jsp"> <img src="./asset/images/shop.png" alt="" /></a>
                            </div>
                            <div class="shopright">
                                <a href="check-out"> <img src="./asset/images/check.png" alt="" /></a>
                            </div>
                        </div>
            </div>  	
           <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
	<%@include file="includes/footer.jsp" %>
</body>
</html>