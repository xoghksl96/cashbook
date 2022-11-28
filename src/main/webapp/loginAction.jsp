<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");

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
	
	MemberDao memberDao = new MemberDao();
	Member loginMember = new Member();
	
	// loginForm으로부터 받아온 값을 loginMember에 저장.
	loginMember.setMemberId(request.getParameter("memberId"));
	loginMember.setMemberPw(request.getParameter("memberPw"));

	
	// loginMember의 정보로 로그인 시도	
	loginMember = memberDao.login(loginMember);
	
	
	if(loginMember != null) { // 로그인에 성공 했을 시,
		
		// 세션에 로그인 정보 저장.
		session.setAttribute("loginMember", loginMember);
	
		String level = "고객 ";
		String msg = "로그인 성공";
		String targetUrl = "/cash/cashList.jsp";
		
		if(loginMember.getMemberLevel() == 1) {	// 관리자 계정일 때
			
			level = "관리자 ";
			targetUrl = "/admin/adminMain.jsp";

		}
			// 고객 계정일 때
			msg = URLEncoder.encode(level + msg, "utf-8");
			response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
			return;
				
	} else { // 로그인에 실패 했을 시, loginForm으로 강제이동
		
		String msg = URLEncoder.encode("올바른 ID와 PW를 입력해주세요", "utf-8");
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
%>