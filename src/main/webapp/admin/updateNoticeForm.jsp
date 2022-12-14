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
<link href="../css/fontcss.css" rel="stylesheet"/>
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
<style>
	table,th,td {
		text-align : center ;
		vertical-align : middle;
	}
</style>
<title>공지수정 (관리자)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
		<div class="container p-5 ">
			<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
			<div class="card-header" style="margin-bottom : 20px;">
				<br>
				<h2><i class="fas fa-table me-1"></i>
					공지사항
				</h2>
			</div>
				<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post" id="updateNoticeForm">
					<table class="table">	
									
						<tr>
							<th>공지 번호</th>
							<td><input type="number" style="background-color : pink; width : 100% ; text-align : center" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"></td>
						</tr>
						
						<tr>
							<th>공지 내용</th>
							<td><textarea  style="width : 100%; height : 50pt ;  text-align : center" id="noticeMemo" name="noticeMemo"><%=noticeMemo%></textarea></td>
						</tr>
						
					</table>
			
					<div style="text-align : center">
						<Button type="button" class="w-btn-outline w-btn-blue-outline" id="updateNoticeBtn">공지 수정</Button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		let updateNoticeBtn = document.querySelector('#updateNoticeBtn');
		
		updateNoticeBtn.addEventListener('click', function(){

			let noticeMemo = document.querySelector('#noticeMemo');
			if(noticeMemo.value == '') {
				alert('공지내용을 입력하세요');
				noticeMemo.focus(); // 커서이동
				return;
			}
			
			let updateNoticeForm = document.querySelector('#updateNoticeForm');
			updateNoticeForm.submit();
		});
	</script>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>