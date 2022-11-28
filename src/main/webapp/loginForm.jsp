<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	// 로그인이 되어 있을때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	// 공지 페이징
	NoticeDao noticeDao = new NoticeDao();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
			
	int rowPerPage = 5;	// 한 페이지에 출력할 공지사항 개수
	int beginRow = (currentPage - 1) * rowPerPage; // 출력 시작점
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;	// 마지막 페이지
	if((noticeDao.selectNoticeCount() % rowPerPage) != 0){ // 나누어 떨어지지 않으면 +1
		lastPage++;
	}
	
	// 공시사항 데이터 가져와서 list에 담기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
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

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<Style>
	.titleText {
		font-size : 30pt;
		font-weight : bolder;
	}
	.text {
		font-size : 15pt;
		font-weight : bold;
	}
	.center {
		text-align : center;
	}
	.buttonSize {
		width : 200px;
	}
	.noticeTd {
		width : 300px;
	}
</Style>
<title>로그인 페이지</title>
</head>
<body>
	<div class="container">		
		<!-- 공지(5개)목록 페이징 -->
		<div>
			<div class="p-3 bg-primary text-white text-center rounded">
				<h1 class="titleText center">공지사항</h1> 
			</div>
			<table class="table">
				<tr>
					<th class="noticeTd">공지 번호</th>
					<th class="noticeTd">공지 내용</th>
					<th class="noticeTd">공지 날짜</th>
				</tr>
				
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td class="noticeTd"><%=n.getNoticeNo()%></td>
							<td class="noticeTd"><%=n.getNoticeMemo()%></td>
							<td class="noticeTd"><%=n.getNoticecreatedate()%></td>
						</tr>
				<%
						
					}
				%>
				
				<tr>	
				
				<%
					if(currentPage == 1) {	// 시작페이지
				%>
					<td class="noticeTd"></td>
					<td class="noticeTd"><a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a></td>
				<%	
					} else if(1 < currentPage && currentPage < lastPage) {
				%>
					<td class="noticeTd"><a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a></td>
					<td class="noticeTd"><a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a></td>
				<%		
					} else if(currentPage == lastPage){ // 마지막 페이지
				%>
					<td class="noticeTd"><a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a></td>
					<td class="noticeTd"></td>
				<%		
					}
				%>
				</tr>
			</table>
		</div>
		
		<div class="p-5 bg-dark text-white text-center rounded">
		  	<h1 class="titleText center">Login</h1> 
		</div>
		
		<br>
		
		<!-- 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table class="table">
				
				<tr>
					<th class="text center">ID</th>
					<td class="text center"><input type="text" name="memberId"></td>
				</tr>
				
				<tr>
					<th class="text center">PW</th>
					<td class="text center"><input type="password" name="memberPw"></td>
				</tr>
				
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">로그인</span></button></th>
				</tr>
				
			</table>
			
			<div>
				<a type="button" href="<%=request.getContextPath()%>/insertMemberForm.jsp"><span class="text">회원가입</span></a>
			</div>
		</form>
	</div>
</body>
</html>