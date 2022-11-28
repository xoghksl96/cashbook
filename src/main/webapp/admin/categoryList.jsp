<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");

	// 1.controller
	
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 관리자 계정으로 로그인되어야만 접근 가능
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
	
	
	
	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectCategoryListByadmin();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
<%
	if(request.getParameter("msg") != null)
	{			
%>	
		alert("<%=request.getParameter("msg")%>");
<%	
	}
%>
</script>

<title>카테고리 관리페이지(관리자 전용)</title>
</head>
<body>
	<table>
		<tr>
			<td><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></td>
		</tr>
		
		<tr>
			<th>카테고리 번호</th>
			<th>카테고리 종류</th>
			<th>카테고리 이름</th>
			<th>최근 수정 날짜</th>
			<th>생성 날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		
		<%
			for(Category c : list) {
		%>
				<tr>
					<td><%=c.getCategoryNo()%></td>
					<td><%=c.getCategoryName()%></td>
					<td><%=c.getCategoryKind()%></td>
					<td><%=c.getUpdatedate()%></td>
					<td><%=c.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
				</tr>			
		<%
			}
		%>
		<tr>
			<td><a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a></td>
		</tr>
		
		<tr>
			<td><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>	
	</table>
</body>
</html>