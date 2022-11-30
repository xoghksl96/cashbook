<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");
	
	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String redirectUrl = null;
	if(loginMember == null) {
		redirectUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	String loginMemberId = loginMember.getMemberId();
	
	
	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	
	// 2. Model호출
	HelpDao helpDao = new HelpDao();
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	map = helpDao.selectHelpOne(loginMemberId, helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">		
		<tr>
			<th>문의 번호</th>
			<th>문의 내용</th>
			<th>문의 작성자</th>
			<th>마지막 수정일</th>
			<th>생성 일자</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		
		<tr>
			<td><%=map.get("helpNo")%></td>
			<td><%=map.get("helpMemo")%></td>
			<td><%=map.get("helpMemberId")%></td>
			<td><%=map.get("helpUpdatedate")%></td>
			<td><%=map.get("helpCreatedate")%></td>
			<%
				if(map.get("commentMemo") == null) {
			%>
					<td><a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=map.get("helpNo")%>">삭제</a></td>
			<%
				} else {
			%>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
			<%
				}
			%>
		</tr>			
	</table>
	
	<br>
	<br>
	
	<table border="1">		
		<tr>
			<th>COMMENT 내용</th>
			<th>COMMENT 작성자</th>
			<th>COMMENT 수정일</th>
			<th>COMMENT 작성일</th>
		</tr>
		
		<tr>
			<%
				if(map.get("commentMemo") == null) {
			%>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
			<%
				} else {
			%>
					<td><%=map.get("commentMemo")%></td>
					<td><%=map.get("commentMemberId")%></td>
					<td><%=map.get("commentUpdatedate")%></td>
					<td><%=map.get("commentCreatedate")%></td>
			<%
				}
			%>
		</tr>			
	</table>
	
	
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
</body>
</html>