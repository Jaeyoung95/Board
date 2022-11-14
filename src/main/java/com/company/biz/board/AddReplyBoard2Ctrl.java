package com.company.biz.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.jdbc.JDBCConnection;


@WebServlet("/AddReplyBoard2Ctrl")
public class AddReplyBoard2Ctrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("/AddReplyBoard2Ctrl");
		
		int boardseq=Integer.parseInt(request.getParameter("boardseq"));
		int seq=Integer.parseInt(request.getParameter("seq"));
		String nickname=request.getParameter("nickname");
		String id=request.getParameter("id");
		String content=request.getParameter("content");
		
		System.out.println(boardseq+" "+seq+" "+nickname+" "+id+" "+content);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="insert into replyboard_2(boardseq,seq,rseq,nickname,regdate,content,userid) \r\n"
					+ "values(?,?,(select nvl(max(rseq),0)+1 from replyboard_2),?,sysdate,?,?)";
			stmt=conn.prepareStatement(sql);
			
			stmt.setInt(1, boardseq);
			stmt.setInt(2, seq);
			stmt.setString(3, nickname);
			stmt.setString(4, content);
			stmt.setString(5, id);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt>0) {
				System.out.println(cnt+"개의 댓글의 댓글 삽입");
			}
			
			response.sendRedirect("GetBoardCtrl?seq="+boardseq);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
