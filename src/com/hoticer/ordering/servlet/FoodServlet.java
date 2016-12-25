package com.hoticer.ordering.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.ShoppingCart;
import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.service.FoodService;
import com.hoticer.ordering.service.UserService;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;
import com.hoticer.ordering.web.WebUtils;

@WebServlet(urlPatterns="/foodServlet",name="foodServlet")
public class FoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	FoodService foodService = new FoodService();
	UserService userService = new UserService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String methodName = request.getParameter("method");
		Method method;
		try {
			method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			method.setAccessible(true);
			method.invoke(this, request, response);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	protected void forwardPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page = request.getParameter("page");
		request.getRequestDispatcher("/WEB-INF/pages/" + page + ".jsp").forward(request, response);
	}
	
	protected void queryTrade(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tradeIdStr = request.getParameter("tradeId");
		int tradeId = 0;
		try {
			tradeId = Integer.parseInt(tradeIdStr);
		} catch (Exception e) {
		}
		if (tradeId == 0) {
			request.getRequestDispatcher("/WEB-INF/pages/emptyorder.jsp").forward(request, response);
			return;
		}
		Trade orderTrade = userService.getCustomerTrade(tradeId);
		request.setAttribute("orderTrade", orderTrade);

		request.getRequestDispatcher("/WEB-INF/pages/customertrade.jsp").forward(request, response);
	}
	
	protected void order(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tableNum = request.getParameter("tableNum");
		Integer tableId = null;
		try {
			tableId = Integer.parseInt(tableNum);
		} catch (Exception e) {
		}
			
		int tradeId = foodService.cash(WebUtils.getShoppingCart(request), tableId);
		if(tradeId==0){
			response.sendRedirect(request.getContextPath() + "/error-1.jsp");
			return;
		}
		request.getSession().setAttribute("tradeId", tradeId);
		request.getRequestDispatcher("/success.jsp").forward(request, response);
	}

	protected void updateItemQuantity(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");
		String quantityStr = request.getParameter("quantity");

		ShoppingCart sc = WebUtils.getShoppingCart(request);

		int foodId = -1;
		int quantity = -1;
		try {
			foodId = Integer.parseInt(foodIdStr);
			quantity = Integer.parseInt(quantityStr);
		} catch (Exception e) {
		}

		if (foodId > 0 && quantity > 0)
			foodService.updateItemQuantity(sc, foodId, quantity);

		// 5.传回JSON数据: foodNumber:xx,totalMoney
		Map<String, Object> result = new HashMap<>();
		result.put("foodNumber", sc.getFoodNumber());
		result.put("totalMoney", sc.getTotalMoney());

		Gson gson = new Gson();
		String jsonStr = gson.toJson(result);
		response.setContentType("text/javascript");
		response.getWriter().print(jsonStr);
	}

	protected void clear(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ShoppingCart sc = WebUtils.getShoppingCart(request);
		foodService.clearShoppingCart(sc);

		request.getRequestDispatcher("/WEB-INF/pages/emptycart.jsp").forward(request, response);
	}
	
	protected void remove(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");

		int foodId = -1;
		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}

		ShoppingCart sc = WebUtils.getShoppingCart(request);
		foodService.removeItemFromShoppingCart(sc, foodId);

		goToCart(request, response);
	}

	protected void goToCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ShoppingCart sc = WebUtils.getShoppingCart(request);
		if (sc.isEmpty()) {
			request.getRequestDispatcher("/WEB-INF/pages/emptycart.jsp").forward(request, response);
			return;
		}
		request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
	}
	
	protected void addToCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1.获取商品的id
		String foodIdStr = request.getParameter("foodId");
		int foodId = -1;
		boolean flag = false;

		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}

		if (foodId > 0) {
			// 2.获取购物车对象
			ShoppingCart sc = WebUtils.getShoppingCart(request);

			// 3.调用FoodService的addToCart()方法把商品放到购物车中
			flag = foodService.addToCart(foodId, sc);
		}

		if (flag) {
			// 4.直接调用getFoods()方法
			getFoods(request, response);
			return;
		}
		response.sendRedirect(request.getContextPath() + "/error-1.jsp");
	}

	protected void getFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");
		int foodId = -1;

		Food food = null;
		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}

		if (foodId > 0)
			food = foodService.getFood(foodId);

		if (food == null) {
			response.sendRedirect(request.getContextPath() + "/error-1.jsp");
			return;
		}
		request.setAttribute("food", food);
		request.getRequestDispatcher("/WEB-INF/pages/food.jsp").forward(request, response);
	}

	protected void getFoods(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pageNoStr = request.getParameter("pageNo");
		String priceArea = request.getParameter("priceArea");
		String tableNum = request.getParameter("tableNum");

		if (tableNum != "" && tableNum != null) {
			HttpSession session = request.getSession();
			session.setAttribute("tableNum", tableNum);
		}

		String minPriceStr = null;
		String maxPriceStr = null;
		if (priceArea != null && priceArea != "") {
			minPriceStr = priceArea.split("x")[0];
			maxPriceStr = priceArea.split("x")[1];
		}

		int pageNo = 0;
		float minPrice = 0;
		float maxPrice = Integer.MAX_VALUE;

		try {
			pageNo = Integer.parseInt(pageNoStr);
		} catch (Exception e) {
		}
		try {
			minPrice = Float.parseFloat(minPriceStr);
		} catch (Exception e) {
		}
		try {
			maxPrice = Float.parseFloat(maxPriceStr);
		} catch (Exception e) {
		}

		CriteriaFood criteriaFood = new CriteriaFood(minPrice, maxPrice, pageNo);
		Page<Food> page = foodService.getPage(criteriaFood);

		request.setAttribute("foodpage", page);

		request.getRequestDispatcher("WEB-INF/pages/foods.jsp").forward(request, response);
	}
}
