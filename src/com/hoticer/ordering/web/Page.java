package com.hoticer.ordering.web;

import java.util.List;

public class Page<T> {
	//��ǰ�ڼ�ҳ
	private int pageNo;
	
	//��ǰҳ��List
	private List<T> list;
	
	//ÿҳ��ʾ��������¼
	private int pageSize  = 8;
	
	//���ж�������¼
	private long totalItemNumber;

	//����������Ҫ��pageNo���г�ʼ
	public Page(int pageNo) {
		super();
		this.pageNo = pageNo;
	}
	
	//��ҪУ��һ��
	public int getPageNo() {
		if(pageNo > getTotalPageNumber())
			pageNo  = getTotalPageNumber();
		if(pageNo <= 0)
			pageNo = 1;
		return pageNo;
	}
	
	public int getPageSize() {
		return pageSize;
	}
	
	public void setList(List<T> list) {
		this.list = list;
	}
	
	public List<T> getList() {
		return list;
	}
	
	public void setTotalItemNumber(long totalItemNumber) {
		this.totalItemNumber = totalItemNumber;
	}
	
	//��ȡ��ҳ��
	public int getTotalPageNumber(){
		int totalPageNumber  = (int)totalItemNumber / pageSize;
		if(totalItemNumber % pageSize != 0){
			totalPageNumber++;
		}
		return totalPageNumber;
	}
	
	public boolean isHasNext(){
		if(getPageNo() < getTotalPageNumber())
			return true;
		return false;
	}
	
	public boolean isHasPrev(){
		if(getPageNo() > 1)
			return true;
		return false;
	}
	
	public int getPrevPage(){
		if(isHasPrev())
			return getPageNo()-1;
		return getPageNo();
	}
	
	public int getNextPage(){
		if(isHasNext())
			return getPageNo()+1;
		return getPageNo();
	}
}
