<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글 처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");	
	
	// 1-1 관리자 계정으로 로그인되어야만 접근 가능
	String redirectUrl = null;
	if(loginMember == null) {
		redirectUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	} else if(loginMember.getMemberLevel() < 1) {
		redirectUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpMemo") == null || 
		request.getParameter("helpNo").equals("") || request.getParameter("helpMemo").equals("")) {
		
		String targetUrl = "/admin/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변추가 페이지(관리자 전용)</title>
</head>
<body>
	<div>
		<h1>답변추가 페이지(관리자 전용)</h1>
	</div>
	
	<div>
		<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
			<table>
				
				<tr>
					<td>문의 번호</td>
					<td><input type="number" name="helpNo" value="<%=helpNo%>" readonly="readonly"></td>
				<tr>
				
				<tr>
					<td>문의내용</td>
					<td><textarea cols="30" rows="5" name="helpMemo" readonly="readonly"><%=helpMemo%></textarea></td>
				<tr>
				
				
				<tr>
					<td>답변내용</td>
					<td><textarea cols="30" rows="5" name="commentMemo"></textarea></td>
				<tr>	
				
				<tr>
					<td colspan="2"><Button type="submit">답변추가</Button>
				</tr>			
			</table>
		</form>
	</div>
</body>
</html>