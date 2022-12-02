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
<meta charset="utf-8"/>	
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
<link href="../css/buttoncss.css" rel="stylesheet"/>
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
<title>공지수정 (관리자)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
		<div class="container p-5 ">
			<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
			<div class="card-header" style="margin-bottom : 20px;">
				<h2><i class="fas fa-table me-1"></i>
					공지사항
				</h2>
			</div>
				<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
					<table class="table">	
									
						<tr>
							<th class="text center">공지 번호</th>
							<td class="text center"><input type="number" style="background-color : pink" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"></td>
						</tr>
						
						<tr>
							<th class="text center">공지 내용</th>
							<td class="text center"><textarea  style="width : 100%" name="noticeMemo"><%=noticeMemo%></textarea></td>
						</tr>
						
					</table>
			
					<div style="text-align : center">
						<Button type="submit" class="w-btn-outline w-btn-blue-outline">공지 수정</Button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>