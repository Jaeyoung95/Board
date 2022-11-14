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


@WebServlet("/DeleteReplyBoardCtrl")
public class DeleteReplyBoardCtrl extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/DeleteReplyBoardCtrl");
		int boardseq=Integer.parseInt(request.getParameter("boardseq")); 
		int seq=Integer.parseInt(request.getParameter("seq"));
		
		System.out.println(boardseq+" "+seq);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="delete from replyboard where boardseq=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, boardseq);
			stmt.setInt(2, seq);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt>0) response.sendRedirect("GetBoardCtrl?seq="+boardseq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
