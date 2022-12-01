<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");
	// 1. Controller : session, request
	
	// 1-1 세션 확인 -> 로그인이 되어있지 않을때는 접근 불가
	/* if(session.getAttribute("loginMember") == null) {
		String msg = URLEncoder.encode("로그인이 필요한 서비스입니다.","utf-8");
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg"+msg);
		return;
	} */
	
	//Member loginMember = (Member)session.getAttribute("loginMember");
	Member loginMember = new Member();
	loginMember.setMemberId("goodee");
	// 1-2 년, 월  request 
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
	
	String title = year + "년 " + (month+1) + "월 가계부";
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
	ArrayList<HashMap<String, Object>> list = cashDao.slectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력 출력 + 일별 cash 목록
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
<link href="css/styles.css" rel="stylesheet"/>
<link href="css/calendarcss.css" rel="stylesheet"/>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
	
	 <div id="layoutSidenav_content">
		<div class="container">
			<div class="calendar shadow bg-white p-5">
				<div class="d-flex align-items-center"><i class="fa fa-calendar fa-3x mr-3"></i>
					<h2 class="month font-weight-bold mb-0 text-uppercase"><%=title%></h2>
				</div>

				<br>
		
				<table>		
					<tr>
						<th class = "align-items-left"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th class = "align-items-right"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a></th>
					</tr>
		
					<tr class="day-names list-unstyled">
						<th style="color : red">일</th>	
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th style="color : blue">토</th>
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
									<div>
										<div>
											<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>" type="button"><span><%=date%></span></a>
										</div>
						<%				
									for(HashMap<String, Object> m : list) {				
										String cashDate = (String)(m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(8)) == date) {
						%>						
										<div>
											[<%=(String)m.get("categoryKind")%>]
											<%=(String)m.get("categoryName")%>
											<%=(Long)m.get("cashPrice")%>원
										</div>
						<%
											}
							
									}
						%>
									</div>
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
	</div>
</div>
	<!-- main end -->
	<jsp:include page="/inc/layoutBottom.jsp"></jsp:include>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="/js/scripts.js"></script>
</body>
</html>