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
	
	//ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	ArrayList<Member> list = memberDao.selectMemberListByPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
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
<title>멤버관리 페이지(관리자 전용)</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
		<div class="container p-5">
			<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
			<div class="card-header" style="margin-bottom : 20px;">
				<h2><i class="fas fa-table me-1"></i>
					멤버
				</h2>
			</div>
				<table id="datatablesSimple">
					<thead>
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
					</thead>
			
					<tfoot>
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
					</tfoot>
			
					 <tbody>
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
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>