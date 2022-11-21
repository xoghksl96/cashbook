<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%
	/* //Controller : session, request
	
	// 1. 세션 확인 -> 로그인이 되어있지 않을때는 접근 불가
	
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} */
	
	
	// 2. 년, 월  request 
	int year = 0;
	int month = 0;
	
	// 넘어온 year, month 값이 null 또는 "" 이면
	if(request.getParameter("year") == null || request.getParameter("month") == null ||
		request.getParameter("year").equals("") || request.getParameter("month").equals("")) {
		
		Calendar today = Calendar.getInstance();
		year = today.get(Calendar.YEAR);	// 현재 날짜의 년도를 가져옴
		month = today.get(Calendar.MONTH);	// 현재 날짜의 월을 가져옴
		
	} else {	// 넘어온 값 그대로 사용
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if(month == -1) {	// month가 -1일때, month -> 11, year -> year-1
			month = 11;
			year -= 1;
		}
		if(month == 13) {	// month가 13일때, month -> 1, year -> year+1
			month = 1;
			year += 1;
		}
	}
	

	// 출력하고자 하는 1일의 요일 (일 1, 월 2, 화 3, 수 4, 목 5, 금 6, 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(year, month, 1);
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일 (1 -> 일, 2 -> 월, .... 7 -> 토)
	
	// 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 첫 주 공백 구하기
	int beginBlank = firstDay-1;
	
	// 마지막 주 공백 선언
	int endBlanck = 0;
	
	// 마지막 주 공백 = 7 - (시작 공백 + 해당 월의 일수) % 7)
	if((beginBlank + lastDate) % 7 != 0) {	// 정확히 떨어지지 7칸으로 떨어지지않는 다면
		endBlanck = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td 개수
	int totalTd = beginBlank + lastDate + endBlanck;
	
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.slectCashListByMonth(year, month+1);
	
	
	// View : 달력 출력 + 일별 cash 목록
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
<title>cashList</title>
</head>
<body>
	<div>
		<!-- 로그인 정보 출력 (로그인 성공 시) -->
		<!--  세션 안에 (loginMember 변수) 출력 -->
		환영합니다.
	</div>
	
	<div>
		<%=year%>년 <%=month+1%> 월
	</div>
	
	<div>
		<table border="1">
			<tr>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
				<th>일</th>
			</tr>
			
			<tr>
		<%
			for(int i=1 ; i<=totalTd ; i++) {
		%>
				<td>
		<%
					int date = i - beginBlank;
					if(date > 0 && date <= lastDate) {
		%>
						 <%=date%>
		<%	
					}
		%>
				</td>
		<%
				if(i%7==0 && i != totalTd) {
		%>
					</tr><tr>
		<%
				}
			}
		%>
			</tr>
		</table>
	</div>
	
	<div>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<div>
					<%=(int)m.get("cashNo")%>
					<%=(String)m.get("cashDate")%>
					<%=(long)m.get("cashPrice")%>
					<%=(int)m.get("categoryNo")%>
					<%=(String)m.get("categoryKind")%>
					<%=(String)m.get("categoryName")%>
				</div>
		<%
			}
		%>
	</div>
	
	<div>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
</body>
</html>