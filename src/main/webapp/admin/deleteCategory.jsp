<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//1. Controller
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		
		String targetUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}


	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	Category deleteCategory = new Category();
	deleteCategory.setCategoryNo(categoryNo);
		
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	
	String msg = "카테고리 삭제 실패...";
	String targetUrl = "/admin/categoryList.jsp";
	
	if(categoryDao.deleteCategory(deleteCategory)) {
		msg = "카테고리 삭제 성공!!!";
	}
	
	msg = URLEncoder.encode(msg,"utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>
