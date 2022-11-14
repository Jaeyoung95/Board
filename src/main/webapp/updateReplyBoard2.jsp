<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = (String) session.getAttribute("name");
if (name == null) {//로그인이 안된 경우,처음 페이지 실행(로그인 안된 상태)

	response.sendRedirect("index.jsp");
}
String id = (String) session.getAttribute("id");
int seq = Integer.parseInt(request.getParameter("seq"));
int boardseq = Integer.parseInt(request.getParameter("boardseq"));
int rseq=Integer.parseInt(request.getParameter("rseq"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글 수정</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="contianer" align="center">
	<h1>답글 수정</h1>
		<!-- 답글을 추가하기 위한 폼 시작-->
		<form name="replyForm2">
			<input type="text" size="100" name="content">
			
			<input type="hidden" name="boardseq" value="<%=boardseq %>">
			<input type="hidden" name="seq" value="<%=seq %>">
			<input type="hidden" name="nickname" value="<%=name %>">
			<input type="hidden" name="rseq" value="<%=rseq %>">
			<!-- 게시글의 닉네임을 저장하는 것이 아니고 로그인 한 사람의 닉네임을 답글에 달아야 함. 따라서 name값을 value속성에 지정 -->
			
			<input type="hidden" name="id" value="<%=id%>">
			
			
			 <input
				type="button" value="답글하기" onclick="reply();return false;"
				class="btn btn-primary">
		</form>
		<!-- 답글을 추가하기 위한 폼 끝 -->
	</div>


	<script type="text/javascript">
		function reply() {
			var content=document.replyForm2.content.value;
			if(content.length==0 || content==""){
				alert('댓글을 입력하세요.');
				document.replyForm2.focus();
			}else{
				document.replyForm2.method="post";
				document.replyForm2.action="UpdateReplyBoard2Ctrl";
				document.replyForm2.submit();
			}
		}
	</script>


</body>
</html>