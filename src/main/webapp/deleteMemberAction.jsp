<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller session, request
	// deleteMemberForm.jsp로부터 받아온 값이 null 또는 "" 일때
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberPwCheck") == null || 
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberPwCheck").equals("")) {
			
		String msg = URLEncoder.encode("회원탈퇴에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	// deleteMemberForm.jsp로부터 받아온 memberPw 와 memberPwCheck 값이 일치하지 않을 때
	if(!request.getParameter("memberPw").equals(request.getParameter("memberPwCheck"))) {
			
		String msg = URLEncoder.encode("입력하신 두 비밀번호가 일치하지않습니다.", "utf-8");
		
		String targetUrl = "/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	
%>