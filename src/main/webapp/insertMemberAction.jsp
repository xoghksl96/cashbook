<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	
	//한글처리
	request.setCharacterEncoding("utf-8");

	// insertMemberForm.jsp로부터 받아온 값이 null 또는 "" 일때
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberPwCheck") == null || request.getParameter("memberName") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberPwCheck").equals("") || request.getParameter("memberName").equals("")) {
			
		String msg = URLEncoder.encode("회원가입에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/insertMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	// insertMemberForm으로부터 받아온 값을 insertMember에 저장.
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberPw(request.getParameter("memberPw"));
	insertMember.setMemberName(request.getParameter("memberName"));
	
	MemberDao memberDao = new MemberDao();
	
	// insertMemberForm.jsp로부터 받아온 memberPw 와 memberPwCheck 값이 일치하지 않을 때
	if(memberDao.passwordCheck(request.getParameter("memberPw"), request.getParameter("memberPwCheck")) == false) {
			
		String msg = URLEncoder.encode("입력하신 두 비밀번호가 일치하지않습니다.", "utf-8");
		
		String targetUrl = "/insertMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	
	// 회원 가입 전 ID중복 확인
	if(memberDao.memberIdChech(insertMember.getMemberId())) { // 중복되는 ID가 DB에 존재할 경우
		
		String msg = URLEncoder.encode("중복된 ID가 존재합니다.", "utf-8");
		String targetUrl = "/insertMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
		
	} else {	// 중복되는 ID가 DB에 존재하지 않을 경우 -> 회원가입 진행
		
		if(memberDao.insertMember(insertMember)) { // 회원가입에 성공 했을 시,
			
			String msg = URLEncoder.encode("회원가입 성공", "utf-8");
			String targetUrl = "/loginForm.jsp";
			response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
			return;
			
		} else { // 회원가입에 실패 했을 시,
			
			String msg = URLEncoder.encode("회원가입 실패", "utf-8");
			String targetUrl = "/insertMemberForm.jsp";
			response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
			return;
			
		}	
	}
%>