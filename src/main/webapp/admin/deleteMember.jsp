<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 1. Controller
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")) {
		
		String targetUrl = "/admin/memberList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}

	Member deleteMember = new Member();
	deleteMember.setMemberId(request.getParameter("memberId"));
	// 2. 멤버호출
	
	MemberDao memberDao = new MemberDao();
	
	String msg = URLEncoder.encode(deleteMember.getMemberId() + " 회원 삭제 실패...","utf-8");
	String targetUrl = "/admin/memberList.jsp";		
	if(memberDao.deleteMemberMyAdmin(deleteMember) == true) {
		msg = URLEncoder.encode(deleteMember.getMemberId() + " 회원 삭제 완료!!!","utf-8");	
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
	
%>