<%@page import="com.company.vo.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 1. 접속한 유저 이름 추출
	// 로그인을 안했으면 로그인 페이지로 이동시킨다.
	String name=(String)session.getAttribute("name");
	if(name==null) response.sendRedirect("login.jsp");
	
	// 2. request에 사용할 데이터가 들어가 있다.
	ArrayList<BoardVO> boardList=(ArrayList<BoardVO>)request.getAttribute("boardList");
	
	int pg;//page변수로 현재 페이지 값을 받아서 페이징 처리에 이용...
	int totalCount;
	
	// 현재 페이지 변수 받음.
	if(request.getParameter("page")==null){
		pg=1;
	}else{
		pg=Integer.parseInt(request.getParameter("page"));
	}
	
	String searchCondition=(String)request.getAttribute("searchCondition");
	String searchKeyword=(String)request.getAttribute("searchKeyword");
	
	System.out.println(searchCondition+" "+searchKeyword);
	
	// 전체 레코드의 수 구하기.. 차후 구하기..일단 기본 값으로 1로 해놓겠다.
	if(request.getAttribute("totalRows")==null){
		totalCount=1;
	}else{
		totalCount=(Integer)request.getAttribute("totalRows");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 검색 목록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container" align="center">
		<h1>검색된 글 목록</h1>
		<h3>
			<%=name %> 님 환영합니다... <a href="LogoutCtrl" class="btn btn-primary">로그아웃</a>
		</h3>
		
		<!-- 검색코드 시작부분 -->
		<form action="GetSearchCtrl">
		<table class="table" style="width: 800px;">
			<tr>
				<td align="right">
					<select name="searchCondition">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text" name="searchKeyword">
					<input type="submit" value="검색" class="btn btn-primary">
				</td>
			</tr>
		</table>
		</form>
		<!-- 검색코드 끝 부분 -->
		
		<hr>

		<table class="table" style="width: 800px;">
			<tr>
				<th style="width:100px;">번호</th>
				<th style="width:200px;">제목</th>
				<th style="width:150px;">작성자</th>
				<th style="width:150px;">등록일</th>
				<th style="width:100px;">조회수</th>
			</tr>
			<%
				for(int i=0;i<boardList.size();i++){
					BoardVO board=boardList.get(i);
			%>
			<tr>
				<td><%=board.getSeq() %></td>
				<td> <a href="GetBoardCtrl?seq=<%=board.getSeq()%>"><%=board.getTitle() %></a> </td>
				<td><%=board.getNickname() %></td>
				<td><%=board.getRegdate() %></td>
				<td><%=board.getCnt() %></td>
			</tr>
			<%
				}
			%>
		</table>
		
		<!-- 페이지 리스트 삽입 시작 -->
		<% 
	
   // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
   int countList=10;
   
   // 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
   int countPage=10;
   
   //totalPage는 전체 페이지 수(전체 게시물/한 페이지에 출력될 게시물 수)
   int totalPage=totalCount/countList;
   
   if(totalCount%countList>0){
   //totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
      totalPage++;
   }
   
   if(totalPage<pg){
      // 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
      // 따라서 현재페이지를 가장 끝 페이지인 totalPage로 이동시킨다.
      pg=totalPage;
   }
   
   int startPage = ((pg - 1) / countList) * countPage + 1;
   
   int endPage = startPage + countPage - 1;
   
   if(endPage>totalPage){
      endPage=totalPage;
   }
   
   if(startPage>1){%>
   <a href="GetSearchCtrl?page=1&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">처음</a>
   <%  
   
   }
   if(pg>1){%>
   <a href="GetSearchCtrl?page=<%=pg-1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">이전</a>
   
   <%} 
   
   for(int iCount=startPage;iCount<=endPage;iCount++){
      if(iCount==pg){%>
      
      <b><%=iCount %></b>&nbsp;
      <%}else{ %>
         &nbsp;<a href="GetSearchCtrl?page=<%=iCount%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>"><%=iCount%></a>&nbsp;
      <%} }  
      if(pg<totalPage){%>
      <a href="GetSearchCtrl?page=<%=pg+1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">다음</a>
      
      <%}
      if(endPage<totalPage){%>
      <a href="GetSearchCtrl?page=<%=totalPage%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>">끝</a>
      <%} %>
		
		<!-- 페이지 리스트 삽입 끝 부분 -->
		
		<br> <a href="addBoard.jsp">새글 등록</a>&nbsp;&nbsp;<a href="GetBoardListCtrl">글목록</a>

	</div>
</body>
</html>