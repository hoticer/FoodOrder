package com.hoticer.ordering.dao;

import java.util.List;

import com.hoticer.ordering.domain.User;

public interface UserDao {

	/**
	 * 根据用户名获取 User 对象
	 * 
	 * @param username
	 * @return
	 */
	public abstract User getUser(String username);

	/**
	 * 根据userid获取user
	 * @param userId
	 * @return
	 */
	public abstract User getUserByUserId(int userId);
	
	/**
	 * 获取user集合
	 * @return
	 */
	public abstract List<User> getUserList();
	
	/**
	 * 添加user
	 * @param user
	 */
	public abstract void insert(User user);

	/**
	 * 根据userid删除user
	 * @param userId
	 */
	public abstract void delete(int userId);

	/**
	 * 修改user
	 * @param user
	 */
	public abstract void update(User user);

	/**
	 * 获取相同username的行数
	 * @param username
	 * @return
	 */
	public abstract long getCounts(String username);

}
