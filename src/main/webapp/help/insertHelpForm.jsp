<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// 한글처리
	
	// 1. Controller
	
	// 1-1 세션확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String redirectUrl = null;
	if(loginMember == null) {
		redirectUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 추가 페이지</title>
</head>
<body>
	<div>
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<table class="table">			
				<tr>
					<th class="text center">작성자</th>
					<td class="text center"><%=loginMember.getMemberId()%></td>
				</tr>
				
				<tr>
					<th class="text center">문의 내용</th>
					<td class="text center">
						<textarea cols="20" rows="5" name="helpMemo">
							
						</textarea>
					</td>
				</tr>
		
				<tr>
					<th colspan="2" class="center"><button type="submit" class="buttonSize"><span class="text">문의 추가</span></button></th>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>