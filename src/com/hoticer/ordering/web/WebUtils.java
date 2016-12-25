package com.hoticer.ordering.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoticer.ordering.domain.ShoppingCart;

public class WebUtils {

	/**
	 * 获取购物车对象:从session中获取,若没有,则创建一个新的购物车对象,放入session中,若有直接返回.
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static ShoppingCart getShoppingCart(HttpServletRequest request) {
		HttpSession session = request.getSession();

		ShoppingCart sc = (ShoppingCart) session.getAttribute("ShoppingCart");
		if (sc == null) {
			sc = new ShoppingCart();
			session.setAttribute("ShoppingCart", sc);
		}

		return sc;
	}
}
