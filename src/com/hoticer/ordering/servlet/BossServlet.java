package com.hoticer.ordering.servlet;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.hoticer.ordering.domain.Food;
import com.hoticer.ordering.domain.Trade;
import com.hoticer.ordering.domain.User;
import com.hoticer.ordering.service.BossService;
import com.hoticer.ordering.service.FoodService;
import com.hoticer.ordering.utils.QRCodeUtil;
import com.hoticer.ordering.web.CriteriaFood;
import com.hoticer.ordering.web.Page;

@WebServlet(urlPatterns = "/bossServlet", name = "bossServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024, maxRequestSize = 1024 * 1024 + 100)
public class BossServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	private BossService bossService = new BossService();
	private FoodService foodService = new FoodService();

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

	protected void createQrcode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tableNum = request.getParameter("tableNum");
		String realPath = this.getClass().getClassLoader().getResource("/").toString().substring(6);
		realPath = realPath.substring(0, realPath.length() - 16);
		String logoPath = realPath + "images/qrcode/logo.jpg";
		String destPath = realPath + "images/qrcode";
		try {
			QRCodeUtil.encode(tableNum, logoPath, destPath, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void checkTrade(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String queryDate = request.getParameter("queryDate");

		if (queryDate == null || queryDate.isEmpty()) {
			Date date = new Date();
			SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
			queryDate = myFormat.format(date);
		}
		request.setAttribute("showDate", queryDate);
		Set<Trade> trades = bossService.getTradesByDate(queryDate);
		request.setAttribute("trades", trades);
		request.getRequestDispatcher("/WEB-INF/pages/checkTrade.jsp").forward(request, response);
	}

	protected void insertUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String accessStr = request.getParameter("access");
		StringBuffer errors = validateFormField(username, password);
		int access = Integer.parseInt(accessStr);
		int access2 = 0;
		if (access > 0) {
			String access2Str = request.getParameter("access2");
			if (errors.toString().equals("")) {
				try {
					access2 = Integer.parseInt(access2Str);
					if (access2 <= 0)
						errors.append("请填写正确的负责组号!");
				} catch (Exception e) {
					errors.append("请填写正确的负责组号!");
				}
			}
		}

		if (errors.toString().equals("")) {
			if (bossService.hasUser(username))
				errors.append("用户名已存在!");
		}

		if (!errors.toString().equals("")) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/WEB-INF/pages/insertUser.jsp").forward(request, response);
			return;
		}

		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		if (access2 > 0)
			user.setAccess(access2);
		else
			user.setAccess(access);
		bossService.insertUser(user);

		request.setAttribute("success", "添加成功");
		request.getRequestDispatcher("/WEB-INF/pages/insertUser.jsp").forward(request, response);
	}

	protected void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userIdStr = request.getParameter("userId");
		int userId = -1;
		try {
			userId = Integer.parseInt(userIdStr);
		} catch (Exception e) {
		}
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String accessStr = request.getParameter("access");
		StringBuffer errors = validateFormField(username, password);
		int access = Integer.parseInt(accessStr);
		int access2 = 0;
		if (access > 0) {
			String access2Str = request.getParameter("access2");
			if (errors.toString().equals("")) {
				try {
					access2 = Integer.parseInt(access2Str);
				} catch (Exception e) {
					errors.append("请填写正确负责组号!");
				}
			}
		}

		if (errors.toString().equals("")) {
			if (bossService.hasUser(username))
				errors.append("用户名已存在!");
		}

		User user = bossService.getUserByUserId(userId);
		if (!errors.toString().equals("")) {
			request.setAttribute("errors", errors);
			request.setAttribute("user", user);
			request.getRequestDispatcher("/WEB-INF/pages/modifyUser.jsp").forward(request, response);
			return;
		}
		user.setUsername(username);
		user.setPassword(password);
		if (access2 > 0)
			user.setAccess(access2);
		else
			user.setAccess(access);
		bossService.updateUser(user);

		request.setAttribute("user", user);
		request.setAttribute("success", "修改成功");
		request.getRequestDispatcher("/WEB-INF/pages/modifyUser.jsp").forward(request, response);
	}

	public StringBuffer validateFormField(String username, String password) {
		StringBuffer errors = new StringBuffer();
		if (username == null || username.trim().equals("")) {
			errors.append("用户名不能为空<br>");
		}

		if (password == null || password.trim().equals("")) {
			errors.append("密码不能为空<br>");
		}
		return errors;
	}

	protected void toUpdateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userIdStr = request.getParameter("userId");
		int userId = -1;
		try {
			userId = Integer.parseInt(userIdStr);
		} catch (Exception e) {
		}

		if (userId > 0) {
			User user = bossService.getUserByUserId(userId);
			request.setAttribute("user", user);
			request.getRequestDispatcher("/WEB-INF/pages/modifyUser.jsp").forward(request, response);
		}
	}

	protected void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userIdStr = request.getParameter("userId");
		int userId = -1;
		try {
			userId = Integer.parseInt(userIdStr);
		} catch (Exception e) {
		}

		if (userId > 0) {
			bossService.deleteUser(userId);
		}
		userManager(request, response);
	}

	protected void userManager(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<User> users = bossService.getUsers();

		request.setAttribute("users", users);

		request.getRequestDispatcher("WEB-INF/pages/viewUser.jsp").forward(request, response);
	}

	protected void insertFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuffer errors = new StringBuffer();
		try {

			String foodName = request.getParameter("foodName");
			String priceStr = request.getParameter("price");
			String storeNumberStr = request.getParameter("storeNumber");
			errors = validateFormField(foodName, priceStr, storeNumberStr);
			float price = 0;
			int storeNumber = 0;
			if (errors.toString().equals("")) {
				try {
					price = Float.parseFloat(priceStr);
				} catch (Exception e) {
					errors.append("请填写正确价格<br>");
				}
				try {
					storeNumber = Integer.parseInt(storeNumberStr);
				} catch (Exception e) {
					errors.append("请填写正确库存数<br>");
				}
			}
			if (!errors.toString().equals("")) {
				request.setAttribute("errors", errors);
				request.getRequestDispatcher("/WEB-INF/pages/insertFood.jsp").forward(request, response);
				return;
			}
			String details = request.getParameter("details");
			Food food = new Food();
			food.setFoodName(foodName);
			food.setPrice(price);
			food.setSalesAmount(0);
			food.setStoreNumber(storeNumber);
			food.setDetails(details);

			// 若是文件域则把文件保存到images/food目录下.
			Part part = request.getPart("image");
			String value = part.getHeader("content-disposition");
			String fileName = value.substring(value.lastIndexOf("=") + 2, value.length() - 1);

			// 有的浏览器会返回文件名，而有的浏览器会返回“路径”+“文件名”，针对后者我们需要通过“字符串截取”获取文件名：
			int index = fileName.lastIndexOf("\\");
			if (index != -1) {
				fileName = fileName.substring(index + 1);
			}
			String extName = fileName.substring(fileName.lastIndexOf(".") + 1);
			List<String> extList = new ArrayList<>();
			extList.add("jpg");
			if (!extList.contains(extName)) {
				errors.append("请上传jpg格式的图片!");
				throw new Exception();
			}
			bossService.insertFood(food);

			InputStream in = part.getInputStream();
			String realPath = this.getClass().getClassLoader().getResource("/").toString().substring(6);
			realPath = realPath.substring(0, realPath.length() - 16);
			fileName = realPath + "images/food/food" + food.getFoodId() + "." + extName;
			OutputStream out = new FileOutputStream(fileName);
			resizeImage(in, out);

		} catch (Exception e) {
			errors.append("图片上传失败");
		}
		if (!errors.toString().equals("")) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/WEB-INF/pages/insertFood.jsp").forward(request, response);
			return;
		}
		request.setAttribute("success", "添加成功");
		request.getRequestDispatcher("/WEB-INF/pages/insertFood.jsp").forward(request, response);
	}

	/**
	 * 改变图片的大小到宽为size，然后高随着宽等比例变化
	 * 
	 * @param is
	 *            上传的图片的输入流
	 * @param os
	 *            改变了图片的大小后，把图片的流输出到目标OutputStream
	 * @param size
	 *            新图片的宽
	 * @param format
	 *            新图片的格式
	 * @throws IOException
	 */
	public static void resizeImage(InputStream is, OutputStream os) throws IOException {
		BufferedImage prevImage = ImageIO.read(is);
		int newWidth = 360;
		int newHeight = 270;
		BufferedImage image = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_BGR);
		Graphics graphics = image.createGraphics();
		graphics.drawImage(prevImage, 0, 0, newWidth, newHeight, null);
		ImageIO.write(image, "jpg", os);
		os.flush();
		is.close();
		os.close();
	}

	protected void updateFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");
		int foodId = -1;
		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}
		String foodName = request.getParameter("foodName");
		String priceStr = request.getParameter("price");
		String storeNumberStr = request.getParameter("storeNumber");
		StringBuffer errors = validateFormField(foodName, priceStr, storeNumberStr);
		float price = 0;
		int storeNumber = 0;
		if (errors.toString().equals("")) {
			try {
				price = Float.parseFloat(priceStr);
			} catch (Exception e) {
				errors.append("请填写正确价格<br>");
			}
			try {
				storeNumber = Integer.parseInt(storeNumberStr);
			} catch (Exception e) {
				errors.append("请填写正确库存数<br>");
			}
		}
		Food food = foodService.getFood(foodId);
		if (!errors.toString().equals("")) {
			request.setAttribute("errors", errors);
			request.setAttribute("food", food);
			request.getRequestDispatcher("/WEB-INF/pages/modifyFood.jsp").forward(request, response);
			return;
		}
		String details = request.getParameter("details");
		food.setFoodName(foodName);
		food.setPrice(price);
		food.setSalesAmount(0);
		food.setStoreNumber(storeNumber);
		food.setDetails(details);
		bossService.updateFood(food);

		request.setAttribute("food", food);
		request.setAttribute("success", "修改成功");
		request.getRequestDispatcher("/WEB-INF/pages/modifyFood.jsp").forward(request, response);
	}

	public StringBuffer validateFormField(String foodName, String priceStr, String storeNumberStr) {
		StringBuffer errors = new StringBuffer();
		if (foodName == null || foodName.trim().equals("")) {
			errors.append("食物名不能为空<br>");
		}

		if (priceStr == null || priceStr.trim().equals("")) {
			errors.append("价格不能为空<br>");
		}

		if (storeNumberStr == null || storeNumberStr.trim().equals("")) {
			errors.append("库存不能为空<br>");
		}
		return errors;
	}

	protected void toUpdateFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");
		int foodId = -1;
		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}

		if (foodId > 0) {
			Food food = foodService.getFood(foodId);
			request.setAttribute("food", food);
			request.getRequestDispatcher("/WEB-INF/pages/modifyFood.jsp").forward(request, response);
		}
	}

	protected void deleteFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String foodIdStr = request.getParameter("foodId");
		int foodId = -1;
		try {
			foodId = Integer.parseInt(foodIdStr);
		} catch (Exception e) {
		}

		if (foodId > 0) {
			bossService.deleteFood(foodId);
			String fileName = getServletContext().getRealPath("images/food/") + "\\food" + foodId + ".jpg";
			File file = new File(fileName);
			if (file.exists() && file.isFile())
				file.delete();
		}
		foodManager(request, response);
	}

	protected void foodManager(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pageNoStr = request.getParameter("pageNo");

		int pageNo = 0;

		try {
			pageNo = Integer.parseInt(pageNoStr);
		} catch (Exception e) {
		}

		CriteriaFood criteriaFood = new CriteriaFood(0, Integer.MAX_VALUE, pageNo);
		Page<Food> page = foodService.getPage(criteriaFood);

		request.setAttribute("foodpage", page);

		request.getRequestDispatcher("WEB-INF/pages/viewFood.jsp").forward(request, response);
	}
}
