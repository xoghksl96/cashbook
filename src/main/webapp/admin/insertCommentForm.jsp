<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글 처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");	
	
	// 1-1 관리자 계정으로 로그인되어야만 접근 가능
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
	if(request.getParameter("helpNo") == null || request.getParameter("helpMemo") == null || 
		request.getParameter("helpNo").equals("") || request.getParameter("helpMemo").equals("")) {
		
		String targetUrl = "/admin/helpOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	
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
<title>답변추가 페이지(관리자 전용)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<br>
			<h2>답변추가 페이지(관리자 전용)</h2>
			<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post" id="insertCommentForm">
				<input type="number" name="helpNo" value="<%=helpNo%>" readonly="readonly" hidden="hidden">
				<table class="styled-table">
					
					<thead>
						<tr>
							<td style="text-align : center; font-size : 15pt">문의내용</td>
							<td><textarea rows="5" style="width : 100% ;text-align:center" id="helpMemo" name="helpMemo" readonly="readonly"><%=helpMemo%></textarea></td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td style="text-align : center; font-size : 15pt">답변내용</td>
							<td><textarea rows="5" style="width : 100% ;text-align:center" id="commentMemo" name="commentMemo"></textarea></td>
						</tr>
					</tbody>	
			
				</table>
				
				<div style="text-align : center">
					<button type="button" class="w-btn-outline w-btn-blue-outline" id="insertCommentBtn">답변 입력</button>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		let insertCommentBtn = document.querySelector('#insertCommentBtn');
		
		insertCommentBtn.addEventListener('click', function(){
			
			let commentMemo = document.querySelector('#commentMemo');
			if(commentMemo.value == '') {
				alert('답변을 입력하세요');
				commentMemo.focus(); // 커서이동
				return;
			}
			
			let insertCommentForm = document.querySelector('#insertCommentForm');
			insertCommentForm.submit();
		});
	</script>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>