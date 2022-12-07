<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");

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
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<link href="css/fontcss.css" rel="stylesheet"/>
<link href="css/tablecss.css" rel="stylesheet"/>
<link href="css/buttoncss.css" rel="stylesheet"/>
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
<title>회원정보 수정 페이지</title>
</head>
<body>
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
	
	<div id="layoutSidenav_content">
		<div class="container p-5 ">
			<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
				<div class="card shadow-lg border-0 rounded-lg mt-5">
					<!-- 로그인 폼 -->
					<div class="card-header"><h3 class="text-center font-weight-light my-4">회원 정보 수정</h3></div>
					<div class="card-body">
    					<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
							<div class="form-floating mb-3">
								<input class="form-control" style="background-color : pink" id="inputEmail" type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>"/>
								<label for="inputEmail">ID</label>
							</div>
							<div class="form-floating mb-3">
								<input class="form-control" id="inputEmail" type="text" name="memberName"/>
								<label for="inputEmail">NAME</label>
							</div>
							<div class="form-floating mb-3">
								<input class="form-control" id="inputPassword" type="password" name="memberPw"/>
								<label for="inputPassword">PW</label>
							</div>
							<div class="d-flex align-items-center justify-content-between mt-4 mb-0">
								<div style="text-align : right">
									<button type="submit" class="btn btn-primary"><span class="text">회원정보 수정</span></button>
								</div>
							</div>
						</form>
					</div>	
				</div>
			</div>
		</div>
	</div>
	<div class="container">
	
		<div class="p-5 bg-dark text-white text-center rounded">
		  	<h1 class="titleText center">회원정보 수정</h1> 
		</div>
		
		<br>
		
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">ID</th>
					<!-- ID를 보여주지만, 수정불가 -->
					<td class="text center"><input style="background-color : pink" type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>"></td>
				</tr>
				
				<tr>
					<th class="text center">PW</th>
					<!-- 비밀번호를 입력하게끔 -->
					<td class="text center"><input type="password" name="memberPw"></td>
				</tr>
				
				<tr>
					<th class="text center">NAME</th>
					<!-- 현재 이름을 보여 주고 수정가능하게 끔 -->
					<td class="text center"><input type="text" name="memberName" value="<%=loginMember.getMemberName()%>"></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">회원 정보수정</span></button></th>
				</tr>
				
			</table>
		</form>
	</div>
	
	<!-- main end -->	
	<jsp:include page="/inc/memberCRUDBottom.jsp"></jsp:include>
</body>
</html>