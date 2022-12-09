<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
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
<style>
	table,th,td {
		text-align : center ;
		vertical-align : middle;
	}
</style>
<title>공지추가 (관리자)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<div class="card-header" style="margin-bottom : 20px;">
				<br>
				<h2><i class="fas fa-table me-1"></i>
					공지 추가
				</h2>
			</div>
			
			<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
				<table class="table">
					<tr>
						<th style="vertical-align : middle;">공지 내용</th>
						<td><textarea name="noticeMemo" style="width : 100%; height : 50pt"></textarea></td>
					</tr>	
				</table>
				
				<div style="text-align : center">
					<button type="submit" class="w-btn-outline w-btn-blue-outline">공지추가</button>
				</div>
			</form>
		</div>
	</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>