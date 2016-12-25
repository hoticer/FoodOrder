package com.hoticer.ordering.dao;

import java.util.Collection;
import java.util.List;

import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.ShoppingCartItem;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;

public interface FoodDao {

	/**
	 * ���� id ��ȡָ�� Food ����
	 * @param id
	 * @return
	 */
	public abstract Food getFood(int foodId);

	/**
	 * ���ݴ���� CriteriaFood ���󷵻ض�Ӧ�� Page ����
	 * @param cb
	 * @return
	 */
	public abstract Page<Food> getPage(CriteriaFood cb);

	/**
	 * ���ݴ���� CriteriaFood ���󷵻����Ӧ�ļ�¼��
	 * @param cb
	 * @return
	 */
	public abstract long getTotalFoodNumber(CriteriaFood cb);

	/**
	 * ���ݴ���� CriteriaFood �� pageSize ���ص�ǰҳ��Ӧ�� List 
	 * @param cb
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public abstract List<Food> getPageList(CriteriaFood cb,int pageSize);

	/**
	 * ����ָ�� id �� food �� storeNumber �ֶε�ֵ
	 * @param id
	 * @return
	 */
	public abstract int getStoreNumber(Integer foodId);

	/**
	 * ���ݴ���� ShoppingCartItem �ļ���, 
	 * �������� myfoods ���ݱ�� storenumber �� salesnumber �ֶε�ֵ
	 * @param items
	 */
	public abstract void batchUpdateStoreNumberAndSalesAmount(
			Collection<ShoppingCartItem> items);
	
	/**
	 * ��myfoods������Ӵ����food
	 * @param food
	 */
	public abstract void insert(Food food);

	/**
	 * ���ݴ����foodIdɾ��������
	 * @param foodId
	 */
	public abstract void delete(int foodId);

	/**
	 * ��myfoods�����޸Ĵ����food
	 * @param food
	 */
	public abstract void update(Food food);
}