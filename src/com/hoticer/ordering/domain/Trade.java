package com.hoticer.ordering.domain;

import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Set;

public class Trade {
	private Integer tradeId;
	private Integer tableId;
	private Timestamp tradeTime;
	private Integer pay;
	private Set<TradeItem> items = new LinkedHashSet<TradeItem>();

	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}

	public Integer getTableId() {
		return tableId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Timestamp getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(Timestamp tradeTime) {
		this.tradeTime = tradeTime;
	}

	public Integer getPay() {
		return pay;
	}

	public void setPay(Integer pay) {
		this.pay = pay;
	}

	public Set<TradeItem> getItems() {
		return items;
	}

	public void setItems(Set<TradeItem> items) {
		this.items = items;
	}

	@Override
	public String toString() {
		return "Trade [tradeId=" + tradeId + ", tableId=" + tableId + ", tradeTime=" + tradeTime + ", pay=" + pay + "]";
	}

}
