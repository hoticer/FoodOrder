package com.hoticer.ordering.utils;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Shape;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class QRCodeUtil {

	private static final String CHARSET = "utf-8";
	private static final String FORMAT_NAME = "png";
	// ��ά��ߴ�
	private static final int QRCODE_SIZE = 400;
	// LOGO���
	private static final int WIDTH = 110;
	// LOGO�߶�
	private static final int HEIGHT = 110;
	// ��Ļ�߶�
	private static final int TXTBOXHEIGHT = 80;
	// �ִ�С
	private static final int TXTSIZE = 40;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static BufferedImage createImage(String tableNum, String imgPath, boolean needCompress) throws Exception {
		Hashtable hints = new Hashtable();
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
		hints.put(EncodeHintType.CHARACTER_SET, CHARSET);
		hints.put(EncodeHintType.MARGIN, 1);
		String content = "http://www.ablazeice.cn:8090/ordering/foodServlet?method=getFoods&tableNum=" + tableNum;
		BitMatrix bitMatrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, QRCODE_SIZE, QRCODE_SIZE,
				hints);
		int width = bitMatrix.getWidth();
		int height = bitMatrix.getHeight();
		BufferedImage image = new BufferedImage(width, height + TXTBOXHEIGHT, BufferedImage.TYPE_INT_RGB);
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				image.setRGB(x, y, bitMatrix.get(x, y) ? 0x000000 : 0xFFFFFF);
			}
		}
		Graphics g = image.getGraphics();
		g.setColor(new Color(255, 255, 255));
		g.fillRect(0, height, width, TXTBOXHEIGHT);
		g.setFont(new Font("����", Font.BOLD, TXTSIZE));
		g.setColor(new Color(65,148,255));
		String ss = tableNum + "����";
		g.drawString(ss, QRCODE_SIZE / 2 - ss.length() * TXTSIZE / 2, height + TXTBOXHEIGHT / 2);
		g.dispose();

		if (imgPath == null || "".equals(imgPath)) {
			return image;
		}
		// ����ͼƬ
		QRCodeUtil.insertImage(image, imgPath, needCompress);
		return image;
	}

	private static void insertImage(BufferedImage source, String imgPath, boolean needCompress) throws Exception {
		File file = new File(imgPath);
		if (!file.exists()) {
			System.err.println("" + imgPath + "   ���ļ������ڣ�");
			return;
		}
		Image src = ImageIO.read(new File(imgPath));
		int width = src.getWidth(null);
		int height = src.getHeight(null);
		if (needCompress) { // ѹ��LOGO
			if (width > WIDTH) {
				width = WIDTH;
			}
			if (height > HEIGHT) {
				height = HEIGHT;
			}
			src = src.getScaledInstance(width, height, Image.SCALE_SMOOTH);
		}
		// ����LOGO
		Graphics2D graph = source.createGraphics();
		int x = (QRCODE_SIZE - width) / 2;
		int y = (QRCODE_SIZE - height) / 2;
		graph.drawImage(src, x, y, width, height, null);
		Shape shape = new RoundRectangle2D.Float(x, y, width, width, 6, 6);
		graph.setStroke(new BasicStroke(3f));
		graph.draw(shape);
		graph.dispose();
	}

	public static void encode(String tableNum, String imgPath, String destPath, boolean needCompress) throws Exception {
		BufferedImage image = QRCodeUtil.createImage(tableNum, imgPath, needCompress);
		mkdirs(destPath);
		String file = "table" + tableNum + "." + FORMAT_NAME;
		ImageIO.write(image, FORMAT_NAME, new File(destPath + "/" + file));
	}

	public static void mkdirs(String destPath) {
		File file = new File(destPath);
		// ���ļ��в�����ʱ��mkdirs���Զ��������Ŀ¼��������mkdir��(mkdir�����Ŀ¼����������׳��쳣)
		if (!file.exists() && !file.isDirectory()) {
			file.mkdirs();
		}
	}
}