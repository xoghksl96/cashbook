<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
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
	
	// 2. Model 호출
	
	// 2-1 helpList 가져오기
	HelpDao helpDao = new HelpDao();
	
	ArrayList<Help> list = new ArrayList<Help>();
	ArrayList<HashMap<String, Object>> mapList = new ArrayList<HashMap<String, Object>>();
	list = helpDao.selectHelpList(loginMemberId);
	
	// 2-2 답변이 달려있는 지 확인
	
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
<title>Insert title here</title>
</head>
<body class="sb-nav-fixed">
<!-- main start -->	
<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
	
<div class="container px-4">
	<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
		<div class="card-header" style="margin-bottom : 20px;">
			<br>
			<h2><i class="fas fa-table me-1"></i>고객문의</h2>
		</div>
		<table id="datatablesSimple">
			<thead>
				<tr>
					<th>QNA 번호</th>
					<th>QNA 내용</th>
					<th>마지막 수정일</th>
					<th>생성 일자</th>
				</tr>
			</thead>
	
			<tfoot>
				<tr>
					<th>QNA 번호</th>
					<th>QNA 내용</th>
					<th>마지막 수정일</th>
					<th>생성 일자</th>
				</tr>
			</tfoot>
	
			 <tbody>
			<%
				for(Help h : list) {
			%>
					<tr>
						<td><%=h.getHelpNo()%></td>
						<td><a href="<%=request.getContextPath()%>/help/helpOne.jsp?helpNo=<%=h.getHelpNo()%>"><%=h.getHelpMemo()%></a></td>
						<td><%=h.getUpdatedate()%></td>
						<td><%=h.getCreatedate()%></td>
					</tr>			
			<%
				}
			%>
			</tbody>
		</table>
		
		<div style="text-align : center">
			<a type="button" class="w-btn-outline w-btn-blue-outline" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의 하기</a>
		</div>
	</div>
</div>
	
<!-- main end -->	
<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>