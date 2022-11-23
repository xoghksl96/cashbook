<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	
	// requset
	// updateMemberPwForm.jsp로부터 받아온 값이 null 또는 "" 일때
	if(request.getParameter("memberId") == null || request.getParameter("oldMemberPw") == null || request.getParameter("newMemberPw") == null || request.getParameter("newMemberPwCheck") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("oldMemberPw").equals("") || request.getParameter("newMemberPw").equals("") || request.getParameter("newMemberPwCheck").equals("")) {
			
		String msg = URLEncoder.encode("비밀번호 수정에 필요한 정보를 모두 입력해주세요", "utf-8");
		
		String targetUrl = "/updateMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}
	

	MemberDao memberDao = new MemberDao();
	Member updateMember = new Member();
	
	// updateMemberPwForm으로부터 받아온 값을 updateMember에 저장.
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberPw(request.getParameter("oldMemberPw"));
	
	// 새 비밀번호
	String newPw = request.getParameter("newMemberPw");
	String newPwCheck = request.getParameter("newMemberPwCheck");
	
	// 2. Model 호출
	// 비밀번호 수정 전 newPw 와 newPwcheck이 일치하는 지 확인
	if(memberDao.passwordCheck(newPw, newPwCheck)) { // 일치 -> 비밀번호 수정
		
		Member loginMember = memberDao.updateMemberPw(updateMember,newPw);
	
		if(loginMember != null) { // 비밀번호 수정에 성공 했을 시,
			
			// 수정된 loginMember를 새로 세션에 넣기
			session.setAttribute("loginMember", loginMember);
			
			String msg = URLEncoder.encode("비밀번호 수정 성공", "utf-8");
			System.out.println("비밀번호 변경 성공 후 cashList.jsp로 이동");
			String targetUrl = "/cash/cashList.jsp";
			response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
			return;
			
		} else { // 비밀번호 수정에 실패 했을 시,
			
			String msg = URLEncoder.encode("비밀번호 수정 실패", "utf-8");
			String targetUrl = "/updateMemberPwForm.jsp";
			response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
			return;
			
		}
	} else { // 불일치 -> 다시 updatePwForm.jsp로 이동
		
		String msg = URLEncoder.encode("새로 입력하신 두 비밀번호가 일치하지않습니다.", "utf-8");
		String targetUrl = "/updateMemberPwForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
		
	}
	
%>