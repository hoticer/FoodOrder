package com.hoticer.ordering.domain;

public class TradeItem {
	private Integer itemId;
	private Integer foodId;
	private int quantity;
	private Integer tradeId;
	private Food food;

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getFoodId() {
		return foodId;
	}

	public void setFoodId(Integer foodId) {
		this.foodId = foodId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}

	public Food getFood() {
		return food;
	}

	public void setFood(Food food) {
		this.food = food;
	}

	public TradeItem(Integer tradeItemId, Integer foodId, int quantity, Integer tradeId) {
		super();
		this.itemId = tradeItemId;
		this.foodId = foodId;
		this.quantity = quantity;
		this.tradeId = tradeId;
	}

	public TradeItem() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "TradeItem [itemId=" + itemId + ", foodId=" + foodId + ", quantity=" + quantity + ", tradeId=" + tradeId
				+ "]";
	}
}
