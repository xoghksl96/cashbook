<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 로그인이 되어 있지 않을 때 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<link href="css/fontcss.css" rel="stylesheet"/>
<link href="css/tablecss.css" rel="stylesheet"/>
<link href="css/buttoncss.css" rel="stylesheet"/>
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
<title>비밀번호 수정 페이지</title>
</head>
<body class="sb-nav-fixed">
<%
	if(loginMember.getMemberLevel() == 1) {
%>
		<!-- main start -->	
		<jsp:include page="/inc/layoutTopAdmin.jsp"></jsp:include>
<%
	} else {
%>
		<!-- main start -->	
		<jsp:include page="/inc/layoutTop.jsp"></jsp:include>
<%
	}
%>
	
	<div class="container p-5 ">
		<div class="card shadow-lg border-0 rounded-lg mt-5">
			<!-- 로그인 폼 -->
			<div class="card-header"><h3 class="text-center font-weight-light my-4">비밀번호 변경</h3></div>
			<div class="card-body">
  					<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post" id="updateMemberPwForm">
					<div class="form-floating mb-3">
						<input class="form-control" style="background-color : pink" id="inputEmail" type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>"/>
						<label for="inputEmail">ID</label>
					</div>
					<div class="form-floating mb-3">
						<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="oldMemberPw" type="password" name="oldMemberPw"/>
						<label for="inputPassword">OLD PW</label>
					</div>
					<div class="form-floating mb-3">
						<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="newMemberPw" type="password" name="newMemberPw"/>
						<label for="inputPassword">NEW PW</label>
					</div>
					<div class="form-floating mb-3">
						<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="newMemberPwCheck" type="password" name="newMemberPwCheck"/>
						<label for="inputPassword">NEW PW CHECK</label>
					</div>
					<div class="d-flex align-items-center justify-content-between mt-4 mb-0">
						<button type="button" class="btn btn-primary" id="updateMemberPwBtn"><span class="text">비밀번호 변경</span></button>
					</div>
				</form>
			</div>	
		</div>
	</div>
	
	<script>
		let updateMemberPwBtn = document.querySelector('#updateMemberPwBtn');
		
		updateMemberPwBtn.addEventListener('click', function(){
			
			let oldMemberPw = document.querySelector('#oldMemberPw');
			if(oldMemberPw.value == '') {
				alert('현재 비밀번호를 입력하세요');
				oldMemberPw.focus(); // 커서이동
				return;
			}
			let newMemberPw = document.querySelector('#newMemberPw');
			if(newMemberPw.value == '') {
				alert('새 비밀번호를 입력하세요');
				newMemberPw.focus(); // 커서이동
				return;
			}
			let newMemberPwCheck = document.querySelector('#newMemberPwCheck');
			if(newMemberPwCheck.value == '') {
				alert('새 비밀번호 다시한번 입력하세요');
				newMemberPwCheck.focus(); // 커서이동
				return;
			}
			if(newMemberPw.value != newMemberPwCheck.value){ // 새로운 비밀번호가 일치하지 않을 경우
				alert('새 비밀번호가 일치하지 않습니다.');
				newMemberPw.focus(); // 커서이동
				return;
			}
			
			let updateMemberPwForm = document.querySelector('#updateMemberPwForm');
			updateMemberPwForm.submit();
		});
	</script>
	
	<!-- main end -->	
	<jsp:include page="/inc/memberCRUDBottom.jsp"></jsp:include>
</body>
</html>