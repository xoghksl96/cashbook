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
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);		
	
	// View
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

<title>공지관리 페이지(관리자)</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/MemberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	
	
	<table>	
		<tr>
			<th>공지 번호</th>
			<th>공지 내용</th>
			<th>공지 날짜</th>
			<th>공지 수정</th>
			<th>공지 삭제</th>
		</tr>
		
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
		<tr>
			<td><a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지추가</a></td>
		</tr>
		
		<tr>
			<td><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>
		
	</table>
</body>
</html>