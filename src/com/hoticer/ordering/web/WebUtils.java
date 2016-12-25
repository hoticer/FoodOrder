package com.hoticer.ordering.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoticer.ordering.domain.ShoppingCart;

public class WebUtils {

	/**
	 * ��ȡ���ﳵ����:��session�л�ȡ,��û��,�򴴽�һ���µĹ��ﳵ����,����session��,����ֱ�ӷ���.
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
