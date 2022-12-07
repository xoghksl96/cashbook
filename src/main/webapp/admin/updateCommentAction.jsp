<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글 처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("commentNo") == null || request.getParameter("commentMemo") == null || 
		request.getParameter("helpNo").equals("") || request.getParameter("commentNo").equals("") || request.getParameter("commentMemo").equals("")) {
		
		String targetUrl = "/admin/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl+"?helpNo="+request.getParameter("helpNo"));
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	Comment updateComment = new Comment();
	updateComment.setCommentNo(commentNo);
	updateComment.setCommentMemo(commentMemo);
	updateComment.setMemberId(loginMember.getMemberId());
	
	// 2. Model 호출	
	CommentDao commentDao = new CommentDao();
	
	String msg = "답변 수정 실패...";
	String targetUrl = "/admin/helpOne.jsp";
	
	if(commentDao.updateComment(updateComment)) {
		msg = "답변 수정 성공!!!";
		targetUrl = "/admin/helpOne.jsp";
	}
	
	msg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect(request.getContextPath() + targetUrl + "?helpNo=" + helpNo + "&msg=" +msg);
%>