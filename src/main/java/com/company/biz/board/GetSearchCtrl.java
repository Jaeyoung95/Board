package com.company.biz.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.jdbc.JDBCConnection;
import com.company.vo.BoardVO;

@WebServlet("/GetSearchCtrl")
public class GetSearchCtrl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/GetSearchCtrl");
	
		
		
		int page;
		if(request.getParameter("page")==null)
			page=1;
		else
			page=Integer.parseInt(request.getParameter("page"));

		// 1. 접속한 유저 이름 추출
		// 로그인을 안했으면 로그인 페이지로 이동시킨다.
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		if (name == null)
			response.sendRedirect("login.jsp");

		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");

		System.out.println(searchCondition);
		System.out.println(searchKeyword);

//		제목,작성자,내용 검색이 3가지로 검색되는 코드를 사용하여야 한다.
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		
		try {
			conn=JDBCConnection.getConnection();
			
//			if(searchCondition.equals("nickname")) {
//				// 작성자 검색
//				
//			}else if(searchCondition.equals("title")) {
//				// 제목 검색
//				
//			}else {
//				// 내용 검색
//				
//			}
//			위와 같이 각각 검색조건에 따라 코드를 구현할 수 있지만 공통이 되는 코드의 길이가
//			많이 있으면 검색조건과 검색내용을 함수로 전달하여 함수화 시켜 코드를 
//			만드는 것이 효율적이다.
			
			stmt=search(conn,searchCondition,searchKeyword,page);
			// search매소드 수행 후 반환값을 PrepareStatmement로 한다.
			// 반환된 stmt로 쿼리작업 수행.
			
			rs=stmt.executeQuery();
			
			System.out.println("검색쿼리 문제없이 수행");
			
			ArrayList<BoardVO> boardList=new ArrayList<BoardVO>();
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setSeq(rs.getInt("seq"));
				vo.setTitle(rs.getString("title"));
				vo.setNickname(rs.getString("nickname"));
				vo.setContent(rs.getString("content"));
				vo.setRegdate(rs.getString("regdate"));
				vo.setCnt(rs.getInt("cnt"));
				vo.setUserid(rs.getString("userid"));
				
				boardList.add(vo);
			}
			
			
			stmt.close();
			rs.close();
			
//			검색이 된 쿼리에서 전체 레코드 개수를 구해야 한다.
			String sql="select count(*) from board where "+searchCondition+" like '%'||?||'%'";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, searchKeyword);
			
			rs=stmt.executeQuery();
			int totalRows=0;
			if(rs.next())
				totalRows=rs.getInt(1);
			
			System.out.println(totalRows);
			
			request.setAttribute("boardList", boardList);
			
//			3개의 값을 request영역에 저장.(검색 상태에서 페이지 번호 클릭,이전,다음,처음 클릭 시
//			해당 페이지에 있는 rownum을 검색하여 출력을 하여야 한다. 따라서. 해당 값을
//			같이 전송하기 위해 request영역에 저장.
			request.setAttribute("totalRows", totalRows);
			request.setAttribute("searchCondition", searchCondition);
			request.setAttribute("searchKeyword", searchKeyword);
			
			
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("getSearchBoardList.jsp");
			dispatcher.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
	
	}

	private PreparedStatement search(Connection conn, String searchCondition, String searchKeyword,int page) throws SQLException {
		PreparedStatement stmt=null;
		System.out.println(searchCondition+" "+searchKeyword);
		String sql="select * from\r\n"
				+ "(select rownum as rnum,B.* from (select seq,title,nickname,content,to_char(regdate,'yyyy-mm-dd') \r\n"
				+ "as regdate,cnt,userid from board \r\n"
				+ "where "+searchCondition+" like '%' || ? || '%' order by seq desc) B)\r\n"
				+ "where rnum between ? and ?";
//		like연산자 활용법 (Oracle)
//		select from mytable where name like '%' || ? || '%'
//		stmt.setString(1,name);  
//		?로 바인딩이 되는 값을 매핑할 경우에는 필드이름을 사용하지 않고 실제
//		적용되는 값(실제 대입되는 값)을 사용한다.
		
		
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, searchKeyword);
		stmt.setInt(2, page*10-9);
		stmt.setInt(3, page*10);
		
		return stmt;
	}

}
