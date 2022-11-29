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
	if(request.getParameter("helpNo") == null || request.getParameter("commentNo") == null || 
		request.getParameter("helpNo").equals("") || request.getParameter("commentNo").equals("")) {
		String targetUrl = "/admin/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl+"?helpNo="+request.getParameter("helpNo"));
	}

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	Comment deleteComment = new Comment();
	deleteComment.setCommentNo(commentNo);
	deleteComment.setMemberId(loginMember.getMemberId());
	
	// 2. Model 호출	
	CommentDao commentDao = new CommentDao();
	
	String msg = "답변 삭제 실패...";
	String targetUrl = "/admin/helpOne.jsp";
	
	if(commentDao.deleteComment(deleteComment)) {
		msg = "답변 삭제 성공!!!";
		targetUrl = "/admin/helpOne.jsp";
	}
	
	msg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg+"&helpNo="+request.getParameter("helpNo"));
%>