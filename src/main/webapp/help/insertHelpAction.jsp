<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 1-2 request
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = "필요한 정보를 모두 입력해주세요.";
		String targetUrl = "help/insertHelpForm.jsp";
		
		msg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
	}
	
	Help insertHelp = new Help();
	insertHelp.setMemberId(loginMember.getMemberId());
	insertHelp.setHelpMemo(request.getParameter("helpMemo"));
	
	// 2. Model호출
	
	HelpDao helpDao = new HelpDao();
	
	String msg = "문의 추가 실패...";
	String targetUrl = "/help/insertHelpForm.jsp";
	if(helpDao.insertHelp(insertHelp)) {
		msg = "문의 추가 성공!!!";
		targetUrl = "/help/helpList.jsp";
	}
	
	msg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
%>
