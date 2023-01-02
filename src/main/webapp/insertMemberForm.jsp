<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인이 되어 있을때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
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
<link href="css/styles.css" rel="stylesheet"/>
<link href="css/calendarcss.css" rel="stylesheet"/>
<link href="css/fontcss.css" rel="stylesheet"/>
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
</head>
<body class="bg-dark">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-7">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header"><h3 class="text-center font-weight-light my-4">회원가입</h3></div>
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" id="insertMemberForm">  
										<div class="form-floating mb-3 mb-md-0">
											<input class="form-control" id="memberId" name="memberId" type="text" placeholder="Id" />
											<label for="inputId">ID</label>
										</div>
										                            		    
										<br>
											
										<div class="form-floating mb-3 mb-md-0">
											<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="memberPw" name="memberPw" type="password" placeholder="Password" />
											<label for="inputPasswordConfirm">Password</label>
										</div>
										                                        
										<br>
											
										<div class="form-floating mb-3 mb-md-0">
											<input class="form-control" style="font-family:'궁서체'; font-size:10pt;" id="memberPwCheck" name="memberPwCheck" type="password" placeholder="Password Check" />
											<label for="inputPasswordConfirm">Password Check</label>
										</div>
										                                        
										<br>
											
										<div class="form-floating mb-3 mb-md-0">
											<input class="form-control" id="memberName" name="memberName" type="text" placeholder="Enter your name" />
											<label for="inputName">NAME</label>
										</div>
						
										<br>
										<div class="mt-4 mb-0">
											<div class="d-grid"><button type="button" class="btn btn-primary btn-block" id="insertMemberBtn">회원가입</button></div>
										</div>
	                                      </form>
	                                  </div>
								<div class="card-footer text-center py-3">
									<div class="small"><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	
	<script>
		let insertMemberBtn = document.querySelector('#insertMemberBtn');
		
		insertMemberBtn.addEventListener('click', function(){
			
			let memberId = document.querySelector('#memberId');
			if(memberId.value == '') {
				alert('아이디를 입력하세요');
				memberId.focus(); // 커서이동
				return;
			}
			let memberPw = document.querySelector('#memberPw');
			if(memberPw.value == '') {
				alert('비밀번호를 입력하세요');
				memberPw.focus(); // 커서이동
				return;
			}
			let memberPwCheck = document.querySelector('#memberPwCheck');
			if(memberPwCheck.value == '') {
				alert('비밀번호 확인을 입력하세요');
				memberPwCheck.focus(); // 커서이동
				return;
			}
			if(memberPw.value != memberPwCheck.value) {
				alert('두 비밀번호가 일치하지 않습니다.');
				memberPw.focus(); // 커서이동
				return;
			}
			let memberName = document.querySelector('#memberName');
			if(memberName.value == '') {
				alert('이름을 입력하세요');
				memberName.focus(); // 커서이동
				return;
			}
			
			let insertMemberForm = document.querySelector('#insertMemberForm');
			insertMemberForm.submit();
		});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>	
</body>
</html>