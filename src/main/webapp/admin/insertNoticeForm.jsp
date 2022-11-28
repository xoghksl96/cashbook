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
<title>공지추가 (관리자)</title>
</head>
<body>
	<div class="container">		
		<!-- 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">공지 내용</th>
					<td class="text center"><textarea name="noticeMemo"></textarea></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">공지 추가</span></button></th>
				</tr>
				
			</table>
			
			<div>
				<a type="button" href="<%=request.getContextPath()%>/logout.jsp"><span class="text">로그아웃</span></a>
			</div>
		</form>
	</div>
</body>
</html>