<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");	
	
	// 관리자 계정으로 로그인되어야만 접근 가능
	String redirectUrl = null;
	if(loginMember == null) {
		redirectUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	} else if(loginMember.getMemberLevel() < 1) {
		redirectUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	// 공지 페이징
		NoticeDao noticeDao = new NoticeDao();
		MemberDao memberDao = new MemberDao();
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
				
		int rowPerPage = 5;	// 한 페이지에 출력할 공지사항 개수
		int beginRow = (currentPage - 1) * rowPerPage; // 출력 시작점
		int lastPage = noticeDao.selectNoticeCount() / 5;	// 마지막 페이지
		if((noticeDao.selectNoticeCount() % rowPerPage) != 0){ // 나누어 떨어지지 않으면 +1
			lastPage++;
		}
		
		// 공시사항 데이터 가져와서 list에 담기
		ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
		ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	// Model 호출
	
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
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
<title>관리자 메인페이지</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<br>
			<h2>최근공지</h2>
			<table class="styled-table">
				<thead>
					<tr>
						<th>공지 번호</th>
						<th>공지 내용</th>
						<th>공지 날짜</th>
					</tr>
				</thead>
				
				<tbody>
				<%
					for(Notice n : noticeList) {
				%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getNoticecreatedate()%></td>
						</tr>			
				<%
					}
				%>
				</tbody>
			</table>
		</div>
		
		<div class="shadow bg-white p-4">
			<br>
			<h2>최근 가입 멤버</h2>
			<table class="styled-table">
				<thead>
					<tr>
						<th>멤버 번호</th>
						<th>멤버 ID</th>
						<th>가입 날짜</th>
					</tr>
				</thead>
				
				<tbody>
				<%
					for(Member m : memberList) {
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td><%=m.getCreatedate()%></td>
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