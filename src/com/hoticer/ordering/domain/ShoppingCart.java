package com.hoticer.ordering.domain;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
	
	private Map<Integer, ShoppingCartItem> foods = new HashMap<>();
	
	/**
	 * �޸�ָ�������������
	 */
	public void updateItemQuantity(Integer foodId, int quantity){
		ShoppingCartItem sci =foods.get(foodId);
		if(sci != null){
			sci.setQuantity(quantity);
		}
	}
	
	/**
	 * �Ƴ�ָ���Ĺ�����
	 * @param id
	 */
	public void removeItem(Integer foodId){
		foods.remove(foodId);
	}
	
	/**
	 * ��չ��ﳵ
	 */
	public void clear(){
		foods.clear();
	}
	
	/**
	 * ���ع��ﳵ�Ƿ�Ϊ��
	 * @return
	 */
	public boolean isEmpty(){
		return foods.isEmpty();
	}
	
	/**
	 * ��ȡ���ﳵ�����е���Ʒ���ܵ�Ǯ��
	 * @return
	 */
	public float getTotalMoney(){
		float total = 0;
		
		for(ShoppingCartItem sci: getItems()){
			total += sci.getItemMoney();
		}
		
		return total;
	}
	
	/**
	 * ��ȡ���ﳵ�е����е� ShoppingCartItem ��ɵļ���
	 * @return
	 */
	public Collection<ShoppingCartItem> getItems(){
		return foods.values();
	}
	
	/**
	 * ���ع��ﳵ����Ʒ��������
	 * @return
	 */
	public int getFoodNumber(){
		int total = 0;
		
		for(ShoppingCartItem sci: foods.values()){
			total += sci.getQuantity();
		}
		
		return total;
	}
	
	public Map<Integer, ShoppingCartItem> getFoods() {
		return foods;
	}
	
	/**
	 * ���鹺�ﳵ���Ƿ��� id ָ������Ʒ		
	 * @param id
	 * @return
	 */
	public boolean hasFood(Integer foodId){
		return foods.containsKey(foodId);
	}		
			
	/**
	 * ���ﳵ�����һ����Ʒ		
	 * @param food
	 */
	public void addFood(Food food){
		//1. ��鹺�ﳵ����û�и���Ʒ, ����, ��ʹ������ +1, ��û��, 
		//�´������Ӧ�� ShoppingCartItem, ��������뵽 foods ��
		ShoppingCartItem sci = foods.get(food.getFoodId());
		
		if(sci == null){
			sci = new ShoppingCartItem(food);
			foods.put(food.getFoodId(), sci);
		}else{
			sci.increment();
		}
	}
}
