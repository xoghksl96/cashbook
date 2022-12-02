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
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeMemo") == null ||
			request.getParameter("noticeNo").equals("") || request.getParameter("noticeMemo").equals("")) {
		
		String targetUrl = "/admin/updateNoticeForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	Notice updateNotice = new Notice();
	updateNotice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	updateNotice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	// 2. Model호출
	
	NoticeDao noticeDao = new NoticeDao();
	
	String msg = URLEncoder.encode(updateNotice.getNoticeNo() + "번 공지 수정 실패...","utf-8");
	String targetUrl = "/admin/updateNoticeForm.jsp";	
	
	if(noticeDao.updateNotice(updateNotice) == true) {
		targetUrl = "/admin/noticeList.jsp";
		msg = URLEncoder.encode(updateNotice.getNoticeNo() + "번 공지 수정 완료!!!","utf-8");
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>