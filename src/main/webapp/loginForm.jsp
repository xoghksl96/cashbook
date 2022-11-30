<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	// 로그인이 되어 있을때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/cash/cashList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	// 공지 페이징
	NoticeDao noticeDao = new NoticeDao();
	
	// 공시사항 데이터 가져와서 list에 담기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
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

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/styles.css">
<title>로그인 페이지</title>
</head>

<body class="bg-dark">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                	<!-- 로그인 폼 -->
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                        <form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
									        <div class="form-floating mb-3">
									            <input class="form-control" id="inputEmail" type="text" name="memberId"/>
									            <label for="inputEmail">ID</label>
									        </div>
									        <div class="form-floating mb-3">
									            <input class="form-control" id="inputPassword" type="password" name="memberPw"/>
									            <label for="inputPassword">PW</label>
									        </div>
									        
									        <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
									            <button type="submit" class="btn btn-primary"><span class="text">Login</span></button>
									        </div>
									    </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                    </div>
                </main>
        
			<div id="layoutSidenav_content">>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i>
						공지사항
					</div>
					<div class="card-body">
						<table id="datatablesSimple">
							<thead>
								<tr>
									<th class="noticeTd">공지 번호</th>
									<th class="noticeTd">공지 내용</th>
									<th class="noticeTd">공지 날짜</th>
								</tr>
							</thead>

							<tfoot>
								<tr>
									<th class="noticeTd">공지 번호</th>
									<th class="noticeTd">공지 내용</th>
									<th class="noticeTd">공지 날짜</th>
								</tr>
							</tfoot>

							 <tbody>
							<%
								for(Notice n : list) {
							%>
									<tr>
										<td class="noticeTd"><%=n.getNoticeNo()%></td>
										<td class="noticeTd"><%=n.getNoticeMemo()%></td>
										<td class="noticeTd"><%=n.getNoticecreatedate()%></td>
									</tr>
							<%
								
							}
							%>
							</tbody>
						</table>
			        </div>
			    </div>
			</div>
		</div>
    </div>
        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>