package com.hoticer.ordering.domain;

/**
 * ��װ�˹��ﳵ�е���Ʒ, ��������Ʒ�������Լ����ﳵ�и���Ʒ������
 *
 */
public class ShoppingCartItem {

	private Food food;
	private int quantity;

	public ShoppingCartItem(Food food) {
		this.food = food;
		this.quantity = 1;
	}

	public Food getFood() {
		return food;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	/**
	 * ���ظ���Ʒ�ڹ��ﳵ�е�Ǯ��
	 * 
	 * @return
	 */
	public float getItemMoney() {
		return food.getPrice() * quantity;
	}

	/**
	 * ʹ��Ʒ���� + 1
	 */
	public void increment() {
		quantity++;
	}

}
