<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");	
	
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
	
	// Model 호출
	ArrayList<Notice> listNotice = new ArrayList<Notice>();
	
	NoticeDao noticeDao = new NoticeDao();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
			
	int rowPerPage = 10;	// 한 페이지에 출력할 공지사항 개수
	int beginRow = (currentPage - 1) * rowPerPage; // 출력 시작점
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;	// 마지막 페이지
	if((noticeDao.selectNoticeCount() % rowPerPage) != 0){ // 나누어 떨어지지 않으면 +1
		lastPage++;
	}
	
	
	// Model 호출
	//ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);		
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage();		
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
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet"/>
<link href="../css/tablecss.css" rel="stylesheet"/>
<link href="../css/buttoncss.css" rel="stylesheet"/>
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
<title>공지관리 페이지(관리자)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
		<div class="container p-5 ">
			<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
			<div class="card-header" style="margin-bottom : 20px;">
				<h2><i class="fas fa-table me-1"></i>
					공지사항
				</h2>
			</div>
				<table id="datatablesSimple">
					<thead>
						<tr>
							<th>공지 번호</th>
							<th>공지 내용</th>
							<th>공지 날짜</th>
							<th>공지 수정</th>
							<th>공지 삭제</th>
						</tr>
					</thead>
			
					<tfoot>
						<tr>
							<th>공지 번호</th>
							<th>공지 내용</th>
							<th>공지 날짜</th>
							<th>공지 수정</th>
							<th>공지 삭제</th>
						</tr>
					</tfoot>
			
					 <tbody>
					<%
						for(Notice n : list) {
					%>
							<tr>
								<td><%=n.getNoticeNo()%></td>
								<td><%=n.getNoticeMemo()%></td>
								<td><%=n.getNoticecreatedate()%></td>
								<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>">수정</a></td>
								<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
							</tr>			
					<%
						}
					%>
					</tbody>
				</table>
				
				<div style="text-align : center">
					<a type="button" class="w-btn-outline w-btn-blue-outline" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지 추가</a>
				</div>
			</div>
		</div>
	</div>

	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>