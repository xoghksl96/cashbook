<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");
	
	// 1. Controller
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null ||
		request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")) {
		
		String targetUrl = "/admin/insertCategoryForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	Category insertCategory = new Category();
	insertCategory.setCategoryKind(categoryKind);
	insertCategory.setCategoryName(categoryName);
		
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	String msg = "카테고리 추가 실패...";
	String targetUrl = "/admin/insertCategoryForm.jsp";
	
	if(categoryDao.insertCategory(insertCategory)) {
		msg = "카테고리 추가 성공!!!";
		targetUrl = "/admin/categoryList.jsp";
	}
	
	msg = URLEncoder.encode(msg,"utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>