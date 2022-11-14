package com.company.biz.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.jdbc.JDBCConnection;

@WebServlet("/UpdateBoardCtrl")
public class UpdateBoardCtrl extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/UpdateBoardCtrl");
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html;charset=UTF-8");
		
		PrintWriter out=response.getWriter();

		// 1. 접속한 유저 이름 추출
		// 로그인을 안했으면 로그인 페이지로 이동시킨다.
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		if (name == null)
			response.sendRedirect("login.jsp");
		
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int seq= Integer.parseInt(request.getParameter("seq"));
		
		System.out.println(title+" "+content+" "+seq);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn=JDBCConnection.getConnection();
			String sql="update board set title=?,content=? where seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setInt(3, seq);
			
			int cnt=stmt.executeUpdate();
			
			System.out.println(cnt+"개 레코드 수정");
			
			out.print("<script>alert('글 수정 완료');location.href='GetBoardListCtrl';</script>");
			
			out.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
