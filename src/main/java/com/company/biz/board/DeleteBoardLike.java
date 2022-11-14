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


@WebServlet("/DeleteBoardLike")
public class DeleteBoardLike extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/DeleteBoardLike");
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		String id=request.getParameter("id");
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="delete from boardlike where id=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setInt(2, seq);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt>0)
				response.sendRedirect("GetBoardCtrl?seq="+seq);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
