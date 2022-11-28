<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//1. Controller
	if(request.getParameter("memberId") == null || request.getParameter("memberLevel") == null || 
		request.getParameter("memberId").equals("") || request.getParameter("memberLevel").equals("")) {
		
		String targetUrl = "/admin/memberList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}

	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	// 2. 멤버호출
	
	MemberDao memberDao = new MemberDao();
	
	String msg = URLEncoder.encode(updateMember.getMemberId() + " 회원 등급 수정 실패...","utf-8");
	String targetUrl = "/admin/memberList.jsp";		
	if(memberDao.updateMemberLevel(updateMember) == true) {
		msg = URLEncoder.encode(updateMember.getMemberId() + " 회원 등급 수정 성공!!!","utf-8");	
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl+"?msg="+msg);
	
%>