package com.hoticer.ordering.dao;

import java.util.Set;

import com.hoticer.ordering.domain.Trade;

public interface TradeDao {

	/**
	 * 向数据表中插入 Trade 对象
	 * 
	 * @param trade
	 */
	public abstract void insert(Trade trade);

	/**
	 * 根据 userId 获取和其关联的 Trade 的集合
	 * 
	 * @param userId
	 * @return
	 */
	public abstract Set<Trade> getTradesWithTableId(Integer tableId);

	/**
	 * 根据tradeId获取trade
	 * @param tradeId
	 * @return
	 */
	public abstract Trade getTradeWithTradeId(Integer tradeId);

	/**
	 * 根据access获取新的trade的集合
	 * @param access
	 * @return
	 */
	public abstract Set<Trade> getNewTrades(int access);

	/**
	 * 更新订单状态
	 * @param tradeId
	 * @param pay
	 */
	public abstract void updatePay(Integer tradeId, Integer pay);
	
	/**
	 * 根据queryDate获取trade集合
	 * @param queryDate
	 * @return
	 */
	public abstract Set<Trade> getTradesByDate(String queryDate);
}