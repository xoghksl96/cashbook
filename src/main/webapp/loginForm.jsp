<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인이 되어 있을때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
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
%>.
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
</Style>
<title>로그인 페이지</title>
</head>
<body>
	<div class="container">
	
		<div class="p-5 bg-dark text-white text-center rounded">
		  	<h1 class="titleText center">Login Page</h1> 
		</div>
		
		<br>
		
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">ID</th>
					<td class="text center"><input type="text" name="memberId"></td>
				</tr>
				
				<tr>
					<th class="text center">PW</th>
					<td class="text center"><input type="password" name="memberPw"></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">로그인</span></button></th>
				</tr>
				
			</table>
			
			<div>
				<a type="button" href="<%=request.getContextPath()%>/insertEmpForm.jsp"><span class="text">회원가입</span></a>
			</div>
		</form>
	</div>
</body>
</html>