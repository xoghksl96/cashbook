<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("utf-8");
	// 1-1 세션 확인


	// 1-2 request
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model호출
	HelpDao helpDao = new HelpDao();
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	map = helpDao.selectHelpOneByAdmin(helpNo);
%>
<!DOCTYPE html>
<html>
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
<title>Insert title here</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	
	<div id="layoutSidenav_content">
			<div class="container p-5 ">
				<div class="shadow bg-white p-3" style="margin-bottom : 50px;">
					<br>
					<h2>문의 사항</h2>
					<table class="styled-table">	
						<thead>
							<tr>
								<th>문의 번호</th>
								<th>문의 내용</th>
								<th>회원 ID</th>
								<th>문의 날짜</th>
								<th>답변 내용</th>
								<th>답변 날짜</th>
								<th>답변 추가/수정/삭제</th>
							</tr>
						</thead>
					
						<tbody>
							<tr>
								<td><%=map.get("helpNo")%></td>
								<td><%=map.get("helpMemo")%></td>
								<td><%=map.get("helpMemberId")%></td>
								<td><%=map.get("helpCreatedate")%></td>
								<%
									if(map.get("commentMemo") == null) {
								%>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td><a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=map.get("helpNo")%>&helpMemo=<%=map.get("helpMemo")%>">답변 입력</a></td>
								<%
									} else {
								%>
									<td><%=map.get("commentMemo")%></td>
									<td><%=map.get("commentCreatedate")%></td>
									<td>
										<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=map.get("helpNo")%>&helpMemo=<%=map.get("helpMemo")%>&commentNo=<%=map.get("commentNo")%>&commentMemo=<%=map.get("commentMemo")%>">답변 수정</a>
										/
										<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?helpNo=<%=map.get("helpNo")%>&commentNo=<%=map.get("commentNo")%>">답변 삭제</a>
									</td>
								<%
									}
								%>
							</tr>
						</tbody>			
					</table>
				</div>
			</div>
		</div>
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
	
</body>
</html>