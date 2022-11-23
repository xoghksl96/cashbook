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
<title><%=title%> 가계부</title>
</head>
<body>
	<!-- cash 입력 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
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
			
			<tr>
				<td colspan="4">
					<Button type="submit">입력</Button>
				</td>
			</tr>
			
		</table>
	</form>
	
	<br>
	<br>
	
	<!-- cash 출력 -->
	<table border="1">
	
		<tr>
			<td></td>
			<td colspan="4"><%=title%></td>
			<td></td>
		<tr>
		
		<tr>
			<td>수입/지출</td>
			<td>항목</td>
			<td>금액</td>
			<td>상세정보</td>
			<td></td>
			<td></td>
		<tr>
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
	</table>
</body>
</html>