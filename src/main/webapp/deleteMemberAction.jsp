<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller session, request
	
	// deleteMemberForm.jsp로부터 받아온 값이 null 또는 "" 일때
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
			
		String msg = URLEncoder.encode("회원탈퇴에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}

	Member loginMember = (Member) session.getAttribute("loginMember");
	
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	MemberDao memberDao = new MemberDao();
	
	if(memberDao.deleteMember(loginMember)) { // 회원정보 삭제 완료
		System.out.println("회원탈퇴 완료");
	
		// 로그아웃 페이지로 이동
		String targetUrl = "/logout.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		
	} else { // 회원정보 삭제 실패
		System.out.println("회원탈퇴 실패");
		
		String msg = URLEncoder.encode("올바른 비밀번호를 입력해주세요.","utf-8");
		
		// msg를 가지고 다시 delteMemberForm.jsp로 이동
		String targetUrl = "/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl +"?msg="+msg);
	}
	// Model 호출
	
	
%>