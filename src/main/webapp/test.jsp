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
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Static Navigation - SB Admin</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/testcss.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body>
    
    	 <include src="./header.html"></include>
    	 
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Start Bootstrap</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="index.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Layouts
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="layout-static.html">Static Navigation</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Pages
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">Addons</div>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Charts
                            </a>
                            <a class="nav-link" href="tables.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <div class="container">

  <div class="calendar shadow bg-white p-5">
    <div class="d-flex align-items-center"><i class="fa fa-calendar fa-3x mr-3"></i>
      <h2 class="month font-weight-bold mb-0 text-uppercase"><%=title%></h2>
    </div>
    
    <br>
    <table>		
		<tr>
			<th class = "align-items-left"><a href="<%=request.getContextPath()%>/test.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th class = "align-items-right"><a href="<%=request.getContextPath()%>/test.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a></th>
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
							<div class = "dateOuter">
								<div class = "dateInner">
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
  <!-- calendar-left -->

</div>
<!-- container -->
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
