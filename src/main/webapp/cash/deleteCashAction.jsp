<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// 다시 cashDateList로 돌아가기 위한 날짜 변수 request
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// request 확인
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?year="+year+"&month="+month+"&date="+date);
		return;	
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// ashDao.selectCashOne에 필요한 데이터 정의
	String memberId = loginMember.getMemberId();
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	CashDao cashDao = new CashDao();
	Cash deleteCash = new Cash();
	
	deleteCash = cashDao.selectCashOne(memberId, cashNo);
	
	// 수정할 값, 위치를 찾을 memberId, cashNo 세팅
	deleteCash.setMemberId(memberId);
	deleteCash.setCategoryNo(cashNo);

	
	if(cashDao.deleteCash(deleteCash)) {	// 가계부 수정 성공

		String msg = URLEncoder.encode("가계부 삭제 성공", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
		
	} else {	// 가계부 수정 실패
		
		String msg = URLEncoder.encode("가계부 수정 실패", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;	
	}
%>