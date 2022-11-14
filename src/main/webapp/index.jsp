<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container" align="center">
		<h1>게시판 제작 예제</h1>
		<br> <br>
		<c:choose>
			<c:when test="${empty name }">
				<div style="width: 800px;">
					<a href="login.jsp" class="btn btn-primary">로그인</a> <a
						href="join.jsp" class="btn btn-primary">회원가입</a>
				</div>
			</c:when>
			<c:otherwise>
				<div style="width: 800px;">
					<a href="LogoutCtrl" class="btn btn-primary">로그아웃</a> <a
						href="GetBoardListCtrl" class="btn btn-primary">글 목록</a> <a
						href="addBoard.jsp" class="btn btn-primary">글 쓰기</a>
				</div>
			</c:otherwise>

		</c:choose>


	</div>
</body>
</html>