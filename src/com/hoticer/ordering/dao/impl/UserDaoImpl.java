package com.hoticer.ordering.dao.impl;

import java.util.List;

import com.hoticer.ordering.dao.UserDao;
import com.hoticer.ordering.domain.User;

public class UserDaoImpl extends BaseDao<User> implements UserDao {

	@Override
	public User getUserByUserId(int userId) {
		String sql = "SELECT userId,username,password,access FROM userinfo WHERE userId = ?";
		return query(sql, userId);
	}
	
	@Override
	public User getUser(String username) {
		String sql = "SELECT userId,username,password,access FROM userinfo WHERE username = ?";
		return query(sql, username);
	}

	@Override
	public List<User> getUserList() {
		String sql = "SELECT userId,username,password,access FROM userinfo";
		return queryForList(sql);
	}

	@Override
	public void insert(User user) {
		String sql = "INSERT INTO userinfo(username,password,access) VALUES (?,?,?) ";
		int userId = (int) insert(sql, user.getUsername(), user.getPassword(), user.getAccess());
		user.setUserId(userId);
	}

	@Override
	public void delete(int userId) {
		String sql = "DELETE FROM userinfo WHERE userId = ?";
		update(sql, userId);
	}

	@Override
	public void update(User user) {
		String sql = "UPDATE userinfo SET username = ?,password = ?, access = ?  WHERE userId = ?";
		update(sql, user.getUsername(), user.getPassword(), user.getAccess(), user.getUserId());
	}

	@Override
	public long getCounts(String username) {
		String sql = "SELECT count(userId) FROM userinfo WHERE username = ?";
		return getSingleVal(sql, username);
	}
}
