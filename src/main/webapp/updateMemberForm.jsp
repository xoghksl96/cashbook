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
<title>회원정보 수정 페이지</title>
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
	
	<div class="container p-5 ">
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
						<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="inputPassword" type="password" name="memberPw"/>
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
	<!-- main end -->	
	<jsp:include page="/inc/memberCRUDBottom.jsp"></jsp:include>
</body>
</html>