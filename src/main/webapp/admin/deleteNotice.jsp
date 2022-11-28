<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 1. Controller
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		
		String targetUrl = "/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}

	Notice deleteNotice = new Notice();
	deleteNotice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	
	// 2. 멤버호출
	NoticeDao noticeDao = new NoticeDao();
	
	String msg = URLEncoder.encode(deleteNotice.getNoticeNo() + " 번 공지 삭제 실패...","utf-8");
	String targetUrl = "/admin/noticeList.jsp";	
	
	if(noticeDao.deleteNotice(deleteNotice) == true) {
		msg = URLEncoder.encode(deleteNotice.getNoticeNo() + " 번 공지 삭제 완료!!!","utf-8");	
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
	
%>
