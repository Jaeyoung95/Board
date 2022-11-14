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


@WebServlet("/DeleteReplyBoard2Ctrl")
public class DeleteReplyBoard2Ctrl extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/DeleteReplyBoard2Ctrl");
		
		int boardseq=Integer.parseInt(request.getParameter("boardseq"));
		int seq=Integer.parseInt(request.getParameter("seq"));
		int rseq=Integer.parseInt(request.getParameter("rseq"));
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="delete from replyboard_2 where boardseq=? and seq=? and rseq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, boardseq);
			stmt.setInt(2, seq);
			stmt.setInt(3, rseq);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt>0)
				System.out.println("답글의 답글 삭제 완료");
			
			response.sendRedirect("GetBoardCtrl?seq="+boardseq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
