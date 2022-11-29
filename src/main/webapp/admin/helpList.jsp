<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	
	// 1. Controller
	
	// 1-1
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 1-2
	
	// 2. Model호출
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	HelpDao helpDao = new HelpDao();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (1-currentPage) * rowPerPage;
	int lastPage = helpDao.selectHelpCount() / rowPerPage;
	if((helpDao.selectHelpCount() % rowPerPage) != 0){ // 나누어 떨어지지 않으면 +1
		lastPage++;
	}
	
	list = helpDao.selectHelpList(beginRow, rowPerPage);
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
			<th>회원 ID</th>
			<th>문의 날짜</th>
			<th>답변 여부</th>
		</tr>
		
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpNo")%></td>
					<td><a href="<%=request.getContextPath()%>/admin/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpMemo")%></a></td>
					<td><%=m.get("helpMemberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
					<%
						if(m.get("commentMemo") == null) {
					%>
							&nbsp;&nbsp;
					<%
						} else {
					%>
							답변완료
					<%
						}
					%>
					</td>
				</tr>			
		<%
			}
		%>
		
		<tr>
			<td><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>
		
	</table>
</body>
</html>