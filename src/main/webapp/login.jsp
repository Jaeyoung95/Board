<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container" align="center">
		<h1>로그인</h1>
		<hr>
		<form action="LoginCtrl" method="post">
			<table class="table" style="width:400px;">
				<tr>
					<td>아이디</td>
					<td> <input type="text" name="id" value="root"> </td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="password" value="root1234"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align:center;">
						<input type="submit" value="로그인" class="btn btn-primary">
						<input type="reset" value="다시입력" class="btn btn-primary">
					</td>
				</tr>
			</table>
		</form>
		<hr>
	</div>
</body>
</html>