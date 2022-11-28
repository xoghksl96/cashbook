<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글 처리
	request.setCharacterEncoding("utf-8");
	
	// 1. Controller
	
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
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeMemo") == null ||
		request.getParameter("noticeNo").equals("") || request.getParameter("noticeMemo").equals("")) {
		
		String targetUrl = "/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	
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

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<Style>
	.titleText {
		font-size : 30pt;
		font-weight : bolder;
	}
	.text {
		font-size : 15pt;
		font-weight : bold;
	}
	.center {
		text-align : center;
	}
	.buttonSize {
		width : 200px;
	}
	.noticeTd {
		width : 300px;
	}
</Style>
<title>공지수정 (관리자)</title>
</head>
<body>
	<div class="container">		
		<!-- 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">공지 번호</th>
					<td class="text center"><input type="number" style="background-color : pink" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"></td>
				</tr>
				
				<tr>
					<th class="text center">공지 내용</th>
					<td class="text center"><textarea name="noticeMemo"><%=noticeMemo%></textarea></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">공지 수정</span></button></th>
				</tr>
				
			</table>
			
			<div>
				<a type="button" href="<%=request.getContextPath()%>/logout.jsp"><span class="text">로그아웃</span></a>
			</div>
		</form>
	</div>
</body>
</html>