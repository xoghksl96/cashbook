<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	// 1. Controller : session, request
	
	// 1-1 세션 확인 -> 로그인이 되어있지 않을때는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String msg = URLEncoder.encode("로그인이 필요한 서비스입니다.","utf-8");
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet" />
<link href="../css/calendarcss.css" rel="stylesheet"/>
<link href="../css/fontcss.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
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
<title>Insert title here</title>
</head>
<body class="sb-nav-fixed">
<%
	if(loginMember.getMemberLevel() == 1) {
%>
		<!-- main start -->	
		<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
<%
	} else {
%>
		<!-- main start -->	
		<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
<%
	}
%>

	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<div class="card-header" style="margin-bottom : 20px;">
				<br>
				<h2><i class="fas fa-table me-1"></i>
					연도 선택 월별 통계
				</h2>
			</div>
			<ol>
				<li><a type="button" href="<%=request.getContextPath()%>/stats/statsByMonth.jsp?year=2021">2021년</a></li>
				&nbsp;
				<li><a type="button" href="<%=request.getContextPath()%>/stats/statsByMonth.jsp?year=2022">2022년</a></li>
			</ol>
			</div>
		</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>