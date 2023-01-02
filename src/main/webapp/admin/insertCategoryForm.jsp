<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");

	// 1. Controller
	
	Member loginMember = (Member)session.getAttribute("loginMember");

	//관리자 계정으로 로그인되어야만 접근 가능
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
	
	
	// 2. Model 호출
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
<title>Insert title here</title>
</head>
<body>
	<!-- main start -->	
	<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
	<div class="container px-4">
		<div class="calendar-fluid shadow bg-white p-4" style="margin-top : 20px">
			<br>
			<h2>카테고리추가 페이지</h2>
			<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post" id="insertCategoryForm">
				<table class="styled-table">
					<thead>
						<tr>
							<th>수입 / 지출</th>
							<th>이름</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td>
								<input type="radio" id="categoryKind" name="categoryKind" class="categoryKind" value="수입">&nbsp;수입
								&nbsp;
								<input type="radio" id="categoryKind" name="categoryKind" class="categoryKind" value="지출">&nbsp;지출
							</td>
							<td><input type="text" id="categoryName" name="categoryName" value="" style="text-align : center ;"></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align : center">
					<button type="button" class="w-btn-outline w-btn-blue-outline" id="insertCategoryBtn">카테고리 추가</button>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		let insertCategoryBtn = document.querySelector('#insertCategoryBtn');
		
		insertCategoryBtn.addEventListener('click', function(){
			
			let categoryKind = document.querySelectorAll('.categoryKind:checked'); // querySelectorAll의 반환타입은 배열(태그의배열)
			console.log(categoryKind.length); // 1
			if(categoryKind.length != 1) {
				alert('수입/지출을 선택하세요');
				return;
			}

			let categoryName = document.querySelector('#categoryName');
			if(categoryName.value == '') {
				alert('카테고리 명을 입력하세요');
				categoryName.focus(); // 커서이동
				return;
			}
			
			let insertCategoryForm = document.querySelector('#insertCategoryForm');
			insertCategoryForm.submit();
		});
	</script>
		
	<!-- main end -->	
	<jsp:include page="/inc/layoutBottomAdmin.jsp"></jsp:include>
</body>
</html>