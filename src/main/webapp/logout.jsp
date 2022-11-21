<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 되어있지 않을때는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>