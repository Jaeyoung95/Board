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

import com.company.jdbc.JDBCConnection;

@WebServlet("/DeleteBoardCtrl")
public class DeleteBoardCtrl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int seq = Integer.parseInt(request.getParameter("seq"));
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		System.out.println("/DeleteBoardCtrl");

		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "delete from board where seq=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, seq);

			int cnt = stmt.executeUpdate();

			System.out.println(cnt + "개 레코드 삭제");

			out.print("<script>alert('글 삭제 완료');location.href='GetBoardListCtrl';</script>");

			out.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
