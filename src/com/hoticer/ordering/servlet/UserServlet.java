package com.hoticer.ordering.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.domain.User;
import com.hoticer.ordering.service.UserService;

@WebServlet(urlPatterns="/userServlet",name="userServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	private UserService userService = new UserService();

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

	protected void updatePay(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tradeIdStr = request.getParameter("tradeId");
		String payFlag = request.getParameter("payFlag");
		int tradeId = -1;
		int pay = 1;
		try {
			tradeId = Integer.parseInt(tradeIdStr);
		} catch (Exception e) {
		}
		try {
			pay = Integer.parseInt(payFlag);
		} catch (Exception e) {
		}
		userService.updatePay(tradeId, pay + 1);
	}

	protected void getTradeWithTableId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tableIdStr = request.getParameter("tableId");
		int tableId = 0;
		try {
			tableId = Integer.parseInt(tableIdStr);
		} catch (Exception e) {
		}
		Set<Trade> trades = userService.getTrades(tableId);
		request.setAttribute("trades", trades);
		request.setAttribute("tableId", tableId);

		// ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/WEB-INF/pages/trades.jsp").forward(request, response);
	}

	protected void queryTrade(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tradeIdStr = request.getParameter("tradeId");
		int tradeId = 0;
		try {
			tradeId = Integer.parseInt(tradeIdStr);
		} catch (Exception e) {
		}
		Trade orderTrade = userService.queryTrade(tradeId);

		request.setAttribute("orderTrade", orderTrade);

		// ת��ҳ�浽 /WEB-INF/pages/trades.jsp
		request.getRequestDispatcher("/WEB-INF/pages/orderTrade.jsp").forward(request, response);
	}

	protected void getOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		HashMap<String, String> newInfos = new HashMap<String, String>();

		Object accessStr = session.getAttribute("access");
		if (accessStr == null) {
			response.sendRedirect(request.getContextPath() + "/error-2.jsp");
			return;
		}
		int access = (int) accessStr;
		Set<Trade> newTrades = userService.getNewTrades(access);
		if (!newTrades.isEmpty()) {
			for (Trade t : newTrades)
				newInfos.put(t.getTradeId().toString(), t.getTableId() + "�������µĶ���,������: " + t.getTradeId() + "!�������ӵ�");
		}
		session.setAttribute("newInfos", newInfos);
		request.getRequestDispatcher("/WEB-INF/pages/employee.jsp").forward(request, response);
	}

	protected void htlogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String people = request.getParameter("people");

		StringBuffer errors = validateFormField(username, password);
		User user = userService.getUserByUserName(username);

		if (errors.toString().equals("")) {
			errors = validateUser(user, password);
		}
		if (errors.toString().equals("")) {
			errors = validateAccess(user, people);
		}

		if (!errors.toString().equals("")) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/WEB-INF/pages/htlogin.jsp").forward(request, response);
			return;
		}

		if (people.equals("op1")) {
			request.getSession().setAttribute("access", user.getAccess());
			// ��֤ͨ��ִ�о�����߼�����
			request.getRequestDispatcher("userServlet?method=getOrder").forward(request, response);
		} else if (people.equals("op2")) {
			request.getRequestDispatcher("/WEB-INF/pages/boss.jsp").forward(request, response);
		}
	}

	public StringBuffer validateAccess(User user, String people) {
		StringBuffer errors = new StringBuffer("");
		if (people.equals("op2")) {
			if (user.getAccess() != 0)
				errors.append("�Բ���,Ȩ�޲���!");
		}
		return errors;
	}

	public StringBuffer validateUser(User user, String password) {
		boolean flag = false;
		if (user != null) {
			String password2 = user.getPassword();
			if (password.trim().equals(password2)) {
				flag = true;
			}
		}

		StringBuffer errors = new StringBuffer("");
		if (!flag) {
			errors.append("�û��������벻ƥ��");
		}
		return errors;
	}

	// ��֤�����Ƿ���ϻ�������
	public StringBuffer validateFormField(String username, String password) {
		StringBuffer errors = new StringBuffer();
		if (username == null || username.trim().equals("")) {
			errors.append("�û�������Ϊ��<br>");
		}

		if (password == null || password.trim().equals("")) {
			errors.append("���벻��Ϊ��");
		}
		return errors;
	}
}
