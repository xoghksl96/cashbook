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
	if( request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		
		String targetUrl = "/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	Notice insertNotice = new Notice();
	insertNotice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	// 2. Model호출
	
	NoticeDao noticeDao = new NoticeDao();
	
	String msg = URLEncoder.encode("공지 추가 실패...","utf-8");
	String targetUrl = "/admin/noticeList.jsp";	
	
	if(noticeDao.insertNotice(insertNotice) == true) {
		msg = URLEncoder.encode("공지 추가 완료!!!","utf-8");	
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>