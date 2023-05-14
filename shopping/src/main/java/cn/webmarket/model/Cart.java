package cn.webmarket.model;

public class Cart extends Product {
	private int quantity;
	
	
	public Cart() {
		
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public double setEachTotalPrice(double price,int quantity) {
		return price *quantity;
	}
	
}
