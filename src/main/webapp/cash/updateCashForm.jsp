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
<meta charset="UTF-8">

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
	td {
		width : 200px;
		height : 80px;
		font-size : 20pt;
		text-align : center;
	}
	.cashMemo {
		width : 500px;
	}
</style>
<title><%=title%> 가계부 수정</title>
</head>
<body>
	<!-- cash 입력 -->
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="cashNo" value="<%=cashNo%>"> 
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>"> 
		<table border="1">
			<tr>
				<td>categoryNo</td>
				<td>cashDate</td>
				<td>cashPrice</td>
				<td>cashMemo</td>
			</tr>
			
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
			
			<tr>
				<td colspan="4">
					<Button type="submit">가계부 수정</Button>
				</td>
			</tr>
			
		</table>
	</form>
</body>
</html>