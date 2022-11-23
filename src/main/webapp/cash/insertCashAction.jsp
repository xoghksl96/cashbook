<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%	
	//한글처리
	request.setCharacterEncoding("utf-8");

	// Controller
	
	Cash cash = new Cash();

	// cashDateList.jsp에서 받아온 값들이 null 또는 ""일 경우
	if(request.getParameter("categoryNo") == null || request.getParameter("cashDate") == null || request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null ||
		request.getParameter("categoryNo").equals("") || request.getParameter("cashDate").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")) {
		
		
	} else { // cashDateList.jsp에서 받아온 값들이 정상적인 경우
		cash.setMemberId(request.getParameter("memberId"));
		cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
		cash.setCashDate(request.getParameter("cashDate"));
		cash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
		cash.setCashMemo(request.getParameter("cashMemo"));
		
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// Model 호출
	CashDao cashDao = new CashDao();
	
	if(cashDao.insertCash(cash)) {
		
		String msg = URLEncoder.encode("가계부 작성 성공", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
		
	} else {
		
		String msg = URLEncoder.encode("가계부 작성 성공", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}

%>