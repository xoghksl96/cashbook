<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글 처리
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
	if(request.getParameter("helpNo") == null || request.getParameter("helpMemo") == null || request.getParameter("commentMemo") == null || request.getParameter("commentNo") == null || 
		request.getParameter("helpNo").equals("") || request.getParameter("helpMemo").equals("") || request.getParameter("commentMemo").equals("") || request.getParameter("helpMemo") == null ||request.getParameter("commentNo").equals("")) {
		
	}
	
	String loginMemberId = loginMember.getMemberId();
	String helpMemo = request.getParameter("helpMemo");
	String commentMemo = request.getParameter("commentMemo");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
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
<title>답변수정 페이지(관리자 전용)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div>
		<h1>답변수정 페이지(관리자 전용)</h1>
	</div>
	
	<div>
		<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
			<table>
				<tr>
					<td>문의번호</td>
					<td><input type="number" style="background-color : pink" name="helpNo" value="<%=helpNo%>" readonly="readonly"></td>
				<tr>
				
				<tr>
					<td>문의내용</td>
					<td><textarea cols="30" rows="5" name="helpMemo"><%=helpMemo%></textarea></td>
				<tr>
				
				<tr>
					<td>답변번호</td>
					<td><input type="number" style="background-color : pink" name="commentNo" value="<%=commentNo%>" readonly="readonly"></td>
				<tr>
				
				<tr>
					<td>답변번호</td>
					<td><textarea cols="30" rows="5" name="commentMemo"><%=commentMemo%></textarea></td>
				<tr>
				
				<tr>
					<td colspan="2"><Button type="submit">답변수정</Button>
				</tr>							
			</table>
		</form>
	</div>
	
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>