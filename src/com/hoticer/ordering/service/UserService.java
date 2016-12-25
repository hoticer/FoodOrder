package com.hoticer.ordering.service;

import java.util.Set;

import com.hoticer.ordering.dao.FoodDao;
import com.hoticer.ordering.dao.TradeDao;
import com.hoticer.ordering.dao.TradeItemDao;
import com.hoticer.ordering.dao.UserDao;
import com.hoticer.ordering.dao.impl.FoodDaoImpl;
import com.hoticer.ordering.dao.impl.TradeDaoImpl;
import com.hoticer.ordering.dao.impl.TradeItemDaoImpl;
import com.hoticer.ordering.dao.impl.UserDaoImpl;
import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.domain.TradeItem;
import com.hoticer.ordering.domain.User;

public class UserService {
	private FoodDao foodDao = new FoodDaoImpl();
	private UserDao userDao = new UserDaoImpl();
	private TradeDao tradeDao = new TradeDaoImpl();
	private TradeItemDao tradeItemDao = new TradeItemDaoImpl();

	public void updatePay(int tradeId, int pay) {
		tradeDao.updatePay(tradeId, pay);
	}

	public Set<Trade> getTrades(int tableId) {
		Set<Trade> trades = tradeDao.getTradesWithTableId(tableId);
		if (trades != null) {
			for (Trade trade : trades) {
				int tradeId = trade.getTradeId();
				if (trade.getPay() == 0) {
					tradeDao.updatePay(tradeId, 1);
					trade.setPay(1);
				}
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

	public Trade queryTrade(int tradeId) {
		Trade trade = getCustomerTrade(tradeId);
		if (trade!=null&&trade.getPay() == 0) {
			tradeDao.updatePay(tradeId, 1);
			trade.setPay(1);
		}
		return trade;
	}

	public Set<Trade> getNewTrades(int access) {
		return tradeDao.getNewTrades(access);
	}

	public User getUserByUserName(String username) {
		return userDao.getUser(username);
	}

	public Trade getCustomerTrade(int tradeId) {
		Trade trade = tradeDao.getTradeWithTradeId(tradeId);
		Set<TradeItem> items = tradeItemDao.getTradeItemsWithTradeId(tradeId);
		if (trade != null && items != null) {
			for (TradeItem item : items) {
				item.setFood(foodDao.getFood(item.getFoodId()));
			}
			trade.setItems(items);
		}
		return trade;
	}
}
