package com.hoticer.ordering.utils;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * ����� Utils ��������
 * �ṩ����˽�б���, ��ȡ�������� Class, ��ȡ������Ԫ�����Ե� Utils ����
 * @author Administrator
 *
 */
public class ReflectionUtils {

	
	/**
	 * ͨ������, ��ö��� Class ʱ�����ĸ���ķ��Ͳ���������
	 * ��: public EmployeeDao extends BaseDao<Employee, String>
	 * @param clazz
	 * @param index
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Class getSuperClassGenricType(Class clazz, int index){
		Type genType = clazz.getGenericSuperclass();
		
		if(!(genType instanceof ParameterizedType)){
			return Object.class;
		}
		
		Type [] params = ((ParameterizedType)genType).getActualTypeArguments();
		
		if(index >= params.length || index < 0){
			return Object.class;
		}
		
		if(!(params[index] instanceof Class)){
			return Object.class;
		}
		
		return (Class) params[index];
	}
	
	/**
	 * ͨ������, ��� Class �����������ĸ���ķ��Ͳ�������
	 * @param <T>
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" } )
	public static<T> Class<T> getSuperGenericType(Class clazz){
		return getSuperClassGenricType(clazz, 0);
	}
}
