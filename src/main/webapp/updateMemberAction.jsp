<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// updateMemberForm.jsp로부터 받아온 값이 null 또는 "" 일때
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("")) {
			
		String msg = URLEncoder.encode("회원정보 수정에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/updateMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	// updateMemberForm으로부터 받아온 값을 updateMember에 저장.
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberPw(request.getParameter("memberPw"));
	updateMember.setMemberName(request.getParameter("memberName"));
	
	MemberDao memberDao = new MemberDao();
	
	// 회원정보 수정 메서드 실행
	Member loginMember = memberDao.updateMember(updateMember);
	
	// 회원 가입 전 ID중복 확인
	if(loginMember != null) { // 회원정보 수정에 성공 했을 시,
		
		// 수정된 loginMember를 새로 세션에 넣기
		session.setAttribute("loginMember", loginMember);
		
		String msg = URLEncoder.encode("회원정보 수정 성공", "utf-8");
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
		
	} else { // 회원가입에 실패 했을 시,
		
		String msg = URLEncoder.encode("올바른 비밀번호를 입력해주세요.", "utf-8");
		String targetUrl = "/updateMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
		
	}	
%>