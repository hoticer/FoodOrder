package com.hoticer.ordering.dao;

import java.util.List;

import com.hoticer.ordering.domain.User;

public interface UserDao {

	/**
	 * �����û�����ȡ User ����
	 * 
	 * @param username
	 * @return
	 */
	public abstract User getUser(String username);

	/**
	 * ����userid��ȡuser
	 * @param userId
	 * @return
	 */
	public abstract User getUserByUserId(int userId);
	
	/**
	 * ��ȡuser����
	 * @return
	 */
	public abstract List<User> getUserList();
	
	/**
	 * ���user
	 * @param user
	 */
	public abstract void insert(User user);

	/**
	 * ����useridɾ��user
	 * @param userId
	 */
	public abstract void delete(int userId);

	/**
	 * �޸�user
	 * @param user
	 */
	public abstract void update(User user);

	/**
	 * ��ȡ��ͬusername������
	 * @param username
	 * @return
	 */
	public abstract long getCounts(String username);

}
