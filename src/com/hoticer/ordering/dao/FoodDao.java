package com.hoticer.ordering.dao;

import java.util.Collection;
import java.util.List;

import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.ShoppingCartItem;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;

public interface FoodDao {

	/**
	 * 根据 id 获取指定 Food 对象
	 * @param id
	 * @return
	 */
	public abstract Food getFood(int foodId);

	/**
	 * 根据传入的 CriteriaFood 对象返回对应的 Page 对象
	 * @param cb
	 * @return
	 */
	public abstract Page<Food> getPage(CriteriaFood cb);

	/**
	 * 根据传入的 CriteriaFood 对象返回其对应的记录数
	 * @param cb
	 * @return
	 */
	public abstract long getTotalFoodNumber(CriteriaFood cb);

	/**
	 * 根据传入的 CriteriaFood 和 pageSize 返回当前页对应的 List 
	 * @param cb
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public abstract List<Food> getPageList(CriteriaFood cb,int pageSize);

	/**
	 * 返回指定 id 的 food 的 storeNumber 字段的值
	 * @param id
	 * @return
	 */
	public abstract int getStoreNumber(Integer foodId);

	/**
	 * 根据传入的 ShoppingCartItem 的集合, 
	 * 批量更新 myfoods 数据表的 storenumber 和 salesnumber 字段的值
	 * @param items
	 */
	public abstract void batchUpdateStoreNumberAndSalesAmount(
			Collection<ShoppingCartItem> items);
	
	/**
	 * 在myfoods表中添加传入的food
	 * @param food
	 */
	public abstract void insert(Food food);

	/**
	 * 根据传入的foodId删除表中行
	 * @param foodId
	 */
	public abstract void delete(int foodId);

	/**
	 * 在myfoods表中修改传入的food
	 * @param food
	 */
	public abstract void update(Food food);
}