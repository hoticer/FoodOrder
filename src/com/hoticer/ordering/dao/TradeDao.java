package com.hoticer.ordering.dao;

import java.util.Set;

import com.hoticer.ordering.domain.Trade;

public interface TradeDao {

	/**
	 * �����ݱ��в��� Trade ����
	 * 
	 * @param trade
	 */
	public abstract void insert(Trade trade);

	/**
	 * ���� userId ��ȡ��������� Trade �ļ���
	 * 
	 * @param userId
	 * @return
	 */
	public abstract Set<Trade> getTradesWithTableId(Integer tableId);

	/**
	 * ����tradeId��ȡtrade
	 * @param tradeId
	 * @return
	 */
	public abstract Trade getTradeWithTradeId(Integer tradeId);

	/**
	 * ����access��ȡ�µ�trade�ļ���
	 * @param access
	 * @return
	 */
	public abstract Set<Trade> getNewTrades(int access);

	/**
	 * ���¶���״̬
	 * @param tradeId
	 * @param pay
	 */
	public abstract void updatePay(Integer tradeId, Integer pay);
	
	/**
	 * ����queryDate��ȡtrade����
	 * @param queryDate
	 * @return
	 */
	public abstract Set<Trade> getTradesByDate(String queryDate);
}