<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	
	// 1-1 세션 확인


	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model호출
	HelpDao helpDao = new HelpDao();
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map = helpDao.selectHelpOneByAdmin(helpNo);
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
			<th>답변 내용</th>
			<th>답변 날짜</th>
			<th>답변 추가/수정/삭제</th>
		</tr>
	
		<tr>
			<td><%=map.get("helpNo")%></td>
			<td><%=map.get("helpMemo")%></td>
			<td><%=map.get("helpMemberId")%></td>
			<td><%=map.get("helpCreatedate")%></td>
			<%
				if(map.get("commentMemo") == null) {
			%>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=map.get("helpNo")%>&helpMemo=<%=map.get("helpMemo")%>">답변 입력</a></td>
			<%
				} else {
			%>
				<td><%=map.get("commentMemo")%></td>
				<td><%=map.get("commentCreatedate")%></td>
				<td>
					<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=map.get("helpNo")%>&helpMemo=<%=map.get("helpMemo")%>&commentNo=<%=map.get("commentNo")%>&commentMemo=<%=map.get("commentMemo")%>">답변 수정</a>
					/
					<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?helpNo=<%=map.get("helpNo")%>&commentNo=<%=map.get("commentNo")%>">답변 삭제</a>
				</td>
			<%
				}
			%>
		</tr>			
		
		<tr>
			<td colspan="7"><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>
		
	</table>
</body>
</html>