<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.getParameter("memberId");
	request.getParameter("memberPw");
	request.getParameter("memberName");
	
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberPw").equals("")) {
			
		String msg = URLEncoder.encode("회원가입에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/insesrtMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	// insertMemberForm으로부터 받아온 값을 insertMember에 저장.
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberPw(request.getParameter("memberPw"));
	insertMember.setMemberPw(request.getParameter("memberName"));
	
	
	// insertMember 정보로 회원가입 시도
	MemberDao md = new MemberDao();
	
	if(md.insert(insertMember)) { // 회원가입에 실패 했을 시,
		
		String msg = URLEncoder.encode("회권가입 성공", "utf-8");
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	} else { // 회원가입에 성공 했을 시,
		
		String msg = URLEncoder.encode("중복된 ID가 존재합니다.", "utf-8");
		String targetUrl = "/insesrtMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
%>