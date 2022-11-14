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
import com.company.vo.BoardlikeVO;
import com.company.vo.ReplyBoard2VO;
import com.company.vo.ReplyBoardVO;

@WebServlet("/GetBoardCtrl")
public class GetBoardCtrl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/GetBoardCtrl");

		// 1. 접속한 유저 이름 추출
		// 로그인을 안했으면 로그인 페이지로 이동시킨다.
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		String id = (String) session.getAttribute("id");
		
		if (name == null)
			response.sendRedirect("login.jsp");
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			
			// 조회수 1카운트 처리를 하는 구문
			
			String sql="update board set cnt=cnt+1 where seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			stmt.executeUpdate();
			stmt.close();
			
			// 여기부터는 조회
			
			sql="select seq,title,nickname,content,to_char(regdate,'yyyy-mm-dd') as regdate,cnt,userid from board where seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			rs=stmt.executeQuery();
			
			
			BoardVO vo = null;
			if(rs.next()) {
				vo=new BoardVO();
				vo.setSeq(rs.getInt("seq"));
				vo.setTitle(rs.getString("title"));
				vo.setNickname(rs.getString("nickname"));
				vo.setContent(rs.getString("content"));
				vo.setRegdate(rs.getString("regdate"));
				vo.setCnt(rs.getInt("cnt"));
				vo.setUserid(rs.getString("userid"));
			}
			
			request.setAttribute("vo", vo);
//			여기에 replyboard리스트를 만들어서 답글리스트를 전달할 것
//			답글리스트를 구현하려면 stmt,rs자원을 다시 사용하여야 한다.
//			위에서 게시판 상세글을 전달하기 위한 vo를 추출하기위해
//			stmt와 rs를 사용하였으므로 재사용을 위해 자원을 닫고 다시 사용한다.
//			왜냐하면 자원을 닫게되면 기존 자원을 해제를 하기 때문이다.
			
			stmt.close();
			rs.close();
			
			sql="select boardseq,seq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') as regdate,content,userid from replyboard where boardseq=? order by seq desc";
			
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			rs=stmt.executeQuery();
			
			ArrayList<ReplyBoardVO> replyList=new ArrayList<ReplyBoardVO>();
			
			while(rs.next()) {
				ReplyBoardVO replyVo=new ReplyBoardVO();
				replyVo.setBoardseq(rs.getInt("boardseq"));
				replyVo.setSeq(rs.getInt("seq"));
				replyVo.setNickname(rs.getString("nickname"));
				replyVo.setContent(rs.getString("content"));
				replyVo.setRegdate(rs.getString("regdate"));
				replyVo.setUserid(rs.getString("userid"));
				
				replyList.add(replyVo);
			}
			
			request.setAttribute("replyList", replyList);
			
			// 댓글의 댓글을 검색하여 getBoard.jsp에 값을 전달해야 하므로 자원을 닫는다.
			
			stmt.close();
			rs.close();
			
			sql="select boardseq,seq,rseq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') \r\n"
					+ "as regdate,content,userid from replyboard_2 order by boardseq desc,seq desc,rseq desc";
			stmt=conn.prepareStatement(sql);
			
			rs=stmt.executeQuery();
			
			ArrayList<ReplyBoard2VO> reply2List=new ArrayList<ReplyBoard2VO>();
			while(rs.next()) {
				ReplyBoard2VO board2VO=new ReplyBoard2VO();
				board2VO.setBoardseq(rs.getInt("boardseq"));
				board2VO.setSeq(rs.getInt("seq"));
				board2VO.setRseq(rs.getInt("rseq"));
				board2VO.setNickname(rs.getString("nickname"));
				board2VO.setContent(rs.getString("content"));
				board2VO.setRegdate(rs.getString("regdate"));
				board2VO.setUserid(rs.getString("userid"));
				
				reply2List.add(board2VO);
			}
			
			
			
			request.setAttribute("reply2List", reply2List);
			
			stmt.close();
			rs.close();
			
			sql="select sum(good),sum(bad) from boardlike where seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			rs=stmt.executeQuery();
			BoardlikeVO boardLikevo=null;
			if(rs.next()) {
				boardLikevo=new BoardlikeVO();
				boardLikevo.setGood(rs.getInt(1));
				boardLikevo.setBad(rs.getInt(2));
			}
			
			request.setAttribute("boardLikevo", boardLikevo);
			
			stmt.close();
			rs.close();
			
			String isCheckCode = "G0B0";
			
			sql="select isCheckCode from boardlike where id=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setInt(2, seq);
			rs=stmt.executeQuery();
			if(rs.next()) {
				isCheckCode=rs.getString(1);
			}
			System.out.println(isCheckCode);
			
			request.setAttribute("isCheckCode", isCheckCode);
			
			RequestDispatcher dispatcher=request.getRequestDispatcher("getBoard.jsp");
			dispatcher.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
	
		
	}

}
