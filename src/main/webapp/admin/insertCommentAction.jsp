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
	if(request.getParameter("helpNo") == null ||  request.getParameter("commentMemo") == null || 
		request.getParameter("helpNo").equals("") ||  request.getParameter("commentMemo").equals("")) {
		
		String targetUrl = "/admin/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl+"?helpNo="+request.getParameter("helpNo"));
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");

	Comment insertComment = new Comment();
	insertComment.setHelpNo(helpNo);
	insertComment.setCommentMemo(commentMemo);
	insertComment.setMemberId(loginMember.getMemberId());
	
	// 2. Model 호출	
	CommentDao commentDao = new CommentDao();
	
	String msg = "답변 추가 실패...";
	String targetUrl = "/admin/helpOne.jsp";
	
	if(commentDao.insertComment(insertComment)) {
		msg = "답변 추가 성공!!!";
		targetUrl = "/admin/helpOne.jsp";
	}
	System.out.println(msg);
	msg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg+"&helpNo="+request.getParameter("helpNo"));
%>