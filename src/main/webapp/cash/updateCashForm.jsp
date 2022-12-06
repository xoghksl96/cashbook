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
	
	String memberId = null;
	int cashNo = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null || request.getParameter("cashNo") == null ||
		request.getParameter("year").equals("") || request.getParameter("month").equals("") || request.getParameter("date").equals("") || request.getParameter("cashNo").equals("")) {
		
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		
	} else {
		
		memberId = loginMember.getMemberId();
		cashNo = Integer.parseInt(request.getParameter("cashNo"));
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
	}
	
	Cash cashOne = new Cash();
	CashDao cashDao = new CashDao();
	
	String title = year + "년 " + month + "월 " + date + "일";
	
	
	// 2. Model 호출
	
	// category정보 list에 저장
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// 기존 항목을 보기위해 cashDao.selectCashOne 메서드 실행
	cashOne = cashDao.selectCashOne(memberId, cashNo);
	
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
		width : 80%;
		height : 100%;
		text-align : center;
	}
	textarea {
		width : 100%;
	}
	th,td {
		text-align : center;
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
<title><%=title%> 가계부 수정</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
			<div class="container p-5 ">
				<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
					<br>
					<h2 style="margin-left : 2% ; margin-top : 2%"><%=title%></h2>
					<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
						<input type="hidden" name="cashNo" value="<%=cashNo%>"> 
						<input type="hidden" name="year" value="<%=year%>"> 
						<input type="hidden" name="month" value="<%=month%>"> 
						<input type="hidden" name="date" value="<%=date%>"> 
						<table class="styled-table">
							<thead>
								<tr>
									<td>categoryNo</td>
									<td>cashDate</td>
									<td>cashPrice</td>
									<td>cashMemo</td>
								</tr>
							</thead>
							
							<tbody>
								<tr>
									<td>
										<select name="categoryNo">
										<%
											for(Category c : categoryList) {
												if(c.getCategoryNo() == cashOne.getCategoryNo()) {
										%>
													<option value="<%=c.getCategoryNo()%>" selected>
														[<%=c.getCategoryKind()%>] <%=c.getCategoryName()%>
													</option>
										<%
												} else {
										%>
													<option value="<%=c.getCategoryNo()%>">
														[<%=c.getCategoryKind()%>] <%=c.getCategoryName()%>
													</option>
										<%
												}
											}
										%>
										</select>
									</td>
									<td><input type="text" name="cashDate" value="<%=cashOne.getCashDate()%>" readonly="readonly"></td>
									<td><input type="number" name="cashPrice" value="<%=cashOne.getCashPrice()%>"></td>
									<td><textarea rows="3" cols="50" name="cashMemo"><%=cashOne.getCashMemo()%></textarea></td>
								</tr>
							</tbody>
							
						</table>
						
						<div style="text-align : center">
							<Button type="submit" class="w-btn-outline w-btn-blue-outline">수정</Button>
						</div>
					</form>
				</div>
			</div>
		</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
</body>
</html>