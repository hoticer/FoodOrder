package com.hoticer.ordering.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hoticer.ordering.db.JDBCUtils;
import com.hoticer.ordering.web.ConnectionContext;

@WebFilter(urlPatterns={"/*"})
public class TransactionFilter implements Filter {

	public TransactionFilter() {
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		Connection connection = null;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpServletRequest req = (HttpServletRequest) request;

		try {
			// 1.��ȡ����
			connection = JDBCUtils.getConnection();

			// 2.��������
			connection.setAutoCommit(false);

			// 3.����ThreadLocal�����Ӻ͵�ǰ�̰߳�
			ConnectionContext.getInstance().bind(connection);

			// 4.������ת��Ŀ��Servlet
			chain.doFilter(request, response);

			// 5.�ύ����
			connection.commit();
		} catch (Exception e) {
			e.printStackTrace();

			// 6.�ع�����
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

			// String qs = req.getQueryString();
			// if (qs != null && qs.indexOf("ht=ht") != -1)
			// resp.sendRedirect(req.getContextPath() + "/error-2.jsp");
			// else
			resp.sendRedirect(req.getContextPath() + "/error-1.jsp");
		} finally {
			// 7.�����
			ConnectionContext.getInstance().remove();

			// 8.�ر�����
			JDBCUtils.release(connection);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
