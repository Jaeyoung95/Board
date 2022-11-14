package com.company.biz.admin;

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


@WebServlet("/DeleteBoardListAdmin")
public class DeleteBoardListAdmin extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/DeleteBoardListAdmin");
		request.setCharacterEncoding("UTF-8");
		
		String[]  seqArray=request.getParameterValues("delBoardCheckbox");
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			
			for(String s:seqArray) {
				System.out.println(s);
				int seq=Integer.parseInt(s);
				String sql="delete from board where seq=?";
				
				stmt=conn.prepareStatement(sql);
				stmt.setInt(1, seq);
				
				stmt.executeUpdate();
			}
			
			response.sendRedirect("GetBoardListCtrl");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
		
	}

}
