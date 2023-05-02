package com.login.bean;

import java.sql.Timestamp;

public class ListingBean {
	int auctionId;
	int sellerId;
	public ListingBean(int auctionId, int sellerId, String category, String itemName, String brand, String color,
			String size, String gender, Float price, Float reservePrice, Timestamp closeDate) {
		super();
		this.auctionId = auctionId;
		this.sellerId = sellerId;
		this.category = category;
		this.itemName = itemName;
		this.brand = brand;
		this.color = color;
		this.size = size;
		this.gender = gender;
		this.price = price;
		this.reservePrice = reservePrice;
		this.closeDate = closeDate;
	}
	public ListingBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getAuctionId() {
		return auctionId;
	}
	public void setAuctionId(int auctionId) {
		this.auctionId = auctionId;
	}
	public void setReservePrice(Float reservePrice) {
		this.reservePrice = reservePrice;
	}
	public int getSellerId() {
		return sellerId;
	}
	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}
	String category;
	String itemName;
	String brand;
	String color;
	String size;
	String gender;
	Float price;
	Float reservePrice;
	Timestamp closeDate;
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public float getReservePrice() {
		return reservePrice;
	}
	public void setReservePrice(float reservePrice) {
		this.reservePrice = reservePrice;
	}
	public Timestamp getCloseDate() {
		return closeDate;
	}
	public void setCloseDate(Timestamp timestamp) {
		this.closeDate = timestamp;
	}
	@Override
	public String toString() {
		return "ListingBean [category=" + category + ", itemName=" + itemName + ", brand=" + brand + ", color=" + color
				+ ", size=" + size + ", gender=" + gender + ", price=" + price + ", reservePrice=" + reservePrice
				+ ", closeDate=" + closeDate + "]";
	}
	
	

}
