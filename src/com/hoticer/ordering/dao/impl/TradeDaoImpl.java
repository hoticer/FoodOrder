package com.hoticer.ordering.dao.impl;

import java.util.LinkedHashSet;
import java.util.Set;

import com.hoticer.ordering.dao.TradeDao;
import com.hoticer.ordering.domain.Trade;

public class TradeDaoImpl extends BaseDao<Trade> implements TradeDao {

	@Override
	public void insert(Trade trade) {
		String sql = "INSERT INTO trade(tableId,tradetime,pay) VALUES (?,?,?) ";
		int tradeId = (int) insert(sql, trade.getTableId(), trade.getTradeTime(), 0);
		trade.setTradeId(tradeId);
	}

	@Override
	public Set<Trade> getTradesWithTableId(Integer tableId) {
		String sql = "SELECT tradeId,tableId,tradeTime,pay FROM trade WHERE tableId = ? ORDER BY tradeTime DESC";
		return new LinkedHashSet<Trade>(queryForList(sql, tableId));
	}

	@Override
	public Trade getTradeWithTradeId(Integer tradeId) {
		String sql = "SELECT tradeId,tableId,tradeTime,pay FROM trade WHERE tradeId = ?";
		return query(sql, tradeId);
	}

	@Override
	public Set<Trade> getNewTrades(int access) {
		String sql = "SELECT tradeId,tableId,tradeTime,pay FROM trade WHERE pay = 0 AND tableId BETWEEN ? AND ? ORDER BY tradeTime DESC ";
		return new LinkedHashSet<Trade>(queryForList(sql, access * 4 - 3, access * 4));
	}

	@Override
	public void updatePay(Integer tradeId, Integer pay) {
		String sql = "UPDATE trade SET pay = ? WHERE tradeId = ?";
		update(sql, pay, tradeId);
	}

	@Override
	public Set<Trade> getTradesByDate(String queryDate) {
		String sql = "SELECT tradeId,tableId,tradeTime,pay FROM trade WHERE tradeTime LIKE ? ORDER BY tradeTime DESC";
		return new LinkedHashSet<Trade>(queryForList(sql, queryDate+"%"));
	}

}
