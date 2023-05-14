package cn.webmarket.dao;

import cn.webmarket.connection.DbCon;
import cn.webmarket.model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.webmarket.model.*;

public class ProductDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ProductDao(Connection con) {
		this.con = con;
	}
	
	public List<Product> getAllProduct(){
		List<Product> products = new ArrayList<Product>();
		try {
			query = "select * from products";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setDiScription(rs.getString("discription"));
				row.setPrice(rs.getDouble("price"));
				row.setImg(rs.getString("image"));
				row.setCategory(rs.getString("category"));
				products.add(row);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return products;
	}

	
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products = new ArrayList<Cart>();
		try {
			if(cartList.size() > 0) {
				for(Cart item:cartList) {
					query = "select * from products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setDiScription(rs.getString("discription"));
						row.setPrice(rs.getDouble("price"));
						row.setEachTotalPrice(rs.getDouble("price"), item.getQuantity());
						row.setQuantity(item.getQuantity());
						row.setImg(rs.getString("image"));
						row.setCategory(rs.getString("category"));
						products.add(row);
						
					}
				}
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return products;
	}
	public Product getSingleProduct(int id) {
		Product row = null;
		
		try {
			query = "select * from products where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			
			while(rs.next()) {
				row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setPrice(rs.getDouble("price"));
				row.setImg(rs.getString("image"));
				row.setDiScription(rs.getString("diScription"));
				row.setCategory(rs.getString("category"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return row;
	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException {
//	ProductDao pd = new ProductDao(DbCon.getConnection());
//	Product list = pd.getSingleProduct(1);
//	
//		System.out.println(list);
//	
//}
	
	public double getTotalCartPrice(ArrayList<Cart> cartList) {
		double sum = 0;
		try {
			if(cartList.size() > 0) {
				for(Cart item:cartList) {
					query = "select price from products where id=?";
					 pst = this.con.prepareStatement(query);
					 pst.setInt(1, item.getId());
					 rs = pst.executeQuery();
					 
					 while(rs.next()) {
						 sum+= rs.getDouble("price")*item.getQuantity();
					 }
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	
	public List<Product> searchProduct(String txtSearch){
		List<Product> products = new ArrayList<Product>();
		try {
			query = "select * from products where [name] like ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1,"%"+txtSearch+"%");
			rs = pst.executeQuery();
			while(rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setDiScription(rs.getString("discription"));
				row.setPrice(rs.getDouble("price"));
				row.setImg(rs.getString("image"));
				row.setCategory(rs.getString("category"));
				
				products.add(row);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return products;
	}

}
