package com.hoticer.ordering.dao.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.hoticer.ordering.dao.TradeItemDao;
import com.hoticer.ordering.domain.TradeItem;

public class TradeItemDaoImpl extends BaseDao<TradeItem> implements TradeItemDao {

	@Override
	public void batchSave(Collection<TradeItem> items) {
		String sql = "INSERT INTO tradeitem(foodid,quantity,tradeid) VALUES(?,?,?)";
		Object[][] params = new Object[items.size()][3];
		List<TradeItem> tradeItems = new ArrayList<>(items);
		for(int i = 0;i < tradeItems.size();i++){
			params[i][0] = tradeItems.get(i).getFoodId();
			params[i][1] = tradeItems.get(i).getQuantity();
			params[i][2] = tradeItems.get(i).getTradeId();
		}
		batch(sql, params);
	}

	@Override
	public Set<TradeItem> getTradeItemsWithTradeId(Integer tradeId) {
		String sql = "SELECT itemId,foodId,quantity,tradeId FROM tradeitem WHERE tradeId = ?";
		return new HashSet<TradeItem>(queryForList(sql, tradeId));
	}

}
