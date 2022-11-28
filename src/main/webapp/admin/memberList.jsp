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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	int lastPage = 0;
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	
	lastPage = (memberDao.selectMemberCount() / rowPerPage);
	
	if(memberDao.selectMemberCount() % rowPerPage != 0) {
		lastPage++;
	}
	
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
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

<title>멤버관리 페이지(관리자 전용)</title>
</head>
<body>
	<table>
		<tr>
			<td><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/MemberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></td>
		</tr>
		
		<tr>
			<th>멤버 번호</th>
			<th>멤버 ID</th>
			<th>멤버 레벨</th>
			<th>멤버 이름</th>
			<th>마지막 수정일</th>
			<th>생성 일자</th>
			<th>레벨 수정</th>
			<th>강제 퇴장</th>
		</tr>
		
		<%
			for(Member m : list) {
		%>
				<tr>
					<td><%=m.getMemberNo()%></td>
					<td><%=m.getMemberId()%></td>
					<td><%=m.getMemberLevel()%></td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getUpdatedate()%></td>
					<td><%=m.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp?memberId=<%=m.getMemberId()%>&memberLevel=<%=m.getMemberLevel()%>">레벨 전환</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberId=<%=m.getMemberId()%>">회원 강퇴</a></td>
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