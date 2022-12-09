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
		text-align : center;
	}
</style>
<title>Insert title here</title>
</head>
<body class="sb-nav-fixed">
<!-- main start -->	
<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<div class="card-header" style="margin-bottom : 20px;">
			<br>
			<h2><i class="fas fa-table me-1"></i>
				고객문의
			</h2>
		</div>
		
		<table class="styled-table">
			<thead>
				<tr>
					<th>문의 번호</th>
					<th style="width : 40%">문의 내용</th>
					<th>문의 작성자</th>
					<th>마지막 수정일</th>
					<th>생성 일자</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><%=map.get("helpNo")%></td>
					<td><%=map.get("helpMemo")%></td>
					<td><%=map.get("helpMemberId")%></td>
					<td><%=map.get("helpUpdatedate")%></td>
					<td><%=map.get("helpCreatedate")%></td>
					<%
						if(map.get("commentMemo") == null) {
					%>
							<td><a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=map.get("helpNo")%>">수정</a></td>
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
			</tbody>					
		</table>
		
		<br>
		
		<table class="styled-table">
			<thead>
				<tr>
					<th style="width : 60%">COMMENT 내용</th>
					<th>COMMENT 작성자</th>
					<th>COMMENT 수정일</th>
					<th>COMMENT 작성일</th>
				</tr>
			</thead>		
			
			<tbody>
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
			</tbody>			
		</table>
	</div>
	</div>
	
<!-- main end -->	
<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>