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


@WebServlet("/UpdateReplyBoard2Ctrl")
public class UpdateReplyBoard2Ctrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/UpdateReplyBoardCtrl");
		
		request.setCharacterEncoding("UTF-8");
		
		int boardseq=Integer.parseInt(request.getParameter("boardseq")); 
		int seq=Integer.parseInt(request.getParameter("seq"));
		int rseq=Integer.parseInt(request.getParameter("rseq"));
		String content=request.getParameter("content");
		
		System.out.println(boardseq+" "+seq+" "+rseq);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="update replyboard_2 set content=?,regdate=sysdate where boardseq=? and seq=? and rseq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, content);
			stmt.setInt(2, boardseq);
			stmt.setInt(3, seq);
			stmt.setInt(4, rseq);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt>0) response.sendRedirect("GetBoardCtrl?seq="+boardseq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	

}
