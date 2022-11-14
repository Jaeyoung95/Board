<%@page import="com.company.vo.ReplyBoard2VO"%>
<%@page import="com.company.vo.ReplyBoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.vo.BoardVO"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<c:if test="${empty name }">
<c:redirect url="login.jsp"/>
</c:if>
	<%
	String id = (String) session.getAttribute("id");

	//2. Servlet이 전달한 데이터를 받는다.
	BoardVO board = (BoardVO) request.getAttribute("vo");
	
	// 답글 데이터 받기
	ArrayList<ReplyBoardVO> replyList=(ArrayList<ReplyBoardVO>)request.getAttribute("replyList");
	
	// 답글의 답글 데이터 받기
		ArrayList<ReplyBoard2VO> reply2List=(ArrayList<ReplyBoard2VO>)request.getAttribute("reply2List");
	%>
	<div class="container" align="center">
		<h3>글 상세</h3>
		<h3>
			${name }님 로그인 환영합니다..... <a href="LogoutCtrl"
				class="btn btn-primary">로그아웃</a>
		</h3>
		<hr>
		<form action="UpdateBoardCtrl" method="post">
			<table class="table" style="width: 800px;">
				<tr>
					<input type="hidden" name="seq" value="${vo.seq }">
					<td>제목</td>
					<td>
						<%
						if (id.equals(board.getUserid())) {
						%> <input type="text" name="title" class="form-control"
						value="${vo.title }"> <%
 } else {
 %> ${vo.title }
						<%
						}
						%>
					</td>
				</tr>

				<tr>
					<td>작성자</td>
					<td>${vo.nickname }</td>
				</tr>

				<tr>
					<td>내용</td>
					<td>
						<%
						if (id.equals(board.getUserid())) {
						%> <textarea rows="10" cols="40" name="content"
							class="form-control">${vo.content }</textarea> <%
 } else {
 %>
						${vo.content } <%
 }
 %>
					</td>
				</tr>

				<tr>
					<td>등록일</td>
					<td>${vo.regdate }</td>
				</tr>

				<tr>
					<td>조회수</td>
					<td>${vo.cnt }</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						공감 - ${boardLikevo.good } &nbsp;&nbsp;&nbsp;&nbsp; 비공감 - ${boardLikevo.bad }
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="font-size: 20px;"> 
					<c:choose>
					<c:when test="${isCheckCode=='G1B0'}">
					<!-- 공감이 눌려있는 상태이므로 공감버튼을 눌러진 형태로 처리 -->
						<a href="DeleteBoardLike?id=${id}&seq=${vo.seq}" class="fa-solid fa-toggle-on"></a> 공감 
					
					&nbsp;&nbsp;&nbsp; <a href="UpdateBoardLike?id=${id}&seq=${vo.seq}&value=bad" class="fa-solid fa-toggle-off"></a> 비공감
					</c:when>
					<c:when test="${isCheckCode=='G0B1'}">
					<!-- 비공감이 눌려있는 상태이므로 비공감버튼을 눌러진 형태로 처리 -->
						<a href="UpdateBoardLike?id=${id}&seq=${vo.seq}&value=good" class="fa-solid fa-toggle-off"></a> 공감 
					
					&nbsp;&nbsp;&nbsp; <a href="DeleteBoardLike?id=${id}&seq=${vo.seq}" class="fa-solid fa-toggle-on"></a> 비공감
					</c:when>
					<c:when test="${isCheckCode=='G0B0'}">
					<!-- 공감,비공감 눌려지지 않은 상태로 처리 -->
						<a href="UpdateBoardLike?id=${id}&seq=${vo.seq}&value=good" class="fa-solid fa-toggle-off"></a> 공감 
					
					&nbsp;&nbsp;&nbsp; <a href="UpdateBoardLike?id=${id}&seq=${vo.seq}&value=bad" class="fa-solid fa-toggle-off"></a> 비공감 
					</c:when>
					</c:choose>
					 </td>
				</tr>
				<%
				if (id.equals(board.getUserid())) {
				%>
				<tr>
					<td colspan="2" style="text-align: center;"><input
						type="submit" value="글 수정" class="btn btn-primary"></td>
				</tr>
				<%
				}
				%>
			</table>
		</form>
		<hr>
		<a href="addBoard.jsp">글등록</a>&nbsp;&nbsp;&nbsp;
		<%
		if (id.equals(board.getUserid())) {
		%>
		<a href="DeleteBoardCtrl?seq=${vo.seq }">글삭제</a>&nbsp;&nbsp;&nbsp;
		<%
		}
		%>
		<a href="GetBoardListCtrl">글목록</a> <br><br><br><br><br>
		<!-- 답글 리스트 시작 -->
		<%if(replyList.size()==0){ %>
			답글 없습니다.
		<%}else{ 
			for(int i=0;i<replyList.size();i++){
				ReplyBoardVO vo=replyList.get(i);%>		
			<table style="width:800px;line-height: 2;">
			<tr>
				<td colspan="2">
				<b>	<%=vo.getNickname() %> </b> <br>
					<%=vo.getContent() %> - &nbsp;&nbsp; <span style="color:gray;font-size: 13px;"><%=vo.getRegdate() %></span>
					&nbsp;&nbsp;<a href="addReply2Board.jsp?boardseq=<%=vo.getBoardseq()%>&seq=<%=vo.getSeq()%>">답글</a>
					<%if(vo.getUserid().equals(id)){ %>
					<a href="DeleteReplyBoardCtrl?boardseq=<%=vo.getBoardseq()%>&seq=<%=vo.getSeq()%>">삭제</a> 
					<a href="updateReplyBoard.jsp?boardseq=<%=vo.getBoardseq()%>&seq=<%=vo.getSeq()%>">수정</a> 
					<%} %>
					
					<!-- 여기에 반복문을 추가하여 2중 반복문 처리.
					조건은 boardseq와 seq가 replyboard2의 boardseq와 seq가 같은 것만 표시하는 방식 
					 -->
					 <%for(int j=0;j<reply2List.size();j++){ 
						 ReplyBoard2VO vo2=reply2List.get(j);
						 if(vo.getBoardseq()==vo2.getBoardseq() && vo.getSeq()==vo2.getSeq()){
					 %>
					 	<br>
					 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-brands fa-replyd"></i> <b><%=vo2.getNickname() %></b> <br>
					 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=vo2.getContent() %> - &nbsp;&nbsp; <span style="color:gray;font-size: 13px;"><%=vo2.getRegdate() %></span>
					 	&nbsp;&nbsp; <%if(vo2.getUserid().equals(id)){ %>
					<a href="DeleteReplyBoard2Ctrl?boardseq=<%=vo2.getBoardseq()%>&seq=<%=vo2.getSeq()%>&rseq=<%=vo2.getRseq()%>">삭제</a>
					<a href="updateReplyBoard2.jsp?boardseq=<%=vo2.getBoardseq()%>&seq=<%=vo2.getSeq()%>&rseq=<%=vo2.getRseq()%>">수정</a> 
					<%} %>	
					 <%}} %>
					
				</td>
			</tr>
			
			</table>
				
		<% } }%>
		<!-- 답글 리스트 끝 -->
		
		<!-- 답글을 추가하기 위한 폼 시작-->
		<form name="replyForm">
			<input type="text" size="100" name="content">
			<input type="hidden" name="seq" value="${vo.seq }">
			<input type="hidden" name="nickname" value="${name }">
			<!-- 게시글의 닉네임을 저장하는 것이 아니고 로그인 한 사람의 닉네임을 답글에 달아야 함. 따라서 name값을 value속성에 지정 -->
			
			<input type="hidden" name="id" value="${id }">
			<input type="button" value="답글하기" onclick="reply();return false;" class="btn btn-primary">
		</form>
		<!-- 답글을 추가하기 위한 폼 끝 -->

	</div>
	
	<script type="text/javascript">
		function reply(){
			var content=document.replyForm.content.value;
			if(content=="" || content.length==0){
				alert('답글을 입력하세요.');
			}else{
				document.replyForm.action="AddReplyBoardCtrl";
				document.replyForm.method="post";
				document.replyForm.submit();
			}
		}
		
		
	</script>
</body>
</html>