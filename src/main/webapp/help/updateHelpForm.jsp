<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");
	
	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String redirectUrl = null;
	if(loginMember == null) {
		redirectUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	String loginMemberId = loginMember.getMemberId();
	
	
	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	
	// 2. Model호출
	HelpDao helpDao = new HelpDao();
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	map = helpDao.selectHelpOne(loginMemberId, helpNo);
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
<title>Insert title here</title>
</head>
<body class="sb-nav-fixed">
	<!-- main start -->	
	<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
		<div class="container px-4">
			<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
				<div class="card-header" style="margin-bottom : 20px;">
				<br>
				<h2><i class="fas fa-table me-1"></i>
					고객문의
				</h2>
			</div>
			<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post" id="insertHelpForm">
				<input type="number" name="helpNo" value="<%=map.get("helpNo")%>" hidden="hidden">
				<table class="styled-table">
					<thead>
						<tr>
							<th>문의 번호</th>
							<th style="width : 50%">문의 내용</th>
							<th>문의 작성자</th>
							<th>마지막 수정일</th>
							<th>생성 일자</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td><%=map.get("helpNo")%></td>
							<td>
								<textarea style="width : 100% ;height : 50pt;text-align:center" id="helpMemo" name="helpMemo"><%=map.get("helpMemo")%></textarea>
							</td>
							<td><%=map.get("helpMemberId")%></td>
							<td><%=map.get("helpUpdatedate")%></td>
							<td><%=map.get("helpCreatedate")%></td>
						</tr>
					</tbody>					
				</table>
				
				<div style="text-align : center">
					<button type="button" class="w-btn-outline w-btn-blue-outline" id="updateHelpBtn">문의 수정</button>
				</div>
			</form>
			<br>
		</div>
	</div>
	
	<script>
		let updateHelpBtn = document.querySelector('#updateHelpBtn');
		
		updateHelpBtn.addEventListener('click', function(){
	
			let helpMemo = document.querySelector('#helpMemo');
			console
			if(helpMemo.value == '') {
				alert('문의내용을 입력하세요');
				helpMemo.focus(); // 커서이동
				return;
			}
			
			let insertHelpForm = document.querySelector('#insertHelpForm');
			insertHelpForm.submit();
		});
	</script>		
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>