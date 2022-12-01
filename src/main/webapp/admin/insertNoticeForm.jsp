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
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<div class="container p-5 ">
				<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
					<h2>공지 추가</h2>
					<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
						<table class="table">
							<tr>
								<th class="text center">공지 내용</th>
								<td class="text center"><textarea name="noticeMemo" style="width : 100%"></textarea></td>
							</tr>
							
							<tr>
								<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">공지 추가</span></button></th>
							</tr>
							
						</table>
					</form>
				</div>
			</div>
		</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>