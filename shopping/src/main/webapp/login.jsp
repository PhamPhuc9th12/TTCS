<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="cn.webmarket.dao.ProductDao"%>
<%@page import="cn.webmarket.connection.DbCon"%>
<%@page import ="cn.webmarket.model.*" %>
  <%
  User auth= (User)request.getSession().getAttribute("auth");
  if(auth != null){
	  request.setAttribute("auth", auth);

  }
 %>	  
 <%
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if(cart_list != null){
		request.setAttribute("cart_list",cart_list );
	}
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="includes/header.jsp" %>
<title>Login</title>
</head>
<body>
	<input type = "hidden" id = "status" value ="<%= request.getAttribute("status") %>">
		<input type = "hidden" id = "statusRegis" value ="<%= request.getAttribute("statusRegis") %>">
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
	<%@include file = "includes/navbar.jsp" %>

        <div class="content-login">
            <div class="sign-in-form">
                <h3>You have an account</h3>
                <p>Please sign in with the form bellow</p>
                <form action="user-login" method="post">
                    <input class = "sign-in-field" type="email" placeholder="Enter your Email" name ="login-email" required="required">
                    <input class = "sign-in-field" type="password" placeholder="******" name ="login-password" required="required" >                    
                <p>If you forgot your passoword just enter your email and click <a href="#">here</a></p>
                <div class="button-login">
                    <button>Sign In</button>
                </div>
                </form>
            </div>
            <div class="register-form">
                <h3>Register New Accout</h3>
                <form action="user-registration" method ="post">
                    <input class = "register-field"type="text" name ="uName" placeholder="Your Name">
                    <input class = "register-field"type="email" name ="uEmail" placeholder="Email">
                    <input class = "register-field"type="password" name ="uPassword" placeholder="Password">
                    <input class = "register-field"type="text" name ="uPhone"placeholder="Phone Number">
                <div class="button-register">
                    <button>Create Accout</button>
                    <p class="terms">By clicking 'Create Account' you agree to the <a href="#">Terms &amp; Conditions</a>.</p>
                </div>
                </form>
            </div>
        </div>
    </div>

    <%@include file="includes/footer.jsp" %>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type = "text/javascript">
	var status = document.getElementById("status").value;
	if(status == "failed"){
		swal("Sorry","Wrong Username or Password","failed")
	}
</script>
<script type = "text/javascript">
	var statusRegis = document.getElementById("statusRegis").value;
	if(statusRegis == "success"){
		swal("Done","Your Account is created","Welcome to my Store!");
	}
</script>


</body>
</html>