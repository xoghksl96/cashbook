<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 1. controller 

	// 1-1 세션 확인 -> 로그인이 되어있지 않을때는 접근 불가
	
	if(session.getAttribute("loginMember") == null) {
		String msg = URLEncoder.encode("로그인이 필요한 서비스입니다.","utf-8");
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	
	// 1-2 request
	int year = 0;
	int month = 0;
	int date = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null ||
		request.getParameter("year").equals("") || request.getParameter("month").equals("") || request.getParameter("date").equals("")) {
		
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl+"?year="+year+"&month"+month);
		
	} else {
		
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
	}
	
	String title = year + "년 " + month + "월 " + date + "일";
	
	
	// model 호출
	
	// category정보 list에 저장
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash정보 list에 저장
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> cashList = cashDao.slectCashListByDate(loginMember.getMemberId(), year, month, date);
	
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
<link href="../css/styles.css" rel="stylesheet" />
<link href="../css/fontcss.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
<link href="../css/buttoncss.css" rel="stylesheet"/>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<style>
	input {
		width : auto;
		text-align : center;
	}
	textarea {
		width : 100%;
	}
	th,td {
		text-align : center;
	}
	.cashMemo {
	 width : 70%
	}
</style>
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
<title><%=title%> 가계부</title>
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
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<br>
			<h2><%=title%></h2>
			<!-- cash 출력 -->
			<table class="styled-table">
				<thead>
					<tr>
						<th>수입/지출</th>
						<th>항목</th>
						<th>금액</th>
						<th>상세정보</th>
						<th></th>
						<th></th>
					<tr>
				</thead>
				
				<tbody>
				<%
					for(HashMap<String, Object> m : cashList) {		
				%>
						<tr>
							<%
								if(m.get("categoryKind").equals("지출"))
								{
							%>
									<td style="color : blue"><%=m.get("categoryKind")%></td>
							<%
								} else {
							%>
									<td style="color : red"><%=m.get("categoryKind")%></td>
							<%
								}
							%>
							<td>[<%=m.get("categoryName")%>]</td>
							<td><%=m.get("cashPrice")%>원</td>
							<td class="cashMemo"><%=m.get("cashMemo")%></td>
							<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">삭제</a></td>
						</tr>
				<%
					}
				%>
				</tbody>
			</table>

			<br>
			<h2>가계부 작성</h2>
			<!-- cash 입력 -->
			<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="year" value="<%=year%>"> 
				<input type="hidden" name="month" value="<%=month%>"> 
				<input type="hidden" name="date" value="<%=date%>"> 
				<table class="styled-table">
						
					<thead>
						<tr>
							<th>categoryNo</th>
							<th>cashDate</th>
							<th>cashPrice</th>
							<th>cashMemo</th>
						<tr>
					</thead>
					
					<tbody>
						<tr>
							<td>
								<select name="categoryNo" style="height : 25px ; font-size : 10pt">
								<%
									for(Category c : categoryList) {
								%>
										<option value="<%=c.getCategoryNo()%>">
											[<%=c.getCategoryKind()%>] <%=c.getCategoryName()%>
										</option>
								<%
									}
								%>
								</select>
							</td>
							<td><input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>
							<td><input type="number" name="cashPrice" value=""></td>
							<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
						</tr>
					</tbody>				
				</table>
					
				<div style="text-align : center">
					<Button type="submit" class="w-btn-outline w-btn-blue-outline">작성</Button>
				</div>
			</form>
		</div>
	</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>