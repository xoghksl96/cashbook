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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></td> <!-- 카테고리 페이징 X -->
			<td><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/helpList.jsp">고객센터</a></td>
		</tr>
		
		<tr>
			<th>공지 번호</th>
			<th>공지 내용</th>
			<th>공지 날짜</th>
		</tr>
		
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
		
		<tr><td> <td></tr>
		<tr><td> <td></tr>
		
		<tr>
			<th>멤버 번호</th>
			<th>멤버 ID</th>
			<th>가입 날짜</th>
		</tr>
		
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
		<tr>
			<td><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></td>
		</tr>
		
	</table>
	
</body>
</html>