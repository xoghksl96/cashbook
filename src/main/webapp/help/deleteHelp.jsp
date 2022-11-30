<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		String targetUrl = "/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl+"?helpNo="+request.getParameter("helpNo"));
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help deleteHelp = new Help();
	deleteHelp.setHelpNo(helpNo);
	deleteHelp.setMemberId(loginMember.getMemberId());
	
	// 2. Model 호출	
	HelpDao deleteHelpDao = new HelpDao();
	
	String msg = "문의 삭제 실패...";
	String targetUrl = "/helpOne.jsp";
	
	if(deleteHelpDao.deleteHelp(deleteHelp)) {
		msg = "문의 삭제 성공!!!";
		targetUrl = "/helpOne.jsp";
	}
	
	msg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg+"&helpNo="+request.getParameter("helpNo"));
%>
