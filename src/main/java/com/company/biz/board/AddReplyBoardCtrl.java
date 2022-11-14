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


@WebServlet("/AddReplyBoardCtrl")
public class AddReplyBoardCtrl extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/AddReplyBoardCtrl");
		request.setCharacterEncoding("UTF-8");
		
		String nickname=request.getParameter("nickname");
		String content=request.getParameter("content");
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=request.getParameter("id");
		
		System.out.println(nickname+" "+content+" "+seq+" "+id);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="insert into "
					+ "replyboard(boardseq,seq,nickname,content,userid) "
					+ "values(?,(select nvl(max(seq),0)+1 from "
					+ "replyboard),?,?,?)";
			stmt=conn.prepareStatement(sql);
			
			stmt.setInt(1, seq);
			stmt.setString(2, nickname);
			stmt.setString(3, content);
			stmt.setString(4, id);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt!=0) response.sendRedirect("GetBoardCtrl?seq="+seq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
