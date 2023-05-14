package cn.webmarket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.webmarket.model.User;

public class UserDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "select * from users where email=? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			
			if(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return user;
	}
	public boolean userRegisted(User newUser) {
		boolean added = false;
		try {
			query = "insert into users(name,email,password,phone) values(?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setString(1, newUser.getName());
			pst.setString(2, newUser.getEmail());
			pst.setString(3, newUser.getPassword());
			pst.setString(4, newUser.getPhone());
			int row = pst.executeUpdate();
			if(row > 0) {
				added = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return added;
	}
	
}
