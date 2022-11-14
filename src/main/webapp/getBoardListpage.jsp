<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
   //전체 게시물의 개수
   int totalCount=Integer.parseInt(request.getParameter("totalCount"));
   
   // 현재 페이지
   int pg=Integer.parseInt(request.getParameter("pg"));
   
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
   <a href="GetBoardListCtrl?page=1">처음</a>
   <%  
   
   }
   if(pg>1){%>
   <a href="GetBoardListCtrl?page=<%=pg-1%>">이전</a>
   
   <%} 
   
   for(int iCount=startPage;iCount<=endPage;iCount++){
      if(iCount==pg){%>
      
      <b><%=iCount %></b>&nbsp;
      <%}else{ %>
         &nbsp;<a href="GetBoardListCtrl?page=<%=iCount%>"><%=iCount%></a>&nbsp;
      <%} }  
      if(pg<totalPage){%>
      <a href="GetBoardListCtrl?page=<%=pg+1%>">다음</a>
      
      <%}
      if(endPage<totalPage){%>
      <a href="GetBoardListCtrl?page=<%=totalPage%>">끝</a>
      <%} %>
