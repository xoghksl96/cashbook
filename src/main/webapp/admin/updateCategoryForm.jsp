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

	//관리자 계정으로 로그인되어야만 접근 가능
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
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		
		String targetUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	Category categoryOne = new Category();
	categoryOne.setCategoryNo(categoryNo);

	// 2. Model 호출
	CategoryDao categoryDao = new CategoryDao();
	categoryOne = categoryDao.selectCategoryOneByadmin(categoryOne);
	
	String msg = categoryNo + "번 카테고리 로딩 실패...";
	if(categoryOne.getCategoryName() != null) {
		msg = categoryNo + "번 카테고리 로딩 성공!!!";
	}
	
	System.out.println(msg);
	
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

<title>카테고리 수정페이지(관리자 전용)</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp"method="post">
		<table>
			<tr>
				<td>카테고리 번호</td>
				<td><input type="number" style="background-color : pink" name="categoryNo" value="<%=categoryOne.getCategoryNo()%>" readonly="readonly"></td>
			</tr>
			
			<tr>
				<td>수입 / 지출</td>
				<td>
					<%
						if(categoryOne.getCategoryKind().equals("수입")) {
					%>
						<input type="radio" name="categoryKind" value="수입" checked>수입
						<input type="radio" name="categoryKind" value="지출">지출
					<%
						} else {
					%>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출" checked>지출
					<%	
						}
					%>
				</td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td><input type="text" name="categoryName" value="<%=categoryOne.getCategoryName()%>"></td>
			</tr>
			
			<tr>
				<td colspan="2"><button type="submit">카테고리 수정</button></td>
			<tr>
		</table>
	</form>
</body>
</html>