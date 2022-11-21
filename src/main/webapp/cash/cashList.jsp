<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인이 되어있지 않을때는 접근 불가
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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

<title>cashList</title>
</head>
<body>
	<div>
		<!-- 로그인 정보 출력 (로그인 성공 시) -->
		<!--  세션 안에 (loginMember 변수) 출력 -->
		환영합니다.
	</div>
	
	<div>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
</body>
</html>