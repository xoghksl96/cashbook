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
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
<link href="../css/styles.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
<link href="../css/fontcss.css" rel="stylesheet"/>
<link href="../css/buttoncss.css" rel="stylesheet"/>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
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
<!-- main start -->	
<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
<div class="container px-4">
	<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
		<br>
		<h2>카테고리수정 페이지</h2>
		<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp"method="post">
			<table class="styled-table">
				<thead>
					<tr>
						<td>카테고리 번호</td>
						<th>수입 / 지출</th>
						<th>이름</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td><input type="number" style="background-color : pink ;text-align : center ;" name="categoryNo" value="<%=categoryOne.getCategoryNo()%>" readonly="readonly"></td>
						<td>
							<%
								if(categoryOne.getCategoryKind().equals("수입")) {
							%>
								<input type="radio" name="categoryKind" value="수입" checked>&nbsp;수입
								&nbsp;
								<input type="radio" name="categoryKind" value="지출">&nbsp;지출
							<%
								} else {
							%>
								<input type="radio" name="categoryKind" value="수입">&nbsp;수입
								&nbsp;
								<input type="radio" name="categoryKind" value="지출" checked>&nbsp;지출
							<%	
								}
							%>
						</td>
						<td><input type="text" style="text-align : center ;"name="categoryName" value="<%=categoryOne.getCategoryName()%>"></td>
					</tr>
				</tbody>
			</table>
			<div style="text-align : center">
				<button type="submit" class="w-btn-outline w-btn-blue-outline">카테고리 수정</button>
			</div>
		</form>
	</div>
</div>
<!-- main end -->	
<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>