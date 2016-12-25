package com.hoticer.ordering.service;

import java.util.List;
import java.util.Set;

import com.hoticer.ordering.dao.FoodDao;
import com.hoticer.ordering.dao.TradeDao;
import com.hoticer.ordering.dao.TradeItemDao;
import com.hoticer.ordering.dao.UserDao;
import com.hoticer.ordering.dao.impl.FoodDaoImpl;
import com.hoticer.ordering.dao.impl.TradeDaoImpl;
import com.hoticer.ordering.dao.impl.TradeItemDaoImpl;
import com.hoticer.ordering.dao.impl.UserDaoImpl;
import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.domain.TradeItem;
import com.hoticer.ordering.domain.User;

public class BossService {
	private FoodDao foodDao = new FoodDaoImpl();
	private UserDao userDao = new UserDaoImpl();
	private TradeDao tradeDao = new TradeDaoImpl();
	private TradeItemDao tradeItemDao = new TradeItemDaoImpl();

	public Set<Trade> getTradesByDate(String queryDate) {
		Set<Trade> trades = tradeDao.getTradesByDate(queryDate);
		if (trades != null) {
			for (Trade trade : trades) {
				int tradeId = trade.getTradeId();
				Set<TradeItem> items = tradeItemDao.getTradeItemsWithTradeId(tradeId);
				if (items != null) {
					for (TradeItem item : items) {
						item.setFood(foodDao.getFood(item.getFoodId()));
					}
					trade.setItems(items);
				}
			}
		}
		return trades;
	} 
	
	public void insertUser(User user) {
		userDao.insert(user);
	}

	public void deleteUser(int userId) {
		userDao.delete(userId);
	}

	public void updateUser(User user) {
		userDao.update(user);
	}
	
	public User getUserByUserId(int userId) {
		return userDao.getUserByUserId(userId);
	}
	
	public List<User> getUsers() {
		return userDao.getUserList();
	}

	public void insertFood(Food food) {
		foodDao.insert(food);
	}

	public void deleteFood(int foodId) {
		foodDao.delete(foodId);
	}

	public void updateFood(Food food) {
		foodDao.update(food);
	}

	public boolean hasUser(String username) {
		if(userDao.getCounts(username)>0)
			return true;
		return false;
	}
}
