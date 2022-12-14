<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	
	// 1. Controller
	
	// 1-1
	if(session.getAttribute("loginMember") == null) {
		String msg = URLEncoder.encode("로그인이 필요한 서비스입니다.","utf-8");
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");

	// 관리자 계정으로 로그인되어야만 접근 가능
	String redirectUrl = null;
	
	if(loginMember.getMemberLevel() < 1) {
		redirectUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}

	// 1-2
	
	// 2. Model호출
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	HelpDao helpDao = new HelpDao();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (1-currentPage) * rowPerPage;
	int lastPage = helpDao.selectHelpCount() / rowPerPage;
	if((helpDao.selectHelpCount() % rowPerPage) != 0){ // 나누어 떨어지지 않으면 +1
		lastPage++;
	}
	
	list = helpDao.selectHelpList(beginRow, rowPerPage);
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
<title>고객센터 (관리자 전용)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<div class="card-header" style="margin-bottom : 20px;">
				<br>
				<h2><i class="fas fa-table me-1"></i>
					고객문의
				</h2>
			</div>
				<table id="datatablesSimple">
					<thead>
						<tr>
							<th style="text-algin :center;">문의 번호</th>
							<th>문의 내용</th>
							<th>회원 ID</th>
							<th>문의 날짜</th>
							<th>답변 여부</th>
						</tr>
					</thead>
			
					<tfoot>
						<tr>
							<th style="text-algin :center;">문의 번호</th>
							<th>문의 내용</th>
							<th>회원 ID</th>
							<th>문의 날짜</th>
							<th>답변 여부</th>
						</tr>
					</tfoot>
			
					 <tbody>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr>
								<td style="text-algin :center;"><%=m.get("helpNo")%></td>
								<td><a href="<%=request.getContextPath()%>/admin/helpOne.jsp?helpNo=<%=m.get("helpNo")%>"><%=m.get("helpMemo")%></a></td>
								<td><%=m.get("helpMemberId")%></td>
								<td><%=m.get("helpCreatedate")%></td>
								<td>
								<%
									if(m.get("commentMemo") == null) {
								%>
										&nbsp;&nbsp;
								<%
									} else {
								%>
										답변완료
								<%
									}
								%>
								</td>
							</tr>			
					<%
						}
					%>
					</tbody>
				</table>
			</div>
		</div>

	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>