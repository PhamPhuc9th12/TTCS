package cn.webmarket.model;

public class Product {
	private int id;
	private String img;
	private String name;
	private Double price;
	private String diScription;
	private String category;
	public Product() {
		// TODO Auto-generated constructor stub
	}
	public Product(int id, String img, String name, Double price, String diScription,String category) {
		super();
		this.id = id;
		this.img = img;
		this.name = name;
		this.price = price;
		this.diScription = diScription;
		this.category = category;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getDiScription() {
		return diScription;
	}
	public void setDiScription(String diScription) {
		this.diScription = diScription;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", img=" + img + ", name=" + name + ", price=" + price + ", diScription="
				+ diScription +", category=" + category + "]";
	}
	
	
	
}
