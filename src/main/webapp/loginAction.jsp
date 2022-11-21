<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	
	// Form 으로 부터 입력받은 값이 null 또는 "" 일때
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")) {
			
		String msg = URLEncoder.encode("ID와 PW 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}

	// 분리된 Model 호출
	
	// loginForm으로부터 받아온 값을 loginMember에 저장.
	Member loginMember = new Member();
	loginMember.setMemberId(request.getParameter("memberId"));
	loginMember.setMemberPw(request.getParameter("memberPw"));

	
	// loginMember의 정보로 로그인 시도
	MemberDao md = new MemberDao();
	
	if(md.login(loginMember) != null) { // 로그인에 성공 했을 시,
		
		// 세션에 로그인 정보 저장.
		
		loginMember = md.login(loginMember);
		session.setAttribute("loginMember", loginMember);
		
		String msg = URLEncoder.encode("로그인 성공", "utf-8");
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
				
	} else { // 로그인에 실패 했을 시, loginForm으로 강제이동
		
		String msg = URLEncoder.encode("올바른 ID와 PW를 입력해주세요", "utf-8");
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
%>