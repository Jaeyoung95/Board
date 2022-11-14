<%@page import="com.company.vo.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty name }">
	<c:redirect url="login.jsp" />
</c:if>
<c:choose>
	<c:when test="${empty param.page}">
		<c:set var="page" value="1" />
	</c:when>
	<c:otherwise>
		<c:set var="page" value="${param.page }" />
	</c:otherwise>
</c:choose>

<c:if test="${empty totalRows}">
	<c:set var="totalRows" value="1" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 목록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container" align="center">
		<h1>글 목록</h1>
		<h3>
			${name } 님 환영합니다... <a href="LogoutCtrl" class="btn btn-primary">로그아웃</a>
		</h3>

		<!-- 검색코드 시작부분 -->
		<form action="GetSearchCtrl">
			<table class="table" style="width: 800px;">
				<tr>
					<td align="right"><select name="searchCondition">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="nickname">작성자</option>
					</select> <input type="text" name="searchKeyword"> <input
						type="submit" value="검색" class="btn btn-primary"></td>
				</tr>
			</table>
		</form>
		<!-- 검색코드 끝 부분 -->

		<hr>
		<form name="list">
			<table class="table" style="width: 800px;">
				<tr>
					<th style="width: 100px;">번호</th>
					<th style="width: 200px;">제목</th>
					<th style="width: 150px;">작성자</th>
					<th style="width: 150px;">등록일</th>
					<th style="width: 100px;">조회수</th>
					<c:if test="${id=='root'}">
						<th style="width: 100px;">삭제</th>
					</c:if>
				</tr>
				<c:choose>
					<c:when test="${empty boardList}">
						<tr>
							<td align="center" colspan="5">등록된 글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${boardList }" var="board" varStatus="status">
							<tr>
								<td>${board.seq }</td>
								<td><a href="GetBoardCtrl?seq=${board.seq }">${board.title }</a>
								</td>
								<td>${board.nickname }</td>
								<td>${board.regdate }</td>
								<td>${board.cnt }</td>
								<c:if test="${id=='root'}">
									<td><a href="#"> <input type="checkbox"
											name="delBoardCheckbox" value="${board.seq }">
									</a></td>
								</c:if>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<c:if test="${id=='root'}">
				<a href="DeleteBoardListAdmin" onclick="delBoardList();return false;">관리자 삭제</a>
			</c:if>
		</form>
		<!-- 페이지 리스트 삽입 시작 -->
		<jsp:include page="getBoardListpage.jsp">
			<jsp:param value="${page }" name="pg" />
			<jsp:param value="${ totalRows}" name="totalCount" />
		</jsp:include>

		<!-- 페이지 리스트 삽입 끝 부분 -->

		<br> <a href="addBoard.jsp">새글 등록</a>

	</div>
</body>
	<script type="text/javascript">
		function delBoardList(){
			document.list.method="post";
			document.list.action="DeleteBoardListAdmin";
			document.list.submit();
		}
	</script>
</html>