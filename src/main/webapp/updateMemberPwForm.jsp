<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 로그인이 되어 있지 않을 때 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
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
</Style>
<title>비밀번호 수정 페이지</title>
</head>
<body>
	<div class="container">
	
		<div class="p-5 bg-dark text-white text-center rounded">
		  	<h1 class="titleText center">비밀번호 수정</h1> 
		</div>
		
		<br>
		
		<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">ID</th>
					<!-- ID를 보여주지만, 수정불가 -->
					<td class="text center"><input style="background-color : pink" type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>"></td>
				</tr>
				
				<tr>
					<th class="text center">OLD PW</th>
					<!-- 현재 비밀번호를 입력하게끔 -->
					<td class="text center"><input type="password" name="oldMemberPw"></td>
				</tr>
				
				<tr>
					<th class="text center">NEW PW</th>
					<!-- 새로운 비밀번호를 입력하게끔 -->
					<td class="text center"><input type="password" name="newMemberPw"></td>
				</tr>
				
				<tr>
					<th class="text center">NEW PW CHECK</th>
					<!-- 새로운 비밀번호 확인 -->
					<td class="text center"><input type="password" name="newMemberPwCheck"></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">비밀번호 수정</span></button></th>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>