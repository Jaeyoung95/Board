<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 글 등록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	
	<c:if test="${empty name}">
		<c:redirect url="login.jsp"/>
	</c:if>
	
	<div class="container" align="center">
		<h3>새 글 등록하기... <a href="LogoutCtrl" class="btn btn-primary">로그아웃</a> </h3>
		<hr>
		<form name="addBoard">
			<table class="table" style="width: 800px;">
			<input type="hidden" name="userid" value="${id }">
				<tr>
					<td>제목</td>
					<td><input type="text" name="title"  class="form-control"></td>
				</tr>

				<tr>
					<td>작성자</td>
					<td><input type="text" name="nickname" size="10" class="form-control"></td>
				</tr>

				<tr>
					<td>내용</td>
					<td><textarea rows="10" cols="40" name="content" class="form-control"></textarea></td>
				</tr>

				<tr>
					<td colspan="2" style="text-align: center;"><input
						type="button" onclick="insertBoard();return false;" value="새 글 등록" class="btn btn-primary"></td>
				</tr>
			</table>
		</form>
		<script type="text/javascript">
			function insertBoard(){
				var title=document.addBoard.title.value;
				var nickname=document.addBoard.nickname.value;
				var content=document.addBoard.content.value;
				
				if(title=="" || title.length==0){
					alert('제목을 입력하세요.');
					document.addBoard.title.focus();
				}else if(nickname=="" || nickname.length==0){
					alert('작성자를 입력하세요.');
					document.addBoard.nickname.focus();
				}else if(content=="" || content.length==0){
					alert('내용을 입력하세요.');
					document.addBoard.content.focus();
				}else{
					document.addBoard.method="post";
					document.addBoard.action="AddBoardCtrl";
					document.addBoard.submit();
				}
			}
		</script>
	</div>
</body>
</html>