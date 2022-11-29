<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
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
	
	// 2. Model 호출
	
	// 2-1 helpList 가져오기
	HelpDao helpDao = new HelpDao();
	
	ArrayList<Help> list = new ArrayList<Help>();
	ArrayList<HashMap<String, Object>> mapList = new ArrayList<HashMap<String, Object>>();
	list = helpDao.selectHelpList(loginMemberId);
	
	// 2-2 답변이 달려있는 지 확인
	
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
			<th>QNA 번호</th>
			<th>QNA 내용</th>
			<th>마지막 수정일</th>
			<th>생성 일자</th>
		</tr>
		
		<%
			for(Help h : list) {
		%>
				<tr>
					<td><%=h.getHelpNo()%></td>
					<td><a href="<%=request.getContextPath()%>/help/helpOne.jsp?helpNo=<%=h.getHelpNo()%>"><%=h.getHelpMemo()%></a></td>
					<td><%=h.getUpdatedate()%></td>
					<td><%=h.getCreatedate()%></td>
				</tr>			
		<%
			}
		%>
		
		<tr>
			<td colspan="4"><a type="button" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의 추가</a></td>
		<tr>
		
		<tr>
			<td><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>
		
	</table>
</body>
</html>