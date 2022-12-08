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
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
<link href="../css/buttoncss.css" rel="stylesheet"/>
<link href="../css/fontcss.css" rel="stylesheet"/>
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
<title>카테고리 관리페이지(관리자 전용)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
				<div class="card-header" style="margin-bottom : 20px;">
					<br>
					<h2><i class="fas fa-table me-1"></i>
						카테고리
					</h2>
				</div>
				
				<table id="datatablesSimple">
					<thead>
						<tr>
							<th>카테고리 번호</th>
							<th>카테고리 종류</th>
							<th>카테고리 이름</th>
							<th>최근 수정 날짜</th>
							<th>생성 날짜</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
			
					<tfoot>
						<tr>
							<th>카테고리 번호</th>
							<th>카테고리 종류</th>
							<th>카테고리 이름</th>
							<th>최근 수정 날짜</th>
							<th>생성 날짜</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</tfoot>
			
					 <tbody>
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
					</tbody>
				</table>
				<div style="text-align : center">
					<a type="button" class="w-btn-outline w-btn-blue-outline" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>