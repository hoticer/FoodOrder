package com.hoticer.ordering.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;

import com.hoticer.ordering.dao.FoodDao;
import com.hoticer.ordering.dao.TradeDao;
import com.hoticer.ordering.dao.TradeItemDao;
import com.hoticer.ordering.dao.impl.FoodDaoImpl;
import com.hoticer.ordering.dao.impl.TradeDaoImpl;
import com.hoticer.ordering.dao.impl.TradeItemDaoImpl;
import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.ShoppingCart;
import com.hoticer.ordering.domain.ShoppingCartItem;
import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.domain.TradeItem;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;

public class FoodService {
	private FoodDao foodDao = new FoodDaoImpl();

	public Page<Food> getPage(CriteriaFood criteriaFood) {
		return foodDao.getPage(criteriaFood);
	}

	public Food getFood(int foodId) {
		return foodDao.getFood(foodId);
	}

	public boolean addToCart(int foodId, ShoppingCart sc) {
		Food food = foodDao.getFood(foodId);
		if (food != null) {
			sc.addFood(food);
			return true;
		}
		return false;
	}

	public void removeItemFromShoppingCart(ShoppingCart sc, int foodId) {
		sc.removeItem(foodId);
	}

	public void clearShoppingCart(ShoppingCart sc) {
		sc.clear();
	}

	public void updateItemQuantity(ShoppingCart sc, int foodId, int quantity) {
		sc.updateItemQuantity(foodId, quantity);
	}

	private TradeDao tradeDao = new TradeDaoImpl();
	private TradeItemDao tradeItemDAO = new TradeItemDaoImpl();

	// 业务方法
	public int cash(ShoppingCart shoppingCart, Integer tableId) {
		if(shoppingCart.getItems().isEmpty())
			return 0;
		
		// 1更新myfoods数据表相关记录的salesamount和storenumber
		foodDao.batchUpdateStoreNumberAndSalesAmount(shoppingCart.getItems());

		// 3.向trade数据表插入一条记录
		Trade trade = new Trade();
		Timestamp ts = new Timestamp(new java.util.Date().getTime());
		trade.setTradeTime(ts);
		trade.setTableId(tableId);
		trade.setPay(0);
		tradeDao.insert(trade);
		int tradeId = trade.getTradeId();

		// 4.向tradeItem数据表插入n条记录
		Collection<TradeItem> items = new ArrayList<>();
		for (ShoppingCartItem sci : shoppingCart.getItems()) {
			TradeItem tradeItem = new TradeItem();
			tradeItem.setFoodId(sci.getFood().getFoodId());
			tradeItem.setQuantity(sci.getQuantity());
			tradeItem.setTradeId(trade.getTradeId());
			items.add(tradeItem);
		}
		tradeItemDAO.batchSave(items);

		// 5.清空购物车
		shoppingCart.clear();

		return tradeId;
	}
}
