<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");

	//1. Controller
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null || 
		request.getParameter("categoryNo").equals("") || request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")) {
		
		String targetUrl = "/admin/updateCategoryForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}


	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	System.out.println(categoryNo);
	System.out.println(categoryKind);
	System.out.println(categoryName);
	
	Category updateCategory = new Category();
	updateCategory.setCategoryNo(categoryNo);
	updateCategory.setCategoryKind(categoryKind);
	updateCategory.setCategoryName(categoryName);
		
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	String msg = "카테고리 수정 실패...";
	String targetUrl = "/admin/updateCategoryForm.jsp";
	
	if(categoryDao.updateCateogory(updateCategory)) {
		msg = "카테고리 수정 성공!!!";
		targetUrl = "/admin/categoryList.jsp";
	}
	
	msg = URLEncoder.encode(msg,"utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>
