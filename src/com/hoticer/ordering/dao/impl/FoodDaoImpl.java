package com.hoticer.ordering.dao.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.hoticer.ordering.dao.FoodDao;
import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.ShoppingCartItem;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;

public class FoodDaoImpl extends BaseDao<Food> implements FoodDao {

	@Override
	public Food getFood(int foodId) {
		String sql = "SELECT foodId,foodName,price,salesAmount,storeNumber,details FROM myfoods WHERE foodId = ?";
		return query(sql, foodId);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Page<Food> getPage(CriteriaFood cb) {
		Page page = new Page<>(cb.getPageNo());

		page.setTotalItemNumber(getTotalFoodNumber(cb));
		// 校验pageNo的合法性
		cb.setPageNo(page.getPageNo());
		page.setList(getPageList(cb, page.getPageSize()));

		return page;
	}

	@Override
	public long getTotalFoodNumber(CriteriaFood cb) {
		String sql = "SELECT count(foodId) FROM myfoods WHERE price >= ? AND price <= ?";
		return getSingleVal(sql, cb.getMinPrice(), cb.getMaxPrice());
	}

	@Override
	public List<Food> getPageList(CriteriaFood cb, int pageSize) {
		String sql = "SELECT foodId,foodName,price,"
				+ "salesAmount,storeNumber,details FROM myfoods WHERE price >= ? AND price <= ? " + "LIMIT ?, ?";
		return queryForList(sql, cb.getMinPrice(), cb.getMaxPrice(), (cb.getPageNo() - 1) * pageSize, pageSize);
	}

	@Override
	public int getStoreNumber(Integer foodId) {
		String sql = "SELECT storeNumber FROM myfoods WHERE foodId = ?";
		return getSingleVal(sql, foodId);
	}

	@Override
	public void batchUpdateStoreNumberAndSalesAmount(Collection<ShoppingCartItem> items) {
		String sql = "UPDATE myfoods SET salesAmount = salesAmount + ?," + "storeNumber = storeNumber - ? WHERE foodId = ?";
		Object[][] params = null;
		params = new Object[items.size()][3];
		List<ShoppingCartItem> scis = new ArrayList<>(items);
		for (int i = 0; i < items.size(); i++) {
			params[i][0] = scis.get(i).getQuantity();
			params[i][1] = scis.get(i).getQuantity();
			params[i][2] = scis.get(i).getFood().getFoodId();
		}
		batch(sql, params);
	}

	@Override
	public void insert(Food food) {
		String sql = "INSERT INTO myfoods(foodname,price,salesamount,storenumber,details) VALUES (?,?,?,?,?) ";
		int foodId = (int) insert(sql, food.getFoodName(), food.getPrice(), 0, food.getStoreNumber(), food.getDetails());
		food.setFoodId(foodId);
	}

	@Override
	public void delete(int foodId) {
		String sql = "DELETE FROM myfoods WHERE foodId = ?";
		update(sql, foodId);
	}

	@Override
	public void update(Food food) {
		String sql = "UPDATE myfoods SET foodName = ?,price = ?, storeNumber = ? , details = ? WHERE foodId = ?";
		update(sql, food.getFoodName(), food.getPrice(), food.getStoreNumber(), food.getDetails(), food.getFoodId());
	}

}
